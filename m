Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0952110C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiEJJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbiEJJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:39:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83E28FEA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:35:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1024165wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpoxCESC+tKfReiYtTr+zm9Jdtfa20Hz6e1UFVmIV9E=;
        b=otckcjQQWq8S2/KXmmcT/vpjH/RHBOmfUeC+wrsXxrOm/nu4d1oIijiXarlburytn4
         4rw9Uodw/ln222JwGpqMXN8Vc8NqR/Dejn69UBOyJ2BX5YSb1GePt5/Vbtq0u1zFzVmA
         MznVwqxDsJFOjTlAGwzy4mOotFXz2Ok1arTrDupX2Cx4Wcb5ixeWsLH1HC3sPjWICCL8
         IihefBBCLWhEjG1u/nqMWa6ARe04St/GyO1dqXskRlGLwD13jyI3qZ7xIKHB/Ib/KB4k
         0W87LG+rWYGzGu+PjzAAL7RcvbHRH9aI7xoWOOKln8PUDMGMBo15YJF9mHc4V9jMd0P8
         lLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpoxCESC+tKfReiYtTr+zm9Jdtfa20Hz6e1UFVmIV9E=;
        b=XRRsQr/4s0IQHJzPvCoA2iGSCvk3DJ7F+K5WQ4EhHtmYCX51R2fhEH0TkbUqiL2nEH
         Sh+faB+sfLvlCIlTaRs4IHFt/WpS3Lj78hMNeUz7AscsiF1l52t72s72sz1grq7VcMXz
         gWaQ6TXBBIhlUi/VuUTPkbuV/xtKGd4ECreIn6PgswieUFshzYU4Dzrm7e0MdxvlJBH1
         K7DgLNiM4pz3/ytpcqbXrm6P7TRB7ZE7kgpW7E/4r1t/5RwpLElNbDckgcls4FNx5ufh
         0+wR9J8Eug7zTcbKY35lFCEK1yHT9hG7gAtjCgElQ2dFrztnt5+wVO4wiw6lJ6lRvafJ
         MBkg==
X-Gm-Message-State: AOAM53018hXds5GlvIQmHer2oxiuXK7HVxr+ONiYfHW2orTUZXLLBQrJ
        jAyPalfwfSLVmK6pVtu1uXR5rg==
X-Google-Smtp-Source: ABdhPJw/o2cRM4WLa0no0bgyKdwiIh6F0+0ZQkbQ4ZsDJ32MletRrFxbQg9YKU67tJZt8qZMH5tjHw==
X-Received: by 2002:a05:600c:3ba5:b0:394:6a82:8dbe with SMTP id n37-20020a05600c3ba500b003946a828dbemr19538500wms.185.1652175344448;
        Tue, 10 May 2022 02:35:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600012cf00b0020c547f75easm13791018wrx.101.2022.05.10.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:35:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] nvmem: brcm_nvram: check for allocation failure
Date:   Tue, 10 May 2022 10:35:40 +0100
Message-Id: <20220510093540.23259-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Check for if the kcalloc() fails.

Cc: stable@vger.kernel.org
Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg,

This is the only patch that was not applied cleanly to char-misc-testing due
some fixes that are already applied on the same file.
Rebased this and resending just this one.

Thanks,
--srini


 drivers/nvmem/brcm_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 450b927691c3..48bb8c62cbbf 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -97,6 +97,8 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 	len = le32_to_cpu(header.len);
 
 	data = kcalloc(1, len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.21.0

