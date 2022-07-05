Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3F5670B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGEONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiGEOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD2F8;
        Tue,  5 Jul 2022 07:07:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lw20so21864179ejb.4;
        Tue, 05 Jul 2022 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6L8UfFjo10Ytj/Vnf3NYMNU4nswAMDcGGzfbLleINo4=;
        b=dVcIeVTR2JUcsz0ANwKoL7CTHQocQNkIkUN0Imi8/XAArzODsyI/HYKEW/TFWEQEmj
         lVlZLEKpb/JSvNo4ik3Vt/xIHn83QKQiIEDITjxZ49V5/vnSErKFpvwun4T7otGV0qT6
         7ov8ZdArIn0INofy+CoWBU9g0/9rUM43r0l7Q6keaDAJ5KsWXvqagO1V3VoYGHDQAItO
         36MtK7O8kQoJHXMffIUvWhMkQYN8327fMFmHH5/gW7v8czJAf0QgkSHqoqZq9TCgc/hf
         Hasvwbi/nNHn9VP/p3CrZy8SRA8bIfGhGFDj+WfXw7JxIjkjc9frX+bqzcO3lDcthmGY
         Lg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6L8UfFjo10Ytj/Vnf3NYMNU4nswAMDcGGzfbLleINo4=;
        b=ZG62z9Gdgt/Y/EXynlttzopvyQKJYc0z7RwClR6i8DbYJrq3te15aThtkdMvlYsKlA
         bkI4Svsjfm6zbT103wmRCrBG1hHqWPeKfmAxxOPGzTf865Z9Nov7AAoiuR0MnWd8FHEl
         ss8VANaSHDIQIlp5/Xl3yHxbZXweeg7CmdwCE/XUI9XMEKauGvNWozDRn8VyraP7w+td
         vvpx7tCf1Sb3VfIgjVdjTM28ON5U8c8AOubMhZaAl8I8OYu+mnpIG55vj790Q4CjC7Mq
         MGmNSI747Mxuv+15Gq5itjxcvIMF0+VFFt9rLtwSMYCH4D9YP7789AHxgFMwoYVhK0rB
         Cvyg==
X-Gm-Message-State: AJIora+kch2iNmKzKwxnmJ4OsbIQHWcM1BVd+CeVm0v1YYEK1dludtYB
        BZe+ENb+1qgioKlbQymtOt56FuIm1H4=
X-Google-Smtp-Source: AGRyM1uMalPW+lwEU2G98wsYFw0/UoTRS6FpUTta8Z5JyPRwgd8MRIrdhTi14h+QX1xRjNahhSu9Ng==
X-Received: by 2002:a17:907:a079:b0:72a:b46b:529a with SMTP id ia25-20020a170907a07900b0072ab46b529amr15883098ejc.313.1657029996992;
        Tue, 05 Jul 2022 07:06:36 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:36 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 08/13] ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
Date:   Tue,  5 Jul 2022 15:39:12 +0200
Message-Id: <20220705133917.8405-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Fix dtc warning for missing #address-cells for ipq8064.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e13f6ae92e05..b5aede3d7ccf 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -352,6 +352,7 @@ qcom_pinmux: pinmux@800000 {
 			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -473,6 +474,7 @@ mux {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;
-- 
2.36.1

