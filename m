Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262B539625
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiEaSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbiEaSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:20:51 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448F9CCAF;
        Tue, 31 May 2022 11:20:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id F37C05FD12;
        Tue, 31 May 2022 21:20:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654021247;
        bh=LLTMWVLTXK/FNIjG6+k6fRJKDBqVhP98JFRueLwzPG4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=sjztjmrzsklrw8ter/VYZEpnIbkdWrfct1y+jaA06p0D3zbk+kjMm59zZps6GX6bh
         qZVrqqLTr48c7z89RaRuk6cZxWf7va8LiGL0pkMSC4rvJ0eEzshGDsX1YaniEjgt65
         QXqY4kLQK0oT5H937w5I+qNa/xk8VWvUhX1ijOvxN9j7cN1Po3c/K8R+awermjwa7a
         gEP5MLdMaQMd46tEuliXRKItGuzR4jrie8hK6xVwdQbdvkIn80+GqPpqsVR0MN2LTi
         BmckXpeEQRPeIJoj3pSNuKK/SO4G3VmvFQgIfl2uFq61bYoY4xUn4TP/pyz9hSD1NX
         hqq/Fg0+eaeAA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 31 May 2022 21:20:42 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Topic: [PATCH v2 0/5] iio: treewide: rearrange iio trig get/register
Thread-Index: AQHYb5ohywOA3ErtcUWaOWHlaX8a+a00WgwAgATKtYA=
Date:   Tue, 31 May 2022 18:20:34 +0000
Message-ID: <20220531182018.gdw67ilmnsav2uyc@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru>
 <20220528181004.286e696d@jic23-huawei>
In-Reply-To: <20220528181004.286e696d@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5105E27705BFF24D886B9C7708ABA9AF@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/31 13:37:00 #19629522
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

I've submitted the patch with runtime WARN() as you suggested:

https://lore.kernel.org/linux-iio/20220531181457.26034-1-ddrokosov@sberdevi=
ces.ru/

On Sat, May 28, 2022 at 06:10:04PM +0100, Jonathan Cameron wrote:
> > If this call order is wrong, the next iio_trigger_put() (from sysfs
> > callback or "delete module" path) will dereference "default" module
> > refcnt, which is incorrect behaviour.
>=20
> Hi Dmitry,
>=20
> Series applied to the fixes-togreg branch of iio.git and marked for stabl=
e.
>=20
> Do you think it's also worth adding a runtime warning in iio_trigger_get(=
)
> on !trig->owner so that we catch any cases of this introduced in the futu=
re?
>=20

--=20
Thank you,
Dmitry=
