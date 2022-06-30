Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AB562585
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiF3Vnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiF3Vnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:43:43 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC153ECE;
        Thu, 30 Jun 2022 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656625407; bh=kfSeJYHpcO+DQINDcQTze3o46t7att6FRDfo86mkGb0=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=e56yVha1FJK+4Mwia2qzYcWjNmN8rgjpauwgmzrC3iOtd2hrxNqRTOhTzBNPvVFFA
         zTXGzXQZQyyH+igcF93SPGKv0RAEZ53zAIYtT9peidaU5ctZy9pweCRwwYVqSPH8Rf
         fyQp69dT2g7jmyaDh0UcZTSCkc9yWwG76yDRSOqQ=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Thu, 30 Jun 2022 23:43:27 +0200 (CEST)
X-EA-Auth: R3mel8gQQlMckotIkNXG0Nwv57HB69aXmxYwEO0Dc9nBmk8Y9CpIZOrzkNX4BDt28//Fr3PvmcPPEcBEslUDPKjcy635HDgAePFG8IWvGwE=
Message-ID: <dcd817c8a3852f3e6bad0c221a284fb3e69e1ca9.camel@mailoo.org>
Subject: Re: [PATCH v1 RESEND 1/7] dt-bindings: leds: Convert is31fl319x to
 dtschema
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        hns@goldelico.com
Date:   Thu, 30 Jun 2022 23:43:26 +0200
In-Reply-To: <20220630152806.GA2732671-robh@kernel.org>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
         <20220628182147.2837180-2-vincent.knecht@mailoo.org>
         <1656468579.884791.1403671.nullmailer@robh.at.kernel.org>
         <20220630152806.GA2732671-robh@kernel.org>
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

Le jeudi 30 juin 2022 =C3=A0 09:28 -0600, Rob Herring a =C3=A9crit=C2=A0:
> On Tue, Jun 28, 2022 at 08:09:39PM -0600, Rob Herring wrote:
> > On Tue, 28 Jun 2022 20:21:39 +0200, Vincent Knecht wrote:
> > > Convert leds-is31fl319x.txt to dtschema.
> > > Set license to the one recommended by DT project.
>=20
> Do you have permission to do so? The original .txt file is default GPL2=
=20
> and owned by H. Nikolaus Schaller.=20

No, sorry for the mistake.
Adding to cc, which I forgot to do in the first place...
For reference: https://lore.kernel.org/linux-leds/20220628182147.2837180-1-=
vincent.knecht@mailoo.org/T/

> > >=20
> > > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > > ---
> > > =C2=A0.../bindings/leds/issi,is31fl319x.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 113 ++++++++++++++++++
> > > =C2=A0.../bindings/leds/leds-is31fl319x.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 61 ----------
> > > =C2=A02 files changed, 113 insertions(+), 61 deletions(-)
> > > =C2=A0create mode 100644 Documentation/devicetree/bindings/leds/issi,=
is31fl319x.yaml
> > > =C2=A0delete mode 100644 Documentation/devicetree/bindings/leds/leds-=
is31fl319x.txt
> > >=20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ii=
o/temperature/adi,ltc2983.yaml:
> > patternProperties:^thermistor@:properties:adi,excitation-current-nanoam=
p: '$ref' should not be valid under {'const':
> > '$ref'}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hint: Standard unit suf=
fix properties don't need a type $ref
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http:/=
/devicetree.org/meta-schemas/core.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ii=
o/temperature/adi,ltc2983.yaml: ignoring,
> > error in schema: patternProperties: ^thermistor@: properties: adi,excit=
ation-current-nanoamp
> > Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.d=
tb:0:0: /example-0/spi/ltc2983@0: failed to
> > match any schema with compatible: ['adi,ltc2983']
>=20
> You can ignore this. The bot went amuck.
>=20

Ack... at least it respected the 3 Laws :-)



