Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3469471B09
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhLLPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 10:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhLLPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 10:00:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584AC061751;
        Sun, 12 Dec 2021 07:00:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so10049860wmd.1;
        Sun, 12 Dec 2021 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFsVzNxUTe0zVj2n7sBsxSG3rvMdpK3tm6ziU6/sth4=;
        b=o8kNIO4V5DpeQn/CO4pcYqGPR8q9ooMHRa4H2Nnf3TiH94ML9bRY69YKwLjq9PsWLF
         OKwgvhneOXaHninwwOCbce3CPynUCK2SmXGS7xoyKbd8qmU4PqZDB9MEDQsVNCY5GGQU
         adzzr+E/XVktg+/Q6VheylsmpnJmfR1VI2CluHSFl8qX3DDJcmT2UBvyOcwtyS2Dfe26
         CHpvVJzTkoloIDLVAjiXLx7UvUV+XeZrSauOesllhUwTcE0dE4FXj0O+lNIsuUtwuaMb
         rWz7Zs4ygupu8R8HRwUAxiMia4ySTQCg1HgG3yQcRNmoFXVW6sawitqjv1L4Bk3cTFwi
         BhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFsVzNxUTe0zVj2n7sBsxSG3rvMdpK3tm6ziU6/sth4=;
        b=w0cZaUmd7XpdMZ/XBsjnjddHueAtDPoU5705AdZB1fs+OqpngTTHL7rogt56I/CFHd
         l7andAQ9ZP7EjsDQf+v0PGh6tjllmk1BRqDYQszySUymsLj8cRJnNWM3+1oiHL1iY9EN
         ommpNmPuBKYsGJj+WFHbHG+TKjaOtzZg+XVelIG7QJN4mYUtU3RD050u2tJ5Fwor7OlE
         9ydNfSOe7f0li8DChwF2x6gkg4YlBPii6u+pEIoqKYyrKNBw2ONNETJAMPFmeexm3m5S
         /+QNstR+G/U2ALlchhVeEj8FBRUxoj7xwNYP8I3UEHStWd2ORJZtiyy3YerkSjWhQF54
         5YxQ==
X-Gm-Message-State: AOAM531oxIORe4oXnR7BZr/KD9/ZigfV4Rn7riMkjf+JbioUrVWUOeLv
        MJIrU1sIjSfv23r6tuSpSxbejkzldyE=
X-Google-Smtp-Source: ABdhPJyGOu4P/Sk2o4zR/guets/zV0FzqSwb8tkgl4GngGpSOa/a9EAL+b/sfF4ReYEMO38qI899Gg==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr31048506wms.74.1639321215876;
        Sun, 12 Dec 2021 07:00:15 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6ebc-0100-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:6ebc:100:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v6sm4284789wmh.8.2021.12.12.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:00:15 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/2] mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro
Date:   Sun, 12 Dec 2021 15:59:56 +0100
Message-Id: <20211212145956.1423755-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MESON_SDHC_NUM_BUILTIN_CLKS because it is not used anywhere in
the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
index e1f29b279123..19200b7079a6 100644
--- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
@@ -12,8 +12,6 @@
 
 #include "meson-mx-sdhc.h"
 
-#define MESON_SDHC_NUM_BUILTIN_CLKS	6
-
 struct meson_mx_sdhc_clkc {
 	struct clk_mux			src_sel;
 	struct clk_divider		div;
-- 
2.34.1

