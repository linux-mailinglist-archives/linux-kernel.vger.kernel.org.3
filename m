Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7272E4A5AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiBALDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiBALDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:03:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6DC06173B;
        Tue,  1 Feb 2022 03:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B3CB6149E;
        Tue,  1 Feb 2022 11:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755ADC340EB;
        Tue,  1 Feb 2022 11:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643713379;
        bh=6fcP7lNrKMV0ISHAz8KbKez7zLdzKoYGN881eJYHXtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9W5I1al2BNtvN5Hgt+rshRxiUggNSiicLOlC/QnHgDw/bdZJHzvnbPGEguOg1AF3
         sC8K71wRh4ja1MioTHirtG+qnFTNiYzYnAd9nBFeYZWMLgxwwMM0vEPlm13QEtCVw0
         +aVs/Qn822BzYEmqSlVPNTWReD/mr9CxKQ5lHM6CXTVm/C2fybHSQDItMIxbiL2Fga
         zynvbZMJpm9ZFuh/S3zCxc4rSI49KJsHqUNe7hA0hrLzT7PXBKpN4UouGrS5Fjm/rA
         MpIMOgtS3PPVA9KVqj+bxZn1IIY3n4F/cEPJmJCSNIjg2l328pcs85jhFoZC4vs+Zl
         MTN3LUlj6q46g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEqvr-0008Hl-Dg; Tue, 01 Feb 2022 12:02:43 +0100
Date:   Tue, 1 Feb 2022 12:02:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     "Russell, Scott" <Scott.Russell2@ncr.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] USB: serial: cp210x: add device ids for NCR products
Message-ID: <YfkTU95AuBOKEMUM@hovoldconsulting.com>
References: <20220201104253.10345-1-johan@kernel.org>
 <YfkQkVuT9w93llrf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfkQkVuT9w93llrf@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 11:50:57AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 01, 2022 at 11:42:51AM +0100, Johan Hovold wrote:
> > This series adds a couple of new ids to the cp210x driver for devices
> > found in various NCR products.
> > 
> > Johan
> > 
> > 
> > Johan Hovold (2):
> >   USB: serial: cp210x: add NCR Retail IO box id
> >   USB: serial: cp210x: add CPI Bulk Coin Recycler id
> > 
> >  drivers/usb/serial/cp210x.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied.

Johan
