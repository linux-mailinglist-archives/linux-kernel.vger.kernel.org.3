Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AF5A63F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH3Mvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH3Mvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:51:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16AFBA7F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a15so8272086qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PpqfiNqNN/v5riSi++yk8rU9hwXl2SDNhJUenWsoXaE=;
        b=NFXeVzjXZKNKv6uOvgSArxATA39WpGM/i+P+jv7OCZJJ4TkwgxlfNbJmVEVo5ZXCFn
         0CC7+XRqZ1EBEJDfqmcMMCCLDk9cHU3ZMr29YiPvar/VfBwycOJBk44Ojx9fPV+e6Of0
         3cCcCxuhio+PScyKl9Ia8rhf6tWg3ulIGJhV6h6MLAi4uyLxOTlzwz/0Y9XtzCW9zAvu
         SuiY+Rcx0nbFXEe4A8nvXZX8eAwblRvEvH7P9bqcO6UP9xbjdtaJ0urtJ+Fls3o93gz0
         EC13owlkOf5sYUf5qbmSVrMZad+TsOw0sUH6bGXg50QdT+MwM4J1ele2P+quGgWsXIx9
         yfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PpqfiNqNN/v5riSi++yk8rU9hwXl2SDNhJUenWsoXaE=;
        b=qXsoTjZkV94rjyhJkyKY3fi264++3hBBuDMnXpQe2VnAyQ6Ga6NeJCvYUI45P5AgTW
         srcJh0zoPaefiDKHmFNoXQZAPUb8qcGWWJ1Vn1oWdEyh+ABX8JKTgZvO4dHCXzjb4tFl
         tKlRAbfugT8zdhC9ec8yl0F7f971TOiwqUMMDcgttpx8a1aTTxAVMDvbDzAUVsABzmlm
         Jsu/V8mfVFcYBcRWrGHQd3Xv1ebg1z5CYbCMkYqhk+ulIzVX0/g3tlllRoj5GheKAtvJ
         WjTARbDytdTZUna47SYHevGem/uqZgPi3Kmv0kkxwjJI+WYoJdHYmnrrDsGut/jjT1x4
         Rj0A==
X-Gm-Message-State: ACgBeo3puIuaaRyOV5EACq7YIknQEcG7xpKOJSRRXSXaDDmBZzKhUG7+
        /IuCVRAkTBleC+9d7E3ilvlGP3gEV3/zI0tksfbiAo4nNng=
X-Google-Smtp-Source: AA6agR5MRDg0uXFkiu9jiPXUdGAiYPIRrWu1u3iavC/ytYH+BiJYu4tRF4tMPknyct0Hh7oH38fJSzX1z7Q8XaOsij8=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr11696681qko.383.1661863899956; Tue, 30
 Aug 2022 05:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <202208290618.wU7mHfOp-lkp@intel.com> <20220830110329.00000d18@huawei.com>
 <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
In-Reply-To: <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 15:51:04 +0300
Message-ID: <CAHp75Vc_Jz+APmJ7tQgYGbk-LrNebR26f9YzDc-Lvib-weAESg@mail.gmail.com>
Subject: Re: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kernel test robot <lkp@intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 30, 2022 at 1:03 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 29 Aug 2022 06:25:53 +0800
> > kernel test robot <lkp@intel.com> wrote:
>
> ...
>
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

And additional part

    unsigned int b = 7, c = 1027;
    printf("%02x(b) %02x(c)\n", b, c);


-- 
With Best Regards,
Andy Shevchenko
