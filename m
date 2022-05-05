Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14E51B97A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbiEEHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbiEEHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:54:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A61205CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:50:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nmWFe-0005Nb-AM; Thu, 05 May 2022 09:50:18 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nmWFd-0000oa-KA; Thu, 05 May 2022 09:50:17 +0200
Date:   Thu, 5 May 2022 09:50:17 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_micfil: fix the naming style for mask
 definition
Message-ID: <20220505075017.GJ4012@pengutronix.de>
References: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:44 up 35 days, 20:19, 82 users,  load average: 0.27, 0.17,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 03:34:07PM +0800, Shengjiu Wang wrote:
> Remove the _SHIFT for the mask definition.
> 
> Fixes: 17f2142bae4b ("ASoC: fsl_micfil: use GENMASK to define register bit fields")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

>  sound/soc/fsl/fsl_micfil.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
> index 08901827047d..053caba3caf3 100644
> --- a/sound/soc/fsl/fsl_micfil.h
> +++ b/sound/soc/fsl/fsl_micfil.h
> @@ -74,9 +74,9 @@
>  #define MICFIL_FIFO_STAT_FIFOX_UNDER(ch)	BIT((ch) + 8)
>  
>  /* MICFIL HWVAD0 Control 1 Register -- REG_MICFIL_VAD0_CTRL1*/
> -#define MICFIL_VAD0_CTRL1_CHSEL_SHIFT	GENMASK(26, 24)
> -#define MICFIL_VAD0_CTRL1_CICOSR_SHIFT	GENMASK(19, 16)
> -#define MICFIL_VAD0_CTRL1_INITT_SHIFT	GENMASK(12, 8)
> +#define MICFIL_VAD0_CTRL1_CHSEL		GENMASK(26, 24)
> +#define MICFIL_VAD0_CTRL1_CICOSR	GENMASK(19, 16)
> +#define MICFIL_VAD0_CTRL1_INITT		GENMASK(12, 8)
>  #define MICFIL_VAD0_CTRL1_ST10		BIT(4)
>  #define MICFIL_VAD0_CTRL1_ERIE		BIT(3)
>  #define MICFIL_VAD0_CTRL1_IE		BIT(2)
> @@ -106,7 +106,7 @@
>  
>  /* MICFIL HWVAD0 Zero-Crossing Detector - REG_MICFIL_VAD0_ZCD */
>  #define MICFIL_VAD0_ZCD_ZCDTH		GENMASK(25, 16)
> -#define MICFIL_VAD0_ZCD_ZCDADJ_SHIFT	GENMASK(11, 8)
> +#define MICFIL_VAD0_ZCD_ZCDADJ		GENMASK(11, 8)
>  #define MICFIL_VAD0_ZCD_ZCDAND		BIT(4)
>  #define MICFIL_VAD0_ZCD_ZCDAUT		BIT(2)
>  #define MICFIL_VAD0_ZCD_ZCDEN		BIT(0)
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
