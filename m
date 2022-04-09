Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84324FA7EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiDINEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiDINEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:04:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE462C6C6A;
        Sat,  9 Apr 2022 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509326;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CGkfYa6v34H57lhZ6WEJiPxEbymArlhwCl0WMmH87b4=;
    b=EHDVH2l60ZwQlwRvhJ9IPTtsPXA7FDVqKwjjY1ogcmUH7AsBH6gqhVxUWxPCfO6LaS
    +Cia5G9veAJ4DP22tar5HjWHBfWDs2RnLrWRYgfO5GkbhKzsHVTiVrF9V8WDaNLxjBuC
    ie3C0xFLlapJVI10+KRKBqzVorsrBXi6Utn7B4SL7KuVTgYqfN2jmUtbBdegWalN9dFa
    OT/6fIMUHL6760XcT1bBu6hGai1PY44nb74eOR/hWejfsfSlM84eo/ed6ytep/Ytvjbf
    3eq9VK+3NHXOTict2x/cXdxDHEE495eS65pmt5AZ4hqCenPC08AnJZsZAQWUQqWZ73AZ
    rxOg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D26uTv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:02:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 01/18] MIPS: DTS: jz4780: remove cpu clock-names as
 reported by dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <0a0cb08a-3992-7e20-61ca-7856ce273005@linaro.org>
Date:   Sat, 9 Apr 2022 15:02:05 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8D9DAF0-435B-4701-84E4-580FAA9CE74F@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <064a1f029a82ea3895109efe8fb1f472581d4581.1649443080.git.hns@goldelico.com>
 <0a0cb08a-3992-7e20-61ca-7856ce273005@linaro.org>
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

Hi Krzysztof,

> Am 09.04.2022 um 13:07 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@0: clock-names does not =
match any of the regexes: pinctrl-[0-9]+
>> 	=46rom schema: =
Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@1: clock-names does not =
match any of the regexes: pinctrl-[0-9]+
>> 	=46rom schema: =
Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>=20
> No need to put the same warning twice (cpu index really does not
> matter). One warning is enough.

Well, how can you as a reviewer see immediately that dtbscheck
warns for both instances and that they are both really fixed by the
complete patch?

Assume there were only the first one mentioned and the second one
forgotten to fix...

If it is not included here (completely), you have to run dtbscheck=20
yourself to see that there are two instances involved. Or deduce it
from looking into the source file.

In both cases much more work for you or other reviewers.

This is why I have kept this redundancy. One commit hunk for every
warning line.

And it may only look redundant in the commit message, not in code=20
where it would really hurt to have duplication.

>=20
> Fixing warnings is good, but what if the property should be there and
> the bindings are not correct? If you know the answer, please add it to
> the commit msg.

It has of course been tested on real hardware.
There was only one case where the bindings seem to be wrong (patch =
13/18).

And usually I simply assume such generic bindings are tested on many
other platforms and therefore the reference. What are bindings and
dtbscheck good for if we doubt them as DTS developers?

> This applies to all your patches. Blind fixing of DTS warnings my
> produce incorrect results. :(

Every patch of this series has been tested on real hardware to have
no negative side-effects.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
>=20
> Best regards,
> Krzysztof

BR and thanks,
Nikolaus=
