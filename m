Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F1521325
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiEJLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiEJLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C32AC6D0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AB86184A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D125AC385A6;
        Tue, 10 May 2022 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652180734;
        bh=cEhq0PJv+P9seAlvHCJTfRjKnNFtwRNlIyrJuyROuTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lsd65Vz2p+w0iUyDILvnt1ep5IZkqnskYuYF1l5oisEcJnkWv0OK48vxUeHkOqgTE
         ufVipb8KLAgAhcFtXTX2IgctFLMgJL2pslN1zAPuD14yLUAP+7EA151QXeg/F5NS7n
         DXSsDu7dFis6mRWSiWy9p2rc08f9vRuHE1SXx4lRNUqsE54nBJ1m1H1pmvLU8knVaa
         Z6XuSM21DLOdN5KWRy4dqiiNUHdQyc4aD6gUhAd/r15o4bqqU5kLsJsnB9Vi6fHi+X
         jv3YabR1G/LcXYwMmXEDiqeFUDcNDMTM1+aI6T3ZU+n3pK6af/qV03IUSp00pKFQLk
         qLQGRi3FJ3DVA==
Date:   Tue, 10 May 2022 12:05:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     maz@kernel.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuc.decode@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] arm64: Declare non global symbols as static
Message-ID: <20220510110528.GC27557@willie-the-truck>
References: <20220509043221.16361-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509043221.16361-1-lcherian@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:02:21AM +0530, Linu Cherian wrote:
> Fix below sparse warnings introduced while adding errata.
> 
> arch/arm64/kernel/cpu_errata.c:218:25: sparse: warning: symbol
> 'cavium_erratum_23154_cpus' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changes from V1:
> Reverted change to global symbol cavium_erratum_27456_cpus since it
> was used in other files.
> 
>  arch/arm64/kernel/cpu_errata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
