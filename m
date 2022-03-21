Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167804E2AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiCUOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349204AbiCUO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03C13F22;
        Mon, 21 Mar 2022 07:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9FE8B81648;
        Mon, 21 Mar 2022 14:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88048C340E8;
        Mon, 21 Mar 2022 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647872163;
        bh=hCDpnium04L+NX98eEF16B611YIyYCDehSO1Lv/GK5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6ZOJwLTrYt/LUfTxurjawz2XhZxdcUobTBvnxXsYD2VMuffI2oTFFbpxePM6/rnU
         2ZwiPGsLynn2+81ORsVpu8wTM770Z/e/DIS9dDv2lsc+QQzP9fG2LJUh+0sDHUFbaM
         EjqgCpXZsPN8u3FIl+biRb0twzHJC1bCyh3Pr214ba8DpFcDnOhpI17I7xPQ2v04YG
         LPF93Rs3QaK8fzj7wFYAA1sbOJmnxXuoazUmmU54mphGcpFvnpKlzGvzgX/C6lrMKD
         hC49iEXsoaTW1CkmN2qVSs1jKWHT2IXkLud39oAxKwNMuXW/5FzNFkd40bIkVOXCgm
         J43z5Wt9hIZWQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWIpE-00FyOT-QH; Mon, 21 Mar 2022 14:16:00 +0000
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 14:16:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the irqchip tree
In-Reply-To: <20220322000617.0a351d78@canb.auug.org.au>
References: <20220322000617.0a351d78@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3f500c7bae56e4d7ca2840cf9a0be35c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-21 13:06, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   686121ebe6fc ("irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to
> clear before descheduling")
> 
> Fixes tag
> 
>   Fixes: 57e3cebd022f ("KVM: arm64: Delay the polling of the
> GICR_VPENDBASER.Dirty
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Copy paste trikes back. Now fixed.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
