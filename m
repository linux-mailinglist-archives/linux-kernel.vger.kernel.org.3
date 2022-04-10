Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F294FAFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbiDJTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiDJTQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:16:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251911C36;
        Sun, 10 Apr 2022 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649618033;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=gCViX2U+X9NoN/17GFnwYW9Iv0vePQTk3Ibo8m3xQZE=;
    b=TZBDrSRUNuDjxPFBRINq4i7WvkygdqKJfxF2OoolWxq/LvXD2dSWzmel4bJ9nHQzSL
    w+icia3PSvxfOTYMF0UGhAVEFGD8N+iecnFNhHNVDfxdgSgmkPfKeh4vcicFR0oEnJnx
    M7tU3FyDRNkKYCtGv7nYcEwL1kI+V+GM8r3VErPEnD6HtbytSAwRIYeHVSjV9cU+7tUy
    gXV4quz/ZEVe8BlxlSac4jMnAuuYVpT3lu9YbayT1J6yGbcSleqhbCP2b0BqpqI+KjSv
    IrBrYkQwTOl33Zr7n5tLtOeLwPDTt/lXutBcoy6D6eEQyPKnmLEV19+J5lyhbUa4Ulqj
    IG3g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDWqdw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3AJDrx23
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 10 Apr 2022 21:13:53 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <b6090a27-12b7-0c01-6d33-ae32b31b4b74@wanyeetech.com>
Date:   Sun, 10 Apr 2022 21:13:52 +0200
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FA36CE4-CD39-4767-B49E-D112E4313036@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
 <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
 <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
 <3e95f567-03f5-bf9c-1856-9fe602e9b025@linaro.org>
 <81BA49E3-AFDE-4DFD-BB77-2B03488C727B@goldelico.com>
 <b6090a27-12b7-0c01-6d33-ae32b31b4b74@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 10.04.2022 um 18:32 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi folks,
>=20
> On 2022/4/9 =E4=B8=8B=E5=8D=889:53, H. Nikolaus Schaller wrote:
>>=20
>>> Am 09.04.2022 um 15:44 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>=20
>>> On 09/04/2022 15:32, H. Nikolaus Schaller wrote:
>>>>=20
>>>>> Am 09.04.2022 um 15:15 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>>>=20
>>>>> On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>>>>>> This looks wrong, the block usually should have a specific =
compatible.
>>>>>>> Please mention why it does not.
>>>>>> Well, I did not even have that idea that it could need an =
explanation.
>>>>>>=20
>>>>>> There is no "ingenic,jz4780-otg" and none is needed here to make =
it work.
>>>>> Make it work in what terms? We talk about hardware description, =
right?
>>>> Yes.
>>>>=20
>>>>>> Therefore the generic "snps,dwc2" is sufficient.
>>>>> No, you are mixing now driver behavior (is sufficient) with =
hardware
>>>>> description.
>>>> No. "snps,dwc2" is a hardware description for a licensed block.
>>>> Not a driver behavior.
>>> snps,dwc2 matches the original block, not necessarily this
>>> implementation. Unless you are sure?
>> I assume. Nobody has reported an issue without having any specific =
jz4780 driver in place.
>> Well, that is only evidence, not bullet proof.
>>=20
>>>>> Most of licensed blocks require the specific compatible to
>>>>> differentiate it.
>>>> If there is a need to differentiate.
>>> No, regardless whether there is a need currently, most of them have
>>> specific compatibles, because there are some minor differences. Even =
if
>>> difference is not visible from programming model or wiring, it might
>>> justify it's own specific compatible. For example because maybe once
>>> that tiny difference will require some changes.
>>>=20
>>> Someone added the ingenic compatible, so why do you assume that one =
tool
>>> (bindings) is correct but other piece of code (using specific
>>> compatible) is not? You use the argument "bindings warning" which is =
not
>>> enough. Argument that blocks are 100% same, is good enough, if you =
are
>>> sure. Just use it in commit msg. But are you sure that these are the
>>> same? Same pins, same programming model (entire model, not used by =
Linux)?
>> The compatible ingenic,jz4780-otg was introduced in =
158c774d3c64859e84dd20e04d5fb18c8d3d318e.
>> Hence I have added Yanjie for clarification why he added it in the =
.dts and not in the bindings.
>=20
>=20
> It's my fault, last year I made an OTG driver for Ingenic SoCs and =
sent it
> to the mailing list, and then I received some revision comments, but =
for
> some personal reasons I didn't continue to improve it.
>=20
> I'll finish these modifications as soon as possible and send them out.
> Then after they merge into the mainline, this problem will be solved.

No need to apologize.

If you agree I can add "ingenic,jz4780-otg" to the schema file and keep
the .dts in the v2 of my series.

And I'll add you to the list of reviewers, so you can please comment v2
if it is correct or if we are still missing something.

Best regards and thanks,
Nikolaus

