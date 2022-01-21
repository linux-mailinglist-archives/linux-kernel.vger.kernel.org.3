Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F19495BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbiAUISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:24 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48760 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379412AbiAUISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:22 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA5D79FF;
        Fri, 21 Jan 2022 09:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753099;
        bh=gQW6rIcJEbXKCWQJrx+5bX/2dvSKaZOaNpWU2LZIWXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDrlMSS9Lp5cwxA9026oLzmTHha1FYcCPzXKMZIt+T/I1DD/7jXVM5RnBjvylWwkd
         jzyUYbV6HheKkSq7Fhr/qVsoB9iZNMbj4KELF39Yv0qTX2bEm6uWfHlRnbDVuB5iE0
         eR1PRXzhcBCCBmTvkCiY/z7mCw6C4EiBO1oYVEV0=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 2/7] media: v4l: Add V4L2-PIX-FMT-Y14P format
Date:   Fri, 21 Jan 2022 09:18:05 +0100
Message-Id: <20220121081810.155500-3-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a packed grey-scale image format with a depth of 14 bits per
pixel. Every four consecutive samples are packed into seven bytes. Each
of the first four bytes contain the eight high order bits of the pixels,
and the three following bytes contains the six least significants bits
of each pixel, in the same order.

As the other formats only needed 5 bytes before, append two bytes in the
documentation array.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/v4l/pixfmt-yuv-luma.rst             | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index d37ce6027095..c64485b03d27 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -36,6 +36,8 @@ are often referred to as greyscale formats.
       - Byte 2
       - Byte 3
       - Byte 4
+      - Byte 5
+      - Byte 6
 
     * .. _V4L2-PIX-FMT-GREY:
 
@@ -47,6 +49,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10:
 
@@ -58,6 +62,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10BPACK:
 
@@ -69,6 +75,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`2`\ [9:6]
       - Y'\ :sub:`2`\ [5:0] Y'\ :sub:`3`\ [9:8]
       - Y'\ :sub:`3`\ [7:0]
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10P:
 
@@ -80,6 +88,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`2`\ [9:2]
       - Y'\ :sub:`3`\ [9:2]
       - Y'\ :sub:`3`\ [1:0] Y'\ :sub:`2`\ [1:0] Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [1:0]
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y12:
 
@@ -91,6 +101,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y12P:
 
@@ -102,6 +114,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`0`\ [3:0]
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y14:
 
@@ -113,6 +127,21 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
+
+    * .. _V4L2-PIX-FMT-Y14P:
+
+      - ``V4L2_PIX_FMT_Y14P``
+      - 'Y14P'
+
+      - Y'\ :sub:`0`\ [13:6]
+      - Y'\ :sub:`1`\ [13:6]
+      - Y'\ :sub:`2`\ [13:6]
+      - Y'\ :sub:`3`\ [13:6]
+      - Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [5:0]
+      - Y'\ :sub:`2`\ [3:0] Y'\ :sub:`1`\ [5:2]
+      - Y'\ :sub:`3`\ [5:0] Y'\ :sub:`2`\ [5:4]
 
     * .. _V4L2-PIX-FMT-Y16:
 
@@ -124,6 +153,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y16-BE:
 
@@ -135,6 +166,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
 .. raw:: latex
 
-- 
2.32.0

