Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702A4FB8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiDKKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbiDKKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:03:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D09113F;
        Mon, 11 Apr 2022 03:01:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so22164113wrh.11;
        Mon, 11 Apr 2022 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewHONqcrb7KyRXkSHVhzVTqr07JIHC0hp68Nq3+aWis=;
        b=BK9sFy6b3EfG5Q4LdnkUO7GTR2GFLnmHi88VpTmqdpSDGVlVlqPbXTNhuohonwKej0
         Wle9BAH6RPU21vTMzSWOcDsUTx79au8P8tVfuRJidO5hTqpwaYjjDxtFaA89h4lcYSn6
         aXLiI6OCZq8mMGRApV/FOYv0MHG5dTDWhqf/PdlRzW1dIKHXYVlvR289FJOeWYMHnZT8
         Ty/kMlNNcti9ukg1CUJywDrWdAuum8FbUVFuX3VBNfQYYvf6gBfQp+eWfQJouKHMd92y
         hlhKYFWLp9+qLbqPiAxAuSgcdvT44SkldSms5MTxhgsJhE5chQ31LISADS4LdtMGeTyj
         orMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewHONqcrb7KyRXkSHVhzVTqr07JIHC0hp68Nq3+aWis=;
        b=PucC6XWeNhznN6rkBX2Q7U2QZ0TFWJK16hTTThKBwiz4lAJW+/EDA3yuDl3UCBviQM
         eNk3YYw4lkzI6d6s4UTF4wm5Z/C7hMwCzTfdchy8TMXsPVLFEyuWuPhXEe0rClNkBhSJ
         UP9tVZAMTXpX0Idvag7UPyxjtTDg/tKO+zw7iQsuU9+q5j2o5e3F6eIeZSLB/v+Naewr
         5Od5NhM37kKawSCNNBCCikkCiEJtRlu+ek7rm293qo84aTFrn4TsLAu/VoxZNeEGjOlY
         6ya7HY2deIaVJdbSjAXlFmDa8ASP73AVK9MyqxmJP4yo701JVCEf8PxUmh2cWWEtt6Ko
         M/bg==
X-Gm-Message-State: AOAM532M9/tq5yZ8sEywdeq0aIZC4rjenN2aWiPxx5dgD4wtWlWf4ym/
        8dPMI5ZGJxz5qkshLoRL/oCnfbSlc9mS1Q==
X-Google-Smtp-Source: ABdhPJyyIRgUlQ5M4Xjo75fzKru+MCTLX2sRo7j4GnXRu6GPJul9zze475HBXOeJqQpVtNYY9mQLdQ==
X-Received: by 2002:a05:6000:1f84:b0:207:a34b:3d5a with SMTP id bw4-20020a0560001f8400b00207a34b3d5amr5681915wrb.696.1649671262118;
        Mon, 11 Apr 2022 03:01:02 -0700 (PDT)
Received: from localhost (92.40.202.18.threembb.co.uk. [92.40.202.18])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm17299345wmj.34.2022.04.11.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:01:01 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: dts: ingenic: x1000: Add PWM device tree node
Date:   Mon, 11 Apr 2022 11:01:39 +0100
Message-Id: <20220411100139.15672-1-aidanmacdonald.0x0@gmail.com>
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
 arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..0dcf37527c8e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -127,6 +127,19 @@ wdt: watchdog@0 {
 			clocks = <&tcu TCU_CLK_WDT>;
 			clock-names = "wdt";
 		};
+
+		pwm: pwm@40 {
+			compatible = "ingenic,x1000-pwm";
+			reg = <0x40 0x80>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
+				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
+				 <&tcu TCU_CLK_TIMER4>;
+			clock-names = "timer0", "timer1", "timer2",
+				      "timer3", "timer4";
+		};
 	};
 
 	rtc: rtc@10003000 {
-- 
2.35.1

