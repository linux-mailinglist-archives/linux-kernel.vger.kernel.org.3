Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DBA4660A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356577AbhLBJsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356564AbhLBJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:48:11 -0500
Received: from lb1-smtp-cloud8.xs4all.net (lb1-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D8C061758;
        Thu,  2 Dec 2021 01:44:48 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id sidvmcy8FyGz2sidymL2iA; Thu, 02 Dec 2021 10:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638438287; bh=ZxfQ4v+68ZsHK1oOlFqmClZyuwKlC8mqDwpqsQtx9N4=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=h5qB9hezdtFm7+KuEaKuIoaVVuNPtILkNkltkQlvlmu2PaN4ZznvCV0x4h+wG7msD
         yiqoSW2ITohrKMC9HdMs8MHA6RE8TvbeYiinUT/8d1lQQivFVA1b24ki1UxBnYg0tD
         e5OMXdKKgtgoZiHDqXYJwxWmYtTXlU02a1+axwy8uQU8AuZKxbi+nSTNZVMXN6IfhS
         m68+bLzvPVM0NsCHeYFvOIHkHAqkbHTE/fasNaynFtkf6pkjSG8chWTsySOCAPsARI
         TCWcF6cP088BWq+RHyTyjy9r/Rw7XI+S390d+158gNWtfRCaJvRSj1mrH0EXUJQ2yN
         3MQsY1sMR1JGw==
Subject: Re: [PATCH v13 03/13] media: amphion: add amphion vpu device driver
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1638263914.git.ming.qian@nxp.com>
 <b2219ccda94dd3149c6fa5bd9d5eb77084666ce4.1638263914.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <ea6ed8cc-7f45-d7a6-8169-2b0c726ea3a3@xs4all.nl>
Date:   Thu, 2 Dec 2021 10:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b2219ccda94dd3149c6fa5bd9d5eb77084666ce4.1638263914.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC1aThPEoa4rYiMgtU5qu+ur/Jz24tgSeGQ+nTgB3fmcBoGWiqLmZRQCef3hnGcgfuM8ri9L8Qmy3/IAbbacEKwpkcjWyFW82QQvMAynBapLfrUKI6fk
 rIv3x6Qg6Un/Q3xSJTomtjajSevc9eK74BROk09KNPyEFhOr5syG2s9wm8+vcg9qS2I4aVs8irwbdwmnL/LsbZhJTJtZCoAzrIcRA8qj2zoH/thkrYFA4qof
 H477DJdEe/Gq5dSKTcIu9VWHrPouomUvTOdyyD2kTwqogVb1M/TdTpelSVtd+B2Mtgawmt5Fyi7mUxgX1vGDJdgaT63U2upvzbOVs1jd2Khps7NfeM+E+sVp
 TeiwZQgppS7uXnI6nPvIS97rFjG8mbZtCjDbg/lEkDRVwaH29ad1B0dBI21hfnFlUGdIi7PAOActz/W1FsXI57loHyVL1BmtjksKzox4wYo5idVru0LSXj7K
 0HVrvNRaoFfsV1wWzNb6unohkiQYFeZ1GZjzLorZvfOCekP0WB8tMJ342b3FlUQFCGJrq611hBaHAsMyfRMBZ1OvGL94qj+RuOxP2JxMtM4e9AuMjlhlB2ej
 l1yYFSSr3VDBsmVTrMRk0Znn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 10:48, Ming Qian wrote:
> The amphion vpu codec ip contains encoder and decoder.
> Windsor is the encoder, it supports to encode H.264.
> Malone is the decoder, it features a powerful
> video processing unit able to decode many foramts,

foramts -> formats

> such as H.264, HEVC, and other foramts.

ditto

> 
> This Driver is for this IP that is based on the v4l2 mem2mem framework.
> 
> Supported SoCs are: IMX8QXP, IMX8QM
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/arm64/configs/defconfig               |   1 +
>  drivers/media/platform/Kconfig             |  19 ++
>  drivers/media/platform/Makefile            |   2 +
>  drivers/media/platform/amphion/Makefile    |  20 ++
>  drivers/media/platform/amphion/vpu.h       | 357 +++++++++++++++++++++
>  drivers/media/platform/amphion/vpu_defs.h  | 186 +++++++++++
>  drivers/media/platform/amphion/vpu_drv.c   | 265 +++++++++++++++
>  drivers/media/platform/amphion/vpu_imx8q.c | 271 ++++++++++++++++
>  drivers/media/platform/amphion/vpu_imx8q.h | 116 +++++++
>  9 files changed, 1237 insertions(+)
>  create mode 100644 drivers/media/platform/amphion/Makefile
>  create mode 100644 drivers/media/platform/amphion/vpu.h
>  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f2e2b9bdd702..cc3633112f3f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -657,6 +657,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
>  CONFIG_VIDEO_RCAR_CSI2=m
>  CONFIG_VIDEO_RCAR_VIN=m
>  CONFIG_VIDEO_SUN6I_CSI=m
> +CONFIG_VIDEO_AMPHION_VPU=m
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
>  CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 9fbdba0fd1e7..7d4a8cd52a9e 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -216,6 +216,25 @@ config VIDEO_RCAR_ISP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rcar-isp.
>  
> +config VIDEO_AMPHION_VPU
> +	tristate "Amphion VPU(Video Processing Unit) Codec IP"

Add space before (

> +	depends on ARCH_MXC

Add: || COMPILE_TEST

It should always be possible to compile test drivers, even on other architectures.

> +	depends on MEDIA_SUPPORT
> +	depends on VIDEO_DEV
> +	depends on VIDEO_V4L2
> +	select MEDIA_CONTROLLER
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	select VIDEOBUF2_VMALLOC
> +	help
> +	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
> +	  Windsor is encoder that supports H.264, and Malone is decoder
> +	  that supports H.264, HEVC, and other video formats.
> +	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
> +	  It accelerates encoding and decoding operations on
> +	  various NXP SoCs.
> +	  To compile this driver as a module choose m here.
> +
>  endif # V4L_PLATFORM_DRIVERS
>  
>  menuconfig V4L_MEM2MEM_DRIVERS

Regards,

	Hans
