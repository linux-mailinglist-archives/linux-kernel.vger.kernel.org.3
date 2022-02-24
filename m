Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DA4C20D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiBXAyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBXAyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:54:39 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44B141450;
        Wed, 23 Feb 2022 16:54:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gb39so1001249ejc.1;
        Wed, 23 Feb 2022 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pM5pw1YpKQqELzcFX8vmd83rKnZu8lKXq5VtC+eE4ss=;
        b=G9gSDIB/Ac5CRzuLOjKBmqubWQrPBBJx0jzODrrpVKeV30gd+jXWw3jWHL48/ZBt6q
         IzYaMihLA/IouqWV66vM1wALPtPCoa4+Gx0NJShaeOoImSM37FWdRYnNMHMKkcCxDALJ
         m34EuiWV52MdqilI1MV49oLKAK5ya15RRATJrCAT4wAhshPJ5CoaNjiwiJTEHwm1sCxf
         2Vc5eXQDzty+aHn31rOWswD3kYWUwsZe+cHkA2H9MeiRGGgtPDRS6kTgcvcTYazEiItc
         dsIsWi8Z/IoFBYNEFoHZNqlAbGPxnpH6h0SqqamaVYqEZ6JHpMPIoG8Esjh3jLdbU768
         TayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pM5pw1YpKQqELzcFX8vmd83rKnZu8lKXq5VtC+eE4ss=;
        b=wuvZjB4/HDKLAlI/ZzyYnNencDNonzmwU2nVdvP3Hh3mHpfqRMhMoBNUWsHDmeitpJ
         SDLCZe9kAn0mL1c4sH81HE4t1uJXiclS9+kuYUU2xrZa2txOo2dg/Im93G0w1fqL+g98
         +NmzyAsX88xzuFQrsGbMz/BBU5eXBAFTS5tljcfSA9+W61XCsNRXcrxrh9YCZZmvjfTs
         Mj9pcpr/5+kmrE5kgopQwDOAzjcoiQqw0/46sqq/0zpNNPm+QvI8zmQZrwXEwOc44Lmh
         eFjgwbrG9cJlnlhhEfCL1LV4AthE8jOHYtIxuhK/SWG962uv6bs1ttz2JXconYUyTTYs
         OVig==
X-Gm-Message-State: AOAM531m+oOnpoYRaIFMAbtP6qfJuaMQy+i5f4rYEA9q8c6mK+lclUhy
        fU+d0bNLAywmEGhjheLUNswGatgnGu5bLjq26ac=
X-Google-Smtp-Source: ABdhPJzB9MPssx0eH/yPbtYrAfHV12Sebabh1EqgA0ykQ3M7WDBSPTOaWoMJqBqR5yi52Sp22zek2HHPiLUA6dSX4Bs=
X-Received: by 2002:a17:906:138f:b0:6cd:93db:e54a with SMTP id
 f15-20020a170906138f00b006cd93dbe54amr267069ejc.44.1645663757286; Wed, 23 Feb
 2022 16:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Feb 2022 02:47:53 +0200
Message-ID: <CAHp75VfKtU9qjSYQmc78T_O8tjuGDamWpsULyeW1fD-sd-dP5Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] iio: potentiometer: Add support for DS3502
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Wed, Feb 23, 2022 at 6:35 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
> DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for the entire series,

> Changes since v4:
> 1. Included property.h header which has device_get_match_data()
>    function prototype.
> 2. Removed blank space in tag block of the commit message.
> 3. Style changes for ds1803_cfg structure.
>
> Changes since v3:
> 1. Dropped the chip type switch statement in read_raw function.
> 2. Added device specific read function pointer in their structure.
> 3. Added two separate functions to read values from two different types
>    of devices.
>
> Changes since v2:
> 1. Addressed Andy Shevchenko comments.
> 2. Adding device name in Kconfig file.
> 3. Spliting up of patch into 3 patches.
> 4. Adding channel info into ds1803_cfg in separate patch.
> 5. Dropping the use of enum in firmware data instead using previous
>    pointer method for accessing device specific data.
> 6. Separate patch for using firmware provided data instead of
>    id->driver_data.
> 7. Adding DS3502 support in separate patch.
>
> Changes since v1:
> 1. Fixes the alignment to match the open parenthesis in separate patch.
> 2. Adding available functionality for ds1803 driver in separate patch.
> 3. Moving maxim_potentiometer members into ds1803_cfg structure.
> 4. Droping of the INFO_ENABLE channel type.
> 5. Firmware entry with data is used instead of id->driver_data to
>    to retrieve the chip specific data.
>
> Jagath Jog J (7):
>   iio: potentiometer: Alignment to match the open parenthesis
>   iio: potentiometer: Add available functionality
>   iio: potentiometer: Add channel information in device data
>   iio: potentiometer: Change to firmware provided data
>   iio: potentiometer: Add device specific read_raw function
>   iio: potentiometer: Add support for Maxim DS3502
>   dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
>
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  drivers/iio/potentiometer/Kconfig             |   6 +-
>  drivers/iio/potentiometer/ds1803.c            | 170 ++++++++++++++----
>  3 files changed, 138 insertions(+), 40 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
