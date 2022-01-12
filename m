Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A104A48C7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354972AbiALQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:10:41 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44588 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354948AbiALQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:10:34 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:662a:d95e:24d7:7832])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A47CD88;
        Wed, 12 Jan 2022 17:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642003832;
        bh=CPL98TndGKGtkQcQXijSpd9jF0KSEN0Y2anSqTA4qKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcVUf4LmYd0ePpzKRgPJevaePM4s7diAKhu4Bebr/Ln1dCZk5PXk6ocSgL8A74daq
         tKAzUe1xoDVevlEG11LqQEQ7Szeg/5sp9UPVKc64STaiQfvdUbewpZBWFmIougNXPX
         DKScfZzeQaWXeg219wNYapY0dVLX5gwga6tYcoqo=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        dave.stevenson@raspberrypi.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH 1/3] media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format
Date:   Wed, 12 Jan 2022 17:10:12 +0100
Message-Id: <20220112161014.972076-2-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This packed grey-scale image format has a depth of 10 bits per pixel.
Every four consecutive pixels are packed into 5 bytes. Each of the first
4 bytes contain the 8 high order bits of the pixels, and the 5th byte
contains the 2 least significants bits of each pixel, in the same order.

The first two bytes are not corresponding to this description, fix it.

Fixes: af4f45057695 ("media: doc: pixfmt-yuv: Move all luma-only YUV formats to common file")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 91942c4f0967..8ebd58c3588f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -75,8 +75,8 @@ are often referred to as greyscale formats.
       - ``V4L2_PIX_FMT_Y10P``
       - 'Y10P'
 
-      - Y'\ :sub:`0`\ [7:0]
-      - Y'\ :sub:`1`\ [9:8]
+      - Y'\ :sub:`0`\ [9:2]
+      - Y'\ :sub:`1`\ [9:2]
       - Y'\ :sub:`2`\ [9:2]
       - Y'\ :sub:`3`\ [9:2]
       - Y'\ :sub:`3`\ [1:0] Y'\ :sub:`2`\ [1:0] Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [1:0]
-- 
2.32.0

