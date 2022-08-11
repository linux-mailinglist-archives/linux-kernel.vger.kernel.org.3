Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6E59075F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiHKUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiHKUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:32:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99A9AF8E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:32:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3196834wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9cA4nPyy+3oc8csp/5WI6MWGRIz8pwoP//Q0NeWm1pQ=;
        b=dRJ6nmCzs4/bVQQeyYikvOMhwX+qBAjdKkM6h1FZYIRz7AQtdUfctdNkP+omUlEAfv
         fM5EF7t1oRTXw1dpzjpRFYZHlQfl0FrG6WGes7inhzrk6McQ/4U6jyywhJRxX3QyuXod
         nFdEFP++Z7dO3/pcm62XZyVRqUrEIq9q37NqQOctD+frwr6rZTtfF1gFM1AfDz5V+bUU
         ReWnPW3FiByNKy5y3aMTJ+YhvbInIZ/tlMhzUBZ/IFiRfipdl1WANgKPQlyjGiLYSO+6
         J1znoOVXInn248WAp28EZHhzz2ZlJ4g2hkT/ece/hEDH1a+qmWP6pRYZ5W6QHswZZ8ao
         UcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9cA4nPyy+3oc8csp/5WI6MWGRIz8pwoP//Q0NeWm1pQ=;
        b=Hy5yVSvdw9mRhR8eIFls0io5GhBd+IhFzPzyopiuuvGnxMGEqLy7uLYvVgSfCUE0+F
         jRLdKEBQHcGu9ziU5xMAg36RadI9SJxWWXt7Ju0ECFIcri+hJI2pdR2u3IjbIiK9WWOz
         gZ0Ex4lQh6t4Cif6Bkvmprd4g3x9fUh3PhZ7EmHJSIlkIWKJ41J1VRtlAcawCjUmRMlg
         vY2AlMp1AgNRWNTCp3XDAAdRREaHMOl92s8cPfaLTU0nhY6QP+9UvQ1xTF+qZ3URWnCB
         9XxwaffT449s1auTGjUXoboux/02RaFxBnB5473eOfKIpudeJ15eaGoX6ltSqUmk65A9
         aDbg==
X-Gm-Message-State: ACgBeo2wcmSOOM3p5LS1ktdG05VhHgGl8Q+t2TIli4SuUugkgb2d1SMq
        ID3k7PsyZYxa5dGwrvXqiFN+Nw==
X-Google-Smtp-Source: AA6agR5ZW6U+wgHEyk2sIKMDaM5dl4O7s3S9HPf5I4c+4RPoHVA6W6ojaNVCyERE/MuRFYtOHU7lUQ==
X-Received: by 2002:a7b:c453:0:b0:3a5:b42e:c4fb with SMTP id l19-20020a7bc453000000b003a5b42ec4fbmr486780wmi.167.1660249932431;
        Thu, 11 Aug 2022 13:32:12 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003a30c3d0c9csm8417365wms.8.2022.08.11.13.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:32:11 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: microchip: remove ti,fifo-depth property
Date:   Thu, 11 Aug 2022 21:32:07 +0100
Message-Id: <20220811203207.179470-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Upgrading dt-schema to v2022.08 brings with it better handling of
unevaluatedProperties, exposing a previously undetected missing
property in the cadence macb dt-binding:

arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: ethernet@20112000: ethernet-phy@8: Unevaluated properties are not allowed ('ti,fifo-depth' was unexpected)
        From schema: Documentation/devicetree/bindings/net/cdns,macb.yaml

I know what you're thinking, the binding doesn't look to be the problem
and I agree. I am not sure why a TI vendor property was ever actually
added since it has no meaning... just get rid of it.

Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 2 --
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 044982a11df5..ee548ab61a2a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -84,12 +84,10 @@ &mac1 {
 
 	phy1: ethernet-phy@9 {
 		reg = <9>;
-		ti,fifo-depth = <0x1>;
 	};
 
 	phy0: ethernet-phy@8 {
 		reg = <8>;
-		ti,fifo-depth = <0x1>;
 	};
 };
 
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
index 82c93c8f5c17..dc11bb8fc833 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -54,12 +54,10 @@ &mac1 {
 
 	phy1: ethernet-phy@5 {
 		reg = <5>;
-		ti,fifo-depth = <0x01>;
 	};
 
 	phy0: ethernet-phy@4 {
 		reg = <4>;
-		ti,fifo-depth = <0x01>;
 	};
 };
 
-- 
2.37.1

