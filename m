Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE285019EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiDNRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbiDNRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:21:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B229BC9;
        Thu, 14 Apr 2022 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649956682;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KshZXEHhcUQEnHixAwZGv5dR1rFkLqEAD5Zz92eTH5M=;
    b=M6ktt3FArDL5yCIRbKdklWskTNy9KYDspOm4TEZoOjmU/oBkD7CsChI9LSCTGmrTPJ
    etNdz4Jhm5iVlUU47iuCN2Dx/vxbtmRU0SOZ1apGmdQQ4CxgnU1DHWqB4q9LZnBQeKZ8
    6bLh3NLbMxMn2iVzqH2BBjpp6SrfBF620MZYzoIGE19lJCp1nYOf88H6umsXLhMBjrSE
    9S5R6dumEu/Cukn7zI7Jsb0g3OM7J5D17AG0B8dGGtQ9QniMJDVK18oGXQofPxTdAZS1
    4/J18TdMCkotOD6KR+thF6YF/TEzUxjogSVVMsUJEbfhdHkA32KOwgOsQEsxn8kzIbJC
    JScg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47uAiI="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3EHI1Gaw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 14 Apr 2022 19:18:01 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <40d34f8b-4ab7-5ced-b533-da1f4b501cdc@wanyeetech.com>
Date:   Thu, 14 Apr 2022 19:18:00 +0200
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hminas@synopsys.com, Rob Herring <robh+dt@kernel.org>,
        linux-usb@vger.kernel.org, linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, dragancecavac@yahoo.com,
        dongsheng.qiu@ingenic.com, qipengzhen <aric.pzqi@ingenic.com>,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0853601-C9FA-45E9-95FA-6E05897DA328@goldelico.com>
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
 <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
 <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
 <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
 <76ea346b-0645-97b5-f8fb-5b46b4bcc80b@linaro.org>
 <F6929BAA-D552-4C34-B392-33AEA263F0C9@goldelico.com>
 <40d34f8b-4ab7-5ced-b533-da1f4b501cdc@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
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

> Am 14.04.2022 um 19:11 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi,
>=20
> On 2022/4/14 =E4=B8=8B=E5=8D=886:00, H. Nikolaus Schaller wrote:
>>=20
>>> Am 14.04.2022 um 09:32 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>=20
>>> On 13/04/2022 21:30, H. Nikolaus Schaller wrote:
>>>> So we need "snps,dwc2" to get any driver match and I thought the =
"ingenic,jz4780-otg" is redundant.
>>>>=20
>>>> But maintainers convinced me to keep it as a dummy compatible in =
the .dtsi for potential future
>>>> specialization (which does not exist and seems not to be =
necessary).
>>> Isn't exactly the next patch 2/2 using such specialization?
>>>=20
>>>> Unless I can convince them
>>>> that this is never ever needed. Which is beyond my knowledge and =
almost everyone.
>>>>=20
>>>> So we can't remove the "snps,dwc2" here.
>>>>=20
>>>> Well, we can with more work elsewhere.
>>>> You have to extend the dwc2_of_match_table to include all ingenic =
devices.
>>>>=20
>>>> Therefore we now know 3 potential solutions:
>>>> a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
>>>> b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" =
(your proposal + my suggestion here)
>>>> c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match =
table in drivers//usb/dwc2/params.c (new proposals)
>>>>=20
>>>> =46rom consistency point of view I think variant b) is the right =
one. a) was rejected and c) only adds redundant code.
>>> c) was already proposed by Zhou, so if you think the code is not =
correct
>>> (the params for jz4780) maybe nack it there, so we will know that =
driver
>>> needs fixes.
>> Ah, ok. Now I see. I was just focussed on this patch and related =
dtbscheck
>> messages and did not read patch 2/2.
>>=20
>> Yes, looking at both, they are variant c). Sorry that I didn't see it =
earlier.
>=20
> It looks like we need a [3/3] to remove "snps,dwc2", which not only =
solves
> the dtbscheck complaining problem, but also doesn't affect normal use =
after
> removing "snps,dwc2".

Yes, that seems to be the right thing to do.

BR and thanks,
Nikolaus

