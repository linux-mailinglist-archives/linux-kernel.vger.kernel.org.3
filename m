Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6541D5795FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiGSJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiGSJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:17:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE05220CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so20663790wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LATwaQ4WIDRduSKP//Z3v43fzggOJ7UvcG13Vc+f8Kc=;
        b=eqOvOtH1M0bmp2n9AyFqtA9rauC8lk+Hsg80afasdGfVeaLdH1eAmEzS5eWhzCBcHN
         QN6ClRnrrewK3/Yxhx+nysMtfA1fsd5HmHh4F5sTUM9jfTC7jj4COcGPzbF0Rxj3yaHq
         Ufw4kPPJ3q5I4ZT8yQntW4D9E8o/H9Zjsflfpa/AUNYKQBVbHRN8LHVOJSzAICj9gOWR
         ozIT358fNDXlLl7oPfIJMGK6jdr25peHuKECaVVnn3gCRP/1t0XlTOUkWfYRVcHPB6Mc
         hLjPvsls9CesEwrR+WHW3JafwRwHfS9ZkY4Hx6G9yq/anHOTknAPgvWvx4vfpHApVkbO
         g8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LATwaQ4WIDRduSKP//Z3v43fzggOJ7UvcG13Vc+f8Kc=;
        b=ovWe/qQ9yfeYKxtqhynrwMPaS3zXux72JFBv6kuHmDXF3XB9JaL7yERCTBqPUL9oQr
         bHhjFhsQ3c29VBvIiRoOTPCffWwqWiOyZF2M9UbXbDKbHy1IXtXAvCiQ/NN3w91N3kci
         ovBclN7A+QbyylI9aa49Pd36fvt9Tx/og0L37POjut3Fseks9kxoAJumWoUYuB+26Lu0
         RocZu4g2IBru0rxPwFn0DNWyS0AmAJ9zuvTh06mHiK8QJ6KhunKXoTsV7gb5ItMqTtBw
         uJ7oNpOQSBJz8xCvUeX+55M+LC4XRUjkhAxYUporCubuDd3kCQ6glrtyrl5grjnoK5Hn
         6ndw==
X-Gm-Message-State: AJIora93Sc+kUABxtuGSHXOx8cen77IzKZHC4LUOKS+CHdrpuxAMTRPS
        S+6bCClKMSRjfc1MdEyoevZRWQ==
X-Google-Smtp-Source: AGRyM1s/B72CG0FF5BpIOHB+w+L7iFvA1CWiorKb3eI3MTy4cRNkDjIiKEMWPQomLDaJy47/IUCbLw==
X-Received: by 2002:a5d:4705:0:b0:21d:8a7c:1b3a with SMTP id y5-20020a5d4705000000b0021d8a7c1b3amr26711392wrq.7.1658222270350;
        Tue, 19 Jul 2022 02:17:50 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:49 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 01/14] MAINTAINERS: OMAP2+ support, add tps65218-pwrbutton
Date:   Tue, 19 Jul 2022 11:17:29 +0200
Message-Id: <20220719091742.3221-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

The entry for the pwrbutton driver seems to be missing. Add it to the
list for OMAP2+ SUPPORT.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..562fb0df4a96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14704,6 +14704,7 @@ F:	arch/arm/mach-omap2/
 F:	arch/arm/plat-omap/
 F:	drivers/bus/ti-sysc.c
 F:	drivers/i2c/busses/i2c-omap.c
+F:	drivers/input/misc/tps65218-pwrbutton.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
 F:	drivers/mfd/menelaus.c
-- 
2.17.1

