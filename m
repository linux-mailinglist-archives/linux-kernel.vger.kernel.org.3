Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA974A7756
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiBBR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:57:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58146 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbiBBR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:56:50 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7139:eada:2ff6:73dd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12E25D88;
        Wed,  2 Feb 2022 18:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643824609;
        bh=3+WJ1VEEEx7AKfOQLCiDzdiSnj6PpIWk7JDoawFg4wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rb8wkH8mTD6YCTaTFQ4c5OBW3dp+wygotzRQI+qq1YgBd71TWsyD2W4RfzEUmlGGh
         rGgZvMmXwwrkmYi5jCXCad/BiRe/m52LULEgmGY/vliTuUKfFQCJWFwsnn8Bl/FjVH
         1cNjzWrTKHXiy2H82k5drZXv3sMKmxVCqDr6ZROs=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v3 01/11] media: v4l: Add V4L2-PIX-FMT-Y12P format
Date:   Wed,  2 Feb 2022 18:56:29 +0100
Message-Id: <20220202175639.149681-2-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a packed grey-scale image format with a depth of 12 bits per
pixel. Two consecutive pixels are packed into 3 bytes. The first 2 bytes
contain the 8 high order bits of the pixels, and the 3rd byte contains
the 4 least significants bits of each pixel, in the same order.

Add the entry in userspace API, and document it.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 8ebd58c3588f..d37ce6027095 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -92,6 +92,17 @@ are often referred to as greyscale formats.
       - ...
       - ...
 
+    * .. _V4L2-PIX-FMT-Y12P:
+
+      - ``V4L2_PIX_FMT_Y12P``
+      - 'Y12P'
+
+      - Y'\ :sub:`0`\ [11:4]
+      - Y'\ :sub:`1`\ [11:4]
+      - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`0`\ [3:0]
+      - ...
+      - ...
+
     * .. _V4L2-PIX-FMT-Y14:
 
       - ``V4L2_PIX_FMT_Y14``
-- 
2.32.0

