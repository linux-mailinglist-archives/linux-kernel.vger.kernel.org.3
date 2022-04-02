Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D744F041F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353825AbiDBOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356621AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD985182DA9;
        Sat,  2 Apr 2022 07:36:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f18so1017722edc.5;
        Sat, 02 Apr 2022 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTBoLKmFu3SudRrqJ18gR0Ex2iOqgaqOCTSIcXbzjD4=;
        b=d2XA5+lbzbqgUClSScxRzK8VZ4PkpUMVTN0uvEH/krKdNx4C1+rVGMAkjyjl5wk6F0
         un/rwtokiCwsoqEMKy0SOwqTlDVOQz2srNSeZEd+IvowfEUexyuPGpU7CkIi/vcsK5P0
         bk+WbRlafAay2+EHW94cNWP9r7Ym6QahwLQIlWO5ebpwEY5Nd3XKnBpdRXh56Kvk7Bhp
         5JnXO/dTunO6BrD2H16p80mMYpj/FKFeE7qT8z6Tc2Xza4hNWlYUVG56ASU/cspgFqmD
         bE+fwB3TSUeFBbqgZzbFdt9JJRe4ONJFBg9jw21LAIrTQ15iHnU3WcIpSxb4IanrJEZo
         0DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTBoLKmFu3SudRrqJ18gR0Ex2iOqgaqOCTSIcXbzjD4=;
        b=Og0EZGTQKslCaAEUL6FktsPh3VNl0u5RGzp6pSJ9TiZC9t6eHO+AmsGS4W3fx7h1ux
         DbY7qbUQtmcNdrD5pwd8kJfQT5ULX3Y++VchuRWyLo00Q6kDRyGZhq9Aawa2jxqcEVNy
         c8T9UwBJF2eHA7W/SzKTeuBgvRu558V7JiFpCPBWmUd5QiPdd7kK3pNFJ0nBM8VbujQt
         99xzbmEW649HqCyGejoXUtUXve6aPZXrFwYgiL+x8tAdej6PC/lwxQflD0eJBDq7+nUO
         UFnvCR9gqjPyQgVBYGEwDJaylU9o1vdybRphvfC1dNEY3oj1xDYs3p8IsBVhNLvvybL8
         mXNA==
X-Gm-Message-State: AOAM530xaL1gO9rdsVeaILsSO2M5eb2AwK2BxOCMgL0mRVgbKkYNC9rV
        q/t1hHRRNQjG8xOI6UUs9Wg=
X-Google-Smtp-Source: ABdhPJzZeLptWSIWN1DIeaKwHOX9srEUgHYaOuX/82OJK1wtowsFIw+5wYQxhBkNlts96i0VQfbncQ==
X-Received: by 2002:aa7:db94:0:b0:410:f0e8:c39e with SMTP id u20-20020aa7db94000000b00410f0e8c39emr25102336edt.14.1648910215459;
        Sat, 02 Apr 2022 07:36:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:55 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/16] arm64: dts: rockchip: fix compatible string rk3328 cru node
Date:   Sat,  2 Apr 2022 16:36:33 +0200
Message-Id: <20220402143636.15222-14-jbx6244@gmail.com>
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

The rockchip,rk3328-cru.txt file was converted to YAML.
A DT test of the rk3328 cru node gives notifications regarding
the compatible string. Bring it in line with the binding by
removing some unused fall back strings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 9c76c288b..8ceac0388 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -756,7 +756,7 @@
 	};
 
 	cru: clock-controller@ff440000 {
-		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
+		compatible = "rockchip,rk3328-cru";
 		reg = <0x0 0xff440000 0x0 0x1000>;
 		clocks = <&xin24m>;
 		clock-names = "xin24m";
-- 
2.20.1

