Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522C57C5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiGUIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiGUIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:04:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4F796A8;
        Thu, 21 Jul 2022 01:04:01 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c30a:1501:427e:206e:3eb7:267d] (unknown [IPv6:2a00:23c6:c30a:1501:427e:206e:3eb7:267d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDF2F66019C1;
        Thu, 21 Jul 2022 09:03:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658390640;
        bh=fs3O49CtwD+yyqy9aNqBLmpgxY/wLTliwXWOK4mYbl8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HGnRR4MoeYzwZ7nuD8zWv09oTda5dNBZxtWI1ZlRSAXYOUoInlKoLLoJEW09Gz6MH
         YHrBJtS3ffRwz1SJukzWh5R8chpRRPauzXIEYNgMGPY1U6QBhnsySEPhSJbsSdA2EK
         acSuXIqZujzKznKLTXlBJrx8CoYIVogUzHdOTNYBQgKBT4VhM/Nehzn4QWBlojq971
         2tXjhrr1w0mfnFYzE0ASggX82GGaJbBb8C01yt4lWRkVT+KB3kCZDksFmbjF1gg0Bv
         O2pzVeS498Ryw7IIs1eERQP5VqssOZ1TavbaT70ua/p0Lz37Zifl6ahsmhtpH0okyC
         vA1IezgxwBGqQ==
Message-ID: <86de8ba0157c451fcce4ca92b6cad835e3f1e4d9.camel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MSC
 Technologies
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 Jul 2022 09:03:56 +0100
In-Reply-To: <abd47815-c84b-115b-f6f2-b6ec0dbf1bef@linaro.org>
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
         <abd47815-c84b-115b-f6f2-b6ec0dbf1bef@linaro.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-20 at 19:07 +0200, Krzysztof Kozlowski wrote:
> On 20/07/2022 17:00, Martyn Welch wrote:
> > Add "msc" vendor prefix for MSC Technologies GmbH
> > (https://www.msc-technologies.eu).
>=20
> Does not really work - leads to Avnet, so there is no MSC anymore?
>=20

It still seems to be used as branding by Avnet.

> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
> >=20
> > Changes in v2:
> > =C2=A0 - New addition
> >=20
> > =C2=A0Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 0496773a3c4d..1658357bc1c4 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -816,6 +816,8 @@ patternProperties:
> > =C2=A0=C2=A0 "^mrvl,.*":
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: Marvell Technology Group Ltd.
> > =C2=A0=C2=A0=C2=A0=C2=A0 deprecated: true
> > +=C2=A0 "^msc,.*":
> > +=C2=A0=C2=A0=C2=A0 description: MSC Technologies GmbH.
>=20
> This should be rather msct or msctech, but anyway in fact you maybe
> should use avnet?
>=20

My rationale for using MSC Technologies is that is how the device is
described on the website as being a MSC device. I think the
amalgamation of the MSC website into Avnet's has happened in the last
year or so. I assume a new device released in the near future would be
branded more directly as an Avnet device, or maybe not, I see that the
i.MX 9 is being described as "MSC SM2S-IMX93".

I'll switch to msctech unless there are objections to that.

Martyn

> > =C2=A0=C2=A0 "^mscc,.*":
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: Microsemi Corporation
> > =C2=A0=C2=A0 "^msi,.*":
>=20
>=20
> Best regards,
> Krzysztof

