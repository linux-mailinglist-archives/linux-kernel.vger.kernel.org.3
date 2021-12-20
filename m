Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C447A94B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhLTMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:15:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLTMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:15:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1496B60FFE;
        Mon, 20 Dec 2021 12:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99DAC36AE8;
        Mon, 20 Dec 2021 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640002546;
        bh=MRp0eaEh6lLPWpCu8Ai+ZNJIV+FgrQhpzw+LnkYhzkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7vFFMFQ0C8qkqZwvjP0kPA4dTnNJCar74C/Fe97ZQXMG0qn4bTy7Q795sL1DpafE
         7/CmVzlL43KoqcL9hBjS8kfkFwtLnHW2haP3iHIuQaVKqggE7nJe/C76fC8YfXiLSI
         rJSQSFSjMo1jSiPQB8hpazI+XEMhFFZPEoHoAs3U=
Date:   Mon, 20 Dec 2021 13:15:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gnss: add USB support
Message-ID: <YcBz74iw4nJFpV1f@kroah.com>
References: <20211220111901.23206-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220111901.23206-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:18:59PM +0100, Johan Hovold wrote:
> This series adds a generic driver for GNSS receivers with a USB
> interface and a first device id for the Sierra Wireless XM1210 receiver.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   gnss: add USB support
>   gnss: usb: add support for Sierra Wireless XM1210
> 
>  drivers/gnss/Kconfig  |  11 +++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/usb.c    | 210 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/gnss/usb.c
> 
> -- 
> 2.32.0
> 


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
