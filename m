Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79B47779F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhLPQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:14:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbhLPQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:14:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9482B824E8;
        Thu, 16 Dec 2021 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B2C36AE0;
        Thu, 16 Dec 2021 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639671270;
        bh=CKYWD4uflKuXADXjxGlcp6i8SYM9wuj8VifFMoL/rDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1TNMOJJ9rM2HermfHxfI8sVT+aiATPzXAJ0o9TdsNelkWcTCwedpdPPLOpgDTvXz
         WKUvGGpZdptqH9LHY4j9Ys0Jl8Xg8fSWqb7ioAcN+qg1dCR6uClwfUzWJa6sbwbt9/
         ++AT/FsMB2NCLvdnJ8ZyrhKOwdRzQSYoMObgbjKk=
Date:   Thu, 16 Dec 2021 17:14:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v3] serial: pch_uart: potential dereference of
 null pointer
Message-ID: <Ybtl5JUXKztUYqYz@kroah.com>
References: <20211216154113.423442-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216154113.423442-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:41:13PM +0800, Jiasheng Jiang wrote:
> On Thu, Dec 16, 2021 at 11:24:36PM +0800, Greg KH wrote:
> > Did you run the kernel before your change and then after your change to
> > ensure that the failure you saw before your change is now properly
> > fixed?
> >
> > How did you test this?
> 
> Thank you for your answer. But I haven't run it yet.
> And in fact I don't know how to trigger the alloc failure.

Then perhaps this change is not needed?

thanks,

greg k-h
