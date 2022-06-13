Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D950C5483D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiFMJyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbiFMJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:54:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322A19024;
        Mon, 13 Jun 2022 02:54:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so5443979pjo.1;
        Mon, 13 Jun 2022 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u0NPneZZ9r0x4Kp8TclBRmjdl0tXAndSbSU1SBOWrP4=;
        b=aZRWYoBcDfcD6fB9QGEddxaw1as+HrnOVFyOdoq0/lJ7Xsy3XmVMhiUC3Dck89rqxg
         dQEXNHsXxoZsBMoNRVv/Mk7nL7nRICE9qlEhypAdGv8JP+CiPFz7fsrMRSrmRVzBYhqV
         69k+OEhlN2HJIPP1Ntll+fh/tLs49QUl1L6nLH2l20o8Nkj2Exs1Pz39AN71391pNTeO
         Hh7BqBYYNWMDgd6BQkDsfORl4SaQaI2Nd1QlXAcIlstHkWFbf2sQALiDom25ttP6/EyA
         eo5QbnAOlicF6qcgGrJXJryjxKq85Xfe16a0lq44zoMpuYlj7+9bhRsk34LL0bqjmxAu
         xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u0NPneZZ9r0x4Kp8TclBRmjdl0tXAndSbSU1SBOWrP4=;
        b=SFLQIqqduH1VODLEoHHrnnbMAzqwp79+7K4Y9qb1hjo8E0VlEUSCmo315lAQYdzRAZ
         goCqXQtJYXCPF8GYV/HCl9w/hRSV/ky1Xit7C4INff5WoUpgrGU/ki+tzV3egLkk16xS
         oJrgV5zgI/fteWLKTd7rzS/fMlb6LfUD4J6NaMa8Qv/c2uzPyTA+iATEcZyPG2TIfDoN
         nyNjtCKHD/TS2tYx35/PK3/Pr1oDEtd7qRDspifVqyKq6QH9bTEyOi64LWNKnmka7qJD
         wcoP9cS88EVJG+zXOny6fvguiMwzlK9yj/7pq48Z/oR5BVMWgBNbKLBKAKiYAnY3ZV1A
         SU7g==
X-Gm-Message-State: AOAM532as9QhVvVNjukM/MY3Xq4oIVI+DCWvhyqbI2FPmfoV7zx3MFat
        I4aAWDZ1S03bvbjDiavCPj0=
X-Google-Smtp-Source: ABdhPJyD4dRXQpY85ssRFCE8v1mSl/0QR8h2yF5BwpSNP0u5z+9EM62TKZRSwpmafayM8jgnpOo6gw==
X-Received: by 2002:a17:902:e845:b0:163:ebca:a025 with SMTP id t5-20020a170902e84500b00163ebcaa025mr58149773plg.81.1655114044566;
        Mon, 13 Jun 2022 02:54:04 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001639f038250sm4639754plk.220.2022.06.13.02.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:54:04 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 3/4] ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
Date:   Mon, 13 Jun 2022 17:51:49 +0800
Message-Id: <20220613095150.21917-4-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bind presence-sledX pins via gpio-keys driver to monitor and export
GPIO pin values on DBUS using phosphor-gpio-presence service.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index ee33cc3efae4..7b6de9b51547 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -190,6 +190,41 @@
 			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		presence-sled1 {
+			label = "presence-sled1";
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 2)>;
+		};
+		presence-sled2 {
+			label = "presence-sled2";
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 3)>;
+		};
+		presence-sled3 {
+			label = "presence-sled3";
+			gpios = <&gpio0 ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 4)>;
+		};
+		presence-sled4 {
+			label = "presence-sled4";
+			gpios = <&gpio0 ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 5)>;
+		};
+		presence-sled5 {
+			label = "presence-sled5";
+			gpios = <&gpio0 ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 6)>;
+		};
+		presence-sled6 {
+			label = "presence-sled6";
+			gpios = <&gpio0 ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 7)>;
+		};
+	};
 };
 
 &mac2 {
-- 
2.17.1

