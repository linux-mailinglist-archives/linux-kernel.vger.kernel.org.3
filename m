Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1FC568860
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiGFMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiGFMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:31:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC38252AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7ABEB81CDE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F24C3411C;
        Wed,  6 Jul 2022 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657110689;
        bh=FkOzRRaCg8g1b6CDz+WZmX3BYS39FULPDoML5S8RLAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+j5NLlACF2MuZoSRaKG3UtZBwacG7xgzZPKLobqxh9TBLaxg4VEPIyxiKj+RiidA
         hQvtFChrImW5PTRFSNt3pe+nGBPlHljv/bTECL3G9T3XrbxNbQxHIF27jIClAOfxFI
         NVtR0IjYYZenmpz6YRU9mf1kxKBqiS6Qijtri1Isv2tW9lr/4xRUb2gIRxo4GfZ17t
         uuWqe6+bPK2O2ySLO2k9RY29unEc6v7rlGEU+K/yxHt3/dMsrWaH7z2cf+9AZAS3eg
         wzUEE4jtgYnAMwaCbLjNzzyQtTYLUAfpkdMsi21m04uSLS3YP39SfbvbdmL3nQJA2s
         inqNXk0OmjFZg==
Date:   Wed, 6 Jul 2022 13:31:24 +0100
From:   Will Deacon <will@kernel.org>
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] arm64: Add stack unwinder unit tests
Message-ID: <20220706123124.GJ2403@willie-the-truck>
References: <20220624141000.88120-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624141000.88120-1-iivanov@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:09:59PM +0300, Ivan T. Ivanov wrote:
> Here is my initial arm64 unwinder test support. Code is based on s390
> unwinder tests, while errors introduced are mine. I am hopping that it
> will be useful for testing and validating upcoming arm64
> arch_stack_walk_reliable() support.

Thanks for doing this! Tests are always welcome.

Since you based this on the s390 code, how much scope is there for moving
the tests out of the arch/ directories and unifying them somewhere like
kselftest or lkdtm so that other archs can benefit too?

Will
