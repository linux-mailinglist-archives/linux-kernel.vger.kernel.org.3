Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C7529381
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348610AbiEPWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiEPWSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:18:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497ED2C123
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:18:42 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m25so20370293oih.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwvFqRaw7/r31nlcL9DNcUXufOMLxk6prSBHpW93H5Q=;
        b=jNc9CU9UeoxHPfaoqHA4vz+jPpf6dXwvFB9lYhkodQpraa3a/2lAdJiPDodG7S/Ls1
         3+a+rWG32LsATfLlIKmM6Jf/r8BnVmy6+PW+McQy7Yu9gk/f3PUZKUYQIZNoG/UQSPAq
         gyVUW6V7wNgjwLQQ4vUYvFGtXMrZBbWOGtp26clpY4FX7qfA7298KlrvPDwrERe5y2XM
         halg/UdntPdWzHFrFQ4zXfYlFbIk9L1Ryb7AkZMeSpPwl1/smplwgh8bZhGmitY4udzU
         K2VfzEMfv4meE+XskWCpLLMpNcCatVRL7RUl7EBs+rHphCLb8CvaQRyPnDTy7EDLZhaM
         nyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwvFqRaw7/r31nlcL9DNcUXufOMLxk6prSBHpW93H5Q=;
        b=ShgipfRcTed1MCMYOAdBbvA7mWqCUxIM7P4qFdevaPPb0nNFD5cSkz+xVmse8kRx7k
         N99/PRI406eB8jvxnFba2wTOy2UMIe35rLbsiMIe0a3Eo/+AzK+rijyPh38x/9T85vIZ
         l/bGicv8LBY36KcUQFuIEnOrtynBPLewthE9Sz5ot7Hgvy4+UqF2LYFWcJOpT3bb6Vhc
         zloV6stgTwizI8nm0yjK4dvaYeiCTjWZVrUSCdgkG5U8zqUXplSMjIxQUHkJ9JR4xaFf
         BY8VO542AWAtkzMsbh+oMJR8BN7TRSFa05SFdldodGAClvVqztVx8yfbdkaS7w6eRF21
         zTig==
X-Gm-Message-State: AOAM5334QzPgg2X81YXBZkim1lrMGTUBfyBz3EZ+f0pHt02qbypkckR3
        /iTeDJt5VFFVBDpI4p9ygnI=
X-Google-Smtp-Source: ABdhPJxugFpWlbrLMnohwSEDLTAViWqjB+7KQrp3qJpAsRmic64cD+V2heGtaSZX/oIA5AxMQRJLHQ==
X-Received: by 2002:a05:6808:188d:b0:326:bd47:687c with SMTP id bi13-20020a056808188d00b00326bd47687cmr9292697oib.25.1652739521625;
        Mon, 16 May 2022 15:18:41 -0700 (PDT)
Received: from localhost.localdomain ([191.84.230.150])
        by smtp.gmail.com with ESMTPSA id t22-20020a056871055600b000e686d1389csm5721349oal.54.2022.05.16.15.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:18:41 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH] staging: vc04_services: remove unused macro
Date:   Mon, 16 May 2022 19:17:41 -0300
Message-Id: <20220516221741.1015814-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.36.1
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

BITSET_CLR is not used. Remove the define.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 82b7bd7b54b2..1ddc661642a9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -79,7 +79,6 @@
 #define BITSET_BIT(b)         (1 << (b & 31))
 #define BITSET_IS_SET(bs, b)  (bs[BITSET_WORD(b)] & BITSET_BIT(b))
 #define BITSET_SET(bs, b)     (bs[BITSET_WORD(b)] |= BITSET_BIT(b))
-#define BITSET_CLR(bs, b)     (bs[BITSET_WORD(b)] &= ~BITSET_BIT(b))
 
 enum {
 	DEBUG_ENTRIES,
-- 
2.36.1

