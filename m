Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBBD59A5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350093AbiHSTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiHSTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:03:19 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173610812C;
        Fri, 19 Aug 2022 12:03:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 37BC75FD04;
        Fri, 19 Aug 2022 22:03:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660935784;
        bh=YdpZls8gavBPcjfLbXoFdEp4dDkKg8XvpjvkX2XZ/qY=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Mw6IAzPDLJ8itmPPyYtouSqe7gCBJTNue6ATKlVHocQeo6Gw+Ufh1OiBxeCY4KV15
         Xx8uu/JhfaRDgIYHCnJQrzMoyf5b61Hy7PB185KQZ4o8bSLqz+nRfxdzMFgSklFwQ/
         Oq7X0qKZX63w8ZpYjg4TVzxJsZ4e7IP3NdddXakJy6E84lKwxIzZa3NRaofmUj2SxL
         QJK5ccXqbI2gvGWxLeo/F5EeC4Ohe7Om2GWuR1NtsgwaGFpiNKcvnkiCNL3SYOSLOC
         AUqGwa8neFX9/o1i5VkE4RoYfMpMqZoG8hXjZv1c1/CqYdzYFRuYBhtxaNUgU+7+w9
         b7Pip5AzYWhhQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 Aug 2022 22:02:56 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYsaUBRyDxGBAJ7E6dKrTfsTk6Jq21uX2AgABHogCAAFRpgIAAEXSA
Date:   Fri, 19 Aug 2022 19:02:26 +0000
Message-ID: <20220819190253.d7ms7hgeccdn23i6@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
 <20220816191842.14020-4-ddrokosov@sberdevices.ru>
 <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
 <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220819190025.7702573b@jic23-huawei>
In-Reply-To: <20220819190025.7702573b@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCD86D7DB4B7E84F93B61CFD75E16224@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/19 07:02:00 #20132955
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:00:25PM +0100, Jonathan Cameron wrote:

[...]

> > > > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-=
ENG.pdf =20
> > >=20
> > > Have you ever seen such a tag?
> > > We have the Datasheet that is more or less established for this kind =
of links. =20
> >=20
> > As I mentioned before, if I use Datasheet tag, line length limit will b=
e
> > exceeded. If it's okay, I don't mind.
> Fine to go long.  If someone can't see the remaining chars of a link on t=
heir 80
> character wide terminal - they can scroll sideways :)

Exactly :) Okay, no problem, I'll change it to Datasheet.

[...]

--=20
Thank you,
Dmitry=
