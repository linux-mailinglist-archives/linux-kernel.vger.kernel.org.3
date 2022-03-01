Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF094C9824
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiCAWG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCAWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:06:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03339AE69;
        Tue,  1 Mar 2022 14:05:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FEFBB81B0A;
        Tue,  1 Mar 2022 22:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4DDC340EE;
        Tue,  1 Mar 2022 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646172343;
        bh=CKeoTbu6ViV/O9pVACnKXgJRQa0xBVeX6G0zKR/x7ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EiY4Rauaw5PqxdwKrSki8fV1rSzcu8fc6v5PZjQgk6a03wipxfgZyxa/Cn60FfXM6
         b7xWoFLu4jzS4NeMzLTiD+S44letxbQiwF/oNhZJ3EG7keJV8KwEuKJlDctP/B4AOk
         x28ZZfGMgyaO6EWTSY5cbhl9ZHD2kv8bnrxl7rMGl7xjLLtigsywIbewAuVXJ92nOn
         ELN8P/AlGXZsCo9kdSl0MHFJbEcxhlBhOQikTwNS3duA1EUu30/kVyCp69Q418vPas
         QP/8WjX1PnVWYAKJ2l6qyfTiXvhBPcaC2HoSI4e8SgA093sA1PlXo2qJrfR5WdeYGI
         lhfR7qTwOlMlA==
Date:   Tue, 1 Mar 2022 16:05:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the pci tree
Message-ID: <20220301220541.GA656916@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302081251.76dc066b@canb.auug.org.au>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:12:51AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   8423706fcd6f ("PCI/VGA: Log bridge control messages when adding devices")
>   616c33aeef4d ("PCI/VGA: Move disabled VGA device detection to ADD_DEVICE path")
>   3996347141f2 ("PCI/VGA: Move non-legacy VGA detection to ADD_DEVICE path")
>   74cc9ccf72f4 ("PCI/VGA: Move firmware default device detection to ADD_DEVICE path")
>   7c0045edaf90 ("PCI/VGA: Factor out default VGA device selection")
>   55019256d686 ("PCI/VGA: Move vga_arb_integrated_gpu() earlier in file")
> 
> are missing a Signed-off-by from their committers.

Sorry, fixed.
