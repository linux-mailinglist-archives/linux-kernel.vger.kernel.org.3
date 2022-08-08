Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D427658CB99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiHHPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHHPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:53:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F65FFE;
        Mon,  8 Aug 2022 08:53:27 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k19so2431347qkj.7;
        Mon, 08 Aug 2022 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=632cVpHhmjLitVQZ04+RZU+wT80FL/jo9t2xH7JYoMU=;
        b=ZM157r7LRK1HxC/WtUJDLvCGLNHg2364aXMcFPgHeyzvEFbPSlg4XYC8SXlgWTt5GL
         RX52F/Q77RiYYkmIhVpkTbf/6H1CwACb+An6kO3GVHwmgO71sCplTRNsFMP4Yzc/8ZJ5
         0WLqbozc6YGhvhXCNmezARph7MaSlZsRuRvdhozO7Hvz7bxjQMAYzWxasPQXfsmu3vup
         mgaqr+gmQZjndebdhR9Cb5sRuDPXedc6hyAbJNKMbcSmtNevXWXJdGzv4bR5y/VvyIJV
         Vp1wTDmW26pP+qOi2HjeYKTb6lVZCe8R9UcX9UpearLHqnKyfEP6v0fYTJ7lQIxKQMpm
         jC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=632cVpHhmjLitVQZ04+RZU+wT80FL/jo9t2xH7JYoMU=;
        b=S7s2xdKBwSaY8JddtjVfTSCO3F8Jf91PY8xW92MdAnGyfafDW1G4XcTt+0olyzMibg
         POW/IOD84WSL7D7mzQL7YqJzVwPnGn4d1Sxs1/V7l9JaNImPoeLQtuO5wXgXlgSrTYcZ
         s09M+6Y7UjpoGLFawd4maFAkUAGxe8+DI2X0TsmhoOzkvCD0O9oQ3SWPuiame7O5HDW/
         iiAObrA4oh517Fyd8purao8KyDknZ2EFXhDjmKNiQmDhMWTd1HoDU6mnYlwuflwNmf6c
         F0/KIiy3kPdjvGglTjO/Ua9sZX+VxoZKGHAQLK9WbUo6fb31NOT+HqSner4VPGjeW3da
         KNQQ==
X-Gm-Message-State: ACgBeo3LfDZ7kpabSKAcOqhMXnJHFiXOw2OyqSjH26V2Cc778RvELWR1
        OG/YSAZgFLJieCHYgmAKrI8GpBE7oIYfhNBi2NA=
X-Google-Smtp-Source: AA6agR6HZlKVM6ixWgbVlN3lxTKi3SEoKguNFmbxsrhUSGEl/4CEJ4F8q3dWRbbPc0AcpagMje/l00SGKR7IPqWB7ec=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr14687852qkp.504.1659974006264; Mon, 08
 Aug 2022 08:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220808031132.10075-1-luke@ljones.dev> <20220808031132.10075-3-luke@ljones.dev>
In-Reply-To: <20220808031132.10075-3-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:52:48 +0200
Message-ID: <CAHp75VcjTG=fFBjjHRYT2+ARfE-VHWKJ9aV8sF4JtRVo7Ke2vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] asus-wmi: Add support for ROG X13 tablet mode
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

On Mon, Aug 8, 2022 at 5:12 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
> lid flip (all screen rotations).

...

> -       { KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
> +       { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */

Have maintainers asked you about this? Otherwise it is irrelevant change.

...

> +                       pr_err("This device has lid-flip-rog quirk but got ENODEV checking it. This is a bug.");

dev_err() ?

...

> +                       pr_err("Error checking for lid-flip: %d\n", result);

Ditto.

...

> +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
> +{
> +       int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
> +
> +       if (result >= 0) {

First of all, it's better to decouple assignment and definition, and
move assignment closer to its user. This is usual pattern.

   int result;

  result = ...
  if (result...)

> +               input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +               input_sync(asus->inputdev);
> +       }

Second, it will look better with standard pattern of checking for errors, i.e.

  int result;

  if (result < 0)
    return;
  ...

> +}

-- 
With Best Regards,
Andy Shevchenko
