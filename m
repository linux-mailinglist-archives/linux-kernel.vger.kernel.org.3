Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5851AD0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377103AbiEDSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349468AbiEDSlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:41:06 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C29D0;
        Wed,  4 May 2022 11:37:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 610455FD03;
        Wed,  4 May 2022 21:37:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1651689442;
        bh=0pRI9gjT9I5sHIvuEEphqPu4I5tns7FIRu1caEw5+sM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=AOMBqLy8z7SR5iHEacaI+JsLY4+G0YwEq1X+CyyjFyblIPvc4QHe2nXcRQj2fz9EA
         /POeUUTk5TU0i5wGp4uoIA4zxt9wVu7naEMPaqzBRFZn7ItQOzpe/b71iSefIUWB7E
         8w289ScUiC9XV2qJiMcx3Tj3HYO2jePO4D9WMciF9IU+K0HZB3BRM1QdR6DWAgRVJP
         3m+kVuMvLGgCgvuLYihY53hoZsEU77Pzi7NWpVYLJSQvGiTbf+tkFeQnirKXyhsrDK
         j/JHHmTJ5qqwlEmHLsRnF7kRfwsMqDlM1b9DFK+2wQWIVnmRnaWTZK5oRO50Qv1gCy
         iDl/Fk5jtpTmA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  4 May 2022 21:37:21 +0300 (MSK)
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
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYVASQQZC393Ji1keuDd+e+35bUq0CfseAgAxy2gA=
Date:   Wed, 4 May 2022 18:36:33 +0000
Message-ID: <20220504183716.shhpi5adcxz4ufvj@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-4-ddrokosov@sberdevices.ru>
 <YmhWic3rG8ERtCYY@robh.at.kernel.org>
In-Reply-To: <YmhWic3rG8ERtCYY@robh.at.kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3264DF858B156249B0EDE83771F52D03@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/04 16:46:00 #19352550
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

I've missed one note below, please check if possible.

On Tue, Apr 26, 2022 at 03:31:05PM -0500, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 03:45:58PM +0000, Rokosov Dmitry Dmitrievich wrot=
e:
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> These apply to 'reg' in a child node, but you don't have child nodes so=20
> drop them.
>=20

I'm afraid, I made a mistake in the previous reply. Here I applied
address-cells and size-cells to show which type accelerometer's reg
property has, like this one:

    i2c {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
   =20
        accelerometer@62 {
            compatible =3D "memsensing,msa311";
            reg =3D <0x62>;

Above accelerometer@62 is child node for i2c bus node, so address and
size cells mean accelerometer reg format. Am I missing something?

--=20
Thank you,
Dmitry=
