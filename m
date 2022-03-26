Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68D4E8357
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiCZSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiCZSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:35:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D91EEF0;
        Sat, 26 Mar 2022 11:33:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:4cb:3227:231:99f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BF73D1F40C70;
        Sat, 26 Mar 2022 18:33:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648319634;
        bh=F1dL3cnXKmAu6Uh9VDcqP6Zx5+Do8cHpp5UctZ443fM=;
        h=From:To:Cc:Subject:Date:From;
        b=Dxe0Qk5GLqgaLCfU5869zJs3CanLcbpKDStnNBpn/1VUNfJzXIFw0Mzq6k2xvlqLA
         ZhXyINNAS71xfREVRlKs5ZZTcDgtolqf+43qhhtPSiKH7EvVAeO2jer/dyBRYIP6JH
         fBcVXPQRHjU3Ma6BKtUUenq5DCoXwpZ672xN+91rVyvS5/1r/f5sB7AsJzJp/MSm8L
         wlpJ38EmUOK08YUxTCAa9ZGqaL6f4GfQBT2+yt+ukhCuQxM4aKKXXPandP11VZDMIp
         UwaE5gQDxuMsFMEU3pxJhhqjeP4yc/c4FkFN4MY9dOpZEiicTCttJqAX+GnXkI4Rgj
         yQLSnOO6U4EYw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     acourbot@chromium.org, tfiga@chromium.org,
        hverkuil-cisco@xs4all.nl,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [RFC PATCH 1/2] media: docs-rst: Append HEVC specific term
Date:   Sat, 26 Mar 2022 19:31:56 +0100
Message-Id: <20220326183158.65303-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the coding tree unit as replacement for the macroblock in the
HEVC codec. Highlight a key difference of the HEVC codec to predecessors
like AVC(H.264) to give a better overview of the differences between the
coding standards.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 Documentation/userspace-api/media/v4l/dev-decoder.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Documentation/userspace-api/media/v4l/dev-decoder.rst
index 3cf2b496f2d0..eb5b1b1e3a51 100644
--- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
@@ -72,6 +72,11 @@ coded resolution
 coded width
    width for given coded resolution.
 
+coding tree unit
+   processing unit of the HEVC codec (≘ macroblock units in H.264, VP8, VP9);
+   can use block structures of up to 64×64 pixels;
+   Good at sub-partitioning the picture into variable sized structures.
+
 decode order
    the order in which frames are decoded; may differ from display order if the
    coded format includes a feature of frame reordering; for decoders,
@@ -104,7 +109,8 @@ keyframe
 macroblock
    a processing unit in image and video compression formats based on linear
    block transforms (e.g. H.264, VP8, VP9); codec-specific, but for most of
-   popular codecs the size is 16x16 samples (pixels).
+   popular codecs the size is 16x16 samples (pixels). The HEVC codec uses a
+   slightly more flexible processing unit called coding tree unit (CTU).
 
 OUTPUT
    the source buffer queue; for decoders, the queue of buffers containing
-- 
2.25.1

