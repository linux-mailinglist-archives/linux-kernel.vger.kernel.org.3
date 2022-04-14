Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56FA500AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiDNKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDNKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:03:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC05371A;
        Thu, 14 Apr 2022 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649930428;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=O31Nl5AOFehQyennzN1A7CJVxZkiGCjpOxp+mKyaQqQ=;
    b=cKMhA4eQW+Q4/4zC1E0t2dwtAM5SZoN/60wUkjOv9fFu3m+QW1uxfp8782zUExFeT+
    4HbcuQGT7hVv6Miam3Rf6va5V3WqEntk1/Ihi8HNvExecrbKqqKOzL9q23fLAqTFp5+N
    flH1/PD4Og8XRUO537v/McciufamFtm8suLgGLsDmtIAY0X517GdUx63xz++S+s1F14G
    a+QgiYzupO3o0tThqiei2QdMRZnGh6ATY/zvS3EPI/Bfne+QvqB8YP3b9I/iEYg0pSF5
    i2IiTI7wQpt4SHLIKBhXKlAfR2palHO/QvMI9MxaYOc1IslGybkYNvMo1WAng/LfNDgr
    vdrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47uAiI="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3EA0RDiZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 14 Apr 2022 12:00:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <76ea346b-0645-97b5-f8fb-5b46b4bcc80b@linaro.org>
Date:   Thu, 14 Apr 2022 12:00:27 +0200
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
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
Message-Id: <F6929BAA-D552-4C34-B392-33AEA263F0C9@goldelico.com>
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
 <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
 <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
 <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
 <76ea346b-0645-97b5-f8fb-5b46b4bcc80b@linaro.org>
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



> Am 14.04.2022 um 09:32 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 13/04/2022 21:30, H. Nikolaus Schaller wrote:
>> So we need "snps,dwc2" to get any driver match and I thought the =
"ingenic,jz4780-otg" is redundant.
>>=20
>> But maintainers convinced me to keep it as a dummy compatible in the =
.dtsi for potential future
>> specialization (which does not exist and seems not to be necessary).=20=

>=20
> Isn't exactly the next patch 2/2 using such specialization?
>=20
>> Unless I can convince them=20
>> that this is never ever needed. Which is beyond my knowledge and =
almost everyone.
>>=20
>> So we can't remove the "snps,dwc2" here.
>>=20
>> Well, we can with more work elsewhere.
>> You have to extend the dwc2_of_match_table to include all ingenic =
devices.
>>=20
>> Therefore we now know 3 potential solutions:
>> a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
>> b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" =
(your proposal + my suggestion here)
>> c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match =
table in drivers//usb/dwc2/params.c (new proposals)
>>=20
>> =46rom consistency point of view I think variant b) is the right one. =
a) was rejected and c) only adds redundant code.
>=20
> c) was already proposed by Zhou, so if you think the code is not =
correct
> (the params for jz4780) maybe nack it there, so we will know that =
driver
> needs fixes.

Ah, ok. Now I see. I was just focussed on this patch and related =
dtbscheck
messages and did not read patch 2/2.

Yes, looking at both, they are variant c). Sorry that I didn't see it =
earlier.

As said: I am open to anything as long as the dtbscheck doesn't complain =
any more.

BR and sorry for the confusion,
Nikolaus

