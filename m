Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA094FC18B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbiDKPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiDKPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:54:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3721A067;
        Mon, 11 Apr 2022 08:52:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c7so23771516wrd.0;
        Mon, 11 Apr 2022 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSYUEobIbJ+4TacVBwZODzwx3QJifOGC6/qe9Ci+rXU=;
        b=HBIWCROoEvWJ2eVhlcfE/vxsU+xGs7MV1CdImhOMNOC4DRNZEhgihXWCfC3ETJjijj
         yAtCbJ5tCSqk1LNxp6VlZXiTnGGYwpgGwOJOcbH3ByUU8826g75+cbB2ESYqoLZ7U2Zh
         fYY6dckPplB/h/oHDVL/cT0YhyWFjmRmXYpQSxy+6q5mlk/uOw9AWQbUb58XCvc+vzRJ
         qOse1IX13DmxeCVjYZwcOXkg+/7RJh64U+7U4eiy06i3PPjfO6yDDdN8bHbZGa+Akz9r
         8ERJTL5xBCMv4AV32OtlUmKpuYM3JlEvVT3SPaubosuykisD/bQU5zyAFzAR1y6sN+PB
         D2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSYUEobIbJ+4TacVBwZODzwx3QJifOGC6/qe9Ci+rXU=;
        b=3VemBzj8X4J+LcsdTRicffly6DEnSQH5Pq+2KuQdd9gQL4tSstcOXE2BuMHc+su6M3
         8zzuTULOov6Cdjn02XLwZ83LYsY1itiMdxlq0te/l5UTBBmCmFr74IPyVhDyay8oDSyU
         1QUvgHo9Cb1ZkGcu/VrBS2htLeTvjeEpCoq4jYgHO8Jd2E/woPU216oyJVzQdlGf1CRg
         f4v4Hl5J7CmlTAbB6wxkJmuTV4riKPpbMV/7qFUXkhTxBJYQXIq7ogwhN3cgtqoCG8zd
         YTIKdJo2BpL6BSQ43o/6NiJmCyW2gQjcQbMyzGeoDeCfwY6UlVuhNS7A0vUzkI/y/kxN
         UgBw==
X-Gm-Message-State: AOAM530AwZYW1ohfFGP0dZU+5FP7SG5shU9rSZXs8TlEStEBe/+Zc+vI
        JBN+Xec1ELQKGmVsuy3ucoapuviyhc6XyA==
X-Google-Smtp-Source: ABdhPJxCMRZaoaSRaLPAztQnRdw7+/CWojexfEBQNrWbrHW1VwFLK8uUJTbLxyw4KCIaOnH7kLwGQQ==
X-Received: by 2002:a05:6000:1044:b0:1eb:f72c:7f25 with SMTP id c4-20020a056000104400b001ebf72c7f25mr25187203wrx.155.1649692359757;
        Mon, 11 Apr 2022 08:52:39 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b00207aac5d595sm1440015wrx.38.2022.04.11.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:52:39 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     paul@crapouillou.net, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mips: dts: ingenic: x1000: Add PWM device tree node
Date:   Mon, 11 Apr 2022 16:53:15 +0100
Message-Id: <20220411155315.51769-1-aidanmacdonald.0x0@gmail.com>
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

Copied from the jz4740 devicetree and trimmed to 5 timers, which
is what the hardware supports.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v2: Reduce regmap length since only the first 5 timers need to be accessed,
    and don't wrap the clock-names at 80 columns.

 arch/mips/boot/dts/ingenic/x1000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c2cdbf947264 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -127,6 +127,18 @@ wdt: watchdog@0 {
 			clocks = <&tcu TCU_CLK_WDT>;
 			clock-names = "wdt";
 		};
+
+		pwm: pwm@40 {
+			compatible = "ingenic,x1000-pwm";
+			reg = <0x40 0x50>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
+				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
+				 <&tcu TCU_CLK_TIMER4>;
+			clock-names = "timer0", "timer1", "timer2", "timer3", "timer4";
+		};
 	};
 
 	rtc: rtc@10003000 {
-- 
2.35.1

