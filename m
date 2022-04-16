Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFEF503697
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiDPM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiDPM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:27:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96134261E;
        Sat, 16 Apr 2022 05:24:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso10282656pjj.2;
        Sat, 16 Apr 2022 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xk5zVuuJ8xmtKfBiO5ZV8a9xxkoS24x3Xj7thwpYakY=;
        b=NqiL3CKJCnmj+Fem5ki2WeUSl0LGJpGX5T5QRhTBQE+FE7BO4f/EeYIjVLrSu1kALB
         2MmNIIOQRmMJvV/OJe9k7lisZC4f97WieN7DVq3B0HJRsIYYBqJSxs/hBYv399Y5rp5O
         euOFV0FGzROQeRE+cO+1PxnbUud3DCGe80O6lFqyG/QMRXAOG7dpt8Pf4AduVvHL1wFe
         Wbswp9ReXE0tRh5LLFN8HEHGjAjphVVg1ELj6ztarHrrz4vyPDC4EioxwgBWi3F6NQZC
         bzYCJxypDNiXzo5nNQbDzvOqVMEjt9DuCzi2D3Pld4v215lK++F/THKwOIexdmaG4TdR
         wPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xk5zVuuJ8xmtKfBiO5ZV8a9xxkoS24x3Xj7thwpYakY=;
        b=YmpUT2BWLZWqkHKO0C/jmbIbeIghjvyngtOJc9sX6o6kHjooEQlZNIXt+hANYLTfk+
         VMYf6vKtVVVYRpQ2AXLSY/T67nKPjJhBd2cvVkCuOmp7gNeuvz3ndhruhWd+0bTrlbdD
         pn5PilgJbyq/sHV17+nR45OgwBE273e2mAGIZ6GAOTJJPRSMo6DzOOgQ2Sujt46lNMXB
         kyUaBkY5pmf83SmP4PJTSxh/+sMfdSarKZMDb6lgAYm29sagHh+7nzQoNmf8DGGam8c6
         GEcHUXhYYtCWirQn7h+GlbiqDMdIJEIU3q47PXHlh01/e7inznUKrXkXb7vHfLXR9Z9P
         fiaw==
X-Gm-Message-State: AOAM531dBqYga3NSPSaF7F3ThruteOkrGxubLf05NkgAYrWR5uDUgX6f
        ebV6wbIS7ApkzPpiATCofp0=
X-Google-Smtp-Source: ABdhPJzb8wQZMpjwcODbT4FxvBXcTEA8y4nG0aAzfAFtUo74X+ZmkRHuphuXMHHEl6yFr1ZpLnVYQg==
X-Received: by 2002:a17:902:7049:b0:156:285a:2d64 with SMTP id h9-20020a170902704900b00156285a2d64mr3351572plt.63.1650111881132;
        Sat, 16 Apr 2022 05:24:41 -0700 (PDT)
Received: from ip-172-31-12-67.us-west-1.compute.internal (ec2-54-241-4-221.us-west-1.compute.amazonaws.com. [54.241.4.221])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm6849947pfk.8.2022.04.16.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 05:24:40 -0700 (PDT)
From:   Xiaobing Luo <luoxiaobing0926@gmail.com>
To:     tiny.windzz@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        mripard@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Subject: [PATCH] cpufreq:fix memory leak in sun50i_cpufreq_nvmem_probe
Date:   Sat, 16 Apr 2022 12:21:30 +0000
Message-Id: <20220416122130.4050728-1-luoxiaobing0926@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------------------------------------
unreferenced object 0xffff000010742a00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294902015 (age 1187.652s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b4dfebaa>] __kmalloc+0x338/0x474
    [<00000000d6e716db>] sun50i_cpufreq_nvmem_probe+0xc4/0x36c
    [<000000007d6082a0>] platform_probe+0x98/0x11c
    [<00000000c990f549>] really_probe+0x234/0x5a0
    [<000000002d9fecc6>] __driver_probe_device+0x194/0x224
    [<00000000cf0b94fa>] driver_probe_device+0x64/0x13c
    [<00000000f238e4cf>] __device_attach_driver+0xf8/0x180
    [<000000006720e418>] bus_for_each_drv+0xf8/0x160
    [<00000000df4f14f6>] __device_attach+0x174/0x29c
    [<00000000782002fb>] device_initial_probe+0x20/0x30
    [<00000000c2681b06>] bus_probe_device+0xfc/0x110
    [<00000000964cf3bd>] device_add+0x5f0/0xcd0
    [<000000004b9264e3>] platform_device_add+0x198/0x390
    [<00000000fa82a9d0>] platform_device_register_full+0x178/0x210
    [<000000009a5daf13>] sun50i_cpufreq_init+0xf8/0x168
    [<000000000377cc7c>] do_one_initcall+0xe4/0x570
--------------------------------------------

if sun50i_cpufreq_get_efuse failed, then opp_tables leak.
Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")

Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 2deed8d8773f..75e1bf3a08f7 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -98,8 +98,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = sun50i_cpufreq_get_efuse(&speed);
-	if (ret)
+	if (ret) {
+		kfree(opp_tables);
 		return ret;
+	}
 
 	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
 
-- 
2.25.1

