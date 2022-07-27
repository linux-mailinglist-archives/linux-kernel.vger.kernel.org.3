Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97590582229
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiG0Iah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiG0Iae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:30:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427636317;
        Wed, 27 Jul 2022 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658910610;
        bh=9LCyI6pIYUtH66u1Xy95hPp/TovOUMts9Axa0H2J7Os=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XshX5zFLss0iYqq0hMudm20tWOVsIxwhsMtNAIJeXmjs3v4yrv1vyl7vj8MQSZNLJ
         GTzeQnn/oTIc99jZduN1xIXcr8a2pxjq/8le8OH0YolKhvLfM051LM1mGrHgWYXzzV
         3gR/kxbGIaE/mpAe7iLWylgHfms5S5fm2HjqaU5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7zFj-1nLzCz16ix-0154un; Wed, 27 Jul 2022 10:30:10 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Improve documentation
Date:   Wed, 27 Jul 2022 10:30:04 +0200
Message-Id: <20220727083004.5684-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:on/v+8+79xHGSJTBPMqme4OP2C166EvK8HvrY/oFYxczkg2WlZw
 58Pi+oOcri/zy2FcXjquG7/HCW+3Maurd4O/+GWxYS3I0M/YmgjLWJOLgw1cZ0Acvqgd35/
 v3y6CR28dzSZbS6MIWTLVNDUyAB7ZSIRSgXNrzIeHM5M1c/3Nze8E1mK1nd68lym/sIcepg
 rct4Yu+MlE/9BkJGxEdaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mOVS4Y+7jjQ=:Y0qifn1oelq9Dy1u2D85ne
 ZDWhtGSy+XrbtqVJzn7Lgy6J16GRAjTklXPq0IFlXo9ufhL1lDJDz+uxMM79aBU9i6VNSjxuA
 tNHLfhM/1NDj3s6SF82YBccWduEngPCP3OLWWbCcC7xAI1rmFiU8HkFXikjOO6hOVv1XkGBXc
 N6VEQyFPVIyWwhLB8C1DMePqePuA4VQVAEe6ALDRM9UsKZPH9NGZjsMsgEXzrVGyrmPh4Uoyx
 S1chv5O58Vlr5M8KV+Gi/9vTN0HL8PlGlJHYq/2A7S2ZWUM/zLNkkwiXqulmZyvhLaCNqeH5P
 HqM2StFJAN/EmtH+x7zVTMVpAhgnGOJzvZpB6Q7rUE9HZSwzDms463VfRsYYkl1VAnpLHhEBn
 sdLV9fjtPSvhcrSPll7ceIxGNg1Vs6+j9oUQBX4Tk1RsUrvYvbidhT9rK0lEDpUXMcQz9Bk10
 4UiRL1qUgnVuXYL34qH9IbzkXfsHhwInrJSkidNilqfoHiRoEvyA+oLnnW50qQqbgBbHQ6B0F
 bNjRCpcGE3UBGIC7FliVKeb/GK1Y7LAxubT/dQ95rj4TkvmiImqaly6XbZOV3C1SPh2+ptCdn
 SsGNGnaRC+4ofr/fj7ivBlE+1pB5laF2WXcaheNlJRVs04jlCxB27ewKn2Ah2cRPb7ToURDd8
 qohJyAuqwj5n5GYqSFpWKY1TSfzUtRRHo3dL8ZE0FMWsDF6nF/gTLfF9EfXx9aUdfe6zLxSRV
 njAZV2Jvg9Ws4tPoQcU778g1UClfjMzAsMP8Pf10m7WaejPyK4YvBA0vW4mkQHFNyrme7psAR
 IeJQPb7Kstme03e3gJTZODhb01gXWc6sPn6tUQCA/r+HHCSpR7ZgCW8OyvJkB52Rn1CrTmKVS
 NwZzDRXtEB8gnS6BqzAh2SkJI8NE3L04uQrfSO5aNKakfl3e5lMV5CoyQtg75THBURbsOTiUh
 9YGm754DPFrTJm5EBJheWUHie2GgqOhTfNeCHdowO07xX3DJ5jU0g+iSOPhWmyKmY8tYuKcM1
 Pt4CJVRB1OGvfpU4D5DIuryj/KsIiudgkvsv5IDX4gCDIhJIAIhcDh6hq1KnTlmqdPTYtQ4gf
 G1uoORgm9kCwZAL4SofVc7r5CQD+nce6CEDvBkHgfGwBffZxWuONi7NbQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify users of this driver that each pwmX
attribute controls fan number X, meaning that
probing of pwm channels is unnecessary.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index e5d85e40972c..d8f1d6859b96 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -46,6 +46,9 @@ temp[1-10]_input                RO      Temperature read=
ing in milli-degrees
 temp[1-10]_label                RO      Temperature sensor label.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

+Due to the nature of the SMM interface, each pwmX attribute controls
+fan number X.
+
 Disabling automatic BIOS fan control
 ------------------------------------

=2D-
2.30.2

