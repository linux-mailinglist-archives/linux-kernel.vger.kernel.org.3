Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC54F0427
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356705AbiDBOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356625AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D4182DB6;
        Sat,  2 Apr 2022 07:36:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c10so11311378ejs.13;
        Sat, 02 Apr 2022 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMzMILXZOYBjEHWGG0NtpE3Gk3RKI6Zuc2PgcEOU4hk=;
        b=hKH+EKXwHDcVdeec4xKFrNDsZIRyknKca1Lf0IqDKfvplrYbVWQI6lg8AHp/WMaqRr
         1kgMP/fsOjJzdh1R9iMh0f1MQiXtPIlKnwURS8zfHuVGs53qVd6QkmBmFKedyB0ww4Bv
         oQmK7d1B/fsghyO74h6dJXDYP8VlgjIP1ZpESFOCH0Vw1rZQz73TRX7U4kFGXv0YFoKv
         BYmrjQqzHEDS0Ij8SK1ZUJBNqEmZ7BiOqoo+USngfl6NFbFr+NhlHJ4r11zDNKebbIOR
         iPGrY8wAE4WBBO+z+iCJ5SLfPLygzHXWTdojFiw5VGi+WD9q0GKDRIXGs2xnO4fCial0
         Rz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMzMILXZOYBjEHWGG0NtpE3Gk3RKI6Zuc2PgcEOU4hk=;
        b=7l2ulbvLNoO+4K/0j2n02/5vYmiKK2+lKGtos0nHBUzbTLRcmla5ABf3YPrEYMiq7i
         rF/hwNEXNqo7PcQbl7yiOJFYbq/Nw2UyVGZ09jD1h2jef/Ad300lSArphiD+vQtm1WmM
         ZPZ+eL0FrQ/teXIm87ghkoc3hlPAowA3JHP+nJCbmOY/6fWtlkTTLQzoHvQhnuXZdSTA
         q94RXZcBPJbJXmDOmA0WYxtsukEI1DE4H8fiJUkqRS8mgd7kAvH43rdnN0XJQJGiOiEk
         m+hF0kpa2H2H/K45x91nYMSJTiUrzMiKASNOhGmTEDMylK1C01YZ9/0U6PxBWhLW9L01
         +DLw==
X-Gm-Message-State: AOAM532PyZpBUDCTGAxf8mLPeR5+bb10Zyu7vXg5J138Fek95B4aeZZd
        nAQuj+aTjhbm1C1sgr9cdsA=
X-Google-Smtp-Source: ABdhPJzkt4WAyQJZ3jF1iMKFKicysCmRDS+tUpRwZXcfJmmMfXyM7C6JEmced06QohgpOIs1rpC2cQ==
X-Received: by 2002:a17:907:1c0a:b0:6da:7ac4:5349 with SMTP id nc10-20020a1709071c0a00b006da7ac45349mr3992797ejc.596.1648910216420;
        Sat, 02 Apr 2022 07:36:56 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/16] dt-bindings: clock: replace a maintainer for rockchip,rk3399-cru.yaml
Date:   Sat,  2 Apr 2022 16:36:34 +0200
Message-Id: <20220402143636.15222-15-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
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

With the rk3399 cru YAML conversion the original text author was
somehow added as a maintainer, but who's currently no longer involved
on the subject. Replace this position with the Rockchip clock maintainer
on her request.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 72b286a1b..5ee686938 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Rockchip RK3399 Clock and Reset Unit
 
 maintainers:
-  - Xing Zheng <zhengxing@rock-chips.com>
+  - Elaine Zhang <zhangqing@rock-chips.com>
   - Heiko Stuebner <heiko@sntech.de>
 
 description: |
-- 
2.20.1

