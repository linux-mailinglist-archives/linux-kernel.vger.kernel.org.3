Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837A64FFF56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiDMTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiDMTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:33:07 -0400
X-Greylist: delayed 43642 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 12:30:44 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CB23167;
        Wed, 13 Apr 2022 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649878220;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=XizD8wLk7RPr/MmlqEKaUWzpG6m4WiqeZdBPHS0La8o=;
    b=E29x+v4cnWoYTOOQZ3tOrcqmGRKwpSCBnpTnlNCdcRSrJK4MG4pih2yeqnzzhn/Je/
    GY5tNEepJQbAnarKOqlWgt+zkI1gXNmoEqImr0yfLX0ThgyXg8FLVidTZWqdKx7Q+8MJ
    BYWYh/+X8qnxM4I2W2dat1/9XcgH1Mh36gT0NcC3ibY6LoJRve5A6FfUdHQVfPXy12gy
    U9vVtxjeohA/2w/bgtLPEaod1jTKE9SSd7r4uXmp3R5d5P3gB+2bKe3D82joLMQf57d+
    mXQsSdvz5wDkdwzk0U+d90/mUmGXfnT3bis+Qq5TyblENzOpMk6kpoD3zfK+96K+gL6a
    jAyg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw4nvnQ=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3DJUJAlv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 13 Apr 2022 21:30:19 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
Date:   Wed, 13 Apr 2022 21:30:18 +0200
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hminas@synopsys.com, Rob Herring <robh+dt@kernel.org>,
        linux-usb@vger.kernel.org, linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, dragancecavac@yahoo.com,
        dongsheng.qiu@ingenic.com, qipengzhen <aric.pzqi@ingenic.com>,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
 <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
 <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> Am 13.04.2022 um 20:55 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi Nikolaus,
>=20
> On 2022/4/13 =E4=B8=8B=E5=8D=883:22, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>=20
>>> Am 12.04.2022 um 20:30 schrieb =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou =
Yanjie) <zhouyanjie@wanyeetech.com>
>>> :
>>>=20
>>> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
>>> SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
>>> from Ingenic.
>>>=20
>>> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
>>> <zhouyanjie@wanyeetech.com>
>>>=20
>>> Acked-by: Rob Herring=20
>>> <robh@kernel.org>
>>>=20
>>> ---
>>>=20
>>> Notes:
>>>    v1->v2:
>>>    Add Rob Herring's Acked-by.
>>>=20
>>> Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml =
b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> index 4cebce6..c6e8c0b 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>> @@ -17,6 +17,13 @@ properties:
>>>     oneOf:
>>>       - const: brcm,bcm2835-usb
>>>       - const: hisilicon,hi6220-usb
>>> +      - const: ingenic,jz4775-otg
>>> +      - const: ingenic,jz4780-otg
>>> +      - const: ingenic,x1000-otg
>>> +      - const: ingenic,x1600-otg
>>> +      - const: ingenic,x1700-otg
>>> +      - const: ingenic,x1830-otg
>>> +      - const: ingenic,x2000-otg
>>>=20
>> I have merged it with my recently proposed removal of
>> ingenic,jz4780-otg in jz4780.dtsi but there was no dtbscheck
>> complaint about missing snps,dwc2.
>>=20
>> So I think should it be:
>>=20
>>       - items:
>>           - enum:
>>               - const: ingenic,jz4775-otg
>>               - const: ingenic,jz4780-otg
>>               - const: ingenic,x1000-otg
>>               - const: ingenic,x1600-otg
>>               - const: ingenic,x1700-otg
>>               - const: ingenic,x1830-otg
>>               - const: ingenic,x2000-otg
>>=20

PS: the const: above should be removed (I hadn't run it through the =
compiler).

>>           - const: snps,dwc2

here it is needed.

>>=20
>> similar to the entry for amlogic?
>>=20
>=20
>=20
> Or we can just remove the "snps,dwc2" from jz4780.dtsi?

Well, my recent proposal to fix dtbscheck was the other way round:
remove "ingenic,jz4780-otg" from jz4780.dtsi and leave it out here.

> I'm not too sure, but since we already have a dedicated "ingenic, =
jz4780-otg", it seems "snps,dwc2" is redundant.

As far as I see there is no driver specialization compatible to
"ingenic,jz4780-otg". `grep ingenic,jz4780-otg *` only shows the .dtsi =
(and the new .yaml).

So we need "snps,dwc2" to get any driver match and I thought the =
"ingenic,jz4780-otg" is redundant.

But maintainers convinced me to keep it as a dummy compatible in the =
.dtsi for potential future
specialization (which does not exist and seems not to be necessary). =
Unless I can convince them=20
that this is never ever needed. Which is beyond my knowledge and almost =
everyone.

So we can't remove the "snps,dwc2" here.

Well, we can with more work elsewhere.
You have to extend the dwc2_of_match_table to include all ingenic =
devices.

Therefore we now know 3 potential solutions:
a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" (your =
proposal + my suggestion here)
c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match table =
in drivers//usb/dwc2/params.c (new proposals)

=46rom consistency point of view I think variant b) is the right one. a) =
was rejected and c) only adds redundant code.

I am open to anything as long as the dtbscheck doesn't complain any =
more.

BR an thanks,
Nikolaus

