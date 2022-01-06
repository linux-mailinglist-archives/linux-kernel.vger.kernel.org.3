Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631874869CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiAFSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:45 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39863 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiAFSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:37 -0500
Received: by mail-oi1-f172.google.com with SMTP id a129so3859731oif.6;
        Thu, 06 Jan 2022 10:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5h1dR4PNN5NFkFW0+XiCyKA8d8fazWVArSi0BOxk1SE=;
        b=Bga3uG3lhYTWOBGMyXup/kS3O7N4Z2+uLYpPCfMbI14sVi50QjtFaA2cO12H/xdKSe
         WGUZKK9cIfHyQsjXNFOYD3e6ZPG9g3cTzErQXs78I2DT3b+P3aoUAGmIQ70Ch4kmCljt
         7LeQvZHOgzQXnb/jm2gvbuLtGqUJIDWel5poWSbriTVOL6yG6pIzhhv8pEePqapG84L9
         VVeRNk6zbwdH8GlgE20AeV1lmJpwPZesDPAFScvod6dnmnkvj6uzixBFFsYOIbV3D17A
         LlxxAvrKX411fN5TxUYQqo0wcO7BahraYoxjR5YytDeUrhd9VzWSH8OkP5Jad2FSmN/s
         ZsSg==
X-Gm-Message-State: AOAM531r3OEiJQegrWrDZ5XZshK/veUcqca1cATQB305ML3VrKxG4FFi
        CV8LBqDPhoMYiiaNBwWJDA==
X-Google-Smtp-Source: ABdhPJzepteQkCoDKy1ujIilUFsyTVi5z9LtR0nkVZhj5YPNewotOVWZzrv2vR4uYHaHaLpVu1wZ6A==
X-Received: by 2002:a54:4502:: with SMTP id l2mr3544191oil.167.1641493536337;
        Thu, 06 Jan 2022 10:25:36 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:35 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: rtc: st,stm32-rtc: Make each example a separate entry
Date:   Thu,  6 Jan 2022 12:25:15 -0600
Message-Id: <20220106182518.1435497-7-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each independent example should be a separate entry. This allows for
'interrupts' to have different cell sizes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
index 2359f541b770..764717ce1873 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
@@ -127,6 +127,7 @@ examples:
       st,syscfg = <&pwrcfg 0x00 0x100>;
     };
 
+  - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
     rtc@5c004000 {
-- 
2.32.0

