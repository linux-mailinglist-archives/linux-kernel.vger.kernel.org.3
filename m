Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC958D583
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiHIIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiHIIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:41:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1708C0A;
        Tue,  9 Aug 2022 01:41:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e28so180444qts.1;
        Tue, 09 Aug 2022 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2GWUGJV06d2di07FtdpKYMMbz25wdyp6M5GtNkd9ZH0=;
        b=N6B2unRqY+lno29swo0ZKnl5BLI73wbMFOmhVY3xwjt5kM90wje9zmKmwuFRJBJkNs
         S32cNeodm2vGIv41azHakaZOzXEZFyJGur4JlCm3I80xSddw+sCkjj/a9U6o8RAy0kr+
         EtnVcBa5eRXx86ScWhlql0rXFvz1EUhi0z4VeQaIwdqMXkBiRmjUkGpPqekff+QWQin6
         bgpZe4nGntfE1v/AdABbUtygMO1ghVFRjkWgaLQ77YOe51McFqGQA4bmo0CNSad0/CBv
         UkyLEIu8194MaaLkAXFcU65BPb1mwbjjq6hxQnTw4WYtIaiRxmwcZSfs3DqF7BQ1fd9b
         mu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2GWUGJV06d2di07FtdpKYMMbz25wdyp6M5GtNkd9ZH0=;
        b=Ajx8Ac8SEVferozEKe/87g0d5IU0eJ/pXxqxi+xZjl4Ie8TmR0G9lkMYS0/z69ruA0
         uYoHYt1utoU5NihsvnBCbQ/jAVU8qlbUxsxEIVKpyrBgwcRp9OFMFty4xrCc+oiMwZCw
         yGLHK1AtCubRMI+Ke5say3na9ApnQACOsZ2dygBODh4kenfaq+6D//P1oYazwNj9Nq3m
         cqsmc97bA9XrwEYLAGLjhbbFNXHuks9nbYjUiUvsiQWxyp7+U8QEOdC1lmWodAA1L1bi
         V1CW+gzvg1xb6vUBDrJX3ksc3lTpjy3m/KxJ6Wy19iy127UBbuZRUFv1YSyvhTXcJT23
         kVYg==
X-Gm-Message-State: ACgBeo3yMrFAwOG7ciwIUv3zeIM/dejR3pCSodsBWyMDeVTe54m6OvPp
        hPQy2WRBUSUSyZ9K5GdB7nQgzNJC/DWntE31Xc4Gl0SDasw=
X-Google-Smtp-Source: AA6agR5HeRJNm+1muED9l1I5dO8yNvOG5wEolOrqz7LCJBrOVXPCAH8+OpuvQ2THfA4M9Juejo0+MCwmam2lownJeuE=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr13416295qtj.384.1660034467919; Tue, 09
 Aug 2022 01:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220809033048.1634583-1-luke@ljones.dev> <20220809033048.1634583-3-luke@ljones.dev>
In-Reply-To: <20220809033048.1634583-3-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:40:31 +0200
Message-ID: <CAHp75VeAMBM+itfAn8hRDykV9rRLGXzck8L2kBgpGkVRsPUm5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asus-wmi: Add support for ROG X13 tablet mode
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Tue, Aug 9, 2022 at 5:31 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
> lid flip (all screen rotations).

...

>         { KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>         { KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
> +       { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow laptops */

Shouldn't you keep it sorted by value?

...

>  #define NOTIFY_KBD_FBM                 0x99
>  #define NOTIFY_KBD_TTP                 0xae
>  #define NOTIFY_LID_FLIP                        0xfa
> +#define NOTIFY_LID_FLIP_ROG            0xbd

Ditto.

...

> +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
> +{
> +       int result;
> +
> +       result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
> +       if (result >= 0) {

You missed the second part of my comment. Please, read carefully _all_
reviewer's comments.

> +               input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +               input_sync(asus->inputdev);
> +       }
> +}

...

Overall, it's getting better!

-- 
With Best Regards,
Andy Shevchenko
