Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5855FB60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiF2JH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiF2JHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:07:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED262656E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i1so16908344wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhVaynt23RZRT72OSOPmlLkNv8BfKDn8DPYKDlNl7mo=;
        b=cN3diKYfDOCVK1xYzkybVDRxCRDWEl8dMbv3Yj2mH1/7LycshrX5t7yvg9Nqv4CvNw
         Per/DCaLPXJGkIc2u4jt50Cx5s7SUGjt+PkMzsfhBidJHdxUPZDOKNI7GNvJgjq4RNFP
         M8rrhHumc6+LjSFsEwlrtCMDyP2roUBPdF43EQK3nzS/7w7gomqtHFZd/4wbCG7hpSc/
         BfpjJMUqCblNJYjMlrguPhEEALp1nt6BYwyBCCKAfqn+Gb2KLc8Sb9tuUEPtEvn7WWPY
         GUsoBNUMqfZeknWhFNfZjCIFTQF+0wOQ8DYzez67V5chh/iJgZRmAazf1M9HfvdF1Lnl
         fH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhVaynt23RZRT72OSOPmlLkNv8BfKDn8DPYKDlNl7mo=;
        b=22JZ6OiVdNH754+HWEA2hyn2Y7TJHZC5oAEDFEvDSWoVdZgquDeGC0SpboRJ7xWKXq
         ESShT1AmrMrCh4rxOoG2/jNrTy0QPrQXQGbZrwLNqkrTwgafW9QNTQrRRYfAeDx1Ej3/
         STo8mt/fNMXkCapKv0R6yAn+5xdlAYmB1vg5LLG0RU+awdGRaCIk2d6c24cmOCQ0qR+f
         EwxXw6uyr2+7WXj6U4hKwAMHKY4I/iokj93Pi5w5oDsuKfyv7VipHHM8tGbHCNvrRzJf
         /zTgt+hoT6B6VKg+F7wm3DZYWGP/doULfIc6LizPVbyk6KMSkFTTAkUZvTeWJeVvVXBZ
         Qz4Q==
X-Gm-Message-State: AJIora8e12k+2qBxqR04egp737kj8HvcMBABa3b9d8MeWlnWKnT8UDRY
        6IG7OGNYVwtlfG/17frtua3mWg==
X-Google-Smtp-Source: AGRyM1t/1AaRCniJIXjV+UbMmrXdTt54J5swO771KzJyBE+o4ZTbf1SC9VwQ929xbiGztSbq+J2AWg==
X-Received: by 2002:adf:fb46:0:b0:210:2316:dd02 with SMTP id c6-20020adffb46000000b002102316dd02mr2024995wrs.557.1656493629137;
        Wed, 29 Jun 2022 02:07:09 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm15993341wrv.75.2022.06.29.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:07:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] MAINTAINERS: add ASoC Qualcomm codecs
Date:   Wed, 29 Jun 2022 10:06:44 +0100
Message-Id: <20220629090644.67982-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
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

Add missing Qualcomm codes to the list.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 171fa3160696..c4648e86dc14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16250,6 +16250,8 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	sound/soc/codecs/lpass-rx-macro.*
+F:	sound/soc/codecs/lpass-tx-macro.*
 F:	sound/soc/codecs/lpass-va-macro.c
 F:	sound/soc/codecs/lpass-wsa-macro.*
 F:	sound/soc/codecs/msm8916-wcd-analog.c
@@ -16257,7 +16259,9 @@ F:	sound/soc/codecs/msm8916-wcd-digital.c
 F:	sound/soc/codecs/wcd9335.*
 F:	sound/soc/codecs/wcd934x.c
 F:	sound/soc/codecs/wcd-clsh-v2.*
+F:	sound/soc/codecs/wcd-mbhc-v2.*
 F:	sound/soc/codecs/wsa881x.c
+F:	sound/soc/codecs/wsa883x.c
 F:	sound/soc/qcom/
 
 QCOM EMBEDDED USB DEBUGGER (EUD)
-- 
2.25.1

