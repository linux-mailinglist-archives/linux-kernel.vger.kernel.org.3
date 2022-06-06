Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0353E9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiFFMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiFFMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:35:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5C8B0B2;
        Mon,  6 Jun 2022 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654518939;
        bh=ghNr2zs3nB8uWGOaMVInvT80i/YBm7oEAKKakSvfjK4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DxgZ574GFeH+IXDfHmH869YH+ymVM7piFaKpzmDguICX4YYNtAgKL4xv4nejgs9kG
         00hAMnYyTCBIUDkjylJbMubG1MZR1+0I42PMB6XlUevlEQKZvnNxtLx9ay9zO6JC4K
         k/hDA7UapNbyNxfkBjIZ1Ag2Q2WScTDdF9NE55Vw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([81.173.137.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1nXca31qaW-00iGU0; Mon, 06
 Jun 2022 14:35:39 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] ARM: dts: nuvoton: wpcm450: Add missing aliases for serial0/serial1
Date:   Mon,  6 Jun 2022 14:35:29 +0200
Message-Id: <20220606123529.1738542-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6JbCkkIoJ7puh+jsq7Z0QVKJ/Rp4vALdQenHDos6R3sUDSAoqi
 l7Tn0QrRjAojehLOwKSPZcKS9qEIv36AMEgdLIp8cxbSBYDqIrdOBRfKI/bAhkKIs8oh3WU
 fZIeHHXmBYiRmD4mW6ycRJnUguT8jBTr6Srv5nd61mPn6FWel8Nz6kvO8aebgxXR4QL8TMd
 hI62dbuuEPujMhys5aBRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HEM4Z7hlFEU=:a+Ft4Pem0MM54zC9jJ5v2H
 y+zVA6YxvrdC1kNeQ5TmnMqXXHYXGqFjyDsNebeAYriTMLYXzCuCb/6jI1pFUsYYCDnhHpRhw
 Z13YcTrLsDKornHH79DTPisNn3O47OGZ9dQ2a6rCEIeQ65gF/S3ieHYvQAN7Dt92p0vqOe8H5
 8pts94yZzEbNwDzf/a/Rhlx+yiNF0O4nclUfDTbLyFlElv7NmmYUfrX9AYAp0PUKtxS8ufSfp
 dwtotrtWUAiLRci7zQs2IAynMVg8VhZ4yLSxPbr8DJ+8fWngDc6dPEWE0pRcmo/3tfRTyh+El
 IBvM69RbLoftfI8zumUtACnKvxWfmCnPAEOwxUWn+hT+EtDcsThn7HB3MQzm/FLNZM6p5Kcly
 4m5h9hK1oIVBSs2AsiNvjRF0KZ3RUlH3F6xiNqE2IKw/ehpt3TQsKyZvyCQMmUtKvmPmpYXw4
 ZbKi5o2t59fR+uzgucacpT6nVXRt3wzfcML4rEGFcSg7qiTsqFdfxI49GbvW+y0mVn5w/KpVY
 99L8gXJKuQ6iK8Ma0ddRTFKvy4Ryu+XjB3+Z7L8LDQI7V7CnF9Byo41AbBZZmc2YS+81wXKKq
 5GvHW4rAEyKPzVtR79rVVAmi0+7HeADlqpXdCzW7tBmrxIMdR+lttcxyKRH//96fv8eqoPmcB
 wRclmpzC5ZAJrObwS+jmgUvvqzwhTZhyHgQbwBkfdUHotfnj0ieO0oI6Ofu4zpe91edognZXt
 kMl2OCdPcSqVH+qLX4mRB9t8hfHau6G8SJDH1E+w2GVhktxz9D0dOlMLqDGDYPlukXvyQs3y4
 AyN9iiV+MRhJyXcouYOryqJ27Fnx2AI2G5t0hwOfustebI9xHK2ncJZ6Su4UjigKWZXcYAWGu
 07lPLgquRG0kskraeJdJBNFpUAVADGa9ehjsIlCwvxbp+kIsLXkE0MOz8+41pmLgQ4t4afhMa
 aQ0qijTBRcWQu9DCSZBzwI9vt+uX14ZOoPBcpGDKgS1KmP862lb/ZQEdA+J3M5f69TRzCiVuk
 3rFwH4xfhzGKU9344vdgl5GuzEYno0/4q+SqqVNdYexTE0xc+Va4CLZg00+9WAqNKHabLVPqT
 Zaml7y/JQuJuJSFYLpw3N7uRUHK4Bb3j1hq4HmgtCtHDzfjClZ/H8nuPg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without these, /chosen/stdout-path =3D "serial0:115200n8", as done in
nuvoton-wpcm450-supermicro-x9sci-ln4f.dts, does not work.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- mention WPCM450 in the summary
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 93595850a4c3c..57943bf5aa4a9 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -17,6 +17,8 @@ aliases {
 		gpio5 =3D &gpio5;
 		gpio6 =3D &gpio6;
 		gpio7 =3D &gpio7;
+		serial0 =3D &serial0;
+		serial1 =3D &serial1;
 	};

 	cpus {
=2D-
2.35.1

