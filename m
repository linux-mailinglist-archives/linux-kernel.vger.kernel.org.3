Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B34FA804
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiDINLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiDINLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:11:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDE289A8;
        Sat,  9 Apr 2022 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509759;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oIi38tuRzajE2EeqxoMQylb3cnvM9FT8zTYrRnMOJGU=;
    b=Ak5s/j9iUnwOh71OHAJOKeWJY7GYF6kCXkdFBW2cjeY84a4VVcAHSbxC/Wcac5TUa4
    m4Ga0Mi5+vuzJGfFKwgmtPAR5m2I0bQJGtXuaUM9vUIHrD55HL+sq6uJtO6Ly9VXdcH4
    dP0xmywLmZMOfvGeDx8sskUazOBsvibIgQ7xWLThDHO88VKSw6TxLOIT63fJndplCQau
    Vn+/VLtBb6vlzO96/cLwPwa64DvWBI+STP/+Zfcdimmvda10zRgSXniAU30oO605R/QC
    36gz0Asy4piaVxvAUvR78J6GgQeW4RdjsE84JJWDDkmqjYiawAIUfoN3Osd7C3Q6dzwe
    t5TQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D9JuUd
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:09:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
Date:   Sat, 9 Apr 2022 15:09:19 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9FD64FE-82B0-4DC2-B4C3-BE266DAB28A0@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
 <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
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



> Am 09.04.2022 um 13:26 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> jz4780-nemc needs to be compatible to simple-mfd as well or we get
>>=20
>> arch/mips/boot/dts/ingenic/ci20.dtb: memory-controller@13410000: =
compatible: 'oneOf' conditional failed, one must be fixed:
>> 	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
>> 	'ingenic,jz4725b-nemc' was expected
>> 	'ingenic,jz4740-nemc' was expected
>> 	=46rom schema: =
Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml    | 2 =
+-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml =
b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>> index 24f9e19820282..3b1116588de3d 100644
>> --- =
a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>> +++ =
b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
>> @@ -17,7 +17,7 @@ properties:
>>     oneOf:
>>       - enum:
>>           -=20
>> -          - ingenic,jz4780-nemc
>> +          - [ , simple-mfd ]
>=20
> This is not correct representation. If you really need simple-mfd, =
then
> this should be a separate item below oneOf.

Well, it is valid YAML syntax and seems to be accepted by dtbscheck.

> The true question is whether you need simple-mfd. Isn't the binding =
(and
> the driver) expected to instantiate its children?

I had expected that but current ingenic,jz4780-nemc code doesn't.

Everything is explained in 190607f2d59e174bcf8415efb1bb390737f8d428

But if someone writes a fix for the ingenic,jz4740-nemc driever
we can of course live without this patch. And partially revert
190607f2d59e174bcf8415efb1bb390737f8d428

