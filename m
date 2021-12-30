Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D288C481B92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhL3LE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3LEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:04:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F0C061574;
        Thu, 30 Dec 2021 03:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2ABA61672;
        Thu, 30 Dec 2021 11:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDEBC36AEA;
        Thu, 30 Dec 2021 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640862264;
        bh=wlXE1hKCyvaIRM7TRyCzselG+viWuPEUPId3jt1opro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szvO3ZzrCuBKbFsTD5PhMRas9k4ER1+QiW5Lm3c3JdqGGnBcRf+6ZMmCHMAOVxvpO
         dYWx2E3AnGVA4V1Ltz6sGz8YMbx7J2mPhhlJm2CWz3Zflq8aEQDgaQO/+IOMjJR2vr
         EYuUnn1F2wNpNdmV13hsgmG9FGO8jH+Jt7sgjWNg=
Date:   Thu, 30 Dec 2021 12:03:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     balbi@kernel.org, axboe@kernel.dk, stern@rowland.harvard.edu,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: don't release an existing dev->buf
Message-ID: <Yc2R+nIOG6aJ+hea@kroah.com>
References: <20211230043815.18899-1-hbh25y@gmail.com>
 <20211230043815.18899-2-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230043815.18899-2-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 12:38:14PM +0800, Hangyu Hua wrote:
> dev->buf does not need to be released if it already exists before
> executing dev_config.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

I missed this, where did Alan ack this patch?

thanks,

greg k-h
