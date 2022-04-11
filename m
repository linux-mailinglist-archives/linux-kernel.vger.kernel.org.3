Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010F4FC53E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiDKTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiDKTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:46:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57413DEC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:44:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k22so6014404wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2pHISSBa+vyQR92QCN20csJaECk0Ib305OvqZ71rHM=;
        b=zoxcUWYW3Gll9dA+g/GjitaEWy/DyAUlqsfVUZ3ojP+KlecMBUxwFNrpA8prWNzFM8
         dxiuERPvg2MP+pbMPS/JOt1PuBUC5ikkT1RVkt+AuM9y4fR2M/Z7Et5TLxG0RaH5J9Wf
         b9HD6KOnOmlJY0hkZxe5NFB/kekybtYI2BKbMiUwKB4coa0972KBl9vZSjUkCNgdkDwo
         NMch6eyX+oAeeL6nPnlom/aybBau1AWdfyOkFzV+Rmfo+MLfeGLFsFhf8fCyXAG5LOdN
         eJaU6xyimLvFA89uh2weUbOf0RcSWxxS1tkTLB8n++mSotix7hY6s7uBb9SGZ6K7T938
         HmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2pHISSBa+vyQR92QCN20csJaECk0Ib305OvqZ71rHM=;
        b=ncn542MpAcMX4YQDOSsKN/0ltNzWwVt5HoqePdG3DZ5UFQ7ngPDrOYuOfks5DSHUg8
         RhSnVqaWHqtin5/hrZ2iMd2R7F6h129BCuJCv2tGTIf+NES8EK9NsWAePoCRGy+JVxR3
         Qj1QPHxqSAuNJ5Z4s6D325OycXF7bqVrqoGmZI94uyfbSKKzU+2Yr9YyZUYSfSsDw4zP
         qiDWf2udNN88wl1/UBT+wK6RSlCTJEofHN978Bz+5CV9hcmIkLBg9aIrPIU20llYAenM
         c3MDpiPsVTcywtJIHHtRqLTdbxcD9INO3YcWP3b+oyWXPeDzbKp0rsJSBNs31jVfzWjh
         nF2Q==
X-Gm-Message-State: AOAM530VC8n9RpXn327UABo/0XY0ocvnY56jiVYzD54Q1G6cThYwIoxl
        eYtdnP4K0mR4h8lDcsxdi9bOvMPBnc9w4w==
X-Google-Smtp-Source: ABdhPJxO7/HRhRnIcY4K1+0s34o2a+NwfWWzqFwjG8efgRhmwQJH//fcG8ccAyJosi4yLz8Bf4qFrg==
X-Received: by 2002:adf:eb07:0:b0:207:8534:2ef6 with SMTP id s7-20020adfeb07000000b0020785342ef6mr18321441wrn.62.1649706255289;
        Mon, 11 Apr 2022 12:44:15 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v1-20020adf9e41000000b00205c3d212easm28218101wre.51.2022.04.11.12.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 12:44:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: ASoC: fix invalid yaml
Date:   Mon, 11 Apr 2022 19:44:09 +0000
Message-Id: <20220411194409.3390002-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "or" is useless and breaks yaml validation.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/sound/tas27xx.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 191f4bceb4ee..66a0df8850ea 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -20,7 +20,6 @@ properties:
   compatible:
     enum:
       - ti,tas2764
-      or
       - ti,tas2780
 
   reg:
-- 
2.35.1

