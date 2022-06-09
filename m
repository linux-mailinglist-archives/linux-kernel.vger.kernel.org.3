Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00C2545775
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiFIWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiFIWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:31:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA015D338;
        Thu,  9 Jun 2022 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654813877;
        bh=vEaQf4ej1aP5nbwJBkZozLJilZKt9/y7Cca4UzA3dn4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UKG2zb0qW8oKhFGrjWfD5KVGo9+5L0HVrd01a5Fk2Ms105evTIgKyZFlXv9c/DlV6
         FtdtW3cqo5RoUuvYCdr8DoHJ2NJCu732hTx+xyv7HZAplLA6IeIm4bkvnBqYDWCffe
         gHKA1TcdgKn05DJ/11RMYg1yzqCkJ9GDrKxwG7oc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([81.173.137.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1nkNq8196v-00tQVu; Fri, 10
 Jun 2022 00:31:17 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: Fix reference to definition of default-state
Date:   Fri, 10 Jun 2022 00:31:13 +0200
Message-Id: <20220609223114.183038-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/S+TrqVEu+MfQoi2V9hxHqC1lkX2c/nUIRluP8XEoIkfBeX2O2+
 /RqGjXDXUcNO+192KSgXE+5lrv501h1PsMqlxSpJ5RI+YDMRRl589hWZYTuDBfHkwUP5ElZ
 Yfk2jRnPKcjeGi22/yH+/DWDz3Ccd79bYW47OS/gSl3XexgoFwsyDkmYc/Guxc4hrQYOrXU
 7f5CX/4JmKyvLZXOj8wIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qBo5RD/iq4E=:oUDwP1QXeVH2FbvGIcVs7u
 1d1egTJUSV+4GqcktxoHxMdz6y7bEF5ob5NDXm3N0e4DL0ltkyiLHYo0Borbv2tKqvtnvLTEb
 YDxp3Qv+hfWQ9F1aAeiVC3+dezdeQ4GwIyZlVUazOAfMeX3lQ+Zj4JYa8peYu7OzSLPA7acwc
 GzYjgXfjD2kb8PqjnL/9yMXx+4DXMwHRjne6Oj40e49oPJnyJE3ma/YENlnoI1eOLUjZlPFEn
 f8kr3KYZ+IeE8BQmAWPcehUV83HYkA8h5u0CFjNx03T7YUzM3U5M1NwQfmjYcchevgI81HVrQ
 skhjsIC26BpNxB7S2GNmHXi7tuwHVHlOhoIhpq6ST9CvRPcTqmtbbseTprXoT+cvYuqeqtt6i
 iTlA/PgjRH1KNzqLLbj8MdmdW3kyITD3/r2QU6fdN4Rd0oy7nH4rxNNlkn2qHoCW/AbBYTZOF
 uCnBhMeGOp63U+s2rkPJg/vdIj3Sd4ZYN1eo9ZVvGbT046eWTH/RCQKajHve09opeZBagcZwh
 hDgOX3aFGhCTqfldkWvN5RsnibK7WaoRSXCE3ylcuC3ZT/kPeMXmwzdqTHGxy7fGZ1vzpD/fV
 lDFhkffhbjhoSdgkH8YBU2wH16UN/wT8LPHf6/+GQUVSjDBB/bGGNVZrMYiPmg6TaHE9bjFcZ
 moN7Mo6kRkEbae8ohOzBIcZvQQacjr9fit+BPNF31XWiylixhz+wbHVMf2qD2ly8VnpTm+F3p
 LAGfHzxqNJmMPvN7x84AKVUP+esom3ODLnsrvew80pgezCJzj4FzTCoOkrQI8QGG1cxsutdke
 H1PFrGRUxa83Cj9qI140ffnZXIrRE4pKa7aiHagIgFAWiaz86AA1v+IVSeznAcdWtIAEVnmd2
 1W7egEe2GYi43PRy/sXSsPTQwoFeWKscKHMOxJKx+uFgW3gEKmgdrC4Kt9sE2rY/sXvqRueaK
 2MVBddn34lk4Q7RJ/kmg5k65Wx+XXm3KYERegDf/RyXM1cZtwhzNpO9887MiLUlbazhU/G1pM
 wQEAeuiRvm7nhmi2EgDOZCpLWa92YfOXIfI8Dg4Qw6HdRaRyzrCqW6D2LfvbiLgx6U6icP1gR
 QCJmQ1kHNk5J2jjOfZVfEvv1BAil/TcL2bqfOcqt9FkAegMooGNEIDpzg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least since the YAML conversion, the default-state property is
described in leds/common.yaml, so there's no need to point to another
file for its definition.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/leds/common.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Document=
ation/devicetree/bindings/leds/common.yaml
index 328952d7acbbc..35fcdad711b03 100644
=2D-- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -82,8 +82,7 @@ properties:
     enum:
         # LED will act as a back-light, controlled by the framebuffer sys=
tem
       - backlight
-        # LED will turn on (but for leds-gpio see "default-state" propert=
y in
-        # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
+        # LED will turn on (see also "default-state" property)
       - default-on
         # LED "double" flashes at a load average based rate
       - heartbeat
=2D-
2.35.1

