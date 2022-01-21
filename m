Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9128495BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379454AbiAUIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379430AbiAUISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A2C061574;
        Fri, 21 Jan 2022 00:18:23 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E1DA883;
        Fri, 21 Jan 2022 09:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753099;
        bh=3+WJ1VEEEx7AKfOQLCiDzdiSnj6PpIWk7JDoawFg4wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnKGy2e2Bc1+e14Q5mmySdNElohjgWq04zKGbr55MblLOEx2chMlGf7A+VM7Un9I4
         3omm/ptOTAWYxlEKct8suQEYB2SLW+7sLuy0xSRJS1SXNMJHX4koqJ0H4vuFHcheMm
         gF2ElLyY38atiJIsUyFr8TqnzVvLpqn5mdZfdkP8=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 1/7] media: v4l: Add V4L2-PIX-FMT-Y12P format
Date:   Fri, 21 Jan 2022 09:18:04 +0100
Message-Id: <20220121081810.155500-2-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
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

