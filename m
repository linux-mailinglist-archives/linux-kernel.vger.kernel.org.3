Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0037518576
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiECNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiECNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:33:53 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE15626A;
        Tue,  3 May 2022 06:30:20 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id w124so16385399vsb.8;
        Tue, 03 May 2022 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=D8VyT06Rmhow6nbFzDb81J943Raqjv8J7lLe+yncDm4=;
        b=gZAKUayce+qo5ZZ2PTDNYyJ+rUuXBth60avc8uyVP0lE4tCmGqhmWk5hsakg7oIH/w
         KYAxGeW0HMNrNbI3OprC2ZJ557ZwJlp1NoEKO6xJpygSfZrrWOxg9hZxC0st8iDAaa59
         47IYZWhm7G8XfmZH2htd7f5B0aT99SO8SNEJKuhxTBZKlO3OLdKtPoGwozSqvwlwMqni
         OvBSKiwhSdPQiqCVuNMDxxJgFGkJLybgQS+pYLcGnKwb2abGxitThjOPdDjbkEUuvprl
         ZcOkvxFhyvoEellXdHu/w4H7+QL1rkZapBb1t2cDQxTbPiUyecL3MTSC9pGalv8Jk1EH
         G6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=D8VyT06Rmhow6nbFzDb81J943Raqjv8J7lLe+yncDm4=;
        b=iM58MvNFrFcXVzGtmvdVm+WK3OP/noZ0S7HDewAweLktDMXzuUvMsuJSrkyyw7ZNNL
         Z/Usn0pCSwDI+jfYKB2XkqGbmlovHr+mrHMuUUkle3Zh5fOGZzYjD/PBBVWWwtSbKdMC
         ghVR1SYg4Hccc656lqczYOPPODg3cvJNk1BpmIbuZjMYEnT4ysgUYVIIZs5gUJqFvZqF
         HpvSGbDq2IhdGIiGe9rON6ACR7g/b78KmRcNYBU4UlXxcDxSg9g2tcP9htDQPf8tAfO2
         cnZH6NVzZ+PiFrg65fMV/uXOSAqwL3kDUfP3z8JekCR4uW5zeeaXUPdKNKIsxV6nUz0w
         wGdA==
X-Gm-Message-State: AOAM531oxZHmj+RfYWslP/I7CLnLO9LZ7BkLlUdpgrQbR4FyauEOntqJ
        0Ocsy62pCNwLwyIunO5yPJPoTCpjQ+4lX/HG6lE=
X-Google-Smtp-Source: ABdhPJzeaWMse/IxQ+MHYh8nFLU2d4sGaE6/ZeHGS7WgnAJWxByPgyh6KKkPLo96ZFJmpYy6Pp4QvQ15GSaCa3p+UjI=
X-Received: by 2002:a05:6102:153:b0:32c:fe5a:3d3a with SMTP id
 a19-20020a056102015300b0032cfe5a3d3amr4838407vsr.55.1651584619831; Tue, 03
 May 2022 06:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-13-andrea.merello@gmail.com>
 <202204271554.EiuIRNPI-lkp@intel.com> <CAHp75Vc34K=5U=kMCqtDm_h3VBmqyCqcWr0em+8fZBiM2n76rA@mail.gmail.com>
 <CAN8YU5OeYjf5pikMuLXyaYTO1bsArdFOQf3M6tYMNubeZxqe7A@mail.gmail.com>
In-Reply-To: <CAN8YU5OeYjf5pikMuLXyaYTO1bsArdFOQf3M6tYMNubeZxqe7A@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 3 May 2022 15:30:08 +0200
Message-ID: <CAN8YU5PNUn9oVz9dRZ7BLzZmqfNpTehJp284ou+Y7-e4XgK7_Q@mail.gmail.com>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
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

Il giorno mar 3 mag 2022 alle ore 09:48 Andrea Merello
<andrea.merello@gmail.com> ha scritto:

[...]

> > You need to add a C-file with the only line
> >
> > #include <..._trace.h>
> >
> > And drop that include from the _core.c.
>
> Hum, I'm a bit confused here: the bno055_ser_core.c file explicitly
> looks for that tracepoints (e.g. it calls trace_send_chunks() and
> friends); dropping the include prevents build here because there would
> be no definition for those tracepoints.
>
> There is already a C file bno055_ser_trace.c that just contains the
> said include and it defines CREATE_TRACE_POINTS; I see other drivers
> like dwc3 do the same..

Oops.. it turned out that I just had this almost-empty C file as
untracked in my git tree, and it ended up not being included in
patches also. Being it laying in my src tree caused the build to
succeed.

I have been misled by the other problem I (still) have (below); I was
focused on the wrong thing, sorry.

> But my problem is that I cannot reproduce the issue found by the bot:
> the compiler that is downloaded by the script doesn't run on my build
> box because it wants a newer libc (I was hoping that those compilers
> were statically linked, but they aren't), while any other attempt I
> did with other older compilers resulted in either successful build or
> failed with other weird, apparently unrelated, errors about relocation
> issues (of course I tried with the arch and config used by the build
> bot).
>
> Is there any build farm publicly available or something like that?
>
> > --
> > With Best Regards,
> > Andy Shevchenko
