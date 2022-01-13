Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB548DD97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiAMSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:21:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80BC061574;
        Thu, 13 Jan 2022 10:21:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m4so26174696edb.10;
        Thu, 13 Jan 2022 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMHtdvU9XeJ3wjSZJWX9SQTYtWlQlU+oMcR+hFhhTs0=;
        b=PJY7Zvl/ThfQH8zKW3lnHfZoumnkwhOusZ+9kOji5+/FBwsaW2S2SjYTSd6Qnw65q+
         ECQzmssJDalmRBn2fIKreTTTotSHVjnN0qd9Q3aG0i/diFUQSf0noTB18PdpRoM7fNE6
         QfwisMrbjyDvUqvsrMjJQhnk/mR+DEwd7Qd2NNJr/0E67yp5O5uKQgHk11Xdts+yL+y7
         +1ETJG1nV/bR7OHzBS5dTu6OndnAiupFN6jf8bR/rGP1hZYgvGKNwrUoCXJY+On8h3ZD
         d+U6rluPrxoVoPmOlKWUqc4bctLxPwQi8hpA+mejp4Zwlnw3GCn14uQjXauWyNevNnZV
         a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMHtdvU9XeJ3wjSZJWX9SQTYtWlQlU+oMcR+hFhhTs0=;
        b=pNM59R6SBLNIWoELZ7cQR1nbwzWRjGjC97Llnu8vGw0XslIYnmukXRmT57l0YU6ION
         CRhwqkSP8mWQnhIXsiXmNvn1nfAHtMKcX30jbfH9Sxjr1eedKc6hmSZKlpfuSJ4YejHN
         SzW66adyKRoZcJ83iYDfMeTavQsZoMHY2UydVcq3Etg+i9BjAy2YLjainw/2xRTT3Jsc
         p9jQOuzbVU11+gty2XMysMaj51SnzDPiIKdLsJ/FJ8pv1egdTIeUmBgrwQLfxYu3vAoo
         nkYUIGxO74LCXDszxYc8N+FKyL1lVNxkW8oTyDJQOPkogGqrpznRSR23Wf3m0F4Ujd+N
         LdDQ==
X-Gm-Message-State: AOAM5308QEtQItOMmYbwYTuKD/2Q4kZy2R+eXrObaei8qg035KNzMVaW
        Fk7WPvrHRg2AF9xQmfFDejBjUcinStLAQ8n7s5U=
X-Google-Smtp-Source: ABdhPJwkWP3y+Mykb97iSqNB1kWesZW1rkM7lpPOwVdCiKu991wkE1sXidQ8ZIAbtKxYNQZ3jHEEoq6WzX7zZv9X1rc=
X-Received: by 2002:a05:6402:34cb:: with SMTP id w11mr5218180edc.158.1642098086061;
 Thu, 13 Jan 2022 10:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-8-tanureal@opensource.cirrus.com> <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
 <66351fd6-f434-775f-d8d5-2a6baf098269@opensource.cirrus.com> <CAHp75Vc=x0AanRhkGHvbgs0M9VLdZfEFKJUxRTEMFvT5YwDtzA@mail.gmail.com>
In-Reply-To: <CAHp75Vc=x0AanRhkGHvbgs0M9VLdZfEFKJUxRTEMFvT5YwDtzA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jan 2022 20:19:40 +0200
Message-ID: <CAHp75Vc_Y+1SRryQn+=qpGqfNpRYS7ymGL+RifHdOwKcwsmF-Q@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA systems
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 8:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 13, 2022 at 6:53 PM Lucas tanure
> <tanureal@opensource.cirrus.com> wrote:
> > On 1/6/22 12:29, Andy Shevchenko wrote:
> > > On Fri, Dec 17, 2021 at 5:45 PM Lucas Tanure
> > > <tanureal@opensource.cirrus.com> wrote:

...

> > >> +        * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
> > >
> > > So, you need to add mapping tables and switch to regular APIs, tell
> > > me, why it won't work.

> > The part about how the driver access the ACPI table is going to be
> > improved later if possible.
> > The laptop has already shipped and doesn't have a _DSD node, so the
> > driver needs to read the reset GPIO from a hard coded index inside a
> > node that contains more than one cs35l41.
>
> We have a lot of cases like this, hint: `git grep -n -w
> devm_acpi_dev_add_driver_gpios`.

It's all described here: Documentation/firmware-guide/acpi/gpio-properties.rst

-- 
With Best Regards,
Andy Shevchenko
