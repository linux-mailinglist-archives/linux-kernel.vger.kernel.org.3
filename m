Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F30057972C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiGSKCj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiGSKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:02:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51F373DBE4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:01:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-44wpZVbANnSqGgqWPqcHHw-1; Tue, 19 Jul 2022 11:01:55 +0100
X-MC-Unique: 44wpZVbANnSqGgqWPqcHHw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 11:01:54 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 11:01:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shengjiu Wang' <shengjiu.wang@nxp.com>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format type
Thread-Topic: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format
 type
Thread-Index: AQHYm1RF9VBLG0gK5ky/ItlmeeUnS62FdfSA
Date:   Tue, 19 Jul 2022 10:01:54 +0000
Message-ID: <f2609401c8834e8bbe926200bfc87971@AcuMS.aculab.com>
References: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
 <1658222864-25378-3-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1658222864-25378-3-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang
> Sent: 19 July 2022 10:28
> 
> Fix sparse warning:
> sound/soc/fsl/fsl_asrc.c:1177:60: sparse: warning: incorrect type in argument 3 (different base types)
> sound/soc/fsl/fsl_asrc.c:1177:60: sparse:    expected unsigned int [usertype] *out_value
> sound/soc/fsl/fsl_asrc.c:1177:60: sparse:    got restricted snd_pcm_format_t *
> sound/soc/fsl/fsl_asrc.c:1200:47: sparse: warning: restricted snd_pcm_format_t degrades to integer
> 
> Fixes: 4520af41fd21 ("ASoC: fsl_asrc: Support new property fsl,asrc-format")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 20a9f8e924b3..544395efd605 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -1174,7 +1174,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> 
> -	ret = of_property_read_u32(np, "fsl,asrc-format", &asrc->asrc_format);
> +	ret = of_property_read_u32(np, "fsl,asrc-format", (u32 *)&asrc->asrc_format);

Ugg, you really shouldn't need to do that.
It means that something is badly wrong somewhere.
Casting pointers to integer types is just asking for a bug.

>  	if (ret) {
>  		ret = of_property_read_u32(np, "fsl,asrc-width", &width);
>  		if (ret) {
> @@ -1197,7 +1197,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  		}
>  	}
> 
> -	if (!(FSL_ASRC_FORMATS & (1ULL << asrc->asrc_format))) {
> +	if (!(FSL_ASRC_FORMATS & (1ULL << (__force u32)asrc->asrc_format))) {

Ditto.

	David

>  		dev_warn(&pdev->dev, "unsupported width, use default S24_LE\n");
>  		asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
>  	}
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

