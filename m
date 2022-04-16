Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF3503791
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiDPQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiDPQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:37:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B4186C4;
        Sat, 16 Apr 2022 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650126906; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ou3hBQuM/JxpcQtVbQxk8U/5Tg2lj4pFWqPeSDNeGc=;
        b=M+xkmqPR9SGdenNCjls7+77JYR/Fbx6FvtQv3eHERK67ruY9c3WVIDnIYiX8wFHfXc1t5s
        nqIrFqdi1HoLhWQq+Cr/La74a6ldsLy9GPVQ2dKIU7RWP133zkPz4/Zi9gads31KDcpot1
        nGRBfYqQcsyhFZVoP7NIknNxbCTCjSU=
Date:   Sat, 16 Apr 2022 17:34:55 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 3/3] MIPS: Ingenic: Refresh USB nodes to match driver
 changes.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <72YFAR.2F64W3SYY7912@crapouillou.net>
In-Reply-To: <16eb34cf-508b-b387-b255-4b0a778bf53f@wanyeetech.com>
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1649964337-114337-4-git-send-email-zhouyanjie@wanyeetech.com>
        <WBZDAR.1ZU7BOCJE9S11@crapouillou.net>
        <16eb34cf-508b-b387-b255-4b0a778bf53f@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le sam., avril 16 2022 at 20:16:33 +0800, Zhou Yanjie=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Hi Paul,
>=20
> On 2022/4/15 =E4=B8=8B=E5=8D=8811:07, Paul Cercueil wrote:
>> Hi Zhou,
>>=20
>>=20
>> Le ven., avril 15 2022 at 03:25:37 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Z=
hou Yanjie)=20
>> =7F<zhouyanjie@wanyeetech.com> a =C3=A9crit :
>>> Refresh USB nodes in the jz4780.dtsi, x1000.dtsi, and x1830.dtsi=20
>>> files.
>>>=20
>>> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wa=
nyeetech.com>
>>> ---
>>>=20
>>> Notes:
>>>     v3:
>>>     New patch.
>>>=20
>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>>  arch/mips/boot/dts/ingenic/x1000.dtsi  | 2 +-
>>>  arch/mips/boot/dts/ingenic/x1830.dtsi  | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
>>> =7F=7Fb/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> index b998301..c182a65 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> @@ -577,7 +577,7 @@
>>>      };
>>>=20
>>>      otg: usb@13500000 {
>>> -        compatible =3D "ingenic,jz4780-otg", "snps,dwc2";
>>> +        compatible =3D "ingenic,jz4780-otg";
>>=20
>> Could you refresh my memory - why are the "snps,dwc2" fallback=20
>> strings =7Fremoved?
>>=20
>> To me it seems like they should be here, since the OTG IP in Ingenic=20
>> =7FSoCs is derived from the DWC2 IP.
>=20
>=20
> The reason is that Nikolaus found that the current jz4780.dtsi will=20
> cause
> dtbscheck to complain. After discussion, Nikolaus concluded three=20
> feasible
> solutions, see here:
> https://lkml.org/lkml/2022/4/13/1097
>=20
> And it seems that Krzysztof prefers the c) option.

Understood.

-Paul

>=20
> Thanks and best regards!
>=20
>=20
>>=20
>> Cheers,
>> -Paul
>>=20
>>>          reg =3D <0x13500000 0x40000>;
>>>=20
>>>          interrupt-parent =3D <&intc>;
>>> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi=20
>>> =7F=7Fb/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> index 8bd27ede..343818a2 100644
>>> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>>> @@ -366,7 +366,7 @@
>>>      };
>>>=20
>>>      otg: usb@13500000 {
>>> -        compatible =3D "ingenic,x1000-otg", "snps,dwc2";
>>> +        compatible =3D "ingenic,x1000-otg";
>>>          reg =3D <0x13500000 0x40000>;
>>>=20
>>>          interrupt-parent =3D <&intc>;
>>> diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi=20
>>> =7F=7Fb/arch/mips/boot/dts/ingenic/x1830.dtsi
>>> index 2595df8..6aff19f 100644
>>> --- a/arch/mips/boot/dts/ingenic/x1830.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
>>> @@ -355,7 +355,7 @@
>>>      };
>>>=20
>>>      otg: usb@13500000 {
>>> -        compatible =3D "ingenic,x1830-otg", "snps,dwc2";
>>> +        compatible =3D "ingenic,x1830-otg";
>>>          reg =3D <0x13500000 0x40000>;
>>>=20
>>>          interrupt-parent =3D <&intc>;
>>> --
>>> 2.7.4
>>>=20
>>=20


