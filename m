Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFF6486A53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiAFTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:07:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50532 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiAFTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:07:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FA9B61DCC;
        Thu,  6 Jan 2022 19:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4769CC36AE3;
        Thu,  6 Jan 2022 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641496075;
        bh=kYsnHLd5E6KKw7BnoFj5rY3K+fJjMRRny/vJXZPvvhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JESODrkwBRKPn9MYbApiqpHS66izlfhExHLGa0jjMaCUVMr36af1keiJzGYS0DaDa
         owDCPy/1XyLomE5Hz10FWjo0iA0CTyFcK2aBS9nZNg1Id0kJy5h7iEqETIBhKp2/Hl
         85rDU4XsH6ket5BtOrqUQwSBqDoEwhnWe5rbYJ/RFF4ZBou9WE3LlbWd1TvmAaFxHf
         rCXdUR7LGg792eWZWwL8A0uqBByZEnh5/Grnn2dWTji9/sDBYklvtxDJlD4WSSIOOd
         nRtoKEVhdqbWDr8dkn86ICh142P8IrIvLgZXf4n3OTxr0GSIK59rAEldvn8kcYm+8L
         BejV6N3M/PmHA==
Date:   Thu, 6 Jan 2022 21:07:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the tpmdd tree
Message-ID: <Ydc+BkheAdEW5qI5@iki.fi>
References: <20220104083224.3e23e7e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104083224.3e23e7e2@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 08:32:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   8ca8e009e216 ("tpm: fix potential NULL pointer access in tpm_del_char_device")
> 
> Fixes tag
> 
>   Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing quotes
> 
> Presumably you meant
> 
> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio_bus")
> 
> Please do not truncate or split these tag lines.
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi, I fixed this in my tree, and send updated to PR to Linus. Thank you.

BR,
Jarkko
