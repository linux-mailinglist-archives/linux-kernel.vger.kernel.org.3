Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA357D48A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGUUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiGUUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59E73919;
        Thu, 21 Jul 2022 13:05:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MkqKB-1nnEtB2fs7-00mGYX;
 Thu, 21 Jul 2022 22:00:19 +0200
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
Subject: [PATCH v1 07/12] ARM: dts: vf610-twr: indent use tabs, no spaces at start of line
Date:   Thu, 21 Jul 2022 21:59:30 +0200
Message-Id: <20220721195936.1082422-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:urtMK25yJn7/0uefvNHlvpAK0DMeip8D6bxsy+jqE2n5htx2PPL
 l5KJ/Sy0H1cP/Z40ITV8x2luQtaQ1XcVS3rRUxEasP5vi/LoA+hkXyUtEjZyJFhKMrDSXG5
 fQgRSzETqwAPUPQBA89XCNf7afOkN5535islOSn95e9CK/2raT8uop6E6i95X+umUwolJ+I
 zmXYpF7cEI2F2yrbWYjag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wdJypTsRWTw=:dd1gyUjjVEdZ1+R0WNUi0B
 k8KExjSyAcefYa9JTtgMcYQvVNmTYLCMgB4WmuJeLSn/YW3oXQRai1sEnW4SNONCtewZTGsII
 vLnlzWOb01YytWxdyEu2+f9UmCd7WFvWDQoF7fg6QYPGAByKKAJ6AYgBO/YdCuGOXIBziRORo
 GUEg3SaVH4GnOzBm6mOpuY4cdCazaOHCA82+BKyn3nVM9hVJQzAUZRaaixMHpVdjzihhC8nL4
 S0Fc8EpvjvxdCdyN9wy2A6POA8ZFpOYzBqISlENGtsDgDCvDvu8Lo51+qZgV8ITInBZPN0Bt4
 ca32biVL31YcryiXiqbMeGbLB5w8xR7Rfc1Dd6vQ32TZMgUJVv1vAuxYKFgOCHfOPq4/42Gmw
 R+kOiQqZ4hH3c18SDo1pKVge2ix+46ZRFHeGyI2Gc/Xx5VicgSMLJxvVBpCHjhSvIgxLrtJ+z
 QU+at1/+kls/vIpjwJ1t0/3vxO8EOCboCPTeSGoJuQtMj/dicdyS+e51mFTvI+bfuf7AsoCdd
 Vl42SLzfD3IylBxHf9ha0em1L/Lku5h49mhA5ARwxZMNNF4V1ejj3jAVDvsZf7zyjNLEh2/IW
 DN95osjNQPxT48TjKK5mM7g2SJcOopU6jLnMnzHmT/k8Z01D8nbjDEkKldnPoaEairCGY1dn3
 vD3sq+T3Vq5XhPp/JW9upmAYNH1CcJLibZZDYj+UsabEbUugqkLQ04jzkiIbzGYLaRPb+AmVH
 1W41Nr1usHfZz8JvaMzL89TGvc9621s8ZzqhGyisJyYrC5zZOD4UoHJ02Eg=
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

