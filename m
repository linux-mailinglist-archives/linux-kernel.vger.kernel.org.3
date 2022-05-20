Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B35652F5E3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiETWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiETWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:53:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A84C179C1A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:53:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a38so6005367pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o22h3oPMlsnIXryLoOAHFqdN5N7JnmoMxor1pOpYCAw=;
        b=Nr4q8UMKXI8g+fSga4XE9e6j5zTO7pxyCGKLHwzhXugoMHEsve5aEokrP+7MAknMc5
         VBx/CEppMHbPiipvADeMycCYbIlpKSkWjB7Y+JHVcPFqyEb0HXy07eLPTonHh0IZVsw2
         fJnMuP0ERavpR5om8GMQEqUqFTqf6igNRojVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o22h3oPMlsnIXryLoOAHFqdN5N7JnmoMxor1pOpYCAw=;
        b=EK+J8381+wcT7rdC5LEJE0krLT+qIPDIhOY3nG2sFdEW0Pu+pgLiHwpNCRfWajYr3B
         VwHThIrZgzvXWJYYa4jTqiEK7El4Ehxm7CiqyNOfkYo1UPUXo2N8QwJ6ceWaHL/gTqUU
         6E3bgvMGM7JKes07YB+DFCah7bfR4xJqwJl0iEDdCGHim+vg2TCmMJeGNDkBf9Bb3OHX
         9ak8AEXXA4g2hL35iUSDxxZ9H1t3nJxuEk5ZcCiSE7nfqItfVGfUsMnHTkTsjWQXRwth
         TWjaVb6VGa0xJCD5k7w7oZY474WFp+i5a7bfpzrH821aGIplZgoUWwVDOMUeRfOCQFb0
         2vEA==
X-Gm-Message-State: AOAM532eQDf3tmkcpPUpXy50KqNa0CM6eRXfy5pDEgsOIRNlsrrsH7L5
        5UJrT3sdPuLvaZfbOSgB4tEKQw==
X-Google-Smtp-Source: ABdhPJx7JOARztXZqHURTgRX5Op7Y7PuxbJuHlf06rQcT7xomGOQb80ozWjhRMthGXBemfvTsSgk9A==
X-Received: by 2002:a05:6a00:1826:b0:518:4c8b:c5db with SMTP id y38-20020a056a00182600b005184c8bc5dbmr7803168pfa.22.1653087207535;
        Fri, 20 May 2022 15:53:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b090:3896:c312:c4df])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b0015e8d4eb1fbsm258368plq.69.2022.05.20.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:53:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, matvore@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: qcom: socinfo: Add an ID for sc7180P
Date:   Fri, 20 May 2022 15:53:10 -0700
Message-Id: <20220520155305.v2.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sc7180 Chromebooks actually have sc7180P (known by many names,
apparently, including possibly sc7180 Pro and sc7185). This is a
sc7180 part that has slightly higher clock speeds.

The official ID numbrer allocated to these devices by Qualcomm is 495
so we'll add an entry to the table for them. Note that currently
shipping BIOS for these devices will actually end up reporting an ID
of 407 due to a bug but eventually a new BIOS will be released which
corrects it to 495.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Switch from 407 to 495.

 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index cee579a267a6..c2c879ccc6c0 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -332,6 +332,7 @@ static const struct soc_id soc_id[] = {
 	{ 480, "SM8450" },
 	{ 482, "SM8450" },
 	{ 487, "SC7280" },
+	{ 495, "SC7180P" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.36.1.124.g0e6072fb45-goog

