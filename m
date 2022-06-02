Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B453BA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiFBN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiFBN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:59:48 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E77CB15;
        Thu,  2 Jun 2022 06:59:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 752B25FD02;
        Thu,  2 Jun 2022 16:59:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654178381;
        bh=ntjDMo8fSHZ9AfhI805jRgnlat3aE8+l1Hyxttg/O68=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ACgmHulfxak5IxwiPacyYKbhyhaVpkULsTKQ6y59Pgvm34HT0k+gJ/odo4n3f2+Nr
         KrnoGdTlUjxjsCOe/+KlWZO800GX52M/fS/FM0oS8mWWGpb7f0Bm9daPLvd2bNSBcF
         6Q2vqipsBpz2OxqopQh5ws09s1OPBLRMwLfLv4RiaGZVCsZAgTjLNsvWWuwtSX0uZl
         V3THIwnkChsAbNYaRW3xOxXgHGX6dCkJs+NPEwzb8lvpHRORV2efpcrhsixDo1Ljbn
         LItm/BNXJopUVYX/FBaPfQETjVzyTgmC5OEMOmKoWo6OOTe9dLW15JGkAHUmEKf3RH
         bGnIuRDsMF7aA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Jun 2022 16:59:40 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYcGNrbZDA8bgo60ChNUgj/6S16K07/E6AgAACmgA=
Date:   Thu, 2 Jun 2022 13:59:18 +0000
Message-ID: <20220602135934.f4exakny4rbrdboy@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-2-ddrokosov@sberdevices.ru>
 <20220602135015.GA2186715-robh@kernel.org>
In-Reply-To: <20220602135015.GA2186715-robh@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <705A7B20BE5D0D4ABE40BED15304B2CF@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/02 12:19:00 #19650230
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

Thank you for the Ack. I'm going to send v3 patch series and don't
understand, should I append Acked-by line to v3 version of vendor-prefix
patch... Please suggest me if possible.

On Thu, Jun 02, 2022 at 08:50:15AM -0500, Rob Herring wrote:
> On Wed, 25 May 2022 18:15:30 +0000, Dmitry Rokosov wrote:
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
>=20
> Acked-by: Rob Herring <robh@kernel.org>

--=20
Thank you,
Dmitry=
