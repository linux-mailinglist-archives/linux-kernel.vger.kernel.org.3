Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E4558B4E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiHFJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHFJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:57:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F88110FEB;
        Sat,  6 Aug 2022 02:57:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m22so3428194qkm.12;
        Sat, 06 Aug 2022 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rM2r893tX6UeJ6IA/xwdRLyGKAipcqqqqEylN0hdxZo=;
        b=YM5xBvU8oi3QHNtle90hlJNrkhOzMBUJksPrtbpwJc9GA7EgnAAjFehTHoADnkcmfG
         dIYzS1CEmRcuX1e+vMTsoj0sGGLISC/FAXgsh5bhx2djEDPQWT6FV1hY+KxeMo2kXzA4
         FHeuhwfkPf6vE8KYMbouqN6kyQimOIvkDBZo4gdOCuB23E1mPZTBSPONdkehVId6jRgP
         fi6N0iH2/DudZl3ZJa+n28AGwx1pJUym4QUf6cQJgq9MkiIBWrX6e1h7GrpjYBt7tjHA
         +pPDGLmEhxHc2sakMae9IIdY1MSLEZ+UAzgfKbItczUlHW5Q0ERF4DJjPpHh9t8hBvPv
         Y8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rM2r893tX6UeJ6IA/xwdRLyGKAipcqqqqEylN0hdxZo=;
        b=pkxHr07fuVroOtTGoIfirqr44kquYeOTmAgxArQyJ59wCJ61oWYRlAtTE7+SdueHAa
         KpG4PkB53LzpPgi5mAQLHDAGxAWt0y53N6v/DFksypaCC8Sk1DNqXoqO07CwsC545Ms0
         h+RRkwBzjU/Bj2Ppo6dLjag/sjQGhBlJQmYRXaIEe8F/B4BApQmFnOlW48etTRN4J/N1
         b3r9ykmv3eWsOim6cVL9I6fQ5TWqkQ4DPK1qABpScCuY258vXFli1w2uSMMkb3DZwdMF
         FGidDJGNGR0FPqVSDBwC8PWpGRNm31Sm8WF4BVxp8oWjH8c3RIAtz2npt4wN75W9Tnu+
         7X4A==
X-Gm-Message-State: ACgBeo2fms3RijBdCNZD18Hxz92jyw3+ZybwMo7z6CaeF/l/hKNmVlVI
        Vo6S4HQaLHkyD7tq5MqRYNLhNYPqbLiObgpfQ9KQIwzsmxo=
X-Google-Smtp-Source: AA6agR4lmRT846scNJETOCADZsMtIjb5MBULtHoVx+VaY2KLhelA7SaUzLtq65EXAagcE2T/tQtJORnFCJ+yszsbtVI=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr7841172qkb.320.1659779854641; Sat, 06
 Aug 2022 02:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-3-luke@ljones.dev>
In-Reply-To: <20220805081909.10962-3-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 11:56:58 +0200
Message-ID: <CAHp75VcYba6wYwkMo_Q_QEZsr4wyfDB5czu13w-y6hfQ13CkvQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] asus-wmi: Add support for TUF laptop keyboard RGB
 mode control
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
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

On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for TUF laptop RGB mode control.
>
> Two paths are added:
> - /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode
> - /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode_index

...

> +static int keyboard_rgb_mode_check_present(struct asus_wmi *asus)
> +{
> +       u32 result;
> +       int err;
> +
> +       asus->keyboard_rgb_mode_available = false;
> +
> +       err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
> +       if (err) {
> +               if (err == -ENODEV)
> +                       return 0;
> +               return err;
> +       }

> +       if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +               asus->keyboard_rgb_mode_available = true;
> +       }

{} are not needed (except if they will be utilized in the next patches
in the series).

> +       return 0;
> +}

...

> +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) != 3)
> +               return -EINVAL;

Usually we have three separate nodes for that, but they are kinda
hidden in one driver, so I don't care much.

...

> +       asus->keyboard_rgb_mode.save = save > 0 ? 1 : 0;

So, it's actually boolean.

You may write it as

    ...save = !!save;

> +       /* These are the known usable modes across all TUF/ROG */
> +       asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? mode : 0x0a;
> +
> +       if (speed == 0)
> +               asus->keyboard_rgb_mode.speed = 0xe1;
> +       else if (speed == 1)
> +               asus->keyboard_rgb_mode.speed = 0xeb;
> +       else if (speed == 2)
> +               asus->keyboard_rgb_mode.speed = 0xf5;

> +       else
> +               asus->keyboard_rgb_mode.speed = 0xeb;

So the 1 is default then, why not use switch-case to show this explicitly?

switch (speed) {
  case 0:
    ...
  break;
  case 1:
  default:
    ...
  break;
  case 2:
    ...
  break;
}

Yes, it's longer, but I think it's cleaner.

> +       err = tuf_rgb_brightness_set(cdev, cdev->brightness);
> +       if (err)
> +               return err;
> +       return 0;

return tuf_rgb_brightness_set(...);

> +}

-- 
With Best Regards,
Andy Shevchenko
