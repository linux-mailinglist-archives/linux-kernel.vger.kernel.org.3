Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9231B48D5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiAMK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiAMK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:28:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BDC06173F;
        Thu, 13 Jan 2022 02:28:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w16so21244709edc.11;
        Thu, 13 Jan 2022 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LkqhxnmG1/45++kJ42sZXMqyu9pv2lKUhXS8D1IxEh0=;
        b=pVUsU5c/49h2BIj/nnCUjD7qK846LElhCjSA5Wu2xIsit9XT0nLxFR/+Ij0wMAf/mp
         q+E/3Wh06r6K52AEseE2EM85U/ypdIh+f6+oZikHfHxRx1tArNlXNb2bUNerUGKqp3IK
         MO8mq3bhF2CInPVmTiKKEyJop5o8TwqbT1Nw0RajEv5hYnQoejwV8TxAEo81KLlKWjkE
         Ld5f3SR1ofyN10hikY5dXsfXFZfadIwWTSlWI4Sfs43Belt1RgZhso1zRte65HiGco8L
         olThfm8w5VQC68Mc+zDQ6aWwJQgLjDFsNwSu07ugestunJ4EvF4ZGuH0X7jrpBsOdfvW
         PIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LkqhxnmG1/45++kJ42sZXMqyu9pv2lKUhXS8D1IxEh0=;
        b=DaEaKSLpwDZ7WIX9U83i4QFXOyUOTaNGita+5WiWPreZH0lqV/PscjTZD7vc7+pJBB
         G3OuHOg3yHpxW8kSfTOysnGIgjYJLBoAJot5taevEhldcwS+/b9HCVNiYJQiE97XQRD5
         HorbK6Iecf1Jf8mbdAdbLh/v70ltFUc2+/OnztfExedfGUZ3DKOc98RCu8xDVNKqZh26
         wyeY0UEQb+U00I69d27yk0A9xIBFJB2pyJR7jO4GGrIQCGfxgRBn+nIadQOFTtSeldkE
         ODyxhhX1gKqpojXWF6+ewc4ThQ0zLT2ranBEtws4j1x1/LKj49/GcB8o4AqY8Y7bWEOQ
         gXFA==
X-Gm-Message-State: AOAM533xup6b+OG/YgGnlRsBz5UE1kEjkRB+/OHdlaexYlcseWX/2HQG
        b/dt3bhqs+P/QwRkQKiZ8oI=
X-Google-Smtp-Source: ABdhPJw1+01Ug4iYqgERsBpcHoesyTFCZfBi6nKpid+nRCdtBf2UmMXIRJYYUy5BPCR3+++qQlXOJA==
X-Received: by 2002:a17:906:6691:: with SMTP id z17mr2951555ejo.763.1642069724384;
        Thu, 13 Jan 2022 02:28:44 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id gz11sm722316ejc.223.2022.01.13.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:28:44 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:28:42 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: add 8devices
Message-ID: <20220113102842.GA4357@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix for 8devices [1] is used in device tree [2], but was
not documented so far. Add it to the schema to document it.

[1] https://www.8devices.com/
[2] arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in v2:
  - Reworked patch description
  - Rebase on next-20220113

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f..8928884ba186 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -25,6 +25,8 @@ patternProperties:
   # Keep list in alphabetical order.
   "^70mai,.*":
     description: 70mai Co., Ltd.
+  "^8dev,.*":
+    description: 8devices, UAB
   "^abb,.*":
     description: ABB
   "^abilis,.*":
-- 
2.25.1

