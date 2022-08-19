Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7CA5992F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiHSCIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiHSCI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:08:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC053D36
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:08:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso3541898pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1s5fDBbPwDIfimCminJ//BlOKw42ZvouJWmPQDDpYhg=;
        b=SwMaUxyMweLmAnDFAdcsk8mb09Y6oGUSn+GrMbC/nXJqsp8lzlwtYBT/UeJXxN6FOr
         7bsHRqpSW00Zq1xKGZrxL4rC63LLyE/sHXin/Ev7RV9VoMKLWKaaYTKOoMSIboSvBBrD
         xreevRioe0kzyDukI+0pWWkq02VljatERUQ/vfrB80hAHwgG8o/Q1FI8ORoNyl8nu+Wv
         FljKbsMoRnsF68HsHdJrxWt2MaHGNqN1Kn+mDICFIUmGQusPLYC/ZqMO50UtN51zKLSR
         nYlq4Ep5NWDs0laD7XGUexnqmcB1T/GBPIvXvtKjugL3dmpiFswfa4zsC8oXVQVfslg8
         Z7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1s5fDBbPwDIfimCminJ//BlOKw42ZvouJWmPQDDpYhg=;
        b=aUYcmvZLCutFQPJRXxNVjqTjdgmpB8q1kkp0Weky2Atx+5nIdA42VuMNjQPn1RZk99
         sMchdlwAjhZk48nYjv3VOOwD81ZxhYXhVuyZ1cRJnr+8wb6ZHiyFVa2U2o/6sgyTCxN1
         jE2yRQRuTYtyjZf2T7fisEFnVPEM8lBYjCWiMf7MMJ46BKcIGWm+TTffIw0XveCrE8J7
         m7AFEEeFuC+7CXVcnF8cATzNWlaePal9lPhLIdHduY94iEkOqw5kFI4pxd/LPKUwzdbb
         kD/eSVTGQO3PbFT+UsjC6wHRPzEDcMropSqzCpy6EKXEw8JbRG4c+NgGHxoQ94CsRKlF
         iTgw==
X-Gm-Message-State: ACgBeo2oBBnUvzCmtHqLo8Up3HCL84d+YhPQTkhNq2zKBGvDrXcDz1g/
        spQecdo9Ev8lFA4IYp8LSC2S
X-Google-Smtp-Source: AA6agR5cqavn3AxwZPFY+VqyxUtyzyvTjwT2H07i2jN8lUugalH0jnvrBxHmAvQXsi0rsx4jL8m1JQ==
X-Received: by 2002:a17:90b:4d88:b0:1f3:34aa:9167 with SMTP id oj8-20020a17090b4d8800b001f334aa9167mr5807425pjb.133.1660874905533;
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
Received: from localhost.localdomain ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id v1-20020a622f01000000b0052d98fbf8f3sm2304252pfv.56.2022.08.18.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lpieralisi@kernel.org, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add myself as the reviewer for PCI Endpoint Subsystem
Date:   Fri, 19 Aug 2022 07:38:17 +0530
Message-Id: <20220819020817.197844-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been reviewing the patches related to PCI Endpoint Subsystem for
some time. So I'd like to add myself as the reviewer to get immediate
attention to the patches.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21081f72776d..58a163c2e5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15682,6 +15682,7 @@ PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
+R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
-- 
2.25.1

