Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A150863F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbiDTKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359564AbiDTKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:48:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2718381
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:46:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v4so1719118edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OVcjGSiJ+nlq65WcsbONfbpSCZlHZow1k2gE+HwcCo=;
        b=pldrgPUIn2R72Z4tJz+rlp+UluL86LT0jyZUo9kf++27hTM0pzPgHXY+I0M40I9NY+
         eXHUPwO7vQ/zVAdxzXO9RKovW5dOXy0S5vgPrJugzugD/sq0a2wj43vGseINag5cVdUp
         buPuCcPXISqc1w3yzNrwnzmOwhtZ0oLxlWmhbyJfxD8UXXjuKPksUTMSoVw5W80s0IQg
         bVQSOTj2RWia9S9xt0eVOxCzR9YWNhIAy7RyNMVAdlrNb1+wXoVQFsKqBO+PyXd6PNNq
         Eyk0d+inH3oMBNt0rtRAWn9mTvYqYFsYPUvCQfVRZVk4jEt03BzBm1WDPSE9X25GU3F7
         y5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OVcjGSiJ+nlq65WcsbONfbpSCZlHZow1k2gE+HwcCo=;
        b=PMMjNFA7KfNrz86w+tV8/TaMGIhJeI2hbs/coK7z+w4VqUax7uvEXsSGqC3ZlVeFkv
         I3K3tyo3KKGkUpBxtEl6MNih/Yjn5tqsT+qcR1yMQN0mSoBdqqHgk9Eotx14dbAtgG16
         vp7Wc4NTg5T7vwb4cknuUKusRXwtgGLEZhRoHQjHmrF4xNc75e3Ta9OLJT5m5rbfSW9v
         3R1RnRnI5y4/JOJVXKOi/C3yepX1xt4bqTednvqhWY9BkUPUAVsrrfJNNeHYbXX4Vxpe
         oKLG5BLS4nhLTy8hAKvQ2nNi6QPrlAuO3RtTDLneF5Lkejhu+ylPlG9/wlYEkgBv4kn4
         pRbg==
X-Gm-Message-State: AOAM533Kn0FIBP0WyvJt4E1VQONhRRamjP/OpfdJGqg/IOHreEqzZtc1
        QVeJq22jeZFi0G3tqUkQyNbTkQ==
X-Google-Smtp-Source: ABdhPJw/4gOK7xeclDA9097uwkEU8w5LJ7LCVdGl20UroQC9SxTNcI8HyNfFl0xGksOd2Y3YCOPhbQ==
X-Received: by 2002:aa7:d059:0:b0:41d:76b4:bcc1 with SMTP id n25-20020aa7d059000000b0041d76b4bcc1mr22299244edo.389.1650451563871;
        Wed, 20 Apr 2022 03:46:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mv12-20020a170907838c00b006e87c0247f4sm6529912ejc.186.2022.04.20.03.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 03:46:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: MAINTAINERS: add Bug entry
Date:   Wed, 20 Apr 2022 12:46:01 +0200
Message-Id: <20220420104601.106540-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Bug section, indicating preferred mailing method for bug reports,
to NFC Subsystem entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d746723306a..1786cbdd43a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13842,6 +13842,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-nfc@lists.01.org (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Maintained
+B:	mailto:linux-nfc@lists.01.org
 F:	Documentation/devicetree/bindings/net/nfc/
 F:	drivers/nfc/
 F:	include/linux/platform_data/nfcmrvl.h
-- 
2.32.0

