Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE55AE882
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiIFMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiIFMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:37:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D82408D;
        Tue,  6 Sep 2022 05:37:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j1so8165776qvv.8;
        Tue, 06 Sep 2022 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xpQtocT5Zisw3O9+aeFWboKbjJDP0EWoNrPcWVo7piw=;
        b=YVI/aM+ELJNZDNwkFkIDb1ee3t0OHhCnXR19746BpxdKzbjfIyXfdR9WYP/xCTgvY6
         +f+lwJ6Uvkuaqh7l28Cyeh0aYnAwg2KBoS4KQ72O4mNZtzp/OZKLOzHys1PbPobd4DdZ
         +Sz81M+K/nAN93Ubh6+yydU/4pDEavsPoolCdSzOVWm4Dp53XOGbnAf9FSN1B8bbVhPO
         KizOsX0A0CPXnbpzEGjNYuehR9KUg71pwlD5MzXTIu5PmmpKNr3MxY4FxJ3cgN+gmAL2
         ksntbEcfFMe7kVAz+d45nYoHd5I73gSBLEn+eJcRQuQqxqpWSQLOpF85FeGZGkxfusW6
         2/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xpQtocT5Zisw3O9+aeFWboKbjJDP0EWoNrPcWVo7piw=;
        b=olDI6QZ1xNpRHRZSEeBw4izPa6HhdrltSVY/LYeOqrcvoieKzOh6DgcCdt4mYNRaMh
         RVX116Wm++zN0qi+UDUfq/2xFOiSHdITeRx11Hm5XwZS5+hQAyjb6lUsnow/nt//s/ZT
         N4+joD/cXK5k6vtRQviLn6zbI0c8/nlxIKNk1xawq9uioRLLthFWA6mTbfbn3mQtw0ZD
         ZIEO8MJGPhizX6xeGmWe7Xk+kL3fUxAWOCIKMzJacUb1ks4+r7l2HdWdSDMvPU7fbI2O
         8NsrzDLih2y+2AfTLT8fgROZqmf9/U7WX9ve6TSjSamYTW67OqAFp5rcFYP4ZUr1n1qU
         P9NQ==
X-Gm-Message-State: ACgBeo0ih9keBaCuXC3wNuigoCd0dNc5Jb6ZgCHdT96Pe90iw62ECA9V
        Y9D+M9AV3Hgw7LMwviOScCDSSDqLg65jiCnpKRZTlLyoC+OEOg==
X-Google-Smtp-Source: AA6agR5xg7xsGW4UZ7tl+m6D3eixtJ14kZjmmZ8LYgKwueY9tqDc8gWdClFu2ozn1PkQGJx3BYbrRXBW8DnqZkE2q94=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr25835843qvr.97.1662467830452; Tue, 06
 Sep 2022 05:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com> <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
In-Reply-To: <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 15:36:34 +0300
Message-ID: <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Sep 6, 2022 at 1:52 PM Crt Mori <cmo@melexis.com> wrote:
> On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > Very good and documented code, thanks!
> > I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> > (due to pm_ptr() usage).
> > Otherwise, with some nitpicks that wouldn't prevent a green light,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> I checked DEFINE_.*_PM_OPS usage around drivers and you either have
> SIMPLE (where you define suspend/resume) or you have RUNTIME (for
> runtime suspend/resume), but never are those two together. So I am a
> bit puzzled how to get this working.

The one which suits here is called _DEFINE_DEV_PM_OPS(). But it's
basically the same what you put here with the possible unused case.

-- 
With Best Regards,
Andy Shevchenko
