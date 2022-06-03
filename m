Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0053CBBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiFCOqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFCOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:46:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8F43AD9;
        Fri,  3 Jun 2022 07:46:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y19so16372682ejq.6;
        Fri, 03 Jun 2022 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC2Ee0NCMeJlT8X63fxTRGd38pLFVJ7vG/uklMcOIlI=;
        b=DAB5AcjIBnOjiupP4hH+HStNF4SpkVxPODvVa/NiTvS0oAxIKy2zDSw2eSxFE4DMUn
         SACRISr/C2QkVjCN4BHyV270f/As2rNYKDdazu7lgTfbLhPOIKsLKVTX+xWJfmv/9g/m
         Qs3WDJ/nCF5iy/yKfsiUGGiksML1xaTGbbLmyrASIJpuf2bs0NSfYNGbfjelc/2gzW3h
         /dnyGE4XvUuIXpOmyrsYw9CZryf+DanLuMivUf1FnH8UuLWg/aNYrV6MMtIUVotPyChW
         Qf6G0SMwV4Nh9L2qk01S+lh9wjbqqnrewq3eaUl5Tc9Mmm0ecHf3eqoqYVgbYP8xvvem
         UCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC2Ee0NCMeJlT8X63fxTRGd38pLFVJ7vG/uklMcOIlI=;
        b=shjskqlTi7jZ0+VjE8y9o74LQDjMlX2yTG2otxN1VPxPXSDp8H2+e3d7iPvoA1F8CC
         beC9cWST20+ZCvohmJU0s2leNTiEgTFiiXr0wfIUKpcLzzNzLB5x4E8urzrOR5KjF1ik
         ohHBl207VlKzJx97ZbPbiD2uyLxBeC/eE0ztMkBxGcDVR+mg1u6G6v5yFHRhoSAN87ck
         81O6DP+mlNtPRib+9HDexqafgUpMAXfmUmWj7tnM5wLX87elPdyMyAtHku9HPJozmvKd
         gTdaG3UxycwYBt9csMLdAChzhiykOdujOiAk0Jg/2AZZKPaJYVJHdzZaOKxaxbj73v4g
         4h5w==
X-Gm-Message-State: AOAM533lWlCqza9EY+FCczw8Cdf+vO+b0LyByx+j0xuT0bAfxm7IVv/v
        HuSl0VG6oIsQf4Vkkn/57ZY=
X-Google-Smtp-Source: ABdhPJyrEKILSmBN85RnfzhGT5qzWkMJSCH9sMD+nxXy6MWjnCr3KSkruA0fsiJp3z9mm1ULqrAapw==
X-Received: by 2002:a17:907:3e22:b0:6fe:f080:a383 with SMTP id hp34-20020a1709073e2200b006fef080a383mr8793096ejc.709.1654267605061;
        Fri, 03 Jun 2022 07:46:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id kx16-20020a170907775000b00706e8ac43b8sm2920151ejc.199.2022.06.03.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:46:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: rockchip: enable nfc node in rk3066a-mk808.dts
Date:   Fri,  3 Jun 2022 16:46:27 +0200
Message-Id: <20220603144627.23269-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable nfc node in rk3066a-mk808.dts

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 667d57a4f..cfa318a50 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -160,6 +160,24 @@
 	status = "okay";
 };
 
+&nfc {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		label = "rk-nand";
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-step-size = <1024>;
+		nand-ecc-strength = <40>;
+		nand-is-boot-medium;
+		rockchip,boot-blks = <8>;
+		rockchip,boot-ecc-strength = <24>;
+	};
+};
+
 &pinctrl {
 	usb-host {
 		host_drv: host-drv {
-- 
2.20.1

