Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C484EB1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiC2QcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiC2QcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:32:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E4241B72;
        Tue, 29 Mar 2022 09:30:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a17so21328903edm.9;
        Tue, 29 Mar 2022 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Kco4hdx++fwSJlbz2TB/+gfQh17jeATDzy4+YsiSt8=;
        b=UdkkfW4XqhJOS8m7elAIsHReW+6pb7j+kGvkfAdg53OMsDh0jXcEP+6wQFsKBP83ns
         b69NUdZBo+el18As+qDJ30WmgDQhV4Lbr0MjtaBnWXxNEvIfJGxxN/7GRCqed5yf3vbB
         H1kS1fFUdiJ8JInS2A+E9reqWNnd8m7FwtRc6qwiitXAa2CJx+YF9+WyczRRXqENjlt1
         0EXO5WAxmKm3Su7HZPX2fyNafJ9Eg49vZtVimv9HRMLrYJu6RKso/1W58RNFfVdzVqMb
         bgZKFcIAwt1/Ck581kUrwUPmTyOBKvlWcJkT+OCkVQIT3v949njQloPs8nvkW5J7KEiy
         zePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Kco4hdx++fwSJlbz2TB/+gfQh17jeATDzy4+YsiSt8=;
        b=zrwaT+dYEH9OGx7e1bd7c9RgOJ63GE1HnegcEydAjC/fjjuz0flwch58jk6XO4QTKE
         MuBDevej7295A/dD8xx52Ln/7dpaqoKlOCVZEQl5pbs5C175cxN6fK2wVBYqFdl/IEi6
         lE/xMCdIenPr7oeUqpZYIRMQ9rZsIjGgY6Bi8DXglXoP51pFtBbea+XeOIJT395Er3wK
         DpLV+yVrLCGVpp/hJfkUgGCtZkT6OG/SHKqXMQ4M4DI6FYmbRxXy/4nxMTHyP2PKIQGD
         5kpnx+u5SX50keYg/SFfJFxh9MVyqUW/dcaTDmIsYODUrkWxgln0eVuSRjYtUP6lKD/W
         b+hQ==
X-Gm-Message-State: AOAM530kyICvv/erIyFggwfKAH7yppY2jANkohFgT7Dj1JsCMO2gtLWI
        qvx9Zy/FxVuOh8Az4SF3YE0=
X-Google-Smtp-Source: ABdhPJyZ66JRA0HduKO18iYVGSXAq+jSnAguIvlWsoeEVYE1zGSMp2Zs+eP9zv2g8MyVs3viathGJg==
X-Received: by 2002:a05:6402:42c6:b0:419:276c:4a64 with SMTP id i6-20020a05640242c600b00419276c4a64mr5543580edc.119.1648571428244;
        Tue, 29 Mar 2022 09:30:28 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm8601179edv.42.2022.03.29.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:30:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] arm64: dts: rockchip: fix compatible string rk3328 cru node
Date:   Tue, 29 Mar 2022 18:30:15 +0200
Message-Id: <20220329163016.27458-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329163016.27458-1-jbx6244@gmail.com>
References: <20220329163016.27458-1-jbx6244@gmail.com>
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

The rockchip,rk3328-cru.txt file was converted to YAML.
A DT test of the rk3328 cru node gives notifications regarding
the compatible string. Bring it in line with the binding by
removing some unused fall back strings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc..73418fd2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -756,7 +756,7 @@
 	};
 
 	cru: clock-controller@ff440000 {
-		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
+		compatible = "rockchip,rk3328-cru";
 		reg = <0x0 0xff440000 0x0 0x1000>;
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
-- 
2.20.1

