Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A683D4C8E78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiCAPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiCAPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:02:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9414D9E56E;
        Tue,  1 Mar 2022 07:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8C66CE1C48;
        Tue,  1 Mar 2022 15:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD23EC340F2;
        Tue,  1 Mar 2022 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646146898;
        bh=fsaZzr0CCCP6M/dr2U1LFsH9eaJK6vbc1eqyfSLb/Z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VkPclI6kDUJ0dLw1WIhtpq7EdjRgXY70C5RVnwiqdU/+UFEPxxC5BjXKYf9ihkZrC
         fb/6pohUXMZ0QY0a64QXnE7DE9ePCNLNYaq8cutbtCXjTnKg7ITZ+kPA/xLFgc9/nY
         mZjiy3k3CVqC6ych2388Aub3rFIFf5uImJCgdnD0GNIc8/5XK6acYilRnOIkuaxEls
         bMmmWXQ79IwyZ4LI7Y1vMvf9Z6VlBsTyrIb+KtdVcUjWwarOM2n8AjOowQAoWc9M//
         h3TyDOGoS6D/H/z6igGBC+vb/IGolYHKaN6EaumaBsoQ6lpjyga3pd7npiiDk4JzWP
         vKXae5E0Djlng==
Date:   Tue, 1 Mar 2022 09:01:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the pci tree
Message-ID: <20220301150136.GA609359@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301135938.4c664beb@canb.auug.org.au>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 01:59:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pci tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> Error: Cannot open file drivers/gpu/vga/vgaarb.c
> Error: Cannot open file drivers/gpu/vga/vgaarb.c
> 
> Introduced by commit
> 
>   d6e1898bfa5b ("PCI/VGA: Move vgaarb to drivers/pci")
> 
> The reference in Documentation/gpu/vgaarbiter.rst needs to be updated.

Fixed, thanks!
