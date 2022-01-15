Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D839C48F620
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 10:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiAOJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 04:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiAOJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 04:26:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 01:26:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so10005840plh.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 01:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfWvJ1j3iZuJAtKFQbj91vAw6Zk2fwBdO0h7UliPOPA=;
        b=IhsYJh24bKqAoOy1VbDz+PavHTw5Iv0Zv4BTZ5wGUVWIWLmJ1L3dNwmOU+ifHUeQrF
         8+I51XGqR0bCl4pNd6P0LQvijstXcGA3/pdJbu9hGLZZTLmQ3uWLTJSO0ITxDjSE2Yeu
         oPn3C1YBah58L8PXaJHEM/2sTIZwETFx+QSic9IJ3GJHuacxEJs8lXzBVDK/IPlm3YVZ
         tHzi0fUFDKg8JvCh3AZ+7j/JhjQDa/95GplP5R13OvqYtELUTX3Phd+gH/B9M50z9to4
         V9jAFlO60IeBj80w4tbghjjgYrMhABBIyNj4Jki79+JLwvCTwhYgzdxePTPOduXENa2H
         X0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfWvJ1j3iZuJAtKFQbj91vAw6Zk2fwBdO0h7UliPOPA=;
        b=VBepp9RmrK41Np09FMH2sWx0qDyncNizqyO+e7pfsjEAMmRQ9OTFpe8aj2yxjaFX5n
         +YVdTalZIIULVcgq+f6Qz7wBaY5BHPzZKiRLstLt0S+PaCci2n/OqcoeK+mpunhA/QKV
         hhlW2i9RKd/27q4Onl3jQYbSWuSgLdUMz4VQjcTwxcUalyz2Azq/n7KSou0wVwsUIuJo
         zT3iLOOy29zzE4yKzp4DszcplakIADwvSjbYBh1x/vaZQaGfNQx35pBc1ctLgpj9xEJj
         kGUYyTYsVy2RdHsHUD9wp9zhs74BTO1NddkECQVO4W2V7d2ti+89vX0ZHDALbMUaVHU3
         l5Dw==
X-Gm-Message-State: AOAM530x3gNLPM5ukJXPHOurC4dpCMl7/cswz3b+qkn0KWL/wSsnfppn
        IbUs5uO2NfSwfF0XjVQuN68=
X-Google-Smtp-Source: ABdhPJzYMWv4ZmCJf45HRuoNq8Ih0lDO8lV7XVhQIO3bKAGOforeGlHl5n67s+oqceeeLzILEfC2/w==
X-Received: by 2002:a17:90a:8b95:: with SMTP id z21mr24501244pjn.29.1642238785749;
        Sat, 15 Jan 2022 01:26:25 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q11sm8285287pfk.212.2022.01.15.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 01:26:25 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     rostedt@goodmis.org
Cc:     bristot@kernel.org, deng.changcheng@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] rtla: Remove unneeded semicolon
Date:   Sat, 15 Jan 2022 09:26:14 +0000
Message-Id: <20220115092614.851252-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./tools/tracing/rtla/src/timerlat_hist.c: 800: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/osnoise_hist.c:  776: 2-3: Unneeded semicolon
./tools/tracing/rtla/src/timerlat_top.c:  596: 2-3: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 2 +-
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 tools/tracing/rtla/src/timerlat_top.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 180fcbe423cd..9e417f199a78 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -773,7 +773,7 @@ int osnoise_hist_main(int argc, char *argv[])

                if (!tracefs_trace_is_on(trace->inst))
                        break;
-	};
+	}

        osnoise_read_trace_hist(tool);

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 235f9620ef3d..1b75c1de0466 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -797,7 +797,7 @@ int timerlat_hist_main(int argc, char *argv[])

                if (!tracefs_trace_is_on(trace->inst))
                        break;
-	};
+	}

        timerlat_print_stats(params, tool);

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1ebd5291539c..d8a792b7aa48 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -593,7 +593,7 @@ int timerlat_top_main(int argc, char *argv[])
                if (!tracefs_trace_is_on(trace->inst))
                        break;

-	};
+	}

        timerlat_print_stats(params, top);

--
2.25.1

