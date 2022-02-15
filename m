Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAC4B73D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiBOQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:41:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiBOQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:41:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B594F2135;
        Tue, 15 Feb 2022 08:41:00 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e5so8207818lfr.9;
        Tue, 15 Feb 2022 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjPOeSE+RdrU9J1G95EImhMutKQlZfD+MfnQPmxkIM4=;
        b=iqxLiVFDhQ8rUiXvcWGTD8xi2LzcZdiT9P+dVlz8CO9P4HeVLyisSID8nN1JkC91iJ
         aZkgZU1FAk3g3rsAHUkVaJpKSu+h5FvYMLWxEcjMBd9uKNThzu6wMAdH9xB0mwe+xHzF
         UftxSRyUyhHHJal8VjaQl8T4Lb8DX8zbQY804jUhbDiCLqo6/sJ9w2IrHiMfP9bV66Zq
         4m4vEahHsDEKcY6UseJwYA+oIpBVEctuIyp5OLmy53IAOF/rmMpzhq5wF0J1pVz47EA3
         X8elvkx7bY6BC9TvchH3AnVvOWAx50nZ2umjKlWOI5r+Xp5u++rZB+pxQlB26x0dYQaD
         RKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjPOeSE+RdrU9J1G95EImhMutKQlZfD+MfnQPmxkIM4=;
        b=K8IAoI2Epz451R2OeKJK/ocAqVCT6nGy7NRyWiXgbRgd1VmgaQrSauGoYv2GOJU2F3
         I86u8n2oq4NmB4gUEbOUlMisj1HYjb3K9k2WBrg0JlIEmbIBMWzmZZv4oY0dSuk/rJ3k
         M+neluWiFYSYsXY3KxHQPcYRkB8FNiVyOEDx59RnlrQLdLFwXmx3wfjmdJ05urofbZvl
         qkxnn1BSIFfyl0kILICRTyffwfmp2xSZtjScBaMdIpJrLSDzGkOoCP2HYcsQtfq7s1xb
         hFNpnoOp4IFR9CGXaeJh1iI1UT7dmWBF3CR6IndcQZKXlGh5lV75ZFhbMcfzZ/l9IGtk
         vfTA==
X-Gm-Message-State: AOAM533SqFXFrmv8dAazPiai9MleqN0eA7XTCbxy8i2EiwIsbB0R2Z2s
        7/U2bBVykZroAQq7+56M8Ac=
X-Google-Smtp-Source: ABdhPJzf3WF+0Mr2b/W2BMKEHFQ7z07BI22BudPKSaDp5F5o/heoVcBa1vbxwGm8zWQP+L6B81cixg==
X-Received: by 2002:a05:6512:e9d:: with SMTP id bi29mr3651986lfb.652.1644943257110;
        Tue, 15 Feb 2022 08:40:57 -0800 (PST)
Received: from WBEC678.wbe.local (xt27d8.stansat.pl. [83.243.39.216])
        by smtp.gmail.com with ESMTPSA id s1sm1127092ljd.18.2022.02.15.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:40:56 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Ctera Networks
Date:   Tue, 15 Feb 2022 17:39:23 +0100
Message-Id: <20220215163926.894-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215163926.894-1-paweldembicki@gmail.com>
References: <20220215163926.894-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTERA Networks Intl. is a company based in Israel.
They manufacture NASes, network devices and provide software
products for cloud storage and IT security.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2: no changes

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c48ce3c54951..9e247353b6bc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -275,6 +275,8 @@ patternProperties:
     description: Hangzhou C-SKY Microsystems Co., Ltd
   "^csq,.*":
     description: Shenzen Chuangsiqi Technology Co.,Ltd.
+  "^ctera,.*":
+    description: CTERA Networks Intl.
   "^cubietech,.*":
     description: Cubietech, Ltd.
   "^cui,.*":
-- 
2.25.1

