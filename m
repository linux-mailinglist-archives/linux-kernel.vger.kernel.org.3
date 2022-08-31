Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481785A725F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiHaAY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiHaAYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:24:24 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109C9D8FD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:24:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D6EB65FD04;
        Wed, 31 Aug 2022 03:24:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661905454;
        bh=4fl4RLZ+WkBNNFnhafSFpNfg0CMeWHUQue3HBc22HT4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=SiK5jM35SGwe9LUWazXDkqKx1TpUnpq+JpPXpWktGTZSJsEeUxmKO2os9FEIklp64
         klMIHk5ERntS7nxgDxzgCmatKk+ZIVYtjy9vHyJ87FJ1NZD9vL6qB5TW+pqPCA/VAh
         pNpVAxS+76z+VyDWXNnKYVCKs7W9u+pBsIG7jvl/glfaP+64NjXHvHnOl5+AI11yuE
         QtrtEbTGhCBNfmXkm5Z8aj+yKvsAstkpWO0ZO4jH28QU3HTrwj1XQzn/AjBA47wXqV
         k5VgpQ958LHfaPFB/SMVbuyZVivZ01C5KiOdPkwjZSIHsrzvKOoWKIANGDxLwsvhfm
         XG+Z6SNfK8EWQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 31 Aug 2022 03:24:06 +0300 (MSK)
Date:   Wed, 31 Aug 2022 03:24:05 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
Message-ID: <20220831002405.m3j5sug2rz7bdz5s@Rockosov-MBP>
References: <202208290618.wU7mHfOp-lkp@intel.com>
 <20220830110329.00000d18@huawei.com>
 <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/30 20:46:00 #20189978
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and Andy,

Sorry for such a late response, a couple of days ago my daughter was born.
So I couldn't reach my laptop :)

Please find my thoughts below.

> > > >> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]
> > >                                               "msa311-%hhx", partid);
> > >                                                       ~~~~   ^~~~~~
> > >                                                       %x
> > >    1 warning generated.
> 
> > >    992                msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,
> > >  > 993                                                   "msa311-%hhx", partid);
> 
> > I'm thinking intent here was to limit range of what was printed. Maybe better to use
> > local u8 variable or cast?
> >
> > I can fix it up if that's fine with you - or even better send me a patch that fixes
> > it however you prefer!
> 
> Looking back at what Linus said about those specifiers, I would rather
> go with simple %x or %02x.
> 
> P.S. Surprisingly many C developers don't know the difference between
> %hhx and %02x, which is easy to check by
> 
>   char a = -1;
>   printf("%hhx <==> %02x\n", a, a);
>   a = 217;
>   printf("%hhx <==> %02x\n", a, a);

Thank you for pointing to Linus answer. I have explored it at the link:

https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

Actually, Linus described one exception to this rule, which I have
in my patch. I have an integer which I want to print as a char.
I see that Linus mentions it's a bad idea. I agree with that. But
currently %hhx => %02x replacement breaks the requested behavior, %02x
will not shrink integer value to char. I want to say, maybe it's better
just cast the value to u8 type and print as %x. What do you think? I can
prepare such a patch.

P.S. Andy's example to show the difference between %hhx and %02x makes
more clear why such a replacement is not acceptable here.

Output:
ff <==> ffffffff
d9 <==> ffffffd9

-- 
Thank you,
Dmitry
