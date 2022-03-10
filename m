Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE954D5426
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiCJWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiCJWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:08:36 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283C3B01A;
        Thu, 10 Mar 2022 14:07:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so15113841eje.10;
        Thu, 10 Mar 2022 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+bQm7oSKXNbzL13c/MNl/tddfyzw2sHDv2mP5LKoHU=;
        b=mSmh9CRF/SPistOhGnbTWogGzHmBWpRFtPespWHdrBJg+91FKLLTqaudEHxtNKrEV8
         yUZ2VcqHfxSMkpwVwGcLoQNzY4kvljmW2CMxvHWD9s65sylpXFhiOihcK9TRyWmis7kO
         2jFgjWZEn1S/8ZLJek4Ff7q9tJ0UKrgTMLKk1zP190LVLYSYlgZRDtNS+VrBBK4o3ozZ
         yUSsyFsdhQj8aR+3qQMAdrtOXWWr8hssghFI+PUSY3PBaLkUrrGX9m7DgCe34SRrRZAu
         ofYtBdclMpquqggxVU3qB6HPX/vcZnFV1pnr6Zrn6FlVtmue0c89oAT/76FiiYnbVMjJ
         4JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+bQm7oSKXNbzL13c/MNl/tddfyzw2sHDv2mP5LKoHU=;
        b=pIPhJX8L1JhnrffZa8jQ/RTl5YHSJB/ySMqMzyl2idt5Vsh/aEwEdf6vG37i8OjvKZ
         9lP4ABu7Y5fSPGriFifQpANcmNVs6KPq90P/lem36k9xxk9SIqOTq4M6fM7F9auXHQkB
         usf+6v5X/MDW/70Ao9XjJqHs8gVF49vE36zEAxKCHzFbT+I72Q0qnZVmMEJGgFPUcp9T
         ODO4dxksVIWHJq+XJk6aTXGp6EjJXs1tEwQBXaiNgnqP4U5tRq6ZM7DYKAeB1/snwY/2
         3ETsgPA+TEB9L1gUbwdL82hlJAA+xjs+9v8NSStMjoWOdHFUE4COv62QElnCOsvxaHBx
         bq4g==
X-Gm-Message-State: AOAM53273EEOHK3NX7Wnb9A7amwR4ygA2rQTvrFpQO3EhpQ10K4XZ0n8
        uwAEcOD9WrNIA0/1V9Ucl4taCSdTDZg=
X-Google-Smtp-Source: ABdhPJzF2sw5rugahKzH8n8lxMVuWWePuxitJpHKpluAUzRIosjoOiXtxsDJ/gnSTmDFwmk2CHeaUQ==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr6067525ejc.5.1646950051169;
        Thu, 10 Mar 2022 14:07:31 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id gb2-20020a170907960200b006dac65a914esm2207892ejc.125.2022.03.10.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:07:30 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH] firmware: qcom_scm: Add compatible for ipq806x
Date:   Thu, 10 Mar 2022 23:07:23 +0100
Message-Id: <20220310220723.3772-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add compatible for ipq806x. Just like ipq4019, ipq806x doesn't require
Core, Iface or Bus clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/firmware/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7db8066b19fd..7348c5894821 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1338,6 +1338,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 							     SCM_HAS_IFACE_CLK |
 							     SCM_HAS_BUS_CLK)
 	},
+	{ .compatible = "qcom,scm-ipq806x" },
 	{ .compatible = "qcom,scm-ipq4019" },
 	{ .compatible = "qcom,scm-mdm9607", .data = (void *)(SCM_HAS_CORE_CLK |
 							     SCM_HAS_IFACE_CLK |
-- 
2.34.1

