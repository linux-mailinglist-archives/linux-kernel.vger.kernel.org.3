Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769EB4F5F53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiDFNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiDFNHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901835E3C23;
        Wed,  6 Apr 2022 02:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25755B821EE;
        Wed,  6 Apr 2022 09:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6883AC385A1;
        Wed,  6 Apr 2022 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238094;
        bh=wZn/e4sxHXSGTfbPNJYitmbYpHxKQIky6u4oMw7PM3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1W0Pq5VlxzT1vxIppRRRaQHjPiyd2+3GjHsfBtAWL2t2RGvPpA7SUYNfei7Dglei
         z4KGysW/RSwx9pKhtTxoCmEpn7yn/Pefo9G8NGHMj7LdE9rynk4B4H0FN/NYmSyDlQ
         e8F3HzNs5cYPvUlPCMznnzAJS2XFTekbsnHHIka8v+VoGy/BPtMib/GK5OQgUS2ATL
         e09lQ4QumD5jYP4iAGT/2E5l2HcC21uMCjMt/HLXjy3YE4GHcV5gCOYOtdAPskahQb
         b2TGAFfT/WyGpeNt28kY16lrhjIzn0RjNGArzfq7Thf9PV7U+8TlxvZMaa5T222Gjh
         1wwCWYmpvOurw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v7 13/14] drm/msm: Update generated headers
Date:   Wed,  6 Apr 2022 15:10:30 +0530
Message-Id: <20220406094031.1027376-14-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406094031.1027376-1-vkoul@kernel.org>
References: <20220406094031.1027376-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update headers from mesa commit:

  commit 28ae397be111c37c6ced397e12d453a7695701bd
  Author: Vinod Koul <vkoul@kernel.org>
  Date:   Fri Apr 1 16:53:04 2022 +0530

      freedreno/registers: update dsi registers to support dsc

      Display Stream compression (DSC) compresses the display stream in
      host which is later decoded by panel. This requires addition of 3 new
      DSI registers to support DSC over DSI.

      Signed-off-by: Vinod Koul <vkoul@kernel.org>
      Part-of: <https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/14967>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi.xml.h | 80 +++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
index 4dee6f0bdda6..d1b2a17b0a66 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
@@ -704,5 +704,85 @@ static inline uint32_t DSI_VERSION_MAJOR(uint32_t val)
 
 #define REG_DSI_CPHY_MODE_CTRL					0x000002d4
 
+#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL			0x0000029c
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__MASK		0xffff0000
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__SHIFT		16
+static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(uint32_t val)
+{
+	return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__MASK;
+}
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__MASK		0x00003f00
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__SHIFT		8
+static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE(uint32_t val)
+{
+	return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__MASK;
+}
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__MASK	0x000000c0
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__SHIFT	6
+static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(uint32_t val)
+{
+	return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__MASK;
+}
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__MASK	0x00000030
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__SHIFT	4
+static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(uint32_t val)
+{
+	return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__MASK;
+}
+#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EN			0x00000001
+
+#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL			0x000002a4
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__MASK	0x3f000000
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__SHIFT	24
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__MASK	0x00c00000
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__SHIFT	22
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__MASK	0x00300000
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__SHIFT	20
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EN		0x00010000
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__MASK	0x00003f00
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__SHIFT	8
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__MASK	0x000000c0
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__SHIFT	6
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__MASK	0x00000030
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__SHIFT	4
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EN		0x00000001
+
+#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2			0x000002a8
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__MASK	0xffff0000
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__SHIFT	16
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__MASK;
+}
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__MASK	0x0000ffff
+#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__SHIFT	0
+static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH(uint32_t val)
+{
+	return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__MASK;
+}
 
 #endif /* DSI_XML */
-- 
2.34.1

