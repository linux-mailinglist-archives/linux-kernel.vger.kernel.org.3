Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F958139F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiGZM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiGZM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:56:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEF255B1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g2so11971467wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:cc;
        bh=CDEPpnFfFeQNRb6h6qaD2GBuBJjRD788qOFTnSwzmr8=;
        b=FlHwpR/BGdgeA1Qo4EPCLGZN9pJSYx3Shj8vGvPfjgcvjNQGVL50PDnnpy/7cfmHHC
         W/dUzWuhGJmzIjpmlXsRbdpsBFivMx4GbzsXMA3Dlo22lTILBBElionRNVHKILNRfgQ1
         0PoOv+/1cKxGPYQe1NG9r4B0V/F+1NOUsGej+RnyQ4JzvvWCZJE1isN/yWhM3paK/yF6
         9Dml/P6kNoPbaTA69UFHrKxZlQqihJelbV1q2/l5KKv6fsI+sLdtmcXZ+F82bF0/drpN
         7tfND2OUcC0bTi5J6lW5oMGiEdlVignPik5jBiFK9wMpEUCy5q69zBavlMiDANCUBGk4
         JRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:cc;
        bh=CDEPpnFfFeQNRb6h6qaD2GBuBJjRD788qOFTnSwzmr8=;
        b=Yl5jz2fhEHQ38Pdp4wmX5gs2u4oG4MdfzcvFlwwetHnzz4yUpjFQ2I4G/UGSj5bmqh
         MbT0D9YzH5dBgDYrLKlYX/ufVZAniRbfd6hckDeYSl9pxBuN3Xt0NEBP9ydYGlWsIi9k
         tLh+J0EtXk7NRtWIhNk0Fnru95+MtdLFkrJ6znQrbJyn54zGMVazahAH8FlEH/412Fo1
         GKKaXRXn5bJyCcr/8cAteQwI8Uxv/uuJjIBVSG0KCE0SBp/Ls7s+duEOc1kRQazeExV+
         V/bqwS/lCkHjkquWTDIQfUM4Cy7yLBjKUoRVT60qMAxGpOmHr+EIbwQu5gJVcam/bMKz
         PKFQ==
X-Gm-Message-State: AJIora+kVuiunIBtKPfXae25671nLeAwcUEjDDYudMhTY18xI0rxOMSf
        H27U8bGflulro4uhk4dOYWkuSOd/NPTczA==
X-Google-Smtp-Source: AGRyM1sLSFIrbCMWof8a52ULbmaqJoWBEBO19cwgtC1nBgI86bN7MgA7Xp4VETkGqmgn11gRmyyQaA==
X-Received: by 2002:adf:fd8f:0:b0:21e:bcb4:f731 with SMTP id d15-20020adffd8f000000b0021ebcb4f731mr199816wrr.537.1658840190488;
        Tue, 26 Jul 2022 05:56:30 -0700 (PDT)
Received: from [192.168.2.253] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm14171549wrp.116.2022.07.26.05.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:56:30 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Tue, 26 Jul 2022 14:56:07 +0200
Subject: [PATCH v2 2/7] dt-bindings: mediatek,mt6779-keypad: use
 unevaluatedProperties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v2-2-6d42c357cb76@baylibre.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
X-Mailer: b4 0.10.0-dev-78725
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

writing-bindings.rst states:
> - If schema includes other schema (e.g. /schemas/i2c/i2c-controller.yaml) use
>   "unevaluatedProperties:false". In other cases, usually use
>   "additionalProperties:false".

All 3 properties from matrix-keymap.yaml are valid for the MediaTek keypad:
* keypad,num-rows and keypad,num-cols configure the KP_SEL register
* linux,keymap represents the (at most) 8x8 hardware matrix

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 03ebd2665d07..ca8ae40a73f7 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -56,7 +56,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
b4 0.10.0-dev-78725
