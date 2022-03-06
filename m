Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6194CEB60
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiCFLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCFLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:47:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870CF4163E;
        Sun,  6 Mar 2022 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646567165;
        bh=toZdQsJmBfXRcv7SI2pH2kTldzfr60wZt0rjnEq6McM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UmQq29xJ5H3eALR4nI4JW7urBDyIjBkc0rherFEaUVPUMwCUkHnSQe5JIru9rJACu
         fSQmOsFofSpvDiLO4mtoLvPM3mJkIqLMwEBAE3fWwKltNVlRwWXHpD037gwV21iCif
         uVLjE8NTG6Sy7qJIi4iWpdkb+qEDMr3Fa96S8sJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.163] ([157.180.225.163]) by web-mail.gmx.net
 (3c-app-gmx-bs64.server.lan [172.19.170.148]) (via HTTP); Sun, 6 Mar 2022
 12:46:05 +0100
MIME-Version: 1.0
Message-ID: <trinity-955432eb-74c6-48f6-984e-d88a61854727-1646567165101@3c-app-gmx-bs64>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Aw: Re:  Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 6 Mar 2022 12:46:05 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
 <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
 <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:mzvp8M4NWgc9gJ3vkex67E26cqQCs5HCxUZgX/Fd8GRab70hsw69IlVSs19mFcSVaCM2a
 x2svUvC79JwWz/8wwX22cOIenh1xT+532wIDzWzghI97EIb73RxaXZ7ObK4KzAEkcNq5FB8pbsCh
 6unSNFeQA6vk+LHLbtwHxcd5xRwGUFCbcuPonVWKivdVsrKhp0EHWETBPmgYc5xeQsPildfsTCi+
 FS4CpUrcN53g8cfM7WFeFARmHrX7GgUzxhLT3l8s1JCeVC2UjBiEWcBtMzHBdOWHh54gIYOJXlHO
 64=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZNjNO/uzYqk=:X2O/REvEWSryvey9+y4EqS
 ZBQGJvSyGHkqrI6ePKzxmqiyfN8RECxyxN/bjtxERimKtekTd3/5ihR1BD1NAypbaZBr++B7F
 HclK3R8rgHrENMZb0d+fOYORLBsU2poVRXETSFox9AsBA9N5PUwjGQL7I3x2p8fLTbLh+jIbe
 lstae7v779Ol65aOkvJckZYjfrPUg9jN1g6/DeMPqTogVwpNRpLvf32lNNfPAAovRnP1Q6Gk3
 z5mS5YA4tvGH9XQUuWsPRtOtmMxPepuRfl3nKW3+uWyHcowCGPG0UJyI5XMjctAfbB7dpbrH2
 9x7ZkZhWp1+IviUxd/XTfccCs9nzu9rCfusTbVPD0VpcLe55DG58yzUaviFo6g6tKC6abynJ9
 oVuzWQ2dBNNcT3lzPpduVUVGuRIpL3kQRqsup88JUsBHjPqUGe9N846SWVbISW80DCkTyGm62
 jKGogqsJGQjcTNlOYCBChD5zcyZHLM9jsSmYE+aEM4aM7A5txWlVfW72XC9Mh1htHA47UjK4o
 xLZ+HG+LI70giZODhVhSrZv21MNrewLB38yeIqe5gCgrvbK7Ijh08S5TusvWj060i76vOAvQ8
 dt2x1xzE9QfztAe8CZGldHpstFff8Zca72ANQegukVvOq9GnQO4GEJBFtSNJMHNu5qYKCxMxg
 H60DzykJm7olpLJWDtwzkV/xtjf6LiYcuAMhtkEb+u3QcfgGB0/fA11syEOED6YozjjyKvi5d
 Hr69/6benqG0spnkOwFAi+0l6rexToNjOab41sUIHk729DKjDz9hlqThb0+BdUfLz3SweXXjA
 Hw2ZSFf
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Gesendet: Sonntag, 06=2E M=C3=A4rz 2022 um 12:15 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@canonical=2Ecom>
> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
> Cc: "Frank Wunderlich" <linux@fw-web=2Ede>, devicetree@vger=2Ekernel=2Eo=
rg, "Damien Le Moal" <damien=2Elemoal@opensource=2Ewdc=2Ecom>, "Rob Herring=
" <robh+dt@kernel=2Eorg>, "Andrew Lunn" <andrew@lunn=2Ech>, "Gregory Clemen=
t" <gregory=2Eclement@bootlin=2Ecom>, "Sebastian Hesselbarth" <sebastian=2E=
hesselbarth@gmail=2Ecom>, "Russell King" <linux@armlinux=2Eorg=2Euk>, "Heik=
o Stuebner" <heiko@sntech=2Ede>, "Peter Geis" <pgwipeout@gmail=2Ecom>, "Mic=
hael Riesch" <michael=2Eriesch@wolfvision=2Enet>, "Hans de Goede" <hdegoede=
@redhat=2Ecom>, "Jens Axboe" <axboe@kernel=2Edk>, linux-ide@vger=2Ekernel=
=2Eorg, linux-kernel@vger=2Ekernel=2Eorg, linux-arm-kernel@lists=2Einfradea=
d=2Eorg, linux-rockchip@lists=2Einfradead=2Eorg
> Betreff: Re: Aw: Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:=
 Convert DT bindings to yaml
>
> On 06/03/2022 11:41, Frank Wunderlich wrote:
> >> Gesendet: Sonntag, 06=2E M=C3=A4rz 2022 um 11:27 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@canonical=2Ecom>
> >>>     add compatibles used together with generic-ahci
> >>>       - marvell,berlin2-ahci
> >>
> >> This is fine, just mention it in commit msg=2E
> >>
> >>>       - qcom,apq8064-ahci
> >>>       - qcom,ipq806x-ahci
> >>
> >> These you need to consult with qcom-sata=2Etxt=2E This could be a fol=
lowing
> >> commit which will integrate qcom-sata=2Etxt and remove it=2E
> >=20
> > this depends on Robs opinion
>=20
> Then maybe precise the question for Rob=2E=2E=2E

do i need to fix the errors for qcom-compatibles/reg-count/clock-count (re=
ported by your bot) *now*?

or is binding well enough with adding berlin-compatible and fixing the ind=
entation error in example?

for the marvell anyof issue and the spear13xx i have a patch in my tree wh=
ich i include in v6

> >=20
> >> Either you have
> >> binding document for all devices or you create a common part, like fo=
r UFS:
> >> https://lore=2Ekernel=2Eorg/linux-devicetree/20220222145854=2E358646-=
1-krzysztof=2Ekozlowski@canonical=2Ecom/
> >> https://github=2Ecom/krzk/linux/commits/n/dt-bindings-ufs-v2
> >>
> >> The choice depends more or less on complexity of bindings, IOW, how b=
ig
> >> and complicated bindings would be if you combine everything to one YA=
ML=2E
> >>
> >> In the case of UFS, the devices differ - by clocks, resets, phys and
> >> sometimes supplies=2E Therefore it easier to have one common shared p=
art
> >> and several device bindings=2E
> >>
> >> AHCI looks more consistent - except that Qualcomm - so maybe better t=
o
> >> have one document=2E
> >>
> >>>     increase reg-count to 2 (used in omap5-l4=2Edtsi)
> >>>     increase clock-count to 5 (used in qcom-apq8064=2Edtsi)
> >>
> >> This would need allOf+if=2E
> >=20
> > if i get ok from rob i add only the berlin-compatible and skip the qco=
m+reg/clock-change in the first applied version=2E Adding the allOf/if (and=
 making it right) will only delay the sata-binding/dts-change=2E
>=20
> I don't get what is the problem with delaying this patch for the time
> needed to make the bindings correct? Especially that alternative is to
> add bindings document which soon will need to be modified, e=2Eg=2E spli=
t
> into common part=2E Is there a particular hurry with these bindings
> conversion?

i see it as requirement for last part

"arm64: dts: rockchip: Add sata nodes to rk356x"

if this can applied without the bindings conversion there is nothing to hu=
rry :)

regards Frank
