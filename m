Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A75A87E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiHaVFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiHaVFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:05:00 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99356F72D4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:04:43 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 89B055FD05;
        Thu,  1 Sep 2022 00:04:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661979880;
        bh=HhElJvUhitJ5nxGObCO2CCVplpp0m7vWmHMrypvXYVo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=eUGEVMDm3cm1G+rwNMmJS7QVYT3EMMAZsc8lX5UsXEO+dnIyD9RZ/xAUZVzarjCnI
         AJ4G3Mj3sb8wi5g0ZusonbDdM7amDOynMwlsGbYi+5AV+MKc44fce+YtoyMHEFt69T
         Rv3FOTzrz8jLhJlfnWvG1sTbGVCbHOsIa1MFL1oJe4kOwA5zxMsCo0KF9NqrrCN3yM
         zbgoz+zUCde2wfw+I6i7FnpzRR//C4A7lC5Uv938XGr5PdbbM7+HTLt9UOReQPN0SB
         7a42sPlsijDbQEhyTTI2FiVMwPUUmmgpz12BRalHqKhbQWI6rkI565siArD0ffeksB
         nd0+Mt98VqstQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Sep 2022 00:04:35 +0300 (MSK)
Date:   Thu, 1 Sep 2022 00:04:35 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <kernel@sberdevices.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
Message-ID: <20220831210435.uon3bder7ooeulfd@Rockosov-MBP>
References: <202208290618.wU7mHfOp-lkp@intel.com>
 <20220830110329.00000d18@huawei.com>
 <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
 <20220831002405.m3j5sug2rz7bdz5s@Rockosov-MBP>
 <20220831093810.00006112@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831093810.00006112@huawei.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/31 14:19:00 #20193471
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 09:38:10AM +0100, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 03:24:05 +0300
> Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > Hello Jonathan and Andy,
> > 
> > Sorry for such a late response, a couple of days ago my daughter was born.
> > So I couldn't reach my laptop :)
> 
> Congratulations and good luck! :)

Thank you! :)

> > > > > >> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]  
> > > > >                                               "msa311-%hhx", partid);
> > > > >                                                       ~~~~   ^~~~~~
> > > > >                                                       %x
> > > > >    1 warning generated.  
> > >   
> > > > >    992                msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,  
> > > > >  > 993                                                   "msa311-%hhx", partid);  
> > >   
> > > > I'm thinking intent here was to limit range of what was printed. Maybe better to use
> > > > local u8 variable or cast?
> > > >
> > > > I can fix it up if that's fine with you - or even better send me a patch that fixes
> > > > it however you prefer!  
> > > 
> > > Looking back at what Linus said about those specifiers, I would rather
> > > go with simple %x or %02x.
> > > 
> > > P.S. Surprisingly many C developers don't know the difference between
> > > %hhx and %02x, which is easy to check by
> > > 
> > >   char a = -1;
> > >   printf("%hhx <==> %02x\n", a, a);
> > >   a = 217;
> > >   printf("%hhx <==> %02x\n", a, a);  
> > 
> > Thank you for pointing to Linus answer. I have explored it at the link:
> > 
> > https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> > 
> > Actually, Linus described one exception to this rule, which I have
> > in my patch. I have an integer which I want to print as a char.
> > I see that Linus mentions it's a bad idea. I agree with that. But
> > currently %hhx => %02x replacement breaks the requested behavior, %02x
> > will not shrink integer value to char. I want to say, maybe it's better
> > just cast the value to u8 type and print as %x. What do you think? I can
> > prepare such a patch.
> > 
> > P.S. Andy's example to show the difference between %hhx and %02x makes
> > more clear why such a replacement is not acceptable here.
> > 
> > Output:
> > ff <==> ffffffff
> > d9 <==> ffffffd9
> > 
> In this case the storage is an unsigned int, not an unsigned char.
> Hence the value will be small and positive.  So I'm fairly sure you
> won't hit the above because it's
> 
> 0x000000ff --> ff
> 0x000000d9 --> d9
> 
> The range is limited to 8 bits because that's all the underlying register
> holds.

From "data" format point of view you are right. We have regmap over I2C
and register values will be limited to 8 bits only. But in general
unsigned int value bigger than 0xff formatted by %02x will not be
limited by two positions only. In other words, we can use a simple %x
with the same success.
I want to say if our goal is shrinking the unsigned int value to first
byte in hex format w/o %hhx using, we need to cast unsigned int value to
unsigned char and printout it using simple %x or %02x.

For example, in my opinion, in the below code snippet, only first and
third printout formatting are correct. Currently, we are using the
second in the merged patchset.

>>>
    unsigned int a = 0xDEADBEEF;
    printf("%hhx <==> %02x (uint8_t:%02x)\n", a, a, (unsigned char)a);
<<<
Output:
ef <==> deadbeef (uint8_t:ef)
===

Anyway, regmap over I2C abstraction limits our value to the 8-bit range,
so functionally %02x is working well here.

-- 
Thank you,
Dmitry
