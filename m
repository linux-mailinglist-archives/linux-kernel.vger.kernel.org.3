Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2C57E952
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiGVVzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiGVVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:29 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012AA1180D;
        Fri, 22 Jul 2022 14:55:27 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LsSYo-1nV2k70GyW-011wQG;
 Fri, 22 Jul 2022 23:55:15 +0200
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
Subject: [PATCH v2 07/12] ARM: dts: vf610-twr: indent use tabs, no spaces at start of line
Date:   Fri, 22 Jul 2022 23:54:40 +0200
Message-Id: <20220722215445.3548530-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AoZyOuLX3HZjkhjlbTTIZpr6h+t3Rk4QxwwG7brwXCZd2iZt+50
 9H3Lysc56h6C2xAszOc4PD2grmXjdys2tqIKjg+041exIadiuheaV7FaTWSFjOaz2BxGQup
 3zSJxicVG/WxIui8I9EP/Rn5YuzhTsEg6YsQrPPIs4Vna7ZB4bx7O9b7ygRX/AZMkjyd0Gl
 QukLXbRsCk0Ft0DfyuaNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MLV3ae1QYFY=:aJLOJRlozktu1CxTfw0k4l
 xjZLoclFXFXP347D9ALkBLpUd+LJeP2LcXG0rVMd/h2//OXlI5kjF3Ju9FFEQf6dcjF7oLnKL
 z4RZfo2gRtkLqm/F15rIBcFgfgso3Enbb+tXHm5lM3+4kbtqBYJlTVmPe9kkJrBZ9TD/STrlP
 T86ktM46WUKcfsM3mt+5REUFpbQ97xEvo6TuT8NazBEC33BB7mlbhX+TxhR3DAWm7cgiPWmcD
 S/x3BZ6CLg7zqfzTzuZaDgn+6Q2p3YIac6iceYYwe17j/4psuhkIQXxeXzrQo0jUvnZIgLx/q
 Bfsz5ps9oSAUZ+SDTmz/r3zaLq8R4/QHaHK/f418eeJRD0faymJNQwBE+1EERH5C85DeIv4PJ
 8hjyfr6IdTFOk9BVNawzfiB2vvIG2+qIxP4hrS/QJsLPCSq0VrKBVaa8ItjwGw6/+WkkUrhrj
 tabNrB1cswzUGJgoFlFj9QYPcIpvFuHZLQxJuqODhD/mNSsjS1YBhchFzc2kAprQiYFRlMVDR
 dFdSbYfU4b3/LrN2WuJqV6qNIwN5yvE+/lz2/kNREC5IYiqPohX52LjgzpbT69Z6zRbtdNSyS
 xB5SMWo4wcqYkXUsCIqLKNNTs2EXJ3JvywqRN80MM7D7ohXwB15xxRA+SFQtGcxrXAIXGdB5d
 x7vxzV9jQc1MBDLz+Xzc4gIF+ZcwcQVH1eZXnPMHJbG3+JnDciWWbwxc1KU/8+j05ZKgVw3Ix
 k/RZUGbp8shmC3Z0NU8pp01cdBfOiPHn2vfpceIXprDBmgSo0s4F44NyycE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/vf610-twr.dts:172: warning: please, no spaces at the
 start of a line

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/vf610-twr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index dbb5ffcdcec4..6c246d5aa032 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -169,7 +169,7 @@ codec: sgtl5000@a {
 	       VDDA-supply = <&reg_3p3v>;
 	       VDDIO-supply = <&reg_3p3v>;
 	       clocks = <&clks VF610_CLK_SAI2>;
-       };
+	};
 };
 
 &iomuxc {
-- 
2.35.1

