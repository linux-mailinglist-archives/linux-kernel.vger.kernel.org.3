Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9445A3637
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiH0JPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiH0JPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:15:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB663D9;
        Sat, 27 Aug 2022 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661591668;
        bh=NSZNt0pLSZJ9ZlUlOlVD0Dm2WlTRFEWZaSBc9PVMkXM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pl8eSraZTY4DXGTjdsaq6gtwqr+OVJKUANpAa6+H1YlkdXRRek3B9vGFgS/HEfGcS
         m2iIa/d3musZtHdFd4aH3T1eMIBHOXDuiDLjx99fall5DN4+ibAINiIxOSKUESNL9c
         tnsbH5CGIPrRdTPO9BQgy3gXOmVYc2bZFz7p4Fxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.78.141] ([80.245.78.141]) by web-mail.gmx.net
 (3c-app-gmx-bs16.server.lan [172.19.170.68]) (via HTTP); Sat, 27 Aug 2022
 11:14:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-9006aaf2-5bc2-467c-a86e-ba43efc692e6-1661591668494@3c-app-gmx-bs16>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re:  Re: [PATCH v5 5/5] arm64: dts: rockchip: Add PCIe v3 nodes
 to BPI-R2-Pro
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Aug 2022 11:14:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ee6dc940-8b90-1f57-28b7-6de8e3483027@linaro.org>
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-6-linux@fw-web.de>
 <cae915f6-c951-ba97-346d-00922c85067d@linaro.org>
 <trinity-88fbbdbe-de76-4479-9580-70edc34a4181-1661590200169@3c-app-gmx-bs16>
 <ee6dc940-8b90-1f57-28b7-6de8e3483027@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:EdE3dMgQkeItfCXLp2Op6iNlE9dCZFWvP+6GZ5Udzg6rm0Z5A5fq0aMTQ0emWe+gAoe4j
 t7TkMNyLxEnmzto60dAl00LWbo+PP6iOE590JSOqZN378EZiaIL17Rv8hCUk4wqqGyQl/a8lCgIy
 mPmhqhYVdeP/ciB5VSq7p76QTutOfPyepuNdho/Xn74oKlpgaTgz5MiJ3DeEY546TdUhkH2ZDHh4
 jPEH/XNfLWvoFLc9izMpcib8jGI5NV/t0LlAr134sMOvrlmptJgra+yoD8ZdrO1PkymjtokormSS
 yU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6rPTGCK/7g=:9e/g9j/+v9yPoCSnbrSh7O
 o9q3W8hUCmfdr5FchIgTSNBRplDGVZgpOKCPZa8SGSHBL6pSivJPkPzjP5THduegnJ5CfY+jh
 oDz8Qlsn+MEk4JiZb386vpjlvTUPZ93QSgrn3cZbx7dMGmqrkMLBUwYTdvQMMd54P1FtkzpiU
 7EfQ8cj23pBhd80Fd6dJ8e80mMy1r96G+gbG6AzzDUzVri6IDBgRgmlV7PsBGsSIbo50II/v+
 Bb86I86KisG2VPasQGJkL+5CfmA1brBukiAN91GeYJBJjsIZpwdi3nJhJdgLbjsQ5QXv/nakS
 8yOHHqsLR3kyUO6C5UhV8LMWUdiCtB6tugALinG9xMBD7ZRygQwRavSmjKXl++EH5uWmqwSDh
 tM9XmYDU/WfQz0LThoJQMyEME6Hiny0RpOSWKnf0J1uTV7ssHkNCBVVxwv2BBiv39avQ+tiPw
 KZsWuTTMWXfGXcVjmCwP8303TKQgyWHwpt//Vx9udMrwBsrBsyOBQxbc2Ejm/lFCDP6jAMTnW
 UmFwE2Im61BoUEWWh/wprXN8SasHvbkNjoAgwLlKET9bpfDLbc/MLmcK1REtvi+OfbPOS6t/p
 XmjmXxFQok7FKl1Vuj+ppusdMy5VzwtPkUbrprOznz+CXgSHI5mP91EWVVAzrOIq3ny+ZCF/W
 C5I1Q/+nZ6Y3DtgdA9wLUh51SZRl5m/Lxr34XQehNndnFDSGXVg7NGT++kYMIyKSJLlnhARYP
 OuHrR5SQVLQNynVKhML8t6jk3oRhr3JwDV0t3aL6BAmP3WdeDAgzog4W1jraxOTCvU8Rve4KH
 Rztdx2s
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Samstag, 27. August 2022 um 10:56 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>

> On 27/08/2022 11:50, Frank Wunderlich wrote:
> > Hi
> >
> >> Gesendet: Freitag, 26. August 2022 um 08:50 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> >> On 25/08/2022 22:38, Frank Wunderlich wrote:
> >>> From: Frank Wunderlich <frank-w@public-files.de>
> >
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/ar=
ch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> >>> index 93d383b8be87..40b90c052634 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> >>> @@ -86,6 +86,66 @@ vcc5v0_sys: vcc5v0-sys {
> >>>  		vin-supply =3D <&dc_12v>;
> >>>  	};
> >>>
> >>> +	pcie30_avdd0v9: pcie30-avdd0v9 {
> >>
> >> Use consistent naming, so if other nodes have "regulator" suffix, use=
 it
> >> here as well.
> >
> > only these 3 new have the suffix:
> >
> > vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator
> > vcc3v3_minipcie: vcc3v3-minipcie-regulator
> > vcc3v3_ngff: vcc3v3-ngff-regulator
> >
> > so i would drop it there...
> >
> > so i end up with (including existing ones to compare):
> >
> > vcc3v3_sys: vcc3v3-sys
> > vcc5v0_sys: vcc5v0-sys
> > pcie30_avdd0v9: pcie30-avdd0v9
> > pcie30_avdd1v8: pcie30-avdd1v8
> > vcc3v3_pi6c_05: vcc3v3-pi6c-05
> > vcc3v3_minipcie: vcc3v3-minipcie
> > vcc3v3_ngff: vcc3v3-ngff
> > vcc5v0_usb: vcc5v0_usb
> > vcc5v0_usb_host: vcc5v0-usb-host
> > vcc5v0_usb_otg: vcc5v0-usb-otg
> >
> > is this ok?
> >
> > maybe swap avdd* and pcie30 part to have voltage in front of function.
> >
>
> I prefer all of them have regulator suffix. I think reasonable is also
> to rename the old ones and then add new ones with suffix.

ok, will change these to add -regulator in name (not label). and then rena=
me the others in separate Patch outside of the series.

so basicly here
-       pcie30_avdd0v9: pcie30-avdd0v9 {
+       pcie30_avdd0v9: pcie30-avdd0v9-regulator {
-       pcie30_avdd1v8: pcie30-avdd1v8 {
+       pcie30_avdd1v8: pcie30-avdd1v8-regulator {

how about the swapping of pcie30 and the avddXvY? In Schematic they are na=
med PCIE30_AVDD_0V9 / PCIE30_AVDD_1V8, so better leave this?

avdd0v9-pcie30 will be more similar to the other regulators, but inconsist=
ent with Schematic.

regards Frank
