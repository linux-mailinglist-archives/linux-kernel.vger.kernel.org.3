Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD264D2EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiCIMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiCIMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:19:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BA12756F;
        Wed,  9 Mar 2022 04:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EC2BB820BE;
        Wed,  9 Mar 2022 12:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2115C340E8;
        Wed,  9 Mar 2022 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646828319;
        bh=ouY5psTnFaiLJdRe+co0eH84WKKERydwyyVSm5HVlC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZibjxDI4fgIuTMPdjg3ggS9j5FvUQCDhWEwYS5RJ4mntXh45Kmq/E1oj/Fx8Myud
         6Og2USI0j/SaZQ1k6T+LDunPkhtjrPWVMBuasYmtpR7g4AqebI8xvJVi8l48Qa90ZJ
         x11uIPuDAnlrR9jndrFnmUU1bxyzH9GfjEJ7D7ffi/oLIJWoR5+Mizt8kXZoQeuE+E
         Ce4Dk0qq9HH3IKstS44leH3E8edQ+il/IYpCIkYvlMmvdFhpqeDUQmshICWQ8CIY6Y
         /b8/xnsYjy+MX0cB/GpMG2EvekDDH2HOzeUgKPhjiqknb1lewS95qzQmQq0WNhSW0Z
         ZVccZAdltG42g==
Date:   Wed, 9 Mar 2022 12:18:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm64 tree
Message-ID: <20220309121834.GC397@willie-the-truck>
References: <20220309223411.5492e665@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309223411.5492e665@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:34:11PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm64 tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/kdump/vmcoreinfo.rst:498: WARNING: Title underline too short.
> 
> MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
> -------------
> 
> Introduced by commit
> 
>   2369f171d5c5 ("arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges")

Cheers, I'll fix this.

Will
