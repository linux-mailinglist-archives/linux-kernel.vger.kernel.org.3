Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC248C3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbiALMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:07:26 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:63904 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiALMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:07:24 -0500
X-KPN-MessageId: 1a08e1aa-73a0-11ec-8862-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 1a08e1aa-73a0-11ec-8862-005056aba152;
        Wed, 12 Jan 2022 13:06:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=/kks0r5w0KQ+v/Z4xSIKSyUZglpRSXpEXnyxk0dWxHs=;
        b=QwNvnV8ptaBl5hdUox1MrT/sZ7vpMV3AtJ5+lvI3D3frKBaxzIyrAawowMzSS/BIH1hG1Yd64Pfll
         lXn3tgghw6FwwXbFQq9mT/cnG3hYTKpud7T3tzCvnX4HnC+57ZnpuKa83h7lqQYybH3xWo7FAPjVVv
         LHHes9RyBXDa0WXDgIkjUayc+sTzuu8A+T7N0dqeICBHokXN/JZSEFCRZiyfWxqppBjIsSCe7vjNdX
         Xi0kyjzUXzyoqXy+TWExZZKD//H9T0jQtMW9PgVdtSsYfnNmZeMa6iEbuPvdpztB3recriTIjGnqKA
         trHb0jWKGAzjqDDRoAfwFh9uIFYuk7Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eElTae1qMUScSWAJAAoK/LhQS6rs1AfjpYhHrZqvSg6sfxxF7FyxxDhQ2/PJpVZ
 7RyYmCLWUfmdzADkftIvGvA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 31bf7742-73a0-11ec-94d2-005056abf0db;
        Wed, 12 Jan 2022 13:07:21 +0100 (CET)
Message-ID: <50bb6274-b004-eff7-56d5-68ec8e10d3c4@xs4all.nl>
Date:   Wed, 12 Jan 2022 13:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 00/23] media: atmel: atmel-isc: implement media
 controller
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org, robh+dt@kernel.org, jacopo@jmondi.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On 13/12/2021 14:49, Eugen Hristev wrote:
> This series is the v3 of the series that attempts to support media controller
> in the atmel ISC and XISC drivers.
> This series also includes the csi2dc driver which was previously sent in a
> separate series:
> https://www.spinics.net/lists/linux-media/msg181042.html
> https://www.spinics.net/lists/linux-media/msg181044.html
> The driver now addresses comments received in latest v5 series from last year.
> 
> The series includes some minor changes and fixes that improve the isc common
> code base, like removing the enum frameintervals VIDIOC, fixing bytesperline
> for planar formats, etc.
> 
> Many thanks to folks from libcamera who helped a lot with understanding
> how a media controller driver should behave.
> 
> Feedback is welcome !
> 
> Changes in v3:
> - change in bindings, small fixes in csi2dc driver and conversion to mc
> for the isc-base.
> - removed some MAINTAINERS patches and used patterns in MAINTAINERS
> 
> Changes in v2:
> - integrated many changes suggested by Jacopo in the review of the v1 series.
> - add a few new patches

Based on the current review status I think it would make sense to add
the following patches from this series to a PR:

1-6, 8-9, 11, 16, 18-22.

Are there any patches (esp. 11 and later) that require other patches
not in this list? In other words, does this make sense?

Regards,

	Hans

> 
> 
> Eugen Hristev (23):
>   MAINTAINERS: add microchip csi2dc
>   dt-bindings: media: atmel: csi2dc: add bindings for microchip csi2dc
>   media: atmel: introduce microchip csi2dc driver
>   media: atmel: atmel-isc: split the clock code into separate source
>     file
>   media: atmel: atmel-isc: replace video device name with module name
>   media: atmel: atmel-sama7g5-isc: fix ispck leftover
>   media: atmel: atmel-isc-base: use streaming status when queueing
>     buffers
>   media: atmel: atmel-isc-base: remove frameintervals VIDIOC
>   media: atmel: atmel-isc-base: report frame sizes as full supported
>     range
>   media: atmel: atmel-isc-base: implement mbus_code support in enumfmt
>   media: atmel: atmel-isc-base: fix bytesperline value for planar
>     formats
>   media: atmel: atmel-isc: implement media controller
>   ARM: dts: at91: sama7g5: add nodes for video capture
>   ARM: configs: at91: sama7: add xisc and csi2dc
>   ARM: multi_v7_defconfig: add atmel video pipeline modules
>   media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
>   media: atmel: atmel-isc-base: use mutex to lock awb workqueue from
>     streaming
>   media: atmel: atmel-isc-base: add wb debug messages
>   media: atmel: atmel-isc-base: clamp wb gain coefficients
>   media: atmel: atmel-sama7g5-isc: fix UYVY input format mbus_code typo
>   media: atmel: atmel-isc: add raw Bayer 8bit 10bit output formats
>   media: atmel: atmel-isc: compact the controller formats list
>   media: atmel: atmel-isc: change format propagation to subdev into only
>     verification
> 
>  .../bindings/media/microchip,csi2dc.yaml      | 197 +++++
>  MAINTAINERS                                   |  14 +-
>  arch/arm/boot/dts/sama7g5.dtsi                |  48 ++
>  arch/arm/configs/multi_v7_defconfig           |   3 +
>  arch/arm/configs/sama7_defconfig              |   2 +
>  drivers/media/platform/Makefile               |   1 +
>  drivers/media/platform/atmel/Kconfig          |  15 +
>  drivers/media/platform/atmel/Makefile         |   4 +-
>  drivers/media/platform/atmel/atmel-isc-base.c | 790 ++++++-----------
>  drivers/media/platform/atmel/atmel-isc-clk.c  | 311 +++++++
>  drivers/media/platform/atmel/atmel-isc-mc.c   | 287 +++++++
>  drivers/media/platform/atmel/atmel-isc.h      |  49 ++
>  .../media/platform/atmel/atmel-sama5d2-isc.c  |  59 +-
>  .../media/platform/atmel/atmel-sama7g5-isc.c  |  72 +-
>  .../media/platform/atmel/microchip-csi2dc.c   | 806 ++++++++++++++++++
>  15 files changed, 2085 insertions(+), 573 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
>  create mode 100644 drivers/media/platform/atmel/atmel-isc-clk.c
>  create mode 100644 drivers/media/platform/atmel/atmel-isc-mc.c
>  create mode 100644 drivers/media/platform/atmel/microchip-csi2dc.c
> 

