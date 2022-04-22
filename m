Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07E50B797
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447641AbiDVMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDVMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:48:00 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD81A394;
        Fri, 22 Apr 2022 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650631501; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAoD2y0Qvn4mZ56K12HLHvmWzPEXxA7h9UsTynmvszw=;
        b=F0CU+FRxy3btZ6gcjitq6iZG4oWkaNqUcvbPKniuxJoYPFNt3NnBb0Y02Xl4tz0ZBQfL8u
        C6hQwMBEdabTwOntELojvjWGjmPLzWcTXhLQ/QK5pTmDYXKV6JXREOsxuGuGIu0+j8ln5C
        MB9Fd8rsZ/Xaht9Zad+Hzw2TaxNDVMM=
Date:   Fri, 22 Apr 2022 13:44:50 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/3] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <QERQAR.SQYC38Q7CE0Z2@crapouillou.net>
In-Reply-To: <1650561308-54704-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1650561308-54704-2-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le ven., avril 22 2022 at 01:15:06 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000=20
> SoC,
> the X1600 SoC, the X1830 SoC, and the X2000 SoC from Ingenic.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Notes:
>     v1->v2:
>     Add Rob Herring's Acked-by.
>=20
>     v2->v3:
>     No change.
>=20
>     v3->v4:
>     Remove the compatible string of X1700 since it could use the=20
> X1600 string
>     as the fallback.
>=20
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml=20
> b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 4cebce6..2218df8 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -17,6 +17,12 @@ properties:
>      oneOf:
>        - const: brcm,bcm2835-usb
>        - const: hisilicon,hi6220-usb
> +      - const: ingenic,jz4775-otg
> +      - const: ingenic,jz4780-otg
> +      - const: ingenic,x1000-otg
> +      - const: ingenic,x1600-otg
> +      - const: ingenic,x1830-otg
> +      - const: ingenic,x2000-otg

You should probably also add:
- items:
    - const: ingenic,x1700-otg
    - const: ingenic,x1600-otg

As discussed in your v3.

Cheers,
-Paul

>        - items:
>            - const: rockchip,rk3066-usb
>            - const: snps,dwc2
> --
> 2.7.4
>=20


