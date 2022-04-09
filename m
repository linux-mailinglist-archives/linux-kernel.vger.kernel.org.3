Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B54FA811
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiDINOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiDINOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:14:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139090FDC;
        Sat,  9 Apr 2022 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509945;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XvtUGNRZhAWCV7uaeLu1necoTWMAM/Z5ITGrnklPbrI=;
    b=p23PV2Z/ZKxWK9UmZ5JM5cDAriuUqcT11VRadlWXtqnyRTwqlcLDGcHHmpvI63iJaI
    wzrykKW3WVd/T9oVUyZdwkjbgjye6mma73gssSoXZPrl9magNZPafHeJV2qRt4JL7tJf
    +705tIdo4f4bi+ExoRg1mCXvFDnZXAqYSDiZ8NR4cO30g2TJP4J6mf2zHHbfcRQclE3R
    yZbQE6RVQKC2TAhOb5Jn4gZyGu22CmL/QTYkX26cscORtfo7cnKIa4BQ/jELrhZ0WPpe
    O+zjbGkDo3zEssOrQvY0DvfmrbapyGl+jYf+Vqd4n9JGsEMgCXmkXgZpI4jALLNezl+Y
    BmEA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DCPuUs
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:12:25 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <a99d947d-418c-3f70-6b1a-a90d300604eb@linaro.org>
Date:   Sat, 9 Apr 2022 15:12:25 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0FABB80-17D6-4163-9141-D0002C03581D@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
 <1TN2AR.Q91IJNXMNNNA1@crapouillou.net>
 <a99d947d-418c-3f70-6b1a-a90d300604eb@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 14:38 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 14:24, Paul Cercueil wrote:
>> Hi Krzysztof,
>>=20
>> Le sam., avril 9 2022 at 13:11:48 +0200, Krzysztof Kozlowski=20
>> <krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible:=20
>>>> 'oneOf' conditional failed, one must be fixed:
>>>> 	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is =
too=20
>>>> long
>>>> 	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu',=20
>>>> 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
>>>> 	'simple-mfd' was expected
>>>> 	'ingenic,jz4760-tcu' was expected
>>>=20
>>> Trim it a bit...
>>>=20
>>>> 	=46rom schema:=20
>>>> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>>=20
>>> You need to explain this. You're changing the effective compatible =
of
>>> the device and doing so based only on schema warning does not look
>>> enough. Please write real reason instead of this fat warning, e.g.=20=

>>> that
>>> both devices are actually compatible and this has no real effect=20
>>> except
>>> schema checks.
>>=20
>> Well, if the schema says that it should use a particular fallback=20
>> string, then that's what the DTS should use, right?
>=20
> Or the schema is wrong. :)
>=20
>> If making the DTS schema-compliant causes breakages, then that means=20=

>> the schema is wrong and should be fixed.

Well, in this case making the DTS fit the schema does not break.
So why think or explain why the schema is right?

>=20
> Exactly, so the commit needs a bit of explanation why one solution was
> chosen over the other. BTW, I am not saying that schema or DTS is =
wrong,
> just that commit is not explained enough.
>=20
> Best regards,
> Krzysztof

