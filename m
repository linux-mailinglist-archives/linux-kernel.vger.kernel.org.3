Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B6487CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiAGTF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiAGTFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:05:23 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8792C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:05:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 196so5878449pfw.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S72sOYOwXg9RPix1lZvjtLtkj3XFLsZ4gEDpSvt8vs=;
        b=UNlRvA2ZuRZGr24qbY8d8HRyinc6EpOYSKt7DfYa7U+pylhqD10egaBHZVcWbFvg+d
         HZZoCKimfsUYVZ6hLdx9fE8635nsrgDrj+L00L/QA/Cjac6/OItLx2Gm1LMQY7kdBjlm
         gUl11sQ+hRSXhsijE3Lz0JsafCc/WMzMcjN+p2ZjS7WJkqTYR8lO8OzMXzBLllf3FZN8
         6SuFHJFHb0+VTxIFi9KbZl/oUBDvS7ua7q/kqOUOmGT9RC+dhhVS1J2U1EpVpDJqJhew
         Efg7LRldeNgMVDWyPjGhSj7BNZ5UuIesQ0y/zYKcFCgYdMO4ccJ3NrTfKraxrHj6N1TQ
         QivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S72sOYOwXg9RPix1lZvjtLtkj3XFLsZ4gEDpSvt8vs=;
        b=WxNsCOmSHemOFdN2BS4LpjP0wvNrkWDQm4XO7+rRC5req7pH8T2UF5sGWl0KP7mzNs
         Q0TklaVmez354TZ8q4wP1oJEc0UEQN5DSxSo6ptLvyaeM4lRhcXYTr9JgwGJViL5wzad
         qXDB6bqn+HyK02jC+zMWe/c6+cBOTRJc59cTarUCGn5Hrw0ojXUFWT81vzm7biSonqCL
         bxplVt2g/Utxl4gBVS+FAwyj7PEeFFQ1zLglzhVbpeT0zwsHzFk9OikAHnlXf9+ehXh7
         +Qey3wyJKY6oJY1mhcDGGd4dc2FUHhqRw9QBmRbaa0dv66gAxfeeJ83hp5u4wXP2WpgO
         CJUA==
X-Gm-Message-State: AOAM5334zJRY7UmIzzWUuDw6V175TFktjESWXwQd7rTjEJzl8CTcgUxs
        bfQ3Icj4DT4vLAX/c4ihxIMN+a7TRhD0UUOkxsNCdA==
X-Google-Smtp-Source: ABdhPJybEblBw8MdINxXy3+9JK7qlDbdUwo1shN48fzEsrE5iAHxprn/bdZ6bdR1DoPb8Rx12GSfNjxZRna6xpg2RNM=
X-Received: by 2002:a05:6a00:1249:b0:4bb:4a31:1e0a with SMTP id
 u9-20020a056a00124900b004bb4a311e0amr65535466pfi.81.1641582321973; Fri, 07
 Jan 2022 11:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20211222001127.3337471-1-rajatja@google.com> <20211222001127.3337471-2-rajatja@google.com>
 <Ydh7u1kuXSMzwmW0@google.com>
In-Reply-To: <Ydh7u1kuXSMzwmW0@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 7 Jan 2022 11:04:46 -0800
Message-ID: <CACK8Z6HbKR5QktJjK1+QCKoLCJUHK8btQN5Xbij8A66VYzhcHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] platform/chrome: Add driver for ChromeOS privacy-screen
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, Benson,

On Fri, Jan 7, 2022 at 9:43 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rajat,
>
> On Tue, Dec 21, 2021 at 04:11:26PM -0800, Rajat Jain wrote:
> > +static int chromeos_privacy_screen_remove(struct acpi_device *adev)
> > +{
> > +     struct drm_privacy_screen *drm_privacy_screen = acpi_driver_data(adev);
>
> Please add an empty line here:
>
> WARNING: Missing a blank line after declarations
> #292: FILE: drivers/platform/chrome/chromeos_privacy_screen.c:129:
> +       struct drm_privacy_screen *drm_privacy_screen = acpi_driver_data(adev);
> +       drm_privacy_screen_unregister(drm_privacy_screen);
>
> > +     drm_privacy_screen_unregister(drm_privacy_screen);
> > +     return 0;
> > +}
> > +
> > +static const struct acpi_device_id chromeos_privacy_screen_device_ids[] = {
> > +     {"GOOG0010", 0}, /* Google's electronic privacy screen for eDP-1 */
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, chromeos_privacy_screen_device_ids);
> > +
> > +static struct acpi_driver chromeos_privacy_screen_driver = {
> > +     .name = "chromeos_privacy_screen_drvr",
>
> Could I buy 2 move vowels? ;)
>
> > +     .class = "ChromeOS",
> > +     .ids = chromeos_privacy_screen_device_ids,
> > +     .ops = {
> > +             .add = chromeos_privacy_screen_add,
> > +             .remove = chromeos_privacy_screen_remove,
> > +     },
> > +};
> > +
> > +module_acpi_driver(chromeos_privacy_screen_driver);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("ChromeOS ACPI Privacy Screen driver");
> > +MODULE_AUTHOR("Rajat Jain <rajatja@google.com>");
>
> Otherwise
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks! I took care of your comments and posted a v5:
https://patchwork.kernel.org/project/platform-driver-x86/patch/20220107190208.95479-2-rajatja@google.com/

Thanks & Best Regards,

Rajat


>
> Thanks.
>
> --
> Dmitry
