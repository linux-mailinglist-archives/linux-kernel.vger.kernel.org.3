Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A957B68E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiGTMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiGTMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:35:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2679140DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:35:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id os14so32832642ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgbjDJxnlsoUvGqV3p0oq3wEGrVhwZfOQ07rixfBDyc=;
        b=1EihxAR75uhhs1ZJzkLW6uPWyzjo+D4w/IX+hrrqPW1UvrLuGlCy+T4s8D45WUAH+d
         y//V4H6j+WTcasvfNN5IJPqoQBmfGspRSqOxymhx+JOe3NqD5WM2PqJgcRVRYryXrqiH
         x+yNbDrvnc0xfR6zaThLzILzBR0N/7RjT8PTWRpx+IN+mRcCzoeISWeVfgUO4SdcX0R4
         S4qHDqIUCsQIiC4diVDCFQiUA54xQbam8k7HDl36rhrxitH0nEPhdJTmmd6rFAdN0+Yy
         28QCqeZ/JJO1KtvztG2d3OwbwWEjiZ6sGehpgb5TMBeImgC85+KDBhwXt9x6aQQB36nM
         Eh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgbjDJxnlsoUvGqV3p0oq3wEGrVhwZfOQ07rixfBDyc=;
        b=7flX3Fmc/YcwU2Bx0YrVnIrstzj20J3+s7WjQKufqr3pPMLPkTvoI1x3WrqkcVKnGu
         eCzS8FRZGyIsm88U2pqFk6sfHJzD0pAZf6s8lhZA74Y9LMnh/A60WSAn88bf2C8ruz3B
         Efb/uMlsklaEuMBpVEeo09jlu0H1WocWisWrbUVeJiwYrb1R7O0TNp3i/QfueZCMgv5t
         KLol8vankG3XEd4pR+bmR4htlkVvjUenUCIP93S0OaVZS0a+szQ3QXmpC8TuQHyd7JGK
         ZGV1IC6MRWZNpYyR0x+pbh4W6VjA7Ju5mbOKRewvaHI/qbzsly4X85yQM483o4DxGDXb
         OwrA==
X-Gm-Message-State: AJIora8CMDbx+Wk3BBBaLgYOoWqKrSe48R3ZhS55GfB+qM2Ju8WZI2AE
        re6bnYWJfoZ6ZvTw/LFO8Ix6qzdqgVFQUUHOki1Alw==
X-Google-Smtp-Source: AGRyM1uhG4kCz0NJGlM2u+GQzufPCyNBBSU8Ghb0Zc+6Mta8PYJAw1xofFomiD6DS01G9Uyl4T6d+pzS+gPGTjlRoF0=
X-Received: by 2002:a17:907:1b16:b0:72b:8c16:dac0 with SMTP id
 mp22-20020a1709071b1600b0072b8c16dac0mr34200884ejc.286.1658320548402; Wed, 20
 Jul 2022 05:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220719110601.136474-1-warthog618@gmail.com>
In-Reply-To: <20220719110601.136474-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Jul 2022 14:35:37 +0200
Message-ID: <CAMRc=McwEsmDw2SGfbf8EKm-sHpQCVoPcNj8QMuuAf-P59utnQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: fix include path to kernel headers for
 out of tree builds
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 1:06 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> When building selftests out of the kernel tree the gpio.h the include
> path is incorrect and the build falls back to the system includes
> which may be outdated.
>
> Add the KHDR_INCLUDES to the CFLAGS to include the gpio.h from the
> build tree.
>
> Fixes: 4f4d0af7b2d9 ("selftests: gpio: restore CFLAGS options")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> The test bot suggested
> 4f4d0af7b2d9 ("selftests: gpio: restore CFLAGS options")
> as the commit to be fixed, but the previous fix which turned out to be
> incomplete seems more appropriate.
>
>  tools/testing/selftests/gpio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> index 71b306602368..616ed4019655 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -3,6 +3,6 @@
>  TEST_PROGS := gpio-mockup.sh gpio-sim.sh
>  TEST_FILES := gpio-mockup-sysfs.sh
>  TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
> -CFLAGS += -O2 -g -Wall -I../../../../usr/include/
> +CFLAGS += -O2 -g -Wall -I../../../../usr/include/ $(KHDR_INCLUDES)
>
>  include ../lib.mk
> --
> 2.37.1
>

Queued for fixes, thanks!

Bart
