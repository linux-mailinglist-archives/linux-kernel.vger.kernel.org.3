Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A714E2DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351062AbiCUQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbiCUQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:24:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB8473B0;
        Mon, 21 Mar 2022 09:23:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z92so17554483ede.13;
        Mon, 21 Mar 2022 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/4JuKt6Htrv6Y67HKlFUIMHCVQWL8KyLTSLvYcPIUw=;
        b=q1M23+fFORM3fKMU/2MqJGgS7+/8nyrSw+OKmyI5QMU1+ah5sjuGa6OL7ec2dzQ6gm
         Jrb/Cf8uaocqsOtu73VUzSGwHkBHQlgS7zhPahdYIQrva1Vs0FwSVWCK1Nih8hQ0QueE
         Oc7qF6Wqvu2SZuYU7uTpSmn61VTulPr6F06hwhqK9CnefGhzpoegfj+KsnGhjin76vSh
         NC2le+5xbVg1VBeyNgGPpj8d8S9s2y5Vol6gq1xQFMEPGMmahZ9Bgp3LKq13YmBGUnAa
         qMVDtkZGdvKiPK4zRU8hT83NmeArLMSNRDqW7vlq7IfYWZtWzRjh9POBl5FxeCKZbrIv
         T4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/4JuKt6Htrv6Y67HKlFUIMHCVQWL8KyLTSLvYcPIUw=;
        b=QmLuQkoJHnGvjkSsxVascLVbCsBIKlwDP46kDyWL8Jrb1qMBG5/cCCnj3/6vkfy5M7
         g1pRwv2Q2lYSnRJxp+WAIE+9QHKaepwhUaPFkEvKZPRh7XrQzDtIQQI6Zr56r0P7G01Z
         ab0XBgKctOOKy27EOM32K6y4euIbdHSBrdpjYGStZvf+5y8XVsVvfm77rX9GLm/LixDV
         e7GC+CtniYyAHUIV5lW5TW4sYWIO1M5XhMAzZuL356wrBiuPHL0VR9SyYTnZvo8M77tV
         dnl/yteakhcZzCWhduwKzmPIjz470vvQ+iHA985R+8DCJz70uRqulu+/rDy9/340ov75
         Ry8g==
X-Gm-Message-State: AOAM530iwx3zbPXYoAfpFaUN+ASkNvU2Ym1a6e0XhWlFSZ5+b9XA81up
        7XGrqUuKbWOgz5BPO7WtpK/4uG7cYYTM7fJobco=
X-Google-Smtp-Source: ABdhPJxwzc3BigPYqKD4Zzf0s40qU6tNqTb9vT3s60CS5vPLg08qhwy9lr6tUohVOm/nnVwuaF2nyeRLDP3g4OTdcqU=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr14049234ede.218.1647879800842; Mon, 21
 Mar 2022 09:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220319162006.13c60c1f@jic23-huawei> <20220319193459.2628876-1-ztong0001@gmail.com>
 <CAHp75Vfk+CQZoz+s5PuSTBb0Nb4KLB+yoNiTCJQ4NktxV1nycQ@mail.gmail.com> <CAA5qM4DE7Qehn2G3bOJfJ7wNfOBA01tzAFOuGZa_O4=6Ocb61g@mail.gmail.com>
In-Reply-To: <CAA5qM4DE7Qehn2G3bOJfJ7wNfOBA01tzAFOuGZa_O4=6Ocb61g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 18:22:10 +0200
Message-ID: <CAHp75VfzWpabLsCDDuifpEDgN+pCnU-agi47iO0exYV29k6nSA@mail.gmail.com>
Subject: Re: [PATCH v2] iio:imu:bmi160: disable regulator in error path
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
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

On Mon, Mar 21, 2022 at 5:53 PM Tong Zhang <ztong0001@gmail.com> wrote:
> On Mon, Mar 21, 2022 at 1:28 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 20, 2022 at 8:44 AM Tong Zhang <ztong0001@gmail.com> wrote:

...

> > Haven't I given you a tag?

> Hi Any, Thank you for reviewing the patch. I appreciate it.
> I thought I would need another tag since this patch is a v2.

It depends on the nature of the changes you made. As far as I read the
code the changes you made are in addition to what I have tagged and I
see nothing that prevents you from keeping the tag.

> Sorry for this back and forth. Have a great one.

NP.

-- 
With Best Regards,
Andy Shevchenko
