Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6F49BA53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiAYR03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:26:29 -0500
Received: from relay031.a.hostedemail.com ([64.99.140.31]:63473 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1380798AbiAYRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:19:27 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 3182320C1C;
        Tue, 25 Jan 2022 17:19:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 4035D42;
        Tue, 25 Jan 2022 17:18:51 +0000 (UTC)
Message-ID: <afcc70baa10003ce89c70b7b310981672547218b.camel@perches.com>
Subject: Re: [PATCH v15 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2
 driver entry
From:   Joe Perches <joe@perches.com>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 25 Jan 2022 09:19:02 -0800
In-Reply-To: <2f695f6a597a4372842d75105b654fba6db27d59.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
         <2f695f6a597a4372842d75105b654fba6db27d59.1643077283.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qd8yigbcjnn7odxdizrocdsn51sg6mrd
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4035D42
X-Spam-Status: No, score=-0.34
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19qj9D5y8YasMCA8MRO8wfsgSoZYAra1qc=
X-HE-Tag: 1643131131-328248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-25 at 15:11 +0800, Ming Qian wrote:
> Add AMPHION VPU CODEC v4l2 driver entry
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -13913,6 +13913,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>  F:	drivers/media/platform/imx-jpeg
>  
> +AMPHION VPU CODEC V4L2 DRIVER
> +M:	Ming Qian <ming.qian@nxp.com>
> +M:	Shijie Qin <shijie.qin@nxp.com>
> +M:	Zhou Peng <eagle.zhou@nxp.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
> +F:	drivers/media/platform/amphion/
> +

Alphabetic section ordering please.

>  NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
>  M:	Jonas Malaco <jonas@protocubo.io>
>  L:	linux-hwmon@vger.kernel.org


