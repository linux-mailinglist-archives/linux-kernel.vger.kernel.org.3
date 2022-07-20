Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D757B8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiGTOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiGTOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3533E528AA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u5so3417709wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:to:cc;
        bh=bLWM+s+iR5LdVaHPuafu7iCm3mwz2NHAzkIzkY8xmTY=;
        b=3o97zfA5+8dQXwtwy7pQ9pIIsD5FJ3qzv88L5rTytIICFhHWbxdWnJ9vUD26bICVLZ
         b4WQu8J+7rgfsC3O53slfyN9BObsbC0xNBezoPWL6JvxhPsCac/td0xgxZAAV2A6TtyA
         4fLEJ1TIJRgwWxfwo+JPQdzaQiqGUbTZbTFh57fmlNNc7wH3Am48OgcX1yT5GO2Ph5ep
         jLuFQRALqw50jBJQb7SNOjZbTZkmbsZP7i7I2SZ8jlE20tl3ya59X7uUoVYLB/OxgXWY
         YVKnie59wwIK2I5VIWeQ+ESe12NplRAeK0z7sxIO0TGu4ZME7CKjxHvvEgNtfeuQeO2c
         1JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:to:cc;
        bh=bLWM+s+iR5LdVaHPuafu7iCm3mwz2NHAzkIzkY8xmTY=;
        b=tqq1/h8NYRZKCwRWbWeMpLx7B24LRv/iVulEI997cVe/2SjqoYQFnbBCl0b61hkedp
         20LNZop3iBN1KroRcIeNeqP8BSEaQ9n/bVlJaUftbG5X1KyyPyCIRtkflic2LBIxuoWj
         RFTAlE442YhebiaXZ64/EFxyUACw08AY9ENl8BDTn6P93RBoP3SIisaz8ZjKvp1OXlOV
         5phd0ldiZkoz2zLMcqZBw5mS4+aHh/+iMZHHm1zeUyf0afNDpt5Wo3/ktYIlBqEieDxZ
         Tul5LHzs2qomuW9jABovRKn3/AJYLcMC5gjPuGMtM7iMbKmatZOCUfvp+oAS8p970+Y5
         aiCg==
X-Gm-Message-State: AJIora8Ie+gRqzBfW0phdgmK87kX7er67l1G39mJCZg4x6qS3kI81ve2
        ZFPC4OuAxBp0KxNY8q7kr5msOy+7bKa8Fg==
X-Google-Smtp-Source: AGRyM1uqyELZOTi1y1+BWMg0rNkGod1uVK9t35VqzqBXcj/DigJ522rSj8SmtDKiiJo4GtoMoIymsA==
X-Received: by 2002:a5d:6110:0:b0:21e:4fe4:f7ba with SMTP id v16-20020a5d6110000000b0021e4fe4f7bamr727919wrt.69.1658328519755;
        Wed, 20 Jul 2022 07:48:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb19:85e6:1900:c639:22f8:bed9:44dd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm3321121wmq.7.2022.07.20.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:39 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Wed, 20 Jul 2022 16:48:37 +0200
Subject: [PATCH v1 1/6] MAINTAINERS: input: add mattijs for mt6779-keypad
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v1-1-ef9fc29dbff4@baylibre.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0-dev-54fef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in [1]:
Fengping has no longer interest and time to maintain this driver so he
agreed to transfer maintainership over to me.

Add a dedicated maintainer entry as well for the driver to make sure
that I can help with patch reviews.

[1] https://lore.kernel.org/r/20220421140255.2781505-1-mkorpershoek@baylibre.com
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 264e7a72afd6..f7a0bae74dc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12771,6 +12771,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-jpeg-*.yaml
 F:	drivers/media/platform/mediatek/jpeg/
 
+MEDIATEK KEYPAD DRIVER
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+F:	drivers/input/keyboard/mt6779-keypad.c
+
 MEDIATEK MDP DRIVER
 M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
 M:	Houlong Wei <houlong.wei@mediatek.com>

-- 
b4 0.10.0-dev-54fef
