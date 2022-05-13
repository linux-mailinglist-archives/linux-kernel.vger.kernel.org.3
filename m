Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DE526ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383968AbiEMT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346904AbiEMT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:58:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23093F136B;
        Fri, 13 May 2022 12:58:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f16645872fso101088917b3.4;
        Fri, 13 May 2022 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pW4fIO1zU8hH5UZQ21Ux1LqBB1/44eCl6uSeUwAZ5aM=;
        b=ffKMHRTsZAboB6znpNNJk4ZBl4MZCa/2C4jy3u9at1auqT2Nmm6gNWVfsrLZtTjLUM
         4yVOBJ2Je5sjAFPGP3k8ardglwbqhLXAFhrKR93rOQiORqDG5NMvFvL6GgXNkK5StyNb
         deBmsqJpn5Hj8FeSqbIvf+4YGvtHUe1Do1OYqCyVB1BDkG8laFMHl2DeQeq+r+ivfn5d
         MVyK1XJthRCKigc+YZtjq8+MlQ3e4zAAmPDPp9saM9hDgEeynjuUp7hzgpdsQIp4+IbT
         1u6g9uP8y7qB4JxDRKeT+dGyv8Hl1Koa68marZqIofFV1ozUD/i2KNnrnvG9P90RVlJD
         bjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pW4fIO1zU8hH5UZQ21Ux1LqBB1/44eCl6uSeUwAZ5aM=;
        b=g4j0EpGut1d9VAopyvwKio+gtOCV2nmaEwLU0s0Ib3vOhtpkvGWYaYQWlxs3nlGjhA
         BW+241Pm+jbOrF5PVtvRTCi0E8debFFBsRcsxfhclKWnlJO/MC0evYpzYSdjeZMcrj9J
         62P8MBy9Oz2udW8iIYgyv8OYf9E1juvGqmOWaCvdRKDWdtgETC1letqkdxyi8pbEV/Cq
         tiOxqvuhiKTEbI7+9JGZclkqJ7H0bs9uwddB1XPhSVz8wt89pnvh92KxTziDTy9QwOMc
         aoBYMj5y+kUtvoffWzSSGFlZVMnn0xwO54o8ZTSrfELeKAi+1bFm3Si7QeS5xxTkhi5N
         1W5Q==
X-Gm-Message-State: AOAM530rJPhbzufDBE118Mb7GnQAgHmUrNnIc6QC70QGlxxnFu6Lticr
        fxMjh1Qrlhak3npg14wazdSuTv1SLlyBUImIQPM=
X-Google-Smtp-Source: ABdhPJw6+/SwL2KydeAdgLuJYjz/+K1J1IHTLjBhAneWt/AHH+E75vqBLas8PV6tZm9E97+1M504un5gP//4Zp83qc4=
X-Received: by 2002:a81:70c3:0:b0:2fe:c68c:aa1d with SMTP id
 l186-20020a8170c3000000b002fec68caa1dmr2409691ywc.431.1652471899340; Fri, 13
 May 2022 12:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220512001500.16739-1-fletcher0max@gmail.com>
In-Reply-To: <20220512001500.16739-1-fletcher0max@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Fri, 13 May 2022 12:58:08 -0700
Message-ID: <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: nintendo: fix face button mappings
To:     Max Fletcher <fletcher0max@gmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

Hi Max,

Thanks for your patch, however I must say the patch is not correct for
2 reasons.

Over the years different controllers have different layouts. The
standard which this driver (as well as others such as
hid-sony/hid-playstation) follow is the Linux gamepad standard (see
Documentation/input/gamepad.rst). It stays away of the debate what is
A/B/X/Y. It talks about North/west/.., (yes they are macros which map
to A/B/X/Y). In case of the Switch it does mean things are flipped,
but it was not meant to represent an Xbox controller. (Technically one
could argue that the Xbox controller should be flipped as it was the
SNES controller back in the days which introduced X/Y and the Switch
is still consistent with that.)

Second, even if the patch was right it would be tricky to merge. The
problem is that a changed mapping breaks user spaces and in general
can't do this unless there is a really good reason. It just would
break existing applications and libraries (often e.g. SDL)

Thanks,
Roderick

On Wed, May 11, 2022 at 8:12 PM Max Fletcher <fletcher0max@gmail.com> wrote:
>
> Previously, A and B would match the Xbox layout, but X and Y were incorrectly swapped. This corrects it so that X and Y match the Xbox layout.
>
> Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2204de889739..7735971ede3f 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
>                 input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
>                 input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK);
>                 input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
> -               input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
> -               input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
> -               input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
> -               input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
> +               input_report_key(dev, BTN_X, btns & JC_BTN_Y);
> +               input_report_key(dev, BTN_Y, btns & JC_BTN_X);
> +               input_report_key(dev, BTN_B, btns & JC_BTN_A);
> +               input_report_key(dev, BTN_A, btns & JC_BTN_B);
>         }
>
>         input_sync(dev);
> @@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs_l[] = {
>
>  static const unsigned int joycon_button_inputs_r[] = {
>         BTN_START, BTN_MODE, BTN_THUMBR,
> -       BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
> +       BTN_A, BTN_B, BTN_Y, BTN_X,
>         BTN_TR, BTN_TR2,
>         0 /* 0 signals end of array */
>  };
> --
> 2.35.3
>
