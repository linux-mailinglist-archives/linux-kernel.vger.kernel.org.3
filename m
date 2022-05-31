Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE5F539124
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiEaMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiEaMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A473552
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF0F60916
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A531C385A9;
        Tue, 31 May 2022 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654001571;
        bh=BgK5r/VJqTsmBomquLZzHoVkoWPmJmwZKJWnFVBtVXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DoateXwG9MzCnbzwyP8eV6xrPLYE2RNW+9dF685B1U5RNwYa1QdibyEtIlZ8DIDQa
         pu+aLBC8jirh4L/Ew+/9KeSW+7TkvFyLvLBmj7QRIS7gKz/gIzcqRJuSTn82KM6ljB
         532yi9KdQzsu06yciAlFo5CE0W7gFqxhxyirLckekavyQ8Z0DiF1+fQDieQnZGtrxx
         cUxhHK06DvC7Bw0x9JGCHvtBdkMhtjxTdjdlMRJs9qo3IOdoVEjugn9Boq+oMuVno5
         v49B1j9u9OeVUJJnZgLsQTl3BlYmdvLzGaiwvndDfMuQ1Ar7FMIOjtIeX+xbUvDCQa
         HHTPXGr7nTABQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nw1Mf-00El8I-2Y; Tue, 31 May 2022 13:52:49 +0100
MIME-Version: 1.0
Date:   Tue, 31 May 2022 13:52:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] irqchip: Adjust Kconfig for Loongson
In-Reply-To: <20220531115942.1686812-1-chenhuacai@loongson.cn>
References: <20220531115942.1686812-1-chenhuacai@loongson.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e7cf33a170d0b4e98e53744f60dbf922@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenhuacai@loongson.cn, tglx@linutronix.de, linux-kernel@vger.kernel.org, lixuefeng@loongson.cn, chenhuacai@gmail.com, jiaxun.yang@flygoat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 12:59, Huacai Chen wrote:
> We are preparing to add new Loongson (based on LoongArch, not 
> compatible
> with old MIPS-based Loongson) support.

Please drop this blurb from all your patches. It adds zero information.

> HTVEC will be shared by both old
> and new Loongson processors, so we adjust its description. HTPIC is 
> only
> used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
> PCH_MSI will have some arch-specific code, so we remove the 
> COMPILE_TEST
> dependency to avoid build warnings.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

No cover letter, no indication of what this applies on, no mention
of how this relates to the ongoing irqchip review.

What do you want me to do with this?

         M.
-- 
Jazz is not dead. It just smells funny...
