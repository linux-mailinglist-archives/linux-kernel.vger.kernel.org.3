Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F955AC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiFYUPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiFYUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:15:31 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41D214D18;
        Sat, 25 Jun 2022 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656188125; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VderXXP91GMZTeXsBP4VzfkMZCFsaMn0tF6r71EkAmw=;
        b=jUu26wotV7QfFhupj+NehIGIiPnhESFfYjKVZWLIbrLDlQTqu2g34Jp6ZyA2xEonCFqKYh
        jvwYATl3guqOnKzhbf2Ar4FNuPqXZxIsLBrYlUG6cFkxZroUuF2xh7IEpEArZKLBZEar3L
        5SRm1x6chHphr04OxRAY2JQshMFJ9Bk=
Date:   Sat, 25 Jun 2022 21:15:14 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Message-Id: <EXU1ER.FH53VZXY9EYP3@crapouillou.net>
In-Reply-To: <89b6a40b-eb6b-eba5-78c3-6b5f35bed717@linaro.org>
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
        <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
        <89b6a40b-eb6b-eba5-78c3-6b5f35bed717@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le sam., juin 25 2022 at 21:58:08 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 24/06/2022 20:40, Paul Cercueil wrote:
>>  Hi Krzysztof,
>>=20
>>  Le ven., juin 24 2022 at 19:07:39 +0200, Krzysztof Kozlowski
>>  <krzysztof.kozlowski@linaro.org> a =E9crit :
>>>  gpio-keys children do not use unit addresses.
>>>=20
>>>  Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>=20
>>>  ---
>>>=20
>>>  See:
>>> =20
>>> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@=
linaro.org/
>>>  ---
>>>   arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>>>   arch/mips/boot/dts/ingenic/gcw0.dts           | 31
>>>  +++++++++----------
>>>   arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>>>   arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>>>   .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>>>   arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>>>   .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>>>   arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>>>   .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>>>   arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>>>   10 files changed, 37 insertions(+), 57 deletions(-)
>>>=20
>>>  diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>  b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>  index a8708783f04b..a8da2f992b1a 100644
>>>  --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>  +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>  @@ -59,12 +59,12 @@ led-1 {
>>>=20
>>>   	keys {
>>>   		compatible =3D "gpio-keys";
>>>  -		button@1 {
>>>  +		button-1 {
>>>   			label =3D "Button 1";
>>>   			linux,code =3D <0x101>; /* BTN_1 */
>>>   			gpios =3D <&gpio3 6 GPIO_ACTIVE_LOW>;
>>>   		};
>>>  -		button@2 {
>>>  +		button-2 {
>>>   			label =3D "Button 2";
>>>   			linux,code =3D <0x102>; /* BTN_2 */
>>>   			gpios =3D <&gpio2 14 GPIO_ACTIVE_LOW>;
>>>  diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>  b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>  index 4abb0318416c..5d33f26fd28c 100644
>>>  --- a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>  +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>  @@ -130,89 +130,86 @@ backlight: backlight {
>>>=20
>>>   	gpio-keys {
>>>   		compatible =3D "gpio-keys";
>>>  -		#address-cells =3D <1>;
>>>  -		#size-cells =3D <0>;
>>=20
>>  Are you sure you can remove these?
>=20
> Yes, from DT spec point of view, DT bindings and Linux implementation.
> However this particular change was not tested, except building.
>=20
>>=20
>>  Looking at paragraph 2.3.5 of the DT spec, I would think they have=20
>> to
>>  stay (although with #address-cells =3D <0>).
>=20
> The paragraph 2.3.5 says nothing about regular properties (which can=20
> be
> also child nodes). It says about children of a bus, right? It's not
> related here, it's not a bus.

I quote:
"A DTSpec-compliant boot program shall supply #address-cells and=20
#size-cells on all nodes that have children."

The gpio-keys node has children nodes, therefore it should have=20
#address-cells and #size-cells, there's no room for interpretation here.

> Second, why exactly this one gpio-keys node is different than all=20
> other
> gpio-keys everywhere and than bindings? Why this one has to be
> incompatible/wrong according to bindings (which do not allow
> address-cells and nodes with unit addresses)?

Nothing is different. I'm just stating that your proposed fix is=20
invalid if we want to enforce compliance with the DT spec.

Cheers,
-Paul
>=20


