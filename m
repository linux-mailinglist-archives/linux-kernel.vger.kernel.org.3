Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE755FBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiF2JZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiF2JZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:25:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EA38BD0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:25:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so21462736wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZXMB4ou39aHJBfpOtAkz0VGE1mJbTQ50FrN9wH0yuw=;
        b=TMiM9GduV4kUsax+oP0BqCL+axbrfKZVtU/FwwA4stjYv3ZrsjQSN+cVLrrcMnJx17
         rbNwEgzD0bMfjEKucqpL9OpkqF/msT9mEhRRzP1cWLhz1hLtKAvLKHHB1qQfJYIU18uH
         e1L+2kQcABLJbGK5Mba9oD/EUcEDqosHWT/LDwgX45h+nuCcoar3qRIXKoxSMmkKKMb4
         5GftnCHUe8DIV3miZrN0COF26J4L9PbpyD4Lrn6vWS5fraYPHofzK6Oa1tlqkOqz3N9B
         uHqjcaB24E48cwyIG98lNaBw1VkFUOO5TwM1JxT8dKM5FM9E5iI/QuhvQgerGRuMXnsw
         5Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZXMB4ou39aHJBfpOtAkz0VGE1mJbTQ50FrN9wH0yuw=;
        b=EuP0DsTIkdwEk1alz9tertkmRJ+t/ZVbSqi/ih07xLlFn29afBCXAF7ER09Xyy/wlY
         uTFmUjWE6AcLKzJOwlTqHmcwsDlvYljuhALNfpj/tFHFkO7sZQLkdyZP1Ou3sQs0f+jv
         Hc9fTdZiobUl7HIx/jreMsQ9HpRcx5j9kPcPX3FP7CpBiAzHikVWYrpq8TXJoOINAm2T
         ZmmAGxsB9kPC9487sv+A2jw5vWdnvYefjvzokohflicfTrPknkYGXZ9GXS43mHFY6cl9
         IhzJhpNLHMnCSQ9w7dkDDXHNFNxVJ52WmLG8ud86eGousp2tn3Rb3AcgkreNvpXwT6Xi
         rijQ==
X-Gm-Message-State: AJIora+7cc8D310SSI+SgdltC5H4wyyNIjUcj7oXgd/5risKV0/Y2QYO
        UWPmQcV670n8sbd9TL/gR0iKOQ==
X-Google-Smtp-Source: AGRyM1ta/+OXi4dIyS810zecgvgLP1IesobNM4wDE151WICwk06mXdyYUrZxu03MluDXlQFfX9TsvA==
X-Received: by 2002:a05:6000:1ac7:b0:21d:134e:5d74 with SMTP id i7-20020a0560001ac700b0021d134e5d74mr2221078wry.78.1656494717822;
        Wed, 29 Jun 2022 02:25:17 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c140300b0039c96b97359sm2446261wmi.37.2022.06.29.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:25:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] MAINTAINERS: pinctrl: update qcom file list to include yaml files
Date:   Wed, 29 Jun 2022 10:25:14 +0100
Message-Id: <20220629092514.70752-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Currently Qualcomm pinctrl MAINTAINERS file list does not include yaml
files. Include this for correctness.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4648e86dc14..71e7725aa574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15765,6 +15765,7 @@ M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/qcom,*.txt
+F:	Documentation/devicetree/bindings/pinctrl/qcom,*.yaml
 F:	drivers/pinctrl/qcom/
 
 PIN CONTROLLER - RENESAS
-- 
2.25.1

