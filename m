Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C098C462C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhK3GKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhK3GJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:09:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67452C06175E;
        Mon, 29 Nov 2021 22:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 570A1CE17E4;
        Tue, 30 Nov 2021 06:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A16C53FC7;
        Tue, 30 Nov 2021 06:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638252376;
        bh=q/zOGdTT4xs6T3I1boN7o5TZDyxJ3Nv/FRTXjltnS5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZWSIxuuVOhWz5hC65bSGO0GVqIQG0U3eKLUpYC0dFTRBbwlt2BdfOP12vzddHo46
         dDDfYJKE8/FXSa+4GeCHHfu9oGQTj4VuorVlFffL74XLLUpsjlgpzKay2v1oYBZ0RT
         YCPmunmVmdbSeT9otcFL5ps1pdlDrQo95HkJ3aBwoIjElotLCAuU4l0MkQJoA56tEC
         Zpr/7Dy31/FErVFsGVTm2UUlSy7j4zm0mHOYVBV2RyEM1x2j6KSO1I19OQhQ1gclIO
         Sh2bV/O/uoA7lhBfwAlOqUxP4kmh4Q3vcHzVdqMJdHiiZuSEyz44w8vTd5q8TjvsSK
         x78Vy5Fzd/SdQ==
Date:   Tue, 30 Nov 2021 11:36:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: pci_generic: Simplify code and axe the use of
 a deprecated API
Message-ID: <20211130060611.GB205712@thinkpad>
References: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
 <1625765577.10055.24.camel@codeaurora.org>
 <cd72331c-c3d3-f1e9-e1b2-7572b6cdf0a2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd72331c-c3d3-f1e9-e1b2-7572b6cdf0a2@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:27:20PM +0100, Christophe JAILLET wrote:
> Le 08/07/2021 à 19:32, Hemant Kumar a écrit :
> > On Thu, 2021-07-08 at 06:30 +0200, Christophe JAILLET wrote:
> > > The wrappers in include/linux/pci-dma-compat.h should go away.
> > > 
> > > Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an
> > > equivalent
> > > and less verbose 'dma_set_mask_and_coherent()' call.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > If needed, see post from Christoph Hellwig on the kernel-janitors ML:
> > >     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> > > ---
> > 
> > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > 
> 
> Hi,
> 
> Polite reminder.
> This is still not part of -next.
> 
> The patch is old (July/21), I can resend if needed.

Sorry, this one slipped through the cracks. Applied to mhi-next now!

Thanks,
Mani
