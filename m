Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446705200DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiEIPS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbiEIPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A82529A;
        Mon,  9 May 2022 08:14:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r192so8127646pgr.6;
        Mon, 09 May 2022 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZWn5E2EE8nj4uEWuuAfTQEal8qD1zVL11WzqRE45Q6Q=;
        b=faAQpKEzldkVkRL/XHRO8hiCHrXbqFQa+pdUFHO1feAhT0CRQUcdhryrb2m4ZFHxVL
         TWa40b1NL6mJ5aiDDJ1LylBy+YrupOHd7WFLp4ySA5GmJss0PXnmpt/ZjULZNkkwsJHs
         V2HrdS8O47TfPqtmDNt3LF4LoRPyhscZ3W32pXzqZYbjoGhUJSQ7VWXpW3lVEi6jKE+v
         NGvAxDUSmjPF2Fc64FZPHDc4jqbv2nyyMdy59WSdDpuj+YG8e1LRPtDgWD8AWPhtLFjm
         fDEYzGg+pj/KnO8l3/kAyeSp8hIBzjvwmn29ZHUGFn1is9jH2sBffNhNxSM6R4n0mHg6
         Mbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZWn5E2EE8nj4uEWuuAfTQEal8qD1zVL11WzqRE45Q6Q=;
        b=QvCaIN1WakRkbRRp0sNSHpPk7ZrRTV+cq4q7BG+j+pDtReUR2oJbimExW3BaJ7lxrS
         mYpTmDkr4gDF7QrZj47KBv6Gl8cvDCDG55fEMerjdDdt/WGUIHOKWzboyl/vr+Ptzri/
         g1yGULUdObiYyvRHlaZ/qlQxEw6/8+U3NaJIf3pP16huw6pt1My93QAaLxqcoQ/nLUjP
         SYHhbSb5UnmRpzsmLEZjwRoIeC+ZrqksKpx8rYnPLaHnfmTblsrxwPEHrrD+8Qoprq+S
         NGYfyzCCtmksp3X5KKinTr8D7ny2Ep/nX+nf4guZxvdaVGRnykHU1WPRAFpoWpZCQPCY
         dfcQ==
X-Gm-Message-State: AOAM5327asbe5keB/Z+YC58/A5M4RVKjV+8RDTYAdCoPpOyQ/luLhNM5
        SlSfPVV+YhnhB8JoccshpcE=
X-Google-Smtp-Source: ABdhPJziy1/dsxuxQ5K1tlFRDwXkYdaJw0QVHlhrp3egp6duEob8OIrAAnQmQqNRYCx9dU4sxxCneA==
X-Received: by 2002:a05:6a00:170a:b0:50d:3e40:9e0 with SMTP id h10-20020a056a00170a00b0050d3e4009e0mr16745937pfc.48.1652109264656;
        Mon, 09 May 2022 08:14:24 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:24 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 4/6] ARM: dts: aspeed: bletchley: update gpio0 line names
Date:   Mon,  9 May 2022 23:11:16 +0800
Message-Id: <20220509151118.4899-5-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GPIO line names based on DVT schematic

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 42 ++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 0994ea3f41ae..49e4b9f63a28 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -766,43 +766,55 @@
 &gpio0 {
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
-	/*B0-B7*/	"","","SEL_SPI2_MUX","SPI2_MUX1",
-			"SPI2_MUX2","SPI2_MUX3","","",
+	/*B0-B7*/	"FUSB302_SLED1_INT_N","FUSB302_SLED2_INT_N",
+			"SEL_SPI2_MUX","SPI2_MUX1",
+			"SPI2_MUX2","SPI2_MUX3",
+			"","FUSB302_SLED3_INT_N",
 	/*C0-C7*/	"","","","","","","","",
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
-	/*F0-F7*/	"","","","","","","","",
-	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
+	/*F0-F7*/	"BMC_SLED1_STCK","BMC_SLED2_STCK",
+			"BMC_SLED3_STCK","BMC_SLED4_STCK",
+			"BMC_SLED5_STCK","BMC_SLED6_STCK",
+			"","",
+	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","FM_SOL_UART_CH_SEL",
 			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
 			"presence-sled1","presence-sled2",
 			"presence-sled3","presence-sled4",
 			"presence-sled5","presence-sled6",
-	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
-			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
+	/*I0-I7*/	"REV_ID0","",
+			"REV_ID1","REV_ID2",
+			"","BSM_FLASH_WP_STATUS",
+			"BMC_TPM_PRES_N","FUSB302_SLED6_INT_N",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
-	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
-			"ALERT_SLED3","ALERT_SLED4",
-			"ALERT_SLED5","ALERT_SLED6",
-			"P12V_AUX_ALERT1","",
-	/*N0-N7*/	"","","","","","","","",
+	/*M0-M7*/	"ALERT_SLED1_N","ALERT_SLED2_N",
+			"ALERT_SLED3_N","ALERT_SLED4_N",
+			"ALERT_SLED5_N","ALERT_SLED6_N",
+			"","",
+	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
+			"LED_POSTCODE_2","LED_POSTCODE_3",
+			"LED_POSTCODE_4","LED_POSTCODE_5",
+			"LED_POSTCODE_5","LED_POSTCODE_7",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
 	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","BAT_DETECT",
-			"BMC_BT_WP0","BMC_BT_WP1","","",
+			"BMC_BT_WP0_N","BMC_BT_WP1_N","","FUSB302_SLED4_INT_N",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
+	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL_N",
+			"P12V_AUX_ALERT1_N","PSU_PRSNT",
 			"USB2_SEL0_A","USB2_SEL1_A",
 			"USB2_SEL0_B","USB2_SEL1_B",
-	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
+	/*W0-W7*/	"RST_FRONT_IOEXP_N","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
+	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT_N",
+			"BSM_FLASH_LATCH_N","FUSB302_SLED5_INT_N",
 			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
-- 
2.17.1

