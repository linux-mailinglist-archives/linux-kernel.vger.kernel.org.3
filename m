Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF81C4774C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhLPOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:36:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40224 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhLPOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:36:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD9961E0E;
        Thu, 16 Dec 2021 14:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5326C36AE0;
        Thu, 16 Dec 2021 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639665398;
        bh=L9sfP4SdpwWSAs6EQJ9rviv6zfDFP9fcD8eOiGef6ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANoQmZeNu3SOTZUrL+236qumwQ/gLPKXCWCHCWhM1hPS2o+UYZtPWT+Yqtx0CssGz
         SSuKC96qtj7EHrGDzWLoHC2y6Inwz/OauHSkSXWT1jQJVXAPj9ot9aeYfsX6iOoFvQ
         9R41R4Cw8a/Hbzr7jI1wGxxGhVl9Y4HmCVrTzQzM=
Date:   Thu, 16 Dec 2021 15:36:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: pch_uart: potential dereference of null
 pointer
Message-ID: <YbtO81mPksp3JVkk@kroah.com>
References: <20211216141454.423333-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216141454.423333-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:14:54PM +0800, Jiasheng Jiang wrote:
> The return value of dma_alloc_coherent() needs to be checked.
> To avoid dereference of null pointer in case of the failure of alloc.
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

A blank line is always needed before the signed-off-by line.

> ---
> Changelog:
> 
> v2 -> v3
> 
> *Change 1. Remove dev_err.
> *Change 2. Change the return type of pch_request_dma to int.
> *Change 3. Return -ENOMEM when dma_alloc_coherent() failed and 0 the
> others.
> *Change 4. Check return value of dma_alloc_coherent().

I see v3 here, not v4.  Where is v4?

And how did you test this change?

thanks,

greg k-h
