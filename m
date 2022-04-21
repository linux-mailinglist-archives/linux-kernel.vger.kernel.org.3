Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109350A192
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388744AbiDUOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387503AbiDUOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:32 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD6D46;
        Thu, 21 Apr 2022 07:07:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 40C4D5FD06;
        Thu, 21 Apr 2022 17:07:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650550059;
        bh=UW8njT/+eAAp0sqLL0d7+8NXB7FUyb5NlKr0b71Bps4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NN9p/nyyjo8j0Z2AwA1v2VXhTKkQw8NJ1PtMaib41PB1yPCJvhB5kFJS6TuWUdVXR
         PdDPqRPykJhxGsajzOaoP6VTuq4H7M5T6n2HeRwjETjZFJrYVe+BI/rFNqUi/4USgf
         YcotEt7RUMK5LghRkQgYyObCI+NCYJ3LZaNQGYAgYm+T1HpaLtPTKFtpACzj2PeDWT
         rWjnTIxUgxCsEGrYLL5MPPN9TSkkm7KJp4NcLooYs49YEuxJJBINmOurmp4xr9iyEf
         t+rqnVWNJ8Bs60qYv3CqHlUaOcDM1a9Rh3bzlwqaoSA7i9xu0NrsImvykw9fEyAyi7
         4ocRgLIF+nR7A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 21 Apr 2022 17:07:36 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYVASOybrxT0DjfUWoYWuGUlWOX6z4b44AgAHIYAA=
Date:   Thu, 21 Apr 2022 14:07:29 +0000
Message-ID: <20220421140726.lavjqighkbnxawsd@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-3-ddrokosov@sberdevices.ru>
 <20220420115400.00005c48@Huawei.com>
In-Reply-To: <20220420115400.00005c48@Huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6CC07717222CA41BF369D53716C09DA@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/21 06:36:00 #19322218
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Wed, Apr 20, 2022 at 11:54:00AM +0100, Jonathan Cameron wrote:
> On Tue, 19 Apr 2022 15:45:55 +0000
> Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:
>=20
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamical user selectable ful=
l
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
> > with output data rates from 1Hz to 1000Hz.
> >=20
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >=20
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >=20
>=20
> Forgot to mention. Please add a Datasheet: tag to this patch as it's
> the one introducing the actual driver.
>=20

Sure, I'll make this change for the v2 then.

> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

--=20
Thank you,
Dmitry=
