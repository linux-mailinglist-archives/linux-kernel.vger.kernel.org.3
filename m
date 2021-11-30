Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28D462C80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhK3GEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhK3GEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:04:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A71C061574;
        Mon, 29 Nov 2021 22:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EF36B811EC;
        Tue, 30 Nov 2021 06:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2EAC53FC1;
        Tue, 30 Nov 2021 06:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638252075;
        bh=mcAvUiIoVAk9IAnnlyMQa9dCBo+p8bqdX/VdOnGq5vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2GSQZJNiXWoafXEGyo85MDNxFXBFrdoABNAz2foJh+c7/3mKIYwr0L4aLFMZ3KFf
         MAWit5DfBobqv+NEyYK75BqZ97U7xK4MPlfgRg3XmcP5POmIJIHZIMcGHTkkliLwQf
         Ku8IDAf2JVbDrmctZGoeKhy/OzQfHKfO522BphjiGWXObQMJByjacum2t9Avo0LVSx
         Jw41l5Q9FKpgdyzkFZWYkHpxUHtHcSDdDOMSJHyQAAuMqn5QuU/CKjvCy9zSPmW1++
         InFqh4ZGrpmj79vXECWUsJKApzj1w+l0D/vDFEQ9HhJvOh9l1+bynwMwwuAFopeCXe
         cZE4p+ZAUbEBQ==
Date:   Tue, 30 Nov 2021 11:31:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: pci_generic: Simplify code and axe the use of
 a deprecated API
Message-ID: <20211130060110.GA205712@thinkpad>
References: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 06:30:37AM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
> and less verbose 'dma_set_mask_and_coherent()' call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reveiwed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani
