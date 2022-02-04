Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2714A990B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbiBDMPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:38 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:1606 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358582AbiBDMP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976928; x=1675512928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEvmELRomxbDMI2VuE/soti3drclybeWHepOSKt/hkw=;
  b=KKijEnbyMMR2ZtsrmVrxRFM5BqdNvneOQTerHOFaLV0jnob4XPlmX0yY
   PC2ztzmZUCcfMRQ118E9hRcd+FgO2osl+zoYvSCBp+9shxbT/7pjLGIWv
   gdpD4J2d0UcbUw5wIlOuJP/2Bh5l3/ESUwVby2Wf7Apn3zkOMt3DHGED8
   PMJucew0BWqihxLX59dII3wzBqQgp93aK5akuAQFUxNLbRg2Ew9JoWAv/
   7hGoIcrVIgIb3qf6pOkvsGoEDD5fBxka4ecdvWeS4aV+IA3yFHSIiUFjB
   yZiFGoApg5N0tcbWE3yXKAzcKOBgcAvOT5PiCmvUc3SickEhb5o+G55rc
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903436"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976926; x=1675512926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEvmELRomxbDMI2VuE/soti3drclybeWHepOSKt/hkw=;
  b=mantmV7PeyQB9YOtQOrEWqyKyg2sh4alMqKOVHPHYkD9vJTbpiUa70Zi
   gSm1zZbUY6IMr963DNaGPof2a4j8gc3lP9gSyRVZAc/6n/uVczJSpmd4f
   UxO0z7dd19oFxM+LBXILAvXXEjUQ4h+jzDgnK+SwbY7VWMKkz5Kh81mGu
   +B7QQiiezLR/QtW7fy1nnMmL42AYbT+2i5PpbMmudCVQQ30MTdRuxd71K
   KdDEjBaywLTRQWpgIPb759dRn9fKIIMGEDsS6TE7oiVWhXXKE9DLytXgk
   9sElGxr15C9ztr1V0seP0ibdqTW3hVVeNpGioRB5GZQyc8CKpjmgYRulz
   g==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903435"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 26FEC280075;
        Fri,  4 Feb 2022 13:15:26 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] media: imx: utils: Add more Bayer formats
Date:   Fri,  4 Feb 2022 13:15:13 +0100
Message-Id: <20220204121514.2762676-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this the ioctl VIDIOC_ENUM_FMT will not list the 10/12/14-Bit
Bayer formats. This in return results in
"v4l2-ctl --set-fmt-video pixelformat='RG10'" failing to set the
pixelformat as it is not enumerated as supported format.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This adds the following formats to `v4l2-ctl --list-formats`
[...]
        [18]: 'BG10' (10-bit Bayer BGBG/GRGR)
        [19]: 'GB10' (10-bit Bayer GBGB/RGRG)
        [20]: 'BA10' (10-bit Bayer GRGR/BGBG)
        [21]: 'RG10' (10-bit Bayer RGRG/GBGB)
        [22]: 'BG12' (12-bit Bayer BGBG/GRGR)
        [23]: 'GB12' (12-bit Bayer GBGB/RGRG)
        [24]: 'BA12' (12-bit Bayer GRGR/BGBG)
        [25]: 'RG12' (12-bit Bayer RGRG/GBGB)
        [26]: 'BG14' (14-bit Bayer BGBG/GRGR)
        [27]: 'GB14' (14-bit Bayer GBGB/RGRG)
        [28]: 'GR14' (14-bit Bayer GRGR/BGBG)
        [29]: 'RG14' (14-bit Bayer RGRG/GBGB)
[...]

 drivers/staging/media/imx/imx-media-utils.c | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index e0a256a08c3b..ea56c82d3b32 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -130,6 +130,78 @@ static const struct imx_media_pixfmt pixel_formats[] = {
 		.cs     = IPUV3_COLORSPACE_RGB,
 		.bpp    = 8,
 		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_SBGGR16,
 		.codes  = IMX_BUS_FMTS(
-- 
2.25.1

