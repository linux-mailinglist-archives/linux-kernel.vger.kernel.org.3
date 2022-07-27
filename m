Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EDE5825F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiG0L50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0L5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:57:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579E220F5;
        Wed, 27 Jul 2022 04:57:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ss3so30942561ejc.11;
        Wed, 27 Jul 2022 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsR1NbtCOfGFjl+nMv6v9h4NJWTfkBQzKivKQal2j2E=;
        b=mQVSfdLHWYUblUnK8BsYXLvJVy3sqn9fy2+L+B8NU9mG3W7/DjISMH/cGJP7eWDaeV
         8L0EFisFjN83a68WElHJBqoQx5s/XXX2xl2U1/qts4tbEF3NbyL9ZCthAtFzdyHj68/f
         M0fSVu34uiEpiyYl2Jj/xWf5Km4e+samelQfGDyj0PkK0vlr4HOXlNc447lhN7YjBsV4
         0/OypfAp+PkooftCqk6doXMfsf941AoYlaMGhh58AuCobbAzYNZClaLd7B+dF1nyCejP
         8uo/OHJsxV36f8gFMc29PUPtvIH+2SVROaS9hAHCQo5OIjiXKK/Y9X4lAyU1PBpPaABt
         wLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsR1NbtCOfGFjl+nMv6v9h4NJWTfkBQzKivKQal2j2E=;
        b=O3Ybt2EpIZFx4amqVns5zfSmCy2KO9//wyTxAQiTuwC5cQJcTWDItnUwpgptFxBY0v
         GBlLTaRGP2QgpFPGHHrsCTFZevNK3wsdyhEbKBPSwg2iRasiMQVqDlo65sYTkQrxgNAQ
         xH7dHhnp2Ftqsjs9ETOZ4NqhV/JGLSIu4b3O5aQ4vl7OLH4AhyHJvp4l2/brlIGB9yRW
         rDto6+uYmMRJr4VplgS6+XsK0dt/FJgi5OihBxViVCh41wnTcWMxNN+2iivFLFDLzZa1
         /cr0T12FEQ4C/Jqeug4iWT+J92sHSy/sQMKW4fdt6EsoPLSfPxkZX3DRve8bg/TROE5E
         HeAw==
X-Gm-Message-State: AJIora94zWoGailxvC+fRPi9WfGv21MBCd3YULZKmRUGp5W6SHcGKuIL
        pTRlITywVnJT63tZ0SsK8LIvmsgW9pOjjQoAw6ayWtcf+b0=
X-Google-Smtp-Source: AGRyM1sdLplCsQl9Ma9p5xBO6+5UU4uo2krFGJ9mKpb/8WAtT7A6dol8UklHKfZVBrZ9SGXLgt/sGYpmxmfyq2zoURs=
X-Received: by 2002:a17:906:7950:b0:72f:d4a4:564d with SMTP id
 l16-20020a170906795000b0072fd4a4564dmr12008984ejo.479.1658923040776; Wed, 27
 Jul 2022 04:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064415.940690-1-potin.lai.pt@gmail.com>
 <CAHp75VfNmq12Yv7mqVeijqK0vwRdPsSrH5wMzg9qR15+t7ArSQ@mail.gmail.com> <a385e266-b24e-7ffb-c083-891edd4b0b14@gmail.com>
In-Reply-To: <a385e266-b24e-7ffb-c083-891edd4b0b14@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 13:56:43 +0200
Message-ID: <CAHp75VdjvJRwzPLLdMji+_m2tQY4JLBcNwt-QFkDJTyGFUOdKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: humidity: hdc100x: add manufacturer and
 device ID cehck
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 12:42 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
> On 7/27/22 18:00, Andy Shevchenko wrote:
> > On Wed, Jul 27, 2022 at 8:46 AM Potin Lai <potin.lai.pt@gmail.com> wrote:

...

> >> +       data = device_get_match_data(&client->dev);
> >> +       if (data) {
> > This check is redundant. Too much protective programming. Just oblige
> > that matched ID has to always have an associated data.
> Is it guaranteed that device_get_match_data will not return NULL? I find some examples in other drivers, all of them have a check on returned data.

No, but as I said you may guarantee that by obliging developers not to
shoot in their feet.

> Will it be more appropriate if I move device_get_match_data to probe function, and return EINVAL when we get a NULL pointer from device_get_match_data?

Why is this check needed? We do not like dead code.

> >> +               if (!data->support_mfr_check)
> >> +                       return true;
> >> +       }

-- 
With Best Regards,
Andy Shevchenko
