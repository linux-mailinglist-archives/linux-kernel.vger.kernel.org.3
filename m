Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD9523FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbiEKVsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiEKVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:48:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3E23A713;
        Wed, 11 May 2022 14:48:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b18so5809921lfv.9;
        Wed, 11 May 2022 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6sP9MF85LQx8etkhW8eLxgPVA9IUY3TDzhnSN1EZPw=;
        b=YdVL6LTNJ4dkgB022mJ/gKM2nagkNpdgVkfKhfYl8vSc5F/ohVlcqOAObbEVCLvIX7
         Y4bYVAcyPhixmN/+Xt5xiWmeyvNWEWfhoCTZ3rfAXx3guPKg2mrGE/Bg8ZMKR9O15SA4
         JJsZJeu5ADIjdIA4mR6TUv2mwOvbk9Pr9MEJ7YUPpIsf1pS9Tt+V35DUflCnpHCQ7H/r
         EDXCCdODgGr7YeeiGJetPyiZaL3kJmQ6P5N9DBwZyuMNnf6NmpNzhOChqOPvZ3QgclcL
         KkcrXVnx6BqY9WI/BFTgW+9srPwJJGxnPROZt8VyWB24GW//ekz/Fnd6mew+bOcUIcbH
         mh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6sP9MF85LQx8etkhW8eLxgPVA9IUY3TDzhnSN1EZPw=;
        b=CgdijX9/EmQDqIxSVSvMDwc8FtCZdR5XRfiaMq7xx1vPTH8dgoo4BQqbZu+qjDFq3E
         OLPm5JK/es6BDiUhUM6csA7FQDySw1lJsME6T6jxUKy70ofNMbvHulZFQj23x53XSEPH
         4BCWBBJRQhEScdrQsW7YE+SuCPjt2SBpYWBGcyn3jLgUpYQXnFel1mYfbCgwMqPDkl7S
         NnjTWiBrmXlIimT1Ub4lfvLjyLYwWl1yctoFyPLcKEwAMANj8+ZQtidFEcBFPBl8r710
         9coTP8kV2F2d1jwCfZa0G+gn49CMk3Jh9sMTDIiXJyQcnLDljbXQaM05YZekT9E4b32i
         Ht6Q==
X-Gm-Message-State: AOAM532AyGvpyIHFjo/iMmYAfdiglgpw60NelIH0/VJhYhTkISNd/5Xd
        VGOiCXgeFVWDARdnc/+uOSi3IQHucbu5cA==
X-Google-Smtp-Source: ABdhPJzhaCRyTq1lrGTwMT9IazMt+jljd13/6bLx9BQpIW7V0d7af8al0lsKYABtrAlGNKKiPhDGXQ==
X-Received: by 2002:a05:6512:3c8:b0:474:2645:f42b with SMTP id w8-20020a05651203c800b004742645f42bmr12726743lfp.126.1652305680084;
        Wed, 11 May 2022 14:48:00 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:47:59 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/5] proximity: vl53l0x: Prefer already initialized interrupt flags
Date:   Thu, 12 May 2022 00:47:14 +0300
Message-Id: <20220511214718.50879-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511214718.50879-1-markuss.broks@gmail.com>
References: <20220511214718.50879-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards interrupt type might be different than falling edge,
like hardcoded in driver. Leave interrupt flags as they were pre-configured
from the device-tree. If they're not provided, default to falling edge
interrupts.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 661a79ea200d..ef2c063dfa1c 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -57,11 +57,15 @@ static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
 static int vl53l0x_configure_irq(struct i2c_client *client,
 				 struct iio_dev *indio_dev)
 {
+	int irq_flags = irq_get_trigger_type(client->irq);
 	struct vl53l0x_data *data = iio_priv(indio_dev);
 	int ret;
 
+	if (!irq_flags)
+		irq_flags = IRQF_TRIGGER_FALLING;
+
 	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
-			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
+			irq_flags, indio_dev->name, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
 		return ret;
-- 
2.36.1

