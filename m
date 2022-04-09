Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5744FA7F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiDING6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiDING4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:06:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF721959F0;
        Sat,  9 Apr 2022 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509485;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kuxzjjranCHRLMmIxWWOWvmF7G3BXhuDOS6JbTTDhsk=;
    b=Sz6ScZrdCGeVafipGta4IzpIHSyr4eSTpTze0cS13tWuBJzHF4BgHvBsVtAA4wGCZ2
    +ONEmQz+WhsU79ApqYUHJMpguC1Y/K5qceYAR13veELo3PlcKotLFs87JgSVmzdCNClq
    w30wgaOALTw8/sfmDA63+b5Gvcd2DmJ1GhtRK9Y31wm4tf41hfCyEl0IhnixaQsbfGIM
    +Bwac1oYK6EGQOXn8e5R7HTStVV4yMzUPMDL95z/k/XWaehlEAWfjRL2wgQRb0BxjBq4
    110lq/aEt0/NTiFJXS9uaIVAQWfUp5ri+iq9lk+dUEODPIHPUKBIEhbMXTvhBEcfbYJW
    GYvg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D4juU7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:04:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
Date:   Sat, 9 Apr 2022 15:04:44 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 13:13 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: pin-controller@10010000: =
$nodename:0: 'pin-controller@10010000' does not match =
'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>> 	=46rom schema: =
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi =
b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index 5f44cf004d473..b5299eaffb84a 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -155,7 +155,7 @@ rtc_dev: rtc@10003000 {
>> 		clock-names =3D "rtc";
>> 	};
>>=20
>> -	pinctrl: pin-controller@10010000 {
>> +	pinctrl: pinctrl@10010000 {
>=20
> Do it once for all DTSes, not one file at a time. There are four more
> places with this.

Well, automation has no notion of "similarity" in this case to
merge several patches.

And they are not related. Every one is based on a different .yaml
schema file.

That in all cases the result looks similar comes from similar
requirements by the schemata and has no inherent connection.


