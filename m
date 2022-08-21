Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6559B4F8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiHUPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiHUPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:17:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2323145;
        Sun, 21 Aug 2022 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661095044;
        bh=yQ6H3evZ+n5AN+xHPSsx/w1PB3pFNVVt3/y4SP2JWe8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CmNAHT8r9KE673c9Tq8J3cs3leLysMZdSAJ27m7PKAeu1muN+Dr73Cqb6BAq4O6Ky
         ccRdA6//8y/Zy3wP3Ke9Rdg5y4o5lRxCbi5Y6dbKJb/pUMSz8wszY/9ivInltd0z8d
         pmSsh5skXDwPlNxWvs5XH9WcPjobtrTZM5VPEgY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeCpR-1ozwX50keV-00bIWz; Sun, 21 Aug 2022 17:17:24 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (dell-smm) Improve warning messages
Date:   Sun, 21 Aug 2022 17:17:13 +0200
Message-Id: <20220821151713.11198-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220821151713.11198-1-W_Armin@gmx.de>
References: <20220821151713.11198-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+svDwOC/DgC9j9SJAcrFZdjN03S1KvFROGsaCpLhKALBW82cTuu
 4ATw/vHZrF/9+d+1XGzzpg50+lbsyeYdU15MUOSvkp2AWePzf86OS7YOxLzk5uU83+ueyuT
 kkaS8MR/u2WhR3De96961urN6uN8H1trcDnpenKHWkMAB3juongz2E4mLWxwpdTE27pNHKn
 b54a8MiUphS0WmMOdHFdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:niPkwH41xJc=:W8hZcjRzrQTRs7j9aXOBA9
 /opH0lTEeB8Xahn+YhC8IZzfefRktyebCthxG6GGnbyHjUvH6R5tuJsG1yV7FG4bWe236+UVg
 BbVVMfAkIRY1e7wFqKk/+DxdFE1EBKrGS6qXMADn3OJuPXDsfHfJj/SYzeHrFs3nPkJuSyoKU
 0deXCfNioi7WkeSVOoftAwnBj5AzNBdDOAcvSTYjUYDVEkGulVpK6e8A19QAgn3xhUjPPNNWd
 25VYtfFVa2NtT9n8AJQDD7K6y2RI+nkk5G7CAUx+uWkBHiuxe3LOP5HbwaOIsOgV3B2Ff+Qac
 +qjjLc5viaM/UhbN0M9aFTR6/ShbGvwjz54rTqw5o8zmt2JceC5r6G3K8ekiOeZ5pDw/XgL6z
 C+IJL+O6TIsrbaYoZbTJgdsDhLc9/idZFcK1BZt4SLDPd4rhmrNoKNclQ1fvfBkZ3AmTzyGNW
 yoJpk2QrA7/778nl4QAS2/7l/Ox9DlM8V9azCvpcNYQwffoCLTh30QVLWEe+uLEAIl9c4IvDA
 Dlyka70ZrNKup/SOeQiNxR3nquoEJ1NAxBrrBcUcBxjbUgn0SD5ci6Z9AJN+hbh+tzOw3fHjc
 royDEDegdThiji1MW9n7XPgMq5QRy2Ypyq+TwKDBNQKyAhFdgeHt11SdcCvVRVgtoeWldCMvE
 QKSeBoDQHLn/cQ/NPugVIQK9v8Dn0iiP6RSXWaMeKsl8IrPQhLyB+nA9rcuHUH5V6lfREENBi
 cxvraSNx7pnQdvWrkoDR2eXukJjqhrMvCZHRUEnopCiY1t6hBGRnSF/t/42JjaWhkgr2T0M21
 NiEgc3DPctw4v4WKF4G1+drbl8H8Dtt08wSKymJIPP6D5/KU9CZgynzrQHTmOoPq0Gsd8oTdm
 vt7AbRb/pTN70z0BLpOaJs9hbxxRn3Q+MAq0k7X59oBOalBl3ci8XOMvZ5/J6S47+nYoRn0Zc
 HdkONslw3gmVMQbdiCKGUPAYrgqIP10DTxldgMmaMaJL1Mvq6ctlaViUvyift7DCDeGl+08hd
 WgsQYvPOoi1LksnydZyGEHU+Gu2zBoyY8Ws2HORmjVLLyGcoAFx6ioJUyJXTriStIKPh9KJ2Q
 is3zs0OTUUUXa6gvdMDJ8ixnCKuDN4fVwirSnckr7x1BYbvraOgA0JQJA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dell-smm-hwmon is loaded on a machine with a buggy BIOS
with the option "force" being enabled, it wrongly prints
what the buggy features where disabled. This may cause
users to wrongly assume that the driver still protects them
from these BIOS bugs even with "force" being enabled.
Change the warning message to avoid such a misunderstanding.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index f7bab1a91b93..bf13852afe48 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1354,13 +1354,13 @@ static int __init dell_smm_probe(struct platform_d=
evice *pdev)
 	platform_set_drvdata(pdev, data);

 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
-		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan support\n=
");
+		dev_warn(&pdev->dev, "BIOS has broken fan support\n");
 		if (!force)
 			data->disallow_fan_support =3D true;
 	}

 	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
-		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type call=
\n");
+		dev_warn(&pdev->dev, "BIOS has broken fan type call\n");
 		if (!force)
 			data->disallow_fan_type_call =3D true;
 	}
=2D-
2.30.2

