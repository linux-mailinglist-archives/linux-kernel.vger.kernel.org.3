Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54337516C99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383948AbiEBI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiEBI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:57:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868C57B3B;
        Mon,  2 May 2022 01:53:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l18so26491206ejc.7;
        Mon, 02 May 2022 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8f/RfJ0v8ZoOWgcBYBXtS3wQ6ngQII+9nlVhwMqWD5M=;
        b=LNnY4gKk4Q363NTaO3jxTzc4eW8JA4GIto43Z6wAA1H3SfTYWYy9VSM2v/UAhjqLU3
         MoXn+ZCgNSWpD4MrZ4P1q0HuLNEZ/EiJDqBts1/fEE8nFOFkMw5NuSyF6/YCoJbcgiLK
         CxPYY7z0nN3tsA0KjhLu8jHcVGNnEGDu2T6G2cEU3bgawSCVIfKHsbfTFSOm+yuvr92M
         L6JiEkrCdi3NxKeBxLYC6RovPthN6hKBzKOZnb9/aRT/4U5cVp51gora4K9mRWx2Rb0/
         bn2D8Dbw1B8gmU2tCCJwEpMPBBb6n9EoCZmbxWs0o3eQvQE6pB9X0YSHdM6V9YVFHQZm
         0FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8f/RfJ0v8ZoOWgcBYBXtS3wQ6ngQII+9nlVhwMqWD5M=;
        b=5pbhFbLmsQ5h4EA9ns53KFhZBf4jiYnrBiB+P58UPkoDdEcgZpMAei5fQSUONepOQS
         D7zEBIjXeQBHGxJxACyfGtJL2mQNYKI7JCGWLlsYadnSK1Ss2W/WrZwiSNj7i1Xjygkr
         e/PHLJ+TVyQWutqiTl4PfblGCKyxO/PJKj9dqZ4d3mnNalQuSq53oA+bike284oFCvDl
         4fGinZxI5Zk0ioU+EMpktT7Aqe5B43s7m5behoMtkz9wa0VgbFiCLdgWuwoVApe055bx
         0aYQMO55j2Qm+kAzvtUP7mWo2zNYAcZGzRTVrGbRO1b6VM0LUv0t9I62V+JLCk9ijUMy
         ulkg==
X-Gm-Message-State: AOAM533aaTeWseIu/HbmVc2avxflgTwd7K5bMaqNGjifwyjek/IAS3GE
        TB4mUMEmt9N/MGozg7DQjRfRKB+kguB6YqzyIHc=
X-Google-Smtp-Source: ABdhPJwSEsaWJFk+5cjSPEVdnT3l9iqAnSc+JSYqIp7XaRy1pEG71+44Yfs6JDk6phWkSauHRXjMTGIJ7Qy5f1DFv14=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr10330881ejc.132.1651481615508; Mon, 02
 May 2022 01:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
 <20220501180303.75a0d0a5@jic23-huawei> <CAN8YU5PYkQhqrGP8qUK6BgVWVWWECQvYGrSiREU7P5r4kFxVjA@mail.gmail.com>
 <CAHp75VcFZYyU0ap8WSBCTTpsUtDmC6TqURLOpAOKxYNtbLHAOg@mail.gmail.com> <CAN8YU5Peo8vi0MUqP2hSkKFyO=uAxx_Ad3aXRKBr3zzncS8RPQ@mail.gmail.com>
In-Reply-To: <CAN8YU5Peo8vi0MUqP2hSkKFyO=uAxx_Ad3aXRKBr3zzncS8RPQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 May 2022 10:52:59 +0200
Message-ID: <CAHp75VeRV-Nv_zw6Qe9huXzqi14GJhWxQEpbbejn0z33zPYKtg@mail.gmail.com>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Mon, May 2, 2022 at 10:31 AM Andrea Merello <andrea.merello@gmail.com> wrote:
> Il giorno lun 2 mag 2022 alle ore 09:48 Andy Shevchenko
> <andy.shevchenko@gmail.com> ha scritto:

...

> > > BTW I have also gone through some kernel-robot reports; they also
> > > state "If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>". I'd say that it would
> > > be OK to add this tag to a patch that just fixes what is reported, but
> > > I'm unsure whether it is appropriate to add this tag to the patches in
> > > my series, because they add the code and the fix at once. Any advice
> > > here?
> >
> > For this we specifically amended the kernel documentation recently.
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> >
> > "The tag is intended for bugs; please do not use it to credit feature requests."
>
> Well, no any feature request to credit here; a bug and its fix are
> involved. Sounds more like a "yes" so far.. But it wouldn't be clear
> what the robot did report indeed (squashed bugs and fixes).. Maybe a
> "thank" in the cover letter also to it would suffice?

The reported from bots should be used when your patches.changes
induced by those reports, it seems otherwise in your case.,


-- 
With Best Regards,
Andy Shevchenko
