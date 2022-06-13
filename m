Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F9548FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiFMPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386768AbiFMPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:03:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8524EFF21;
        Mon, 13 Jun 2022 05:10:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o7so10788965eja.1;
        Mon, 13 Jun 2022 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nM1ToNddtuPmZmKp34E+C0azOheh3w4b7TSvswDeFiQ=;
        b=DEg9vurSZxRH4cSk2zXW9txEvtrNLgfxVRta6QlCi+LrOdsSVTdufVJNLkWXm3i+77
         ZzkokCTOBgOqTxn0bBg+uE712WEGb0W/1SXzwb5b4LSalQjNdp8/Sz3sidk+xd0r2MzT
         0l1UbAYNSv1MujwTn8QWIUU1+hqyACRG27Mz0Wlrh4l+WOjfEwth9Ax6zxKP4/PI62Q1
         LO5Z/2RJR+60qpK9KSvthTY2WMmMxZUWW/nF5HQd8qCAdEgq/ky3coUWFXK3oS1uPTqB
         Eq7pfKmSN2t65cWwzuvzp+sfaObZbNQ78b2NMv+ZSTvZjYMdQPmH7DTJC9eb/IIr0cCB
         YUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nM1ToNddtuPmZmKp34E+C0azOheh3w4b7TSvswDeFiQ=;
        b=ZSU37UtsVLEnFWOT8n5z54bSBN7ye1au8aHGfq0DsTixYb5/Vkmkul9qTOFkZofeg0
         rFYh5OVzgF4j42ipQsdpUYV9TBKuxjDZ4oG9aAFRsD0JXQby0Da0+yKjB97mHGPYkmwT
         fvmQUsNbQkCMle5Qx8eGq2wxyq6uyW+LIj9HivuGhvduJoaL18B7dvZIuydaC2nNheXG
         jELnc4QzLMjJ81emyx7qeS7wXcaCPm/Oz6D3VhGwHxM3F3JNKrIchnhCvQWb4F+MHdUg
         lZVxcxEx87hd7gLFfzto6yfLRk3rnzXpNFTmVt9fllNHuKIWxUsaSAgi8r9P2OSfAOYo
         re9w==
X-Gm-Message-State: AOAM532pLJTaJa34UmNrNe2bF1s5AejU4Daom3oN+sGM39kuYGKVY/1d
        /dVKdIc0+WBUffsMR5+WuEiqhY22fI8=
X-Google-Smtp-Source: ABdhPJz7kuEWA784iJJ7FkL/0fAuCrBN5O1XxoGltVSCrkKX2BjLkd9USAyINg9V+2OoGGLTwBGqXw==
X-Received: by 2002:a17:906:9b96:b0:711:d21c:1b0b with SMTP id dd22-20020a1709069b9600b00711d21c1b0bmr34797271ejc.365.1655122220343;
        Mon, 13 Jun 2022 05:10:20 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id lo16-20020a170906fa1000b00708e906faecsm3761336ejb.124.2022.06.13.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:10:19 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/media to MEDIA INPUT INFRASTRUCTURE
Date:   Mon, 13 Jun 2022 14:10:07 +0200
Message-Id: <20220613121007.6181-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainers of the directory Documentation/devicetree/bindings/media
are also the maintainers of the corresponding directory
include/dt-bindings/media.

Add the file entry for include/dt-bindings/media to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mauro, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 856ac3231a54..1b30f6b69477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12501,6 +12501,7 @@ F:	Documentation/driver-api/media/
 F:	Documentation/userspace-api/media/
 F:	drivers/media/
 F:	drivers/staging/media/
+F:	include/dt-bindings/media/
 F:	include/linux/platform_data/media/
 F:	include/media/
 F:	include/uapi/linux/dvb/
-- 
2.17.1

