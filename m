Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A072C4D39FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiCITRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiCITQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842211108F;
        Wed,  9 Mar 2022 11:15:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e24so4562604wrc.10;
        Wed, 09 Mar 2022 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUoBX2KeGcpl8zGZBWHWBmV655aJNbl/ybN21igwOc8=;
        b=kl9Lwq80X/wp/M7q5+753qmc4cyWHdRzk1vs1QfhoX+Duux0eilNAKN3V1sQPk2FeX
         4FfP+seZXLnfIx0/v6nqr/h9zsX3FjoUY6aLSbpAb5xWTGt1azyNkr9u7kxmYLyNJGfb
         XQZ9tLRHz1Mld+q2z/dC94rroReOSXP8CoEi9iSYVN4bR1uhke8zE9AVQTPczQ0ExTs5
         kVVtU5Gllnc6L6MvyFa9xM4dRBC14MPFQ2C0s/BRBCiv0Czd9YarpcnPoRNjYM5oIY8D
         /30aHtH0kIrpeVsISRwjdnuQyqvNT/vF2Csm8vh4AvxQku9g/mL7NhQstnWpqbMalOps
         +EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUoBX2KeGcpl8zGZBWHWBmV655aJNbl/ybN21igwOc8=;
        b=xJ+dK/Eo6+qIc9hktezrBegW+7BZh301WLX4Evm9VHXWA9G+KCoZb2Q88++YqJk61y
         vRctExYHGIAsHm9EB00VET1owdtGKZgVV4RDiriWsdKYBFMj3gBja94fZmU79nJ0UGbE
         O1PVyFD+jFNGIawe8pxx+rMknzGtXJ+TbJCEB1+nkl6UFOf61IZGZsReJOgaga3gR4vR
         UGNLc778p4UtDdxoeOiCnODx3YcHoujdU4XZkEl/jn22N8GoP9wx5HUgttfNIxDQSUW1
         eYwQHDVh1z/QGjAUw+S5yhjgNEgO/Jdrk+AplrxWEkCiVdLTUFheSYxXXOWXvZRh+ugv
         0jGA==
X-Gm-Message-State: AOAM532OhiD857KjA71001G+i+tquxp017eH9ew0r2TKswlG7zQz4gO8
        uRl+I3U/W3xqkXWI4gGPY3g=
X-Google-Smtp-Source: ABdhPJzjtAypnki+gMVlpzQUGPRy9wvZh8+g286WejxtMWDy+PJ1zX3HgfqljbeNtM0+hwQmYYGIgA==
X-Received: by 2002:a5d:59ac:0:b0:1e4:9b6e:eac7 with SMTP id p12-20020a5d59ac000000b001e49b6eeac7mr874420wrr.172.1646853330513;
        Wed, 09 Mar 2022 11:15:30 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:29 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 11/18] ARM: dts: qcom: add sic non secure node for ipq8064
Date:   Wed,  9 Mar 2022 20:01:45 +0100
Message-Id: <20220309190152.7998-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add missing sic non secure node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7df1c1482220..df2702e6136d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -563,6 +563,11 @@ saw_l2: regulator@02012000 {
 			regulator;
 		};
 
+		sic_non_secure: sic-non-secure@12100000 {
+			compatible = "syscon";
+			reg = <0x12100000 0x10000>;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
-- 
2.34.1

