Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD54C1984
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbiBWRI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbiBWRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:08:25 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB91EC55;
        Wed, 23 Feb 2022 09:07:56 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E55524000A;
        Wed, 23 Feb 2022 17:07:51 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:07:50 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 09/13] media: atmel: atmel-sama7g5-isc: remove stray
 line
Message-ID: <20220223170750.ww74aih6a5jtpurm@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-10-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-10-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:41PM +0200, Eugen Hristev wrote:
> Remove stray line from formats struct.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  drivers/media/platform/atmel/atmel-sama7g5-isc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> index a0d60cfdba7b..638af8da2694 100644
> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> @@ -225,7 +225,6 @@ static struct isc_format sama7g5_formats_list[] = {
>  		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
>  		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
>  	},
> -
>  };
>
>  static void isc_sama7g5_config_csc(struct isc_device *isc)
> --
> 2.25.1
>
