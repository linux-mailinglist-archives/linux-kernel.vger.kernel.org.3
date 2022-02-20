Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B34BCF52
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiBTPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiBTPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4993527E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k41so8152239wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kpOgd/mbbp4xC3u6NnhKQ40akLsMpySOQSsC87tSzg=;
        b=z1TfAcl+EIvdi3a1jMqc2vwbel5X71Xp4Tz64WSWTGErR1jyE2S8868wdAD9KL4hCU
         cJgEc9sOSoNC7/ildClbpOSqHnc1DVJAoO3G3rxU4zMlbas9VXpaRjOyJPKmr31cO94P
         VV9S87DuZxXw/W/ZEk/LmRFZ/V4M8BbY8SXQBX2uv35smCC9AnNG+rIZXmkMSGCvQ3b8
         X5P1T/DNsU20bJV+/9CGudjn8wTcq2alIjtrEzo+TPQawMbraH+/PQS2Bfj/x35svu5F
         HHBCfmbpPqtCwPOKWxNszIkDT/Q48Saqv42aYuqrk4qL6MLFuNivN9LJFvJadaHapJkb
         1TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kpOgd/mbbp4xC3u6NnhKQ40akLsMpySOQSsC87tSzg=;
        b=J/5Fbu+3mc9AKdNVcLacPf2JNVgOLeIV/M7oCZ1Js2VdOqcm3+HPeA3NrIJK64CUsG
         /L4q6EWr1n1+N4vmI+uFlTURLWr0cNlOu1F4d0BJEuGnMhuzapkmiYGQXbUP1s2b5Ir9
         5CPNbmUXP9AukBDagymbeFVw5iMZMCSuNtpYzsWiWQh25OhKAU8ky7V2sSY26rINslzO
         GgqXiWuJiHbH8tMBoZ/xD5KAnvkhEDxx+rFn88XZ2zIv68fObSnTcFy+R2IrjeBPG7ED
         FUkyyonKSwahmFxMtP8f9rLGjaXVdLtctykEuAHFyrbArsF19HkLIia++d56upw+Tv+/
         tMgw==
X-Gm-Message-State: AOAM531Yqm8RpVRHlpaPUY20u6lZ8h0E05xJydH6Mh3kfIpxg2SsIOT7
        yxi1LOi5bLJBsfQMMq+/0e9bxQ==
X-Google-Smtp-Source: ABdhPJyAFGk0bZ3Gv4Nl5kc2QuloNxbKyqKiERG6K6djqIuRq8KFGEBdX7gRL5ripblYy/jmMKZ4MA==
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id l39-20020a05600c1d2700b0037c74bb2b4dmr18038411wms.82.1645370159634;
        Sun, 20 Feb 2022 07:15:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/13] doc: nvmem: Update example
Date:   Sun, 20 Feb 2022 15:15:25 +0000
Message-Id: <20220220151527.17216-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

Update the example to reflect the new API. I have chosen the brcm-nvram
driver since it seems to be simpler than the qfprom driver.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/driver-api/nvmem.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 56352ad1b1b0..e3366322d46c 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -43,19 +43,20 @@ nvmem_device pointer.
 
 nvmem_unregister(nvmem) is used to unregister a previously registered provider.
 
-For example, a simple qfprom case::
+For example, a simple nvram case::
 
-  static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.owner = THIS_MODULE,
-  };
-
-  static int qfprom_probe(struct platform_device *pdev)
+  static int brcm_nvram_probe(struct platform_device *pdev)
   {
+	struct nvmem_config config = {
+		.name = "brcm-nvram",
+		.reg_read = brcm_nvram_read,
+	};
 	...
-	econfig.dev = &pdev->dev;
-	nvmem = nvmem_register(&econfig);
-	...
+	config.dev = &pdev->dev;
+	config.priv = priv;
+	config.size = resource_size(res);
+
+	devm_nvmem_register(&config);
   }
 
 Users of board files can define and register nvmem cells using the
-- 
2.21.0

