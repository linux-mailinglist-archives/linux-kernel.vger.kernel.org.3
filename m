Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0C511400
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiD0JFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiD0JFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:05:23 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E019F8E45;
        Wed, 27 Apr 2022 02:02:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 295195FD13;
        Wed, 27 Apr 2022 12:02:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1651050125;
        bh=FlibZqz6Vs1KJA6OMN0S2VlRcGFGa/xmoTfPjJuhQtg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ekZbxxmsobxMJgoGh2uXEX8tsgy6L0NPWFygmbcNWajfzrV7bV80uov37EXsiv3EH
         dz/ZKapovctI//fIG11BvoygCqTr2jQlG2Y1h4aAt6+dfWh4fsJ4Qsni16AK3pBnC4
         k5/1BoOoHZDd2I3HlOf3rHkFMSWp/cUlvVGgxpJc0BPuAjUMl+3WPSOFxCSZH/4cee
         2nY1/b2jBICu6QQwYE4S4caduOctJAdmFlXCxyeuoSc2gkn67I4a8xwx6o1RAbLWq3
         zbvSVAQmz9LbeNaVCnitaiA7Xc7OvXv8tHfulVc4Xo0qJmoEX6+4ZXSd+rEr4VNNgk
         AXCjSyNvl18zQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 27 Apr 2022 12:02:05 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYVASMsRh3FoyxH0G3KQJPx6YT3q0Cfe6AgADSqIA=
Date:   Wed, 27 Apr 2022 09:01:13 +0000
Message-ID: <20220427090201.og6gwed364zr3cmd@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-2-ddrokosov@sberdevices.ru>
 <YmhV08V2jTeB448O@robh.at.kernel.org>
In-Reply-To: <YmhV08V2jTeB448O@robh.at.kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E31A6B890C3DC14C992872EDBF3A6437@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/27 03:59:00 #19365489
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

You are right, I've missed memsic definition, sorry for that. I'll move
memsensing vendor prefix to proper place on the v2 then.

On Tue, Apr 26, 2022 at 03:28:03PM -0500, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 03:45:51PM +0000, Rokosov Dmitry Dmitrievich wrot=
e:
> > MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
> > electromechanical system technology company which produces micro
> > electromechanical system microphones and sensors.
> > MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
> > in consumer electronics, industrial control, medical electronics
> > and automotive, and other fields.
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 294093d..d8f29ad 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -737,6 +737,8 @@ patternProperties:
> >      description: Mellanox Technologies
> >    "^memsic,.*":
> >      description: MEMSIC Inc.
> > +  "^memsensing,.*":
> > +    description: MEMSensing Microsystems Co., Ltd.
>=20
> Alphabetical order. This needs to be before memsic.
>=20

Ack

> >    "^menlo,.*":
> >      description: Menlo Systems GmbH
> >    "^mentor,.*":
> > --=20
> > 2.9.5
> >=20

--=20
Thank you,
Dmitry=
