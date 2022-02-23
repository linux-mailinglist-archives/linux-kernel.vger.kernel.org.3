Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F44C196A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiBWRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiBWRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:06:55 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632645A585;
        Wed, 23 Feb 2022 09:06:18 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D33A21BF203;
        Wed, 23 Feb 2022 17:06:13 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:06:11 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 03/13] media: atmel: atmel-isc: remove redundant
 comments
Message-ID: <20220223170611.bv64yqmyuqrzeu2x@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-4-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-4-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:35PM +0200, Eugen Hristev wrote:
> Remove duplicate comments which are already in place before the struct
> definition.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  drivers/media/platform/atmel/atmel-isc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index 07fa6dbf8460..f9ad7ec6bd13 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -272,7 +272,7 @@ struct isc_device {
>  	struct video_device	video_dev;
>
>  	struct vb2_queue	vb2_vidq;
> -	spinlock_t		dma_queue_lock; /* serialize access to dma queue */
> +	spinlock_t		dma_queue_lock;
>  	struct list_head	dma_queue;
>  	struct isc_buffer	*cur_frm;
>  	unsigned int		sequence;
> @@ -289,8 +289,8 @@ struct isc_device {
>  	struct isc_ctrls	ctrls;
>  	struct work_struct	awb_work;
>
> -	struct mutex		lock; /* serialize access to file operations */
> -	spinlock_t		awb_lock; /* serialize access to DMA buffers from awb work queue */
> +	struct mutex		lock;
> +	spinlock_t		awb_lock;
>
>  	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
>
> --
> 2.25.1
>
