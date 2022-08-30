Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D325A63CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiH3MqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiH3Mpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:45:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA771729
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:45:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so8361855qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mjE/xAmjy9vxfmw5GBlVvKmhsej8si9kPE9vjVE12v8=;
        b=DLo46a2iWTmz9Ets1bGcCAD0mrOEcC3NEJG7PesZjfN6m4Ku0cYMRaA28/5h/R2R+c
         5OlY6oSY/ASo0bc+Mp1iPM6KhfIOdgWjfXEx5PH+RHCQoLU3L809fpMWffuQcOroLjwG
         Y18nLfOFlAs65bHo7sDqkZNYFZ6cZBoVMKUD7CJqXR9ch3ioVIwa1lnuIrAlEkCPM4LV
         fHQ6x3rbrPp4c9mSV9ocxh9ykB+a+UzRZ09FuVr6vsyzSJmZYv4O+ju3HlscgLer6HqG
         29nJxIAduBJURu6mts76NHhooSBTXoogwnWWYg9ICodZaFf6dHy2nCzKHjG9hZ4q+oar
         y0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mjE/xAmjy9vxfmw5GBlVvKmhsej8si9kPE9vjVE12v8=;
        b=Jcjau/GkTqaOK5ZijT17vMP9B8MNKHjDEN7KrX6QgfJLpogzsrpKjUeFUrqjyKFfXh
         YKbAQDJPPRcqGoFpt7SufMSTiC0He5zWm/d2DYW0NPpAwCa2YcLxGkYTO+9WOMtziFaE
         ZxFdVIIbw/xpDrd6r1TP5nEBU7KGGviC+lCJ/VCjw9Mbx0Ln78wF87HAEMlRrJxkHTss
         ED1J3aWZWJwSpo6iQNm7llRnNunWyfAOmAVr2bjtUVEm4NEpp1EfualD1XWbzcQ5m2iO
         4nOCm4+uXghlGRJwVFfQ9d8psncgV1D0aQG9vjpO5BtekOM6DoETnd76iMCpqzV5ofm0
         ZeUw==
X-Gm-Message-State: ACgBeo3jkLGXEl0DEfPbOmy/7dZ0E7wmoiyLrqan74f8wrg2/QBur/IP
        za66WU8C/3sc3BpgAq7sflpP8p+qOlChWQY5kTSGSkDapAAR+A==
X-Google-Smtp-Source: AA6agR4OjmhM5kcJ5ADJGPx2SAbWHITyh+GFtjTEqgs86DnKRnVWMtDTIf5HPe/hUUF7QEwmllQx/EqVKJ/D6GhCUP8=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr14455485qtx.481.1661863548012; Tue, 30
 Aug 2022 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <202208290618.wU7mHfOp-lkp@intel.com> <20220830110329.00000d18@huawei.com>
In-Reply-To: <20220830110329.00000d18@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 15:45:12 +0300
Message-ID: <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
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

On Tue, Aug 30, 2022 at 1:03 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 29 Aug 2022 06:25:53 +0800
> kernel test robot <lkp@intel.com> wrote:

...

> > >> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]
> >                                               "msa311-%hhx", partid);
> >                                                       ~~~~   ^~~~~~
> >                                                       %x
> >    1 warning generated.

> >    992                msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,
> >  > 993                                                   "msa311-%hhx", partid);

> I'm thinking intent here was to limit range of what was printed. Maybe better to use
> local u8 variable or cast?
>
> I can fix it up if that's fine with you - or even better send me a patch that fixes
> it however you prefer!

Looking back at what Linus said about those specifiers, I would rather
go with simple %x or %02x.

P.S. Surprisingly many C developers don't know the difference between
%hhx and %02x, which is easy to check by

  char a = -1;
  printf("%hhx <==> %02x\n", a, a);
  a = 217;
  printf("%hhx <==> %02x\n", a, a);

-- 
With Best Regards,
Andy Shevchenko
