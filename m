Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D12599895
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348049AbiHSJOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348015AbiHSJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:14:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A43DBE6;
        Fri, 19 Aug 2022 02:14:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y18so2898617qtv.5;
        Fri, 19 Aug 2022 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VKM8TcTJgGWEjr2El3gvJFe6zfmgEmlCrlb69frx1uI=;
        b=isbPdSYqfliPlROpQuyUVQJ5e+6RWIqhR+PiC4x/6zDfdZNNVhX10kQ5f8fEhG/UUo
         vB7d6vO002zZ7efDLx1mef8eT7/vQMvQI2boxdN9lqCQ5fQ585JPzJ2UFelZpJAmXJAs
         fF35HtNq6uB+nay819J2UJWSmatnjH+boUkR8pl2tH6n9v+D4D9PetdP8RPBVrYKDEuY
         xOEsek496Ri+Ahy3vEpxQg4MT2kDphNXink1qPNesBibDRpL1x5cXXexUozp/PoKgOtZ
         uxgkhlF0m58y+9b44AvTExF3axrvCZmRHj94U4aT/gIHbB+V5nEN80pDFNJLofx9JevG
         kiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VKM8TcTJgGWEjr2El3gvJFe6zfmgEmlCrlb69frx1uI=;
        b=y+GY3iFDNTwMSbjwtSBQ1kIs8xk+IB8SnARar3JcFyGQCs9tKMyNM9bwVsbWcGX47c
         DpLgG2mJ7mHvpJpqOXrnk2f2uh1/U1Zkm0tx9cSpwZRz9juujfaMCm7Yei2gngNZapH0
         qD1ASGWTfG26BLyv+qec5Gw0XdH0RM1hfSrKaA1BbW3aKi3nQuko9ZSETFKBuRiUkUwI
         3CwqlQ5roSIS4CfbBCG/90oogMVsoh6EyKu0Kmej799F9lJOihiOtiaQB9fsB3SIwBgW
         0+ZaXzR4nBXi1rtS3UZniG6eUjWi9eq1lRPypILkLkxM8KlK6xxVPyWlsFYNSiLR0OLy
         jZsw==
X-Gm-Message-State: ACgBeo2QmrdRN/w5zMPSjXUcy3TUNy5C6bAUyKpzOBceh3rrMkdKts2b
        UZMyLXh/eZ4N1s5snCMCbSU6fyymt1K0mva2brI=
X-Google-Smtp-Source: AA6agR5Ihu8MycYundNRVHx2wexqtqdkevIKQSdCM+iIfxrz6lmiGwSQWVsh7JjQjEOT5OX3KL1k2FPHLVxdE7b6bz4=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr4237877qtx.61.1660900449375; Fri, 19
 Aug 2022 02:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
 <20220813071803.4692-2-jagathjog1996@gmail.com> <20220814180451.44a27126@jic23-huawei>
 <CAM+2EuJu3g98NOt2tOxPzWnGO3kvFNkruuAeZBd-=VxYvw7x9Q@mail.gmail.com>
In-Reply-To: <CAM+2EuJu3g98NOt2tOxPzWnGO3kvFNkruuAeZBd-=VxYvw7x9Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:13:33 +0300
Message-ID: <CAHp75VcUb71tGKN8Pg0wy0+7739LzJKvUiN+rMCkQhMKJDpEMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: Add new event type gesture and use direction
 for single and double tap
To:     Jagath Jog J <jagathjog1996@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
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

On Mon, Aug 15, 2022 at 9:33 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> On Sun, Aug 14, 2022 at 10:24 PM Jonathan Cameron <jic23@kernel.org> wrote:

> Sure, I will leave KernelVersion blank in the next series.

You may use 6.1, that way we don't forget about it.

I'm wondering if checkpatch or other tools can validate the ABI descriptions.

-- 
With Best Regards,
Andy Shevchenko
