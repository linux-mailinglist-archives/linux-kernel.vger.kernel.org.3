Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48D05288D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiEPP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiEPP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:28:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935914030;
        Mon, 16 May 2022 08:28:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d17so14788083plg.0;
        Mon, 16 May 2022 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jvAEBjwUOb6zwBl6DiP+4dhdWO5kB2YZRGfj+rIA7BU=;
        b=U4hyg03xi6oe6X6bhQ1T1+v1r88DZ0by9HRN+VaKWFNIlfUp5+BpC2BgklaZ/gjmSZ
         Hzbe1Rg0Pqrgg6fUbPg9DCsFUP99lBVSI47LnmUwRdBVddVBukWeDVchsCUKHjIsVH6l
         ialCaFcZI0XBicM6OnNUlqlfGebQB2qNtYT6fZkmsI6mZjrfSzemK8yhu92r5cJSnth/
         c31ysVRyvCrgDcd/Mp5vp93qiHTtVsQhpo+1zYC87CD5o7XD6ricuQ2ziF1u53JHteK6
         N39Vy4qsAcIk4UsWLwoGB7+g+5t8oLWp/nfChFy+BlbEL32ZNovG8uZk8Gsv2e1/sYJr
         qehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jvAEBjwUOb6zwBl6DiP+4dhdWO5kB2YZRGfj+rIA7BU=;
        b=W6vR5blQT8aM4rsOTT+/EOSQVHoiviE8LuUizqdP5c3gCRAU1SkrfCIhpiujuGVgsI
         5JKuJMFEU4FwsE/gQNlGc9GnXkwIXcxHcE17aUs9IjwqxT/MW0UxFI/SqefjDfMQOhN1
         9HG2bvz9dM+/Oh07zjticcX166gbimKglX6jB6ZcjHnSxDIXo4Pqd35DgRoShRJelYsf
         tCZh/cE+XxsmqxQ1UZQ4BVKc0wsHohvflswc+JR/kbDm7V+AtsuThBXqd7aWOlPpML5U
         HfeYEi8ifruMeKzlLyTquDWR37dpSGSl519wM3wwi6EHnXj1ZnQudCcEs6OTxuBpODtK
         3gUQ==
X-Gm-Message-State: AOAM533gAhmmYxTGob0bC6wefTy0Y5Hldi/VPhpC/YB2Jn6aFH5NgiRE
        z7mVHMaFD8y/ii1DXA8Fvsc=
X-Google-Smtp-Source: ABdhPJy0iI39XqHCU2EmY5yUaX8imnzPT4LnPTzcfum+hrQ94V4WB81XJo2SovUpsXsl2iF2fpfWMw==
X-Received: by 2002:a17:903:230b:b0:15e:bc9c:18c7 with SMTP id d11-20020a170903230b00b0015ebc9c18c7mr17829910plh.29.1652714885101;
        Mon, 16 May 2022 08:28:05 -0700 (PDT)
Received: from localhost.localdomain ([116.89.131.16])
        by smtp.gmail.com with ESMTPSA id d15-20020a655acf000000b003c14af50605sm6895126pgt.29.2022.05.16.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:28:04 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v1 1/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Mon, 16 May 2022 23:27:49 +0800
Message-Id: <20220516152751.27716-1-ctcchien@nuvoton.com>
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

Add nuvoton real time clock RTC3018Y in I2C node

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 0334641f8829..c1248211b1b4 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -202,6 +202,12 @@
 		reg = <0x48>;
 		status = "okay";
 	};
+	rtc0: rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+		#clock-cells = <0>;
+		host-wakeup-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+	};
 };
 
 /* lm75 on EB */
-- 
2.17.1

