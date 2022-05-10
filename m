Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0DB521DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiEJPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiEJPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:11:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BFE659E;
        Tue, 10 May 2022 07:45:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ks9so27013744ejb.2;
        Tue, 10 May 2022 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGTN6aMN0s/KhqZVZqbtoSr5BOPu4zHPp3TT3ztEYwQ=;
        b=gRi76ycWfaYj+DC25eRDShAGPnPSRBQtz4hKna7OLzNJqQFxUfaZqLK5rMatNpo+Xt
         OPYUMyOpLJM6QsTiZbA/DVzp7wIDRp2Ss2VWbS2G+vKzgZKATIfvZn6N4sxmosUXP8Y6
         p+20OI+1VBjQGsdqkMtq8ANdsjTYlUL4Q0jvD3FdM0lLJanQzBZB02p1VAlQZecjuzG9
         mvsmd9JK5ELIzkdno43Yd59DehKPp8OvEDAq+YBQ6hSo7mEI5kqKSPVp0NAtqSAmQo+I
         OvXHsYnfIvdcgRAggH9QifrSa4Hc0BSrA7VqOlA+LGceJgGmdiRbAaENatxJJdhHTKfm
         TzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGTN6aMN0s/KhqZVZqbtoSr5BOPu4zHPp3TT3ztEYwQ=;
        b=j12soXoiUdoYson0fHeXanLvSgk1ymvooWZYUMW8OImxurAFviVmJe8aE8/yOw/HSA
         5YYLG9x9GjYlokScDAjljY39i2ACL/CmDoHlul1SOQs/PW5K5bIXmy2PykJ6zspXJ8eT
         3dIqCuGjD/WFHUn7c5Sy0kjPVRKadL0+nqNJ3dPCOnQKTBND/HWA97msCGmOKY+19+E+
         7u+Bo54lqlJkOiKXixWAwi+htssqQcDtHGldVCEQY+uukOE3WC/uzFK2e+jIGIRuUxYA
         Y0HRFMCmEsT5K3CXnhr5OeTX8wboA9zjPA6VO5E5ZM2CyHnSSWSY2RNiA9x5nP4jNw0u
         o1mw==
X-Gm-Message-State: AOAM530Btm9PeMaTula9JiLSKZBaZrHvNiJ9heuO286NgcJG2QguaIAo
        2A9G7eNY6QCXRqdwfUNlJhY=
X-Google-Smtp-Source: ABdhPJxqZSKXdWSVeTuLaqUhIC+S7MYZ+4pUf5FWmkaMNwvzSXpE7agGc7utHZ28cZ4QcKHb6o+t8w==
X-Received: by 2002:a17:907:2da2:b0:6f4:7395:568b with SMTP id gt34-20020a1709072da200b006f47395568bmr20115064ejc.766.1652193937643;
        Tue, 10 May 2022 07:45:37 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906241000b006fb6d9d25bfsm829652eja.22.2022.05.10.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:45:37 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 2/2] slimbus: qcom-ngd-ctrl: Initialize ngd_up_work before it can be scheduled
Date:   Tue, 10 May 2022 18:42:19 +0400
Message-Id: <20220510144219.806391-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510144219.806391-1-y.oudjana@protonmail.com>
References: <20220510144219.806391-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

ngd_up_work can be scheduled by the SSR notifier, which is registered
before it is initialized. Move initialization of ngd_up_work before
SSR notifier registration.

Fixes: a899d324863a3 ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..73b9abba305f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1490,7 +1490,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
-	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
 	ctrl->mwq = create_singlethread_workqueue("ngd_master");
 	if (!ctrl->mwq) {
 		dev_err(&pdev->dev, "Failed to start master worker\n");
@@ -1539,6 +1538,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
+
 	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
 	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
 	if (IS_ERR(ctrl->notifier))
-- 
2.36.0

