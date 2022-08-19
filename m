Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED242599986
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiHSKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:07:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1CDEEF3D;
        Fri, 19 Aug 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1660903645; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryDfhbtuwYy5c1tcol3QoAaRVgMHXbulgS9d5yfa2n8=;
        b=AyDj/vtHJrg0GK0pZAzam8akj3i9uUkn1TYV42yobzb9ve+gR5E0rUoRTqd5PXElNpRFvi
        pVtLmsqz8sfYBiV6AqLbf2iXzzKeYazBTwKu/fqHD8GItAq4w23N7Kbin4XdywM7BUmXBl
        kpitl0lC36Tkswi2CoMT8GbetEW2KY8=
Date:   Fri, 19 Aug 2022 12:07:16 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/4] iio/adc: ingenic: fix channel offsets in buffer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Message-Id: <4GXUGR.SAF00K92YJMF@crapouillou.net>
In-Reply-To: <CAHp75Vd49aCKkK+KvmxJrW2mKk7=VgtSBCTYE9umOhZhc4Y8FA@mail.gmail.com>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-2-contact@artur-rojek.eu>
        <CAHp75Vd49aCKkK+KvmxJrW2mKk7=VgtSBCTYE9umOhZhc4Y8FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Le ven., ao=FBt 19 2022 at 11:12:38 +0300, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu>=20
> wrote:
>>=20
>>  Consumers expect the buffer to only contain enabled channels. While
>>  preparing the buffer, the driver also (incorrectly) inserts empty=20
>> data
>>  for disabled channels, causing the enabled channels to appear at=20
>> wrong
>>  offsets. Fix that.
>=20
> What consumers? Have you tested on all of them? Please, elaborate. It
> might be that some of them have to be fixed. In such case you need to
> report the issue to their respective channels and put the
> corresponding links here.

There are no consumers to fix, only this driver. I believe it  wasn't=20
noticed until now because all consumers were only using channels 0 and=20
1.

Cheers,
-Paul

> P.S. It doesn't mean I'm against the patch.
>=20
> --
> With Best Regards,
> Andy Shevchenko


