Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65B4CEA90
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiCFKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiCFKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:43:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83D23E;
        Sun,  6 Mar 2022 02:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646563315;
        bh=2ZtldoCcuDm+WbdqpxXJgLAgo6KQApSmcxb/CajybcM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TVnst9cFRbrhq87YlUQPtG/880b2437Wgz+hR0tawgTZHMzRYxBKO4IHJoPwPAGd2
         8iEZJBOZOi1SkfqH5xhMgAB6/dLeRomTlRRBApwSUltS9M+Qn++eDLpg+Jjh4o20kB
         W3STv5tn+Z3pJztwwSPGsMqxmMsiZmFc+o9U9BcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.243] ([217.61.145.243]) by web-mail.gmx.net
 (3c-app-gmx-bs46.server.lan [172.19.170.98]) (via HTTP); Sun, 6 Mar 2022
 11:41:55 +0100
MIME-Version: 1.0
Message-ID: <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
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
Subject: Aw: Re:  Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 6 Mar 2022 11:41:55 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IgvBmzu90ZoZyUnCcz2HIgCPmRbPZNduuH/gVpl4arVQkah6Gb393hXzknNf47A6FD5Kk
 lVZVaUUsnMdOjM+0UP9GsDOGxHcSuagdMLks5xj1ESPWZGoe6unK9Cftuz5YsJCq7MgStOwYOn6b
 itdMhATol7lHJo1iJ2uLzJd96E1JbyWc6v3Prhkq7Pokh8WrNnrWg20LVHUo0MIyxbhIgrsdDs85
 jv8/WNk//9Qns2Or42EAQ+4qtscGkgidXpQYgztmvEPueR1GnVlFDhckpYU99OQhmUqcNs90dKmX
 I4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:SDYmm5A0j74=:ar+rov1pSfJOh5XSZpkgDx
 vDTBNscaWQyXvDE9R7NHwOjrq3gR9A+jGU680w9yw9HTtn1R/xEXud8fJG4w/zhoPy2+1rYnE
 HvV3bDdCyj34vWXznxOCIW//U+TL6vPM/lTq+IIBFPqvoZEP0KopHTwydNfGHPUhklpGsbiWY
 16MVEF4gJtNziWBcUpOUI72Bl4oJrKuLX36m1MbjjgJXkXq0QTBJpsuBqn1bpwMT1Des1KhdL
 tvYI3sTD2bdpOZDY+/x5pauglpiDG+eMi0lH+iq5xm8vNRC3mtH8iDyMrMoNb9AVaiOWTdnVS
 +0LiBsrj/dAEN5AqDvqsjpZMoLLPFBpTlv4aAFgr7pSLQz6ee3B2KjmidTtudd1bbDN8gyJgd
 XWlssn1ucEB0mx2h5QEQZoEbIfw5KJ2Ujr3rf57r7kZ5rAGpI80Zkv7//3CpgRvdr/VkmsEba
 G/8abntHgPGaGH0pdpY8nUPUk+r0qFOFqYxPflH8p0fdWB9N7Oz+bK+kHX8AWBkoebpDD3f6q
 4LcpGynTXdLkAH2Zxt4oRcbGY+qjX1tetqg9QAlLfB1Y+3P3Zo2drJ2B5K8gxATrStJlaHBTF
 /5o1kO+dFSPPzI+6trkHuPalGz3/VnPFNz7tspKpF28YKKxnT13TB1iKlevXgltNrerWbshl0
 M85LrajLNBfSEhYibiqbHZetpjoJq+Epp7ALSgexsEqHwKPoJqGBRe+tt0HnNb1kwBBiFkZ6f
 pS1rIcwGB9rDlTJa2syFp9ocPE1t8wE9EoYaqB6JCRf8zxqsoAMTysgOSu+ac/qHi7fDZpYDN
 sMIWPVj
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Sonntag, 06=2E M=C3=A4rz 2022 um 11:27 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@canonical=2Ecom>
> >     add compatibles used together with generic-ahci
> >       - marvell,berlin2-ahci
>=20
> This is fine, just mention it in commit msg=2E
>=20
> >       - qcom,apq8064-ahci
> >       - qcom,ipq806x-ahci
>=20
> These you need to consult with qcom-sata=2Etxt=2E This could be a follow=
ing
> commit which will integrate qcom-sata=2Etxt and remove it=2E

this depends on Robs opinion

> Either you have
> binding document for all devices or you create a common part, like for U=
FS:
> https://lore=2Ekernel=2Eorg/linux-devicetree/20220222145854=2E358646-1-k=
rzysztof=2Ekozlowski@canonical=2Ecom/
> https://github=2Ecom/krzk/linux/commits/n/dt-bindings-ufs-v2
>=20
> The choice depends more or less on complexity of bindings, IOW, how big
> and complicated bindings would be if you combine everything to one YAML=
=2E
>=20
> In the case of UFS, the devices differ - by clocks, resets, phys and
> sometimes supplies=2E Therefore it easier to have one common shared part
> and several device bindings=2E
>=20
> AHCI looks more consistent - except that Qualcomm - so maybe better to
> have one document=2E
>=20
> >     increase reg-count to 2 (used in omap5-l4=2Edtsi)
> >     increase clock-count to 5 (used in qcom-apq8064=2Edtsi)
>=20
> This would need allOf+if=2E

if i get ok from rob i add only the berlin-compatible and skip the qcom+re=
g/clock-change in the first applied version=2E Adding the allOf/if (and mak=
ing it right) will only delay the sata-binding/dts-change=2E

> >=20
> > can i still add you reviewed-by to v6?
>=20
> Keeping reviewed-by would be fine when adding compatibles and bumping
> maxItems, but in your case you need to rework these bindings=2E Either b=
y
> growing document with several "if:" or by splitting them, so it will be
> significant change=2E Skip my review then=2E
>=20
> >=20
> > [1] https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/5=2E17-next-202=
20225

regards Frank
