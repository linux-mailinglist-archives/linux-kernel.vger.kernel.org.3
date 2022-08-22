Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2B59BD44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiHVJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:59:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5131EE8;
        Mon, 22 Aug 2022 02:59:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a22so13139733edj.5;
        Mon, 22 Aug 2022 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wp2QrPIpQTo4MWRRsYKkgxdz51VQgkOW/AgaCkMbC7M=;
        b=phfVP8w9KiwL/W4mA2dmekpe3UlDdsBKPNNLVKVEgREABVaQHGoF/XiyHY4D+HNzeG
         vuR2G/KJTUzzKo6dxiWMvJAnFjQr1LGvEGjd/bef118PGxeiSRspryWJiAX60fUFayo9
         kyrq0wzKiB7fQfhwE16K7zbsQ2S/8vv+10WV8P3GKoRQIsmOi5lrvNqmy4asTc0sG4ND
         bFQHD8GtgkKjFRAsfQafJJPwojbE03JMKIy/1cq5fbO5HJ57FL/4kzfEp1nT1zWENFCq
         z1ch4DpxDRrc7MpscaGABAJAZOFNsjn8UFuvhR+jbNTzL/vT+XQbAz4YbOM96UEY6ZH5
         qDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wp2QrPIpQTo4MWRRsYKkgxdz51VQgkOW/AgaCkMbC7M=;
        b=uMbfJK5+FyG2AbH4oaB5A657210YwJ2bUk/rUiJmKEUjoBLbw7diylzv+kdQ22r8lj
         tjHmfAiUMPoPActOgyhtDKplF2yveNlRVR9aYkz0goCE2pdrfnI/1+4gYmNX6zVBKPj5
         KMIpscM19BnZ1m4F2/eiyP6hY5Zr/XSzrNa++EeAjzZ3VJgdCw7n7GpLyWOIpc/yxlqy
         xKrfpcnm7UlalfLV0Dn6Pix4Q8jgREmrcbWAKNl21dtf+fnO7I/eDxXAwqIk4UaLgzH7
         QBB9xSuLUIpu2a+0DkYLn5EXzKUiByNMuywW5lMdC6lJN6H0XHh7rj/3AVso81PJj56S
         oX2Q==
X-Gm-Message-State: ACgBeo3LehtiVCYepQ0AS8TCSbPNDNm/6fNFmLgQJXxhXW6t6MS80dwT
        2p3T626jDS4zeqI1jsmKWhA=
X-Google-Smtp-Source: AA6agR6o3jRs0QOS00HHfbR0AaJKvZmOKKCy7PYKOWsjYtioz65nfG6p80jf/sVC7LQOCWcQm/f2pw==
X-Received: by 2002:a05:6402:3805:b0:43e:8335:3a2a with SMTP id es5-20020a056402380500b0043e83353a2amr15876495edb.296.1661162387018;
        Mon, 22 Aug 2022 02:59:47 -0700 (PDT)
Received: from chgm-pc-linux.. (089144219133.atnat0028.highway.a1.net. [89.144.219.133])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0073306218484sm5909771eju.26.2022.08.22.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:59:46 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Add main_cpts label
Date:   Mon, 22 Aug 2022 11:59:43 +0200
Message-Id: <20220822095943.18563-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Makes it easier to reference the node in board dts files.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index cdb530597c5e..91fbcd7892a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -550,7 +550,7 @@ cpts@3d000 {
 		};
 	};
 
-	cpts@39000000 {
+	main_cpts0: cpts@39000000 {
 		compatible = "ti,j721e-cpts";
 		reg = <0x0 0x39000000 0x0 0x400>;
 		reg-names = "cpts";
-- 
2.37.2

