Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482EA4FA873
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiDIN3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbiDIN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:28:52 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CE3CA72;
        Sat,  9 Apr 2022 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649510797;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=nI08LVmRMf2l9xKPXB+SU7SsJSUx7X6QcmnVhpy//bQ=;
    b=WF8oYnbvA/N8xEvntvt3hSQDpv6kRoZmSJVT0tx3h5Cf3xTwP4j2hw5zKOuPBk0DxQ
    d7/3kL8o18Zl6aS+tA1zPip3BGaR7VYSmHIx0mn4BPKsZQNaGITdFdepTzTGuCs8xdkj
    nn+cKUFjWrdAarVqEg1POe5q2GvRNkjxKJSa7qaNIwqZO2rz4YvHiDLqT2PfstmmaMoe
    BG/hVUg58JYvDjlS261LI3tUqk7bG6Z694onf0mkr39aFyRyHfr783m2e9AMBI1oq6dY
    ceesByZdYWpJOmqC7+Gcu2+5BcyMXTPNwQPs644vnPnAfegU8B96zcmD8jkGVuUaOib5
    ob8A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DQauWH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:26:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 10/18] MIPS: DTS: jz4780: fix uart dmas as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <79dd8425-947d-603c-ebab-0625921551d8@linaro.org>
Date:   Sat, 9 Apr 2022 15:26:36 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F7268BB-CCF3-4F01-ABB9-D5C3319F31F1@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <00ec9d965cac78b252e14444deed8c93f5116bca.1649443080.git.hns@goldelico.com>
 <a7a46736-e917-7274-1593-147ed36a2a68@linaro.org>
 <86044652-7B23-4F4D-B60F-C413F3C7BEF1@goldelico.com>
 <79dd8425-947d-603c-ebab-0625921551d8@linaro.org>
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



> Am 09.04.2022 um 15:16 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:07, H. Nikolaus Schaller wrote:
>>=20
>>=20
>>> Am 09.04.2022 um 13:18 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>=20
>>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dmas' is a =
required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dma-names' =
is a required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dmas' is a =
required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dma-names' =
is a required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dmas' is a =
required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dma-names' =
is a required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dmas' is a =
required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dma-names' =
is a required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dmas' is a =
required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dma-names' =
is a required property
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10050000: 'dmas' is a =
required property
>>>=20
>>> All these warnings are the same two warnings...
>>=20
>> See my earlier explanation that without them you can't verify by just =
reading commit message
>> and diff that all existing warnings have been addressed.
>=20
> Which does not make sense and there is no need... Automation does it
> (see Rob's tools). Don't make human life more difficult...

Ok, you are right. If you apply this patch and then run dtbscheck again, =
there would be
a warning left over.

But may I honestly ask why you review the commits and read the commit =
message at all?
You could simply ignore it... And it would be easier for both of us to =
leave it completely
to Rob's tools :)

BR and thanks,
Nikolaus

