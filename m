Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26C56406E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiGBNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGBNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 09:47:55 -0400
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4522DF2E;
        Sat,  2 Jul 2022 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656769649; bh=KRvAEsUC0sls+O9Nc7UMnd+DxX26VFDrwl51aR8S2gA=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=Np/XkjLGYDSK2m+ojMf9zS4ddJ5r02mOPImaeG/SpQ39LcS6qmijaK8jrWoD/8S5Z
         O4mEVpWt5KRCrV3PgrLVSKbylc1orn1ZHRsXgig4eOEvbxf1Wu+rMVkDXsVw++jSm0
         n0SDVpITUJbq9IWrQS2QtU6Z2/kN4zGhl1ZXYP1A=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Sat,  2 Jul 2022 15:47:29 +0200 (CEST)
X-EA-Auth: NvJ8YmF84cTTSq1nzCuSijqA9StTvrfAFrhbyf6EeamH+Zgv60bAkmVLtOhIEfVGVThA33NXyVo9Jj6btur4iZPjM6f2lfuuSkRCSy8A3eQ=
Message-ID: <a66ee18b02fa7a1654fedab0aa49bde09cedeee1.camel@mailoo.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Convert is31fl319x to dtschema
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Sat, 02 Jul 2022 15:47:28 +0200
In-Reply-To: <99DCB131-5A1F-4F8B-8E3F-1AE283AA591A@goldelico.com>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
         <20220701134415.4017794-2-vincent.knecht@mailoo.org>
         <99DCB131-5A1F-4F8B-8E3F-1AE283AA591A@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 02 juillet 2022 =C3=A0 15:26 +0200, H. Nikolaus Schaller a =C3=A9=
crit=C2=A0:
> Hi Vincent,
>=20
> > Am 01.07.2022 um 15:44 schrieb Vincent Knecht <vincent.knecht@mailoo.or=
g>:
> >=20
> > Convert leds-is31fl319x.txt to dtschema.
> >=20
> > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > ---
> > .../bindings/leds/issi,is31fl319x.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 113 ++++++++++++++++++
> > .../bindings/leds/leds-is31fl319x.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 61 ----------
> > 2 files changed, 113 insertions(+), 61 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl31=
9x.yaml
> > delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl31=
9x.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yam=
l
> > b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> > new file mode 100644
> > index 000000000000..17635a7cf8af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> > @@ -0,0 +1,113 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/issi,is31fl319x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ISSI LED controllers bindings for IS31FL319{0,1,3,6,9}
> > +
> > +maintainers:
> > +=C2=A0 - H. Nikolaus Schaller <hns@goldelico.com>
> > +
>=20
> as noted for v1 you can change this as it is a new file (just same idea i=
n different language) and I won't have time
> to maintain it.
>=20
> BR and thanks,
> Nikolaus

Hi Nikolaus,

ok I'll send a new series.
Just to be sure, is it ok to change license to (GPL-2.0-only OR BSD-2-Claus=
e) too ?

Thank you


