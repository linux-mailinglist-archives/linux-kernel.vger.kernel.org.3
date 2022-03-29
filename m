Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41F4EAFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiC2PJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiC2PJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD821E95C5;
        Tue, 29 Mar 2022 08:07:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id pv16so35832186ejb.0;
        Tue, 29 Mar 2022 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZrjecTc6isxOln40Vu5kdPXZSuYev7N4LqkSkVuX50=;
        b=S1TTstVm4PiS0psirN8/kUMX2zgzB6DwE+2dneSeDqtD7awdbNoysKhZ4GOpg6otnd
         8m8SXbHJ090HjzoJ5eNg5hn3PkvxPmHkKNOmkusbHhr+L84Bp95S7sl/PTHa/6L5S7DN
         aZtbQVb8adDXcQsSeMpl8OIlZ4ybAL1Qh3yqA6nCf5/AmzYoikvKVPz4EcXr7rwryoWr
         EJL/pQFFW7aRMtIiC+8AvAzdGa1tanZv0h56i/C+XFJBsPoLtOUmekwb70Bkwp/QTFcO
         poNcczf7bw6t1PvoqnOgN7vSfI8LVcFV+xYlBs0wm8M02ggY+Ezrb6G/t2XYegW261zB
         mzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZrjecTc6isxOln40Vu5kdPXZSuYev7N4LqkSkVuX50=;
        b=8F8XFShLB5E5aEnbE1uzWJMU1d2j+iK3kMi2DzaQU0gdfLk0S4aAu70WOWQhsNPYL4
         PwjeIemUv89LxGlDls3/JB2jZ64S+7K7yntxlo0q1qo1qIFL6TWzrpvYVIEJ5FoQgRUB
         JUWMeLwzy4WxsJi2/8rt4f7ikQ+/iTnWoPh8v/NnRgCxk6Hjn9AZbeLiaClhe220IMzW
         MsG1O+cW5qpOKvHv9W0gRrr52AQ1ognNZxwcK4f4T1f0Tfo1TUmLhO6/JfumYUyG9y8h
         T1Tz2Y5yAoUkG6HTZJcM4g07q6kiABzjchGvB3kqhTG6xbm2Xh3z7zD/QnwwP+tGb7Sx
         uwTQ==
X-Gm-Message-State: AOAM531sDUvlY5MWTOCUWcBpw30oIBCQ2GIx7/5TdfLzei49wfcwN+az
        2rjbhu9Q/il8Upxzgq/MZ1wJSpuRiMI=
X-Google-Smtp-Source: ABdhPJxK9uAZPCoQxiBP6Nxy0F/7WLolO7THdSnb7f/FIeDNldRKMS9uPvGarmj6h7tQk7InG9ETUA==
X-Received: by 2002:a17:907:7204:b0:6df:6b63:cf49 with SMTP id dr4-20020a170907720400b006df6b63cf49mr34904315ejc.498.1648566471863;
        Tue, 29 Mar 2022 08:07:51 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: clock: replace a maintainer for rockchip,rk3399-cru.yaml
Date:   Tue, 29 Mar 2022 17:07:38 +0200
Message-Id: <20220329150742.22093-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
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
index 76dd24d49..3cc8398fd 100644
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

