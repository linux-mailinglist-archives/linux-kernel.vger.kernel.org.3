Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C15502C49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354800AbiDOPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDOPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:05:53 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF45B717B;
        Fri, 15 Apr 2022 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650035003; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eK/KiKOb6hSi9tkAeMrsraUhi60NwaYuEX999sSwWE=;
        b=TFkfGbxrvEWlErjA3nemolu/mEwunJbV4jBsKrRUSa831fRBYwPt4CSyintxj8+UPPA3s6
        Wgf/puCQjF2pxuzipEE4Izfb2qltrr5TLnMdG9+wGWhOrUvc9MceMIG6cepuF1inEV5pSQ
        cScI6qi+R92B1z9Xa25+pABsdcvJwXk=
Date:   Fri, 15 Apr 2022 16:03:12 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <C5ZDAR.LPUWNN7U3C19@crapouillou.net>
In-Reply-To: <1650032528-118220-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1650032528-118220-3-git-send-email-zhouyanjie@wanyeetech.com>
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



Le ven., avril 15 2022 at 22:22:07 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add the SPI bindings for the JZ4775 SoC, the X1000 SoC,
> and the X2000 SoC from Ingenic.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  Documentation/devicetree/bindings/spi/ingenic,spi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml=20
> b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> index 5b1c7a2..360f76c 100644
> --- a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> @@ -18,7 +18,10 @@ properties:
>      oneOf:
>        - enum:
>            - ingenic,jz4750-spi
> +          - ingenic,jz4775-spi
>            - ingenic,jz4780-spi
> +          - ingenic,x1000-spi
> +          - ingenic,x2000-spi
>        - items:
>            - enum:
>                - ingenic,jz4760-spi
> --
> 2.7.4
>=20


