Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45095B0060
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIGJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIGJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:25:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693D474EA;
        Wed,  7 Sep 2022 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662542693; x=1694078693;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i3OpScyz4S2GYqXWJMQAAeU2Xn1hLYk5DlrfzSFJe4U=;
  b=mCTNY3jaSG9T9InzdPEJ39nkbJ4wvnUyBlf6McNpSY4Wpq8Suw0lrouS
   LHolE/RP/5/LbHN+UW1OuxGFscp+B2/vr7A2NcFOtB8vtBjyUcky3geQU
   rmTZ7bcQNJFBx6LT2wasQKI6E4eAWTjxm7E3od4doZ9HV9m+/tQzIUpA6
   Ryr/0uXFLYmjEvKAWpnZGBxOzuAIvP3ZLCV6NvDsqkjggr4hjqnbGeLWE
   EAzO08dglkeG28FHLHg6MvI/B5zZAmuYzkmJQMegVL1GwNwpdVR7HwjJy
   ITS5vbNi+KphY2Nh9omgasDylune65i0+e1NNGtx/sIzonMr99wRJEQu0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276564957"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="276564957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:24:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676097466"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:24:47 -0700
Date:   Wed, 7 Sep 2022 12:24:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, jirislaby@kernel.org,
        admin@hifiphile.com, kavyasree.kotagiri@microchip.com,
        tudor.ambarus@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 09/13] tty: serial: atmel: Define BRSRCCK bitmask of
 UART IP's Mode Register
In-Reply-To: <20220906135511.144725-10-sergiu.moga@microchip.com>
Message-ID: <b36cb6fb-6e11-3e93-fad-e5d6375e741@linux.intel.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-10-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022, Sergiu Moga wrote:

> Add definitions for the Baud Rate Source Clock bitmask of the
> Mode Register of UART IP's and its bitfields.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before
> 
> 
> 
>  drivers/tty/serial/atmel_serial.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
> index 70d0611e56fd..ed64035ba6c3 100644
> --- a/drivers/tty/serial/atmel_serial.h
> +++ b/drivers/tty/serial/atmel_serial.h
> @@ -68,6 +68,9 @@
>  #define		ATMEL_US_NBSTOP_1		(0 << 12)
>  #define		ATMEL_US_NBSTOP_1_5		(1 << 12)
>  #define		ATMEL_US_NBSTOP_2		(2 << 12)
> +#define	ATMEL_UA_BRSRCCK	GENMASK(13, 12)	/* Clock Selection for UART */
> +#define		ATMEL_UA_BRSRCCK_PERIPH_CLK	(0 << 12)
> +#define		ATMEL_UA_BRSRCCK_GCLK		(1 << 12)

FIELD_PREP(ATMEL_UA_BRSRCCK, ...)

>  #define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
>  #define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
>  #define		ATMEL_US_CHMODE_ECHO		(1 << 14)
> 

-- 
 i.

