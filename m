Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A157E956
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiGVVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiGVVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:31 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB49E21E38;
        Fri, 22 Jul 2022 14:55:30 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LuO6D-1nXWeA1BmZ-011fIx;
 Fri, 22 Jul 2022 23:55:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] ARM: dts: vf610: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 23:54:41 +0200
Message-Id: <20220722215445.3548530-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SFXSl8AGDc2jnB5ZHzR13rZBPd6uPCCgOsuBioCkSetJ6w3yXws
 fxfQAJGNWcZ9UthDDXtzDSEUTCuN3oajbvhY60KAbb2dJOTH3CMTIUUfnUrasECSetPphD9
 uYy/9/PObTAKG54KJd+M3TnmuwzaBJ06MlybQLYHdlJdSrGnMepf9UyVX2pX8J7jMApVU2c
 CCkYHNbdJVAK88LgszUtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IQNczrKdgQ8=:nmncx8v3MEm9nTUtV4MP0N
 Utw+hgdceU4BmB9fG8VFezz3usUd4O83VLajAQGqWvGk2HMz2Ch1sxKQcwW5YGAYSAaL48F0U
 ZLMWYLHImrdGsktBQ673cEm+saoSkSdsaFHJUZvKewa1eSz/1pnAcpYEDwZmO76UdVwftzC4s
 4lYOkowjHWe8v6A2I1AY28vX9KzN8n+EAJYgVCLCkF4paIDeWLQNgzznM+oRHyDY7EaKWSIt0
 2tkXKKgwMtNRh+n2+FicoN/X2s6fdluwwU/w0FLlER3GrBQ4DuBNrlNksW0PTlTGzkfx9aNlc
 8XT8oXNCsgDY5NeG+VS0DQ9RdlbKanoJVE0SuA+w5ilkp2+ZhfECZXzvrF8EPehtaaslmXLW9
 jyUUJ5jHiDOg3N7bBK5CMmMC5913E+cY0mEDIHPamo21wauxSyeWhRBB0VZqquy33rQv5KXq2
 Tyo61WVVvG+VJ6f2swj4FIuEANpNrLeDaO1nk+0ar2XkKyh00N8mnwdM11KT/Kt86xcR0CJGn
 Fr3ywFBDh29emhD8I+v2fuGKFNw/sI79RmeY9RVRTBo5+bF9r7tx7z2bY1g1++zk+ZaFg6yAU
 z2VhojCQIK7k/ORHCQFHVBR5C+1Xrn45EeTVRWPapnmdVpH1NtuEMKTDTZ4uNKhAHNB1jHXg9
 5j1vQikNHWXARraHnPHPB/Gx4OEzgWBIypJiDgGlHs2IqRJmJ0lGDG2rlWGzxG6MfOQZR+L94
 AWiBsaCMXz707yN1zjmh7gBpR421YwKE9j14USGgbMnfy/gRg6yVwe8qfC4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/vf610.dtsi:5: check: Please don't use multiple blank
 lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/vf610.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 956182d08e74..2fba923821d0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -2,7 +2,6 @@
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
 
-
 #include "vf500.dtsi"
 
 &a5_cpu {
-- 
2.35.1

