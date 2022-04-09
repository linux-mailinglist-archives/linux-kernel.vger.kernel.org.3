Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC64FA8E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiDIOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiDIOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:08:12 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A22274F3;
        Sat,  9 Apr 2022 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649513161;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AobUghhpQ3ekLNHOG9d7IDWN4zF0yDIKYAaL0zaeRNg=;
    b=l2WNtM2nz5Agjaw+9H/XkXINfOWW1gZxdJXjllnmybTTYgZzpLx3kH9JDmGwVFiNiS
    bbVWy5bgzrU0tK4Lh/tTZFzhynSYELdVKQopCbfMQOzx7/b3lhYdMfnDLqVlioQ45d0i
    1c/YJlS0AG9Kk/lb64OJUCYOZD6AyPRh1wwTCYNu7jUP8/4zDLuMOlr0WzUQLr9kBnJ/
    2TP7Vkkngr6aOGmDMt+KXAEjgQIXWC2poaptIWXM1o9/iY03bS+6qGt4xBUv5NYeF/sK
    As43ColaTv2bBXpLZTlUslorW+yCdaQaDPzg6CvI7KcgcpOH5PmYO5XFVBzaKxoTeDNd
    EF4g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39E60ud3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 16:06:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7a2e986f-708b-ae4f-e877-6cdc1607626a@linaro.org>
Date:   Sat, 9 Apr 2022 16:06:00 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <318AA65F-A6DD-46F7-9BFA-7283EF0FFE94@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
 <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
 <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
 <B5EB5983-DA9F-4631-B737-2B1417CF9054@goldelico.com>
 <f40e1a00-be4d-11c7-6a7c-6b50635a2960@linaro.org>
 <499848FD-3F64-4B5D-9259-5C9E1ED4E8AB@goldelico.com>
 <fb521d87-2d52-c15c-83c0-1b62bf1b1cc4@linaro.org>
 <F0C0E942-BA61-4C74-860B-93D57C3D0F9A@goldelico.com>
 <7a2e986f-708b-ae4f-e877-6cdc1607626a@linaro.org>
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



> Am 09.04.2022 um 16:00 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:57, H. Nikolaus Schaller wrote:
>>=20
>>=20
>>> Am 09.04.2022 um 15:46 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>=20
>>> On 09/04/2022 15:41, H. Nikolaus Schaller wrote:
>>>>>=20
>>>>> No. I ask you to fix all pin-controller cases, for entire MIPS, =
not just
>>>>> one.
>>>>=20
>>>> Oops. Nope. I am a volunteer and neither your employee nor slave.
>>>=20
>>> No one thinks differently and I am sorry that you felt it. Please =
accept
>>> my apologies, if you get different impression. You understand though =
the
>>> meaning of word "ask for something" and "order something" (the =
latter
>>> which I did not use).
>>>=20
>>> I just asked.
>>=20
>> Ok. Maybe english is not our mother language and we sometimes don't
>> get the nuances right. Sorry if I understood that wrongly.
>>=20
>> At least I now understand what you did suggest.
>=20
> Yeah, probably I did not express my thoughts correctly.
>=20
> I would like to state that I appreciate your work and I think it is
> important, even if I do not express it correctly. Please accept my
> apologies if I am bit harsh or impolite. That's not my intention.

I also was a little harsh in my response. Sorry again.

>=20
>>=20
>> Doing the same change for treewide MIPS is beyond my capabilities =
since
>> I can't easily test any compile setup. So far I only compile for CI20 =
and
>> as far as I know every machine still needs its own config for MIPS=20
>> (haven't checked recently). So I am not even sure if dtbscheck tells =
me
>> all locations.
>=20
>=20
> OK, fair enough.
>=20
>=20
> Best regards,
> Krzysztof

Anyways thank you very much for your reviews and sharing comments.

As far as I see there are only the jz4780-nemc/simple-mfd and the =
snps,dwc2/jz4780-otg
issues really unsolved while the others are more cosmetics.

Let's see how these settle.

BR and thanks,
Nikolaus

