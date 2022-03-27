Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19BB4E8700
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiC0Iqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiC0Iqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:46:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C91B3;
        Sun, 27 Mar 2022 01:44:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sebastianfricke)
        with ESMTPSA id BF4CE1F43B72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648370693;
        bh=F1dL3cnXKmAu6Uh9VDcqP6Zx5+Do8cHpp5UctZ443fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnH+U2zZXV6Zg/EsRrMfFDPIdf6I5V1yBs4cOngTwiDQM0g3CbGKrmuGpDoyxzxPw
         pcFaEtW8Lgv42KL5+EQCKHZMRNl2hVlmyAEAwVVgBw6oI5e7ZzooDe/Hk207PWQbeq
         BtdIAN8cpkS/Tdq4ECN0xLY+WfgRe5pYHoz5EIQ/t4C7BmI3ccCp60JjAowejnJuFk
         edePFLyNlCvIfeIEwdF18huLRkBzP+0bhUPFoAK+GDlmTSyFMyZS9ybTkW4Xnad2/3
         /G29T/c9My6BsUyw1TOdI+ExY8meXxZHPSKUSBEM0hQig6bki/av0stLjTqfrkkQtX
         bfNILFVWtYh0A==
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
Subject: [RFC PATCH v3 1/2] media: docs-rst: Append HEVC specific term
Date:   Sun, 27 Mar 2022 10:43:08 +0200
Message-Id: <20220327084308.9053-2-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327084308.9053-1-sebastian.fricke@collabora.com>
References: <20220327084308.9053-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

