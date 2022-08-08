Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077C58CBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiHHQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiHHQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:12:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B630C;
        Mon,  8 Aug 2022 09:12:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l5so404642qtv.4;
        Mon, 08 Aug 2022 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gILE/DsFTOP8PS0Yp1nF3NCvuUGJhqQFgsUGLdHXvV8=;
        b=jUFe1axofvyCb6gyzxGTtNwHyegk3CnDZMId+aHrAzoNtF8INilsWQPC+STOs1HddK
         CzGUhG3kK4Dx9QqZ3NWbGmnk2O0HnxRnwHI+Iefs6ZnQhZL9TA/eC3fJeL1Sc8Y6s5wa
         VAGzRa91ONRrsOdJKwke1gkVMBSwwhhKVOcrydQpj6d5WUi1PyRrd3zZwygESwtCuYce
         7wqY9ogPv6DbLCNf/yhkPX8W5wdp3bWLoHN6XrXwCv/L3aaZJdGrYyb64m5wkksTl0fS
         9fXNC/2rpvGtEIElZQsiJt4tqf2Qt4cQZT30fa+E6XOWmRGlE3MzpqvKixvzhy2ljIXx
         Z6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gILE/DsFTOP8PS0Yp1nF3NCvuUGJhqQFgsUGLdHXvV8=;
        b=acjBgEV211m4J1YzW27A4eBQH+Nx9wM3zGHdBFMlihKt4mIFL2sml+hub79WVjwRhr
         YOSj/OlVXc+Xb+8O0KtwDZukVmmUtz8uPA3vx0YLUpaKXmad1bokMFIM010NaeobCvzK
         Y+5IdGvQcyWREy+y7ZYsGec5bEDT+SFIKF/Lb7f/qZjfUWbXrIxBmbtwmG7yE94cqCMo
         +kY6Fvo2fycQQyI2YzcpLwFvCqCu75r+QlHNNqm6aIYnKQtBVlEcXHutZ8QZ9IegVEyd
         GsWwwoLt3FaIvNvOI3/4mhHYtrI9m+qCtQTuZgrlxo0r5R+4k9Tbr2jvOnFPI/wBB48t
         5afA==
X-Gm-Message-State: ACgBeo2v3gxOnrHcLMJBK9K2ZNbk+aQQw3Lw5Orkvyfma64Ey7W5IKuy
        MyL1JXLH7pWo/XRwMwCTfQ9gV1ei3EkIE1HwFHU=
X-Google-Smtp-Source: AA6agR6YMGbmSGWrM3mvE3XFN1H+euyfs1mFLCcKBtY7QVRDfF162WRcbFP1i1/j4WhE6bRQtesrXDtrrJbcldYNPn4=
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id
 b17-20020ac87fd1000000b0031ee9c0c071mr16765824qtk.481.1659975128238; Mon, 08
 Aug 2022 09:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-5-luke@ljones.dev>
In-Reply-To: <20220808030420.8633-5-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 18:11:32 +0200
Message-ID: <CAHp75VdJyukGnJkhjPiB7wMxS5aQkVfMwVVhqAxA6DppyH3HLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] asus-wmi: Document previously added attributes
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

On Mon, Aug 8, 2022 at 5:09 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Documents some previously added attributes:
> - dgpu_disable
> - egpu_enable
> - panel_od
> - keyboard_rgb_mode
> - keyboard_rgb_state

...

> +What:          /sys/devices/platform/<platform>/dgpu_disable
> +Date:          Aug 2022
> +KernelVersion: 5.17
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Disable discrete GPU:
> +                       * 0 - Enable dGPU,
> +                       * 1 - Disable dGPU,
> +
> +What:          /sys/devices/platform/<platform>/egpu_enable
> +Date:          Aug 2022
> +KernelVersion: 5.17
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Enable the external GPU paired with ROG X-Flow laptops.
> +               Toggling this setting will also trigger ACPI to disable the dGPU:
> +                       * 0 - Disable,
> +                       * 1 - Enable,
> +
> +What:          /sys/devices/platform/<platform>/panel_od
> +Date:          Aug 2022
> +KernelVersion: 5.17
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Enable an LCD response-time boost to reduce or remove ghosting:
> +                       * 0 - Disable,
> +                       * 1 - Enable,

These should be in  separate patch(es) with the corresponding Fixes
tags. (The latter may not be so important, though. I leave it to Hans
to decide)

...

> +What:          /sys/devices/platform/<platform>/keyboard_rgb_mode
> +Date:          Aug 2022
> +KernelVersion: 6.0

These should go separately. Dunno if it should be a separate
documentation change for the both, or should it be split and
reattached to the respective patches from the series. Up to Hans.

> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Set some RGB keyboard modes and features (write-only).
> +
> +               The accepted input is "save mode speed", where "n n n" options
> +               are:
> +                       * save - 0 or 1, if 0 then settings are not retained on boot
> +                       * mode - 0 to 12, each is an RGB such as static, rainbow, pulse.
> +                                       Not all keyboards accept every mode.
> +                       * speed - 0, 1, 2, equal to low, medium, high.
> +                                       Only applies to certain modes.
> +
> +What:          /sys/devices/platform/<platform>/keyboard_rgb_state
> +Date:          Aug 2022
> +KernelVersion: 6.0
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Set some RGB keyboard power states (write-only).
> +
> +               The accepted input is "boot awake sleep keyboard", where "n n n n n"
> +               options are:
> +                       * save - 0 or 1, if 0 then settings are not retained on boot
> +                       * boot - 0 or 1, controls if a boot animation is shown
> +                       * awake - 0 or 1, controls if the keyboard LED are on during awake
> +                       * sleep - 0 or 1, controls if a suspended animation is shown.
> +                                               This is only active if the AC is connected.
> +                       * keyboard - 0 or 1, unknown what effect this really has


-- 
With Best Regards,
Andy Shevchenko
