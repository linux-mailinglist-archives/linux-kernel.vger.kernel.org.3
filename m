Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E54FF084
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiDMHZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiDMHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:25:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F864EF5B;
        Wed, 13 Apr 2022 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649834576;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jSef++PqlCRC5a4E7G9ko+rR3cG0lpZnUPx+3xD3i7k=;
    b=MiFx7X19KcZviO8N1lBrrnZQxFqdpVnskMF7uzqQgRP/aJm+jDz2EM+ReZG3FMkR5v
    JdYIVJZzej7TkIId6fWcDIni7CLtCBG9UGi0/kPPjn4TZ6CeqPKlF9q9iqr3wv6s4+k7
    Tz0eSNte16z2hyyaXk0SB3UP4ym/Jdr5XGXjLP2mMS2fJqvMe+OrN32QNsghhrpo2WBe
    R60work5jkLFacohwDMRmCtDdfPWaSS4E56DF762marMk6BUmQpfVSd+n+KkoPYLoC7L
    Jc+D0HRXsRjoRhFKBPZjttEZZGcvs7R6zY9G0Mi6skCLwoZtATU6BlU9mAGFD0BkLI6b
    slsw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw4nvnQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3D7Mt7tg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 13 Apr 2022 09:22:55 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
Date:   Wed, 13 Apr 2022 09:22:54 +0200
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hminas@synopsys.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
To:     =?utf-8?B?IuWRqOeQsOadsCAoWmhvdSBZYW5qaWUpIg==?= 
        <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 12.04.2022 um 20:30 schrieb =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou =
Yanjie) <zhouyanjie@wanyeetech.com>:
>=20
> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
> SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
> from Ingenic.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) =
<zhouyanjie@wanyeetech.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Notes:
>    v1->v2:
>    Add Rob Herring's Acked-by.
>=20
> Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml =
b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 4cebce6..c6e8c0b 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -17,6 +17,13 @@ properties:
>     oneOf:
>       - const: brcm,bcm2835-usb
>       - const: hisilicon,hi6220-usb
> +      - const: ingenic,jz4775-otg
> +      - const: ingenic,jz4780-otg
> +      - const: ingenic,x1000-otg
> +      - const: ingenic,x1600-otg
> +      - const: ingenic,x1700-otg
> +      - const: ingenic,x1830-otg
> +      - const: ingenic,x2000-otg

I have merged it with my recently proposed removal of
ingenic,jz4780-otg in jz4780.dtsi but there was no dtbscheck
complaint about missing snps,dwc2.

So I think should it be:

      - items:
          - enum:
              - const: ingenic,jz4775-otg
              - const: ingenic,jz4780-otg
              - const: ingenic,x1000-otg
              - const: ingenic,x1600-otg
              - const: ingenic,x1700-otg
              - const: ingenic,x1830-otg
              - const: ingenic,x2000-otg
          - const: snps,dwc2

similar to the entry for amlogic?

>       - items:
>           - const: rockchip,rk3066-usb
>           - const: snps,dwc2
> --=20
> 2.7.4
>=20

BR and thanks,
Nikolaus=
