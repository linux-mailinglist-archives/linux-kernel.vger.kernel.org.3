Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFD4E265F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbiCUMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiCUMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:30:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EF25C51;
        Mon, 21 Mar 2022 05:29:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so2498160wrc.13;
        Mon, 21 Mar 2022 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5onXiNkmrl/Ehqc3VrHaHK4tRoSPRnZEkLLOepOy9Fs=;
        b=It6egBQCtavAinl/Ct9INixNPLZasjpDNbxSZXBP3AgQlp41YQPMUVXr3ur4BVnl0u
         tZTp3pbO+L+CPJ5mIlJcoHMcHU3Ubqjv0NI5p5V3jZdhirJ8R1EOBEBISulBs9YdVDHA
         n9dqhxu5qdLqoG1ce+MMk/5mlxNVNIHp+R8hr5SHyeclBMq/FswkFAXX312qnsyTreEY
         XlBLlHuEk3Fbx/1HzYX4NMpcdMq0z/T5MBE02/WaPuqeMyO1RWwKPYdd/mxVV6jlTcC2
         u+/hnNa86J8K5IlvLFBkgJgg0Yd1DGPfxB8MR5VWt1BDLoqc020IpJKGfpqvFUQsMQIl
         y89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5onXiNkmrl/Ehqc3VrHaHK4tRoSPRnZEkLLOepOy9Fs=;
        b=cKWbYKzakRjEE4KReRaXxzPMLS9YuY0C40knTdR4PASQz9XrMer8YMh9uaFooAO9pV
         gJBCHa2K8kimA6YFnR3uU0V0L74/O6djlentG9PT+PsIhEm5Kspmgrqbt4bsoVUzJlBG
         fX6/EA29xfrkFoucGImVKSD3YwYJYwsuWl0t1KeLEUqOuVU55ykg0iPxS9U5PEzMKw2x
         P3+1xOkVdmwdLvJQihaTUyfChOdh756gWJbgzQblwb8IT3+GG7lDtw0x8fA/wr/wM5PV
         AaAAxn1fVjqIAc7SdmQTkiSCRr8iacTLqdNBOA4mL+T2FE9Gx78aUGA82WRtUmaNiklE
         IYwA==
X-Gm-Message-State: AOAM531S4G8T5NotdWmKIxaHjTT2FgZVszXfMjK5CvwZOASSuCr+NEwk
        u4ax5fsMpaXA3R64gPXCybVCCgKXvYY=
X-Google-Smtp-Source: ABdhPJxZFGgX1EKl6MYIegOek/g5ia7a9aFJVbLEXOcsL5U0/PyuU2SFYcKo9gzHN0RYl94ieAFiJg==
X-Received: by 2002:adf:e342:0:b0:1f0:648f:c32b with SMTP id n2-20020adfe342000000b001f0648fc32bmr18145392wrj.204.1647865755135;
        Mon, 21 Mar 2022 05:29:15 -0700 (PDT)
Received: from felia.fritz.box (200116b8263e6c00181aa882ca814f87.dip.versatel-1u1.de. [2001:16b8:263e:6c00:181a:a882:ca81:4f87])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b001f04ae0bb6csm12767248wru.58.2022.03.21.05.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:29:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for XILINX CAN DRIVER
Date:   Mon, 21 Mar 2022 13:28:40 +0100
Message-Id: <20220321122840.17841-1-lukas.bulwahn@gmail.com>
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

Commit 7843d3c8e5e6 ("dt-bindings: can: xilinx_can: Convert Xilinx CAN
binding to YAML") converts xilinx_can.txt to xilinx,can.yaml, but missed to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in XILINX CAN DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Marc, please pick this minor non-urgent clean-up patch in your can-next
tree on top of the commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c520915a3222..0c2ea4db3f6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21613,7 +21613,7 @@ M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
 R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/xilinx_can.txt
+F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
 F:	drivers/net/can/xilinx_can.c
 
 XILINX GPIO DRIVER
-- 
2.17.1

