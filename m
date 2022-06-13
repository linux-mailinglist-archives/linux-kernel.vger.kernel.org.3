Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31FB5490AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiFMPLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386092AbiFMPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:10:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3E10EA73;
        Mon, 13 Jun 2022 05:22:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c21so6935769wrb.1;
        Mon, 13 Jun 2022 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CE2d0+60NDVuovHtEXKKvDNeFfiEcyOV0bxSUie0izk=;
        b=AQQtjmGUtZW30Fcgg4eAbM2t8ErNFYEn1s1Lx8T8t57IFy4Ngb1SzvSPJMBAdAGapj
         eP3l1iG8PUBvAc2/h7LN2NSH/QKKw6lRfrzzbjKyPu0mEDVsn0/UYIfz56hLyLpgKNje
         6DLRktUcS2VO5otIqUm4mPUCSPvk2WptrAV57fqhFhJ59dI+pUTcOo9y9omusfvEZriG
         PpGmZeLfaUSPWOpT4MTpKBNHCpVzQUDt58njGpIKRwzQmouBgOKcevBG08vTdvLqzyIH
         UfxQ9cTUubtJz6D2bgKNQiVyxIV/F8Gz+U4Mqu7nA+cbcSAz9pOi/VmKTo9xlwQexnvy
         Lz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CE2d0+60NDVuovHtEXKKvDNeFfiEcyOV0bxSUie0izk=;
        b=OzBIkLGJBbsHQaAXBDGMs7V0nHxFvsL3iqJs6jFWatgsX0hllTHFas4VeWBQwfr5GY
         02+tfZWRys1rm2MyPfVvrJWfsTkKovgpwcjXotGSmY8SpBYkkWO/l1krgbaXxO0tp/Mn
         dOZCNr3grmUunP3H6XRJVcrEufLKTr+NFxgq541YM8Nyx5s1V2wJ19WVFdYFx0H/1uz4
         uodQv+OjjvRhCrtZtTx2H7sRpIqHphFCt8Vue8D2OxqSxHmO3Sv//BU7+dWMfMxEzsqi
         K+RUzRJO08fAXUpRBjhld3fHPOOAn9O9zm5emRPg50twSvAb9b6Bw/NLYU6dyNpWOLdL
         cupA==
X-Gm-Message-State: AOAM530tlXA40SLxdT2sybOaw9nlhAPcH6op3d9MU/4/5cRllOi+wuI5
        c9j1CBYMlC6z1aavPKzILm4=
X-Google-Smtp-Source: ABdhPJzFf4lj4sWEE4BAhluB5zYv2MnSNEYC7Y0b1gmfxGJI3yeJw+Wr4awfC0Vpe0fdjVlyU7Megw==
X-Received: by 2002:a5d:64e6:0:b0:218:29d3:ee74 with SMTP id g6-20020a5d64e6000000b0021829d3ee74mr42920070wri.657.1655122940956;
        Mon, 13 Jun 2022 05:22:20 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id 63-20020a1c1942000000b0039c84c05d88sm8933147wmz.23.2022.06.13.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:22:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/nvmem to NVMEM FRAMEWORK
Date:   Mon, 13 Jun 2022 14:22:10 +0200
Message-Id: <20220613122210.14774-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/nvmem
are also the maintainers of the corresponding directory
include/dt-bindings/nvmem.

Add the file entry for include/dt-bindings/nvmem to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Srinivas, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fe1352137e..3bb8a8724eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14301,6 +14301,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
 F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	Documentation/devicetree/bindings/nvmem/
 F:	drivers/nvmem/
+F:	include/dt-bindings/nvmem/
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
-- 
2.17.1

