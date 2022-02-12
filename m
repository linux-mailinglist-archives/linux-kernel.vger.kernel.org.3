Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A714B373D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiBLSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiBLSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:46 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3330E60043
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id p10so1309433pfo.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ysuje3nEy8KvAdAcfcWxVoVzsgbCmUXoBnVe5XL9ZLI=;
        b=wPHLfGKLHFKi9xnbSoXzfIWPBKlHLJGYnt7UAa0QUROMkK6gLeTd3BcGYde9yoYHyv
         Sc83DVfbwgvKvQ2wZbPnqJMCFY0tHaV+FOgwuQ+kZkK8rStPD+5oibLMQd+pl1l3IG3r
         nhTNeaIhPWKuNvwUvEzHF6yPiWOoRvwTf3MvzDDjqcO3m94cIdD/ykI7i7zh6rrTzBVa
         UbyQHnI96fpSKQZ2fwlakFoZUouYXSHuto5U+fkoFWa1EYWVAiPcWyVq1T5zTRpAxsf0
         XK1OlRStUcpb9ZfjYXLzU4YFECQBOUyngMWv81FRosViehYyrUebh3WzBEl1zBW21bZ/
         mKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ysuje3nEy8KvAdAcfcWxVoVzsgbCmUXoBnVe5XL9ZLI=;
        b=NifeVg4v9uA43DkyXl4j2hTUL3rLhZOJHk4ZZ95eFzeB+bOIDZQenMjVZzKdjRBip7
         WMOYqGbzBXMa23WuM8j1K3+BokiTsxqMImDIyaph36LBObyl34D+9MKRTXFlmtbcadDI
         50knRM8klWE0Oxh11sylRLm/H5NEGelcB65Y6JwIfic7ZI9DarT5gtQc/UB+KO4VIFc6
         Lb8nTovS/pisdFQ8peUee0v9mW0xZtQL7AWtue++JjIUUub8v5M3bupHDZq27DQyoiXH
         VV+b4zO2PCYWtnYAMZb17n9XxqfXDNNZNRLRDh9SUf8PEpLNGGfwmg4OavyAF8vOZV2D
         xqHw==
X-Gm-Message-State: AOAM5318KQLkfg/uEgIDYfg+6txcHlp/TWj6LWCWr20niFQeMHFYarkD
        hJh9UsYeBm+cNEVwYQqx4Qik
X-Google-Smtp-Source: ABdhPJyZVCadrz2t/5hSZ935KMcv1E7SSSKtfPFkJ6xTWe0nbGfrM39zANDUveiLFxgDoKAFavC7yA==
X-Received: by 2002:a05:6a00:2490:: with SMTP id c16mr7060175pfv.67.1644690209534;
        Sat, 12 Feb 2022 10:23:29 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 22/25] bus: mhi: ep: Add support for processing transfer ring
Date:   Sat, 12 Feb 2022 23:51:14 +0530
Message-Id: <20220212182117.49438-23-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for processing the transfer ring from host. For the transfer
ring associated with DL channel, the xfer callback will simply invoked.
For the case of UL channel, the ring elements will be read in a buffer
till the write pointer and later passed to the client driver using the
xfer callback.

The client drivers should provide the callbacks for both UL and DL
channels during registration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b937c6cda9ba..baf383a4857b 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -439,6 +439,55 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 	return 0;
 }
 
+int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct mhi_result result = {};
+	u32 len = MHI_EP_DEFAULT_MTU;
+	struct mhi_ep_chan *mhi_chan;
+	int ret;
+
+	mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+
+	/*
+	 * Bail out if transfer callback is not registered for the channel.
+	 * This is most likely due to the client driver not loaded at this point.
+	 */
+	if (!mhi_chan->xfer_cb) {
+		dev_err(&mhi_chan->mhi_dev->dev, "Client driver not available\n");
+		return -ENODEV;
+	}
+
+	if (ring->ch_id % 2) {
+		/* DL channel */
+		result.dir = mhi_chan->dir;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+	} else {
+		/* UL channel */
+		do {
+			result.buf_addr = kzalloc(len, GFP_KERNEL);
+			if (!result.buf_addr)
+				return -ENOMEM;
+
+			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
+			if (ret < 0) {
+				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
+				kfree(result.buf_addr);
+				return ret;
+			}
+
+			result.dir = mhi_chan->dir;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+			kfree(result.buf_addr);
+			result.bytes_xferd = 0;
+
+			/* Read until the ring becomes empty */
+		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+	}
+
+	return 0;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-- 
2.25.1

