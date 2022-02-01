Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B341B4A5A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiBAKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:51:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41370 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiBAKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:51:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9AB1CCE17E0;
        Tue,  1 Feb 2022 10:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D749C340EB;
        Tue,  1 Feb 2022 10:51:00 +0000 (UTC)
Date:   Tue, 1 Feb 2022 11:50:57 +0100
From:   Greg KH <greg@kroah.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Russell, Scott" <Scott.Russell2@ncr.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] USB: serial: cp210x: add device ids for NCR products
Message-ID: <YfkQkVuT9w93llrf@kroah.com>
References: <20220201104253.10345-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201104253.10345-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 11:42:51AM +0100, Johan Hovold wrote:
> This series adds a couple of new ids to the cp210x driver for devices
> found in various NCR products.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   USB: serial: cp210x: add NCR Retail IO box id
>   USB: serial: cp210x: add CPI Bulk Coin Recycler id
> 
>  drivers/usb/serial/cp210x.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
