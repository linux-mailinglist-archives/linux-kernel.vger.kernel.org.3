Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AD50378E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiDPQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiDPQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:37:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5DF0A;
        Sat, 16 Apr 2022 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650126882; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9/FAC8Z5gAmmI9gbu3oEtXUZTvFVNJbIuuy5fMe1ds=;
        b=Q87IUL2WHqAgSNCHIRolTQ15nDpeBxyLuTY4MpL0/tMalB7nYJiiPJ0dWOHZeBGy/YEgId
        f70Cj1on4xPfg/xT6mn3X+B83cxSp1ZJpnbdB+QGy3KauXGTj/NfEG3qREOQwiisoIgoxW
        ollpzdJyBI460j1Fssn0R6QMsv9m0b8=
Date:   Sat, 16 Apr 2022 17:34:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/3] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <J1YFAR.2881WOMSYUZM2@crapouillou.net>
In-Reply-To: <1649964337-114337-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1649964337-114337-2-git-send-email-zhouyanjie@wanyeetech.com>
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

Le ven., avril 15 2022 at 03:25:35 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
> SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
> from Ingenic.
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
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml=20
> b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 4cebce6..c6e8c0b 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -17,6 +17,13 @@ properties:
>      oneOf:
>        - const: brcm,bcm2835-usb
>        - const: hisilicon,hi6220-usb
> +      - const: ingenic,jz4775-otg
> +      - const: ingenic,jz4780-otg
> +      - const: ingenic,x1000-otg

The driver handles the JZ4775, JZ4780 and X1000 the exact same way.=20
Maybe the latter two should use the JZ4775 string as the fallback? Do=20
you know if the IP cores are any different?

> +      - const: ingenic,x1600-otg
> +      - const: ingenic,x1700-otg
> +      - const: ingenic,x1830-otg

Same here (and btw, first time I hear about the X1600 and X1700 ;))

Cheers,
-Paul

> +      - const: ingenic,x2000-otg
>        - items:
>            - const: rockchip,rk3066-usb
>            - const: snps,dwc2
> --
> 2.7.4
>=20


