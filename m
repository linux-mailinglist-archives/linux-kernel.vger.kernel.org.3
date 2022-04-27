Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF151197C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiD0Nhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiD0Nh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:37:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7004A91A;
        Wed, 27 Apr 2022 06:34:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g21so3160228iom.13;
        Wed, 27 Apr 2022 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6Ly0bciV3x7q/Qi0DbDAz5BGaMk+1K+6gSqnWUs+nM=;
        b=UGSsabq5vlxUKYI+U+QDRVfuj2O91U8yBv+KhvMf7i0YnbTi/pBz65A7phMG9Rzt5q
         pVg3cq4e1JtmzK4hQy9Un17qLSo7a0PzdAXMsr5cme80BcHJNElZ6NXHu4ouuby8+7rc
         9yaWUaX/VCU21Vq8Pfx7ehuUYo7SJlczsD3j9095/a4lgUz9GjMe7yMKjtjRLAXZin0x
         FrjmuninQze3m9yt5xWKoryfnqcreGppkuGawMIpEhOm08xkVjCtfqGIT1yMb3j8pSBY
         TD/CxqzhvYveaAnhkz9nsXMrwSS1FP8vYhhXp5lvw2VwxX4kLGfEMjHSsteKKEKx7auJ
         0LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6Ly0bciV3x7q/Qi0DbDAz5BGaMk+1K+6gSqnWUs+nM=;
        b=4K1mlmdGoCfnpnYiLxYhj5dHRT14jAl0mLA2cfT1T2zk4S7wYi9Jt3LPC9KL0kfyg6
         91T77TP+9dxo7Pvbh6q417P5BGrXxC+RUJR2rNyJM1ZPrUQfQIDU+aQXYUIjiyYJz5lP
         4vKqXkf8sXPTIoJqkMs7Y4P2aV+xENMMqcHc9TK7e71LjFZ6KhaGMLG/e9WFlxVtqeQ8
         2PZRb0QxQtSZiPVRJRaoZopG90q80lL5IFVkzBZCwEsnmoWuaCjZ7LQupOZhCf0PFBuK
         qrC52vqU6Zb0KnUwKCfCZ4J4YBS/+gRzfNtNLg6sU7F0CjBtWqrjoxvxl61HVwcgmk51
         FDag==
X-Gm-Message-State: AOAM532TKO4eVYpRwgkzBxaS9iFdcUBvsnGft7cYHYDRWWd9zDcpgYC8
        zfPme2gL3RaRLrGXj13znYtvxFnDyZvifRiohWOBaN6vHNusRQ==
X-Google-Smtp-Source: ABdhPJxIGVa8eEXmjke4daAbIFilhAl3AEb0/xryuw3KeeW10hGOD5zAYhmJMljsaendSHQ0+8msZga3opYx8X20H6c=
X-Received: by 2002:a05:6638:3d05:b0:32b:35a:2d77 with SMTP id
 cl5-20020a0566383d0500b0032b035a2d77mr3748136jab.241.1651066457603; Wed, 27
 Apr 2022 06:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com> <20220426151656.GA3119637@roeck-us.net>
 <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
 <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net> <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
 <8a8579df-1fd6-32bb-3e27-297efefe28c4@roeck-us.net>
In-Reply-To: <8a8579df-1fd6-32bb-3e27-297efefe28c4@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 15:34:06 +0200
Message-ID: <CAB95QAQPRVO=Cd27QthFZ_fDTr=Nvzqzrh0QnFs5475yTx+qJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'd better leave a comment why module_platform_driver_probe() is
used as opposed to module_platform_driver()? I think that one would be
more straightforward...

Regards,
Eugene

On Wed, 27 Apr 2022 at 15:20, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/27/22 05:16, Eugene Shalygin wrote:
> >> Sorry, I don't follow that part. One can add "__init" or "__initdata",
> >> as in
> >>
> >> static struct platform_driver asus_ec_sensors_platform_driver __initdata = {
> >>
> >> to mark a function or data structure as __init. I don't think adding
> >> "_probe" to the struct platform_driver variable name does that.
> >>
> >
> > __initdata leads to modpost warning:
> > WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.exit.text+0x3):
> > Section mismatch in reference from the function cleanup_module() to
> > the variable .init.data:asus_ec_sensors_platform_driver
> > The function __exit cleanup_module() references
> > a variable __initdata asus_ec_sensors_platform_driver.
> > This is often seen when error handling in the exit function
> > uses functionality in the init path.
> > The fix is often to remove the __initdata annotation of
> > asus_ec_sensors_platform_driver so it may be used outside an init section.
> >
> > Compiling without attributes resulted in another message:
> > WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.data+0x0): Section
> > mismatch in reference from the variable
> > asus_ec_sensors_platform_driver to the function
> > .init.text:asus_ec_probe()
> > The variable asus_ec_sensors_platform_driver references
> > the function __init asus_ec_probe()
> > If the reference is valid then annotate the
> > variable with __init* or __refdata (see linux/init.h) or name the variable:
> > *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> >
> > Here is why I added the "_probe" suffix.
> >
> > Eugene
>
> Ah yes, I forgot about the exit function. It needs a pointer to
> the structure, which would be gone if marked __initdata.
> Please add a comment to the structure name explaining why
> it is named _probe.
>
> Thanks,
> Guenter
