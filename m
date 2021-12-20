Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2847A883
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhLTLVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLTLU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C942C061574;
        Mon, 20 Dec 2021 03:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF5860C7A;
        Mon, 20 Dec 2021 11:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22511C36AE8;
        Mon, 20 Dec 2021 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639999258;
        bh=MVa0Q2mU+egWC6GFZ3kyV1Q/dRebhp0ifKOVrYUeGMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Px2i42Z+ew22oyULvyxyha0RNxO2vZgsA9kfSUFMJLvKPKAo3QVcpVIUVitWotUu4
         MbETS8o9G5oV3WvtMAzPKDw4SY5sWyaEyDmf7yi5o2WdbgH5cE8uTfcRGzANU+H9J4
         zGEXMPEueA1u8uXNWwx0yb5/GVGfcLF4RjfBnWDKvWnp9f8X/ADhFiL+3RIi/CAFJ/
         OG7cYyaC+m1k00Z2WpKk/jAmrynour+esg9v+EH26FIlaX0m5G3feqffnNJ0hnuAHF
         cNcrNuqTKO6I9IiUZhGhbWm0hogezjEmC4//t6tfTKsec+U5or4F8Hjzo1C1Lz9gme
         OYxjN5LK9Ai2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzGip-00063h-4U; Mon, 20 Dec 2021 12:20:51 +0100
Date:   Mon, 20 Dec 2021 12:20:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     ferlandm@amotus.ca
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: simple: add sierra wireless xm1210 gnss
 receiver
Message-ID: <YcBnE3j5x0QeWaJq@hovoldconsulting.com>
References: <20211027200223.72701-1-ferlandm@amotus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027200223.72701-1-ferlandm@amotus.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:02:23PM -0400, ferlandm@amotus.ca wrote:
> From: Marc Ferland <ferlandm@amotus.ca>
> 
> Add device id for the Sierra Wireless XM1210 Multi-GNSS module.
> 
> https://www.sierrawireless.com/iot-solutions/products/xm1210/
> 
> $ lsusb -vd 1199:b000
> 
> Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1199 Sierra Wireless, Inc.
>   idProduct          0xb000
>   bcdDevice            0.01
>   iManufacturer           1 Sierra-wireless
>   iProduct                2 Sierra Wireless_GNSS
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0020
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower               50mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         0
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval             255
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval             255
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0001
>   Self Powered
> 
> Device is also working correctly with:
> 
> $ echo 0x1199 0xb000 > /sys/bus/usb-serial/drivers/generic/new_id
> 
> Signed-off-by: Marc Ferland <ferlandm@amotus.ca>

Sorry about the late reply on this.

I've been meaning to look into adding USB support to the GNSS subsystem
and using that instead of USB serial, but I've been really short on time
lately.

The GNSS subsystem provides a generic interface to user-space regardless
of the type of interface used (e.g. serial, i2c, spi, USB) and can be
extended with GNSS specific features (e.g. power control signals) as
needed.

I've written a small generic driver for GNSS receivers with a USB
interface which I've verified using a u-blox receiver:

	https://lore.kernel.org/r/20211220111901.23206-1-johan@kernel.org

Would you mind giving it a spin with the Sierra device as well?

Johan
