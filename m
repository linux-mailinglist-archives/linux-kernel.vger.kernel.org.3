Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5124775D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhLPPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33206 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLPPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CAE61E24;
        Thu, 16 Dec 2021 15:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B47BC36AE4;
        Thu, 16 Dec 2021 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639668278;
        bh=ev+/ApSEEBzT/7SKV33Zoy3rD+RW1vJUeBArUO5NNBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfh7Vgx1Wmp4GbwvSAXicP9SFnLIcX+kDCXZQo1IQR3+R6IIa9Ypn2KgQk08aiFnB
         DuvRMT3GrSD+8cof4gZFAUVnsycWOvDpnXduvOd1jZs2N3LRAJvnuYUkSXIKod30Vk
         vtLHN2MtfBIMorwb78zGYDRrrSAFhHZOqQfWgvSo=
Date:   Thu, 16 Dec 2021 16:24:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] serial: pch_uart: potential dereference of null
 pointer
Message-ID: <YbtaNI/P6oxxWyXk@kroah.com>
References: <20211216150539.423387-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216150539.423387-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:05:39PM +0800, Jiasheng Jiang wrote:
> On Thu, Dec 16, 2021 at 10:36:35PM +0800, Greg KH wrote:
> >> The return value of dma_alloc_coherent() needs to be checked.
> >> To avoid dereference of null pointer in case of the failure of alloc.
> >> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> 
> >A blank line is always needed before the signed-off-by line.
> 
> >> ---
> >> Changelog:
> >> 
> >> v2 -> v3
> >> 
> >> *Change 1. Remove dev_err.
> >> *Change 2. Change the return type of pch_request_dma to int.
> >> *Change 3. Return -ENOMEM when dma_alloc_coherent() failed and 0 the
> >> others.
> >> *Change 4. Check return value of dma_alloc_coherent().
> >
> > I see v3 here, not v4.  Where is v4?
> >
> > And how did you test this change?
> >
> > thanks,
> >
> > greg k-h
> 
> Sorry, I just have v3, maybe that is my fault. But I don't know why you think there is v4.

You say "change 4".  Am I confused?

> And I have no idea about the "test this change"? Please give me more detail. 

Did you run the kernel before your change and then after your change to
ensure that the failure you saw before your change is now properly
fixed?

How did you test this?

thanks,

greg k-h
