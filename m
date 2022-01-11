Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7848B3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiAKRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiAKRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:22:19 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C74C06173F;
        Tue, 11 Jan 2022 09:22:19 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i14so23393221ioj.12;
        Tue, 11 Jan 2022 09:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4PSF1qKJn9d8H1hOu0YBwxP6y9n6SgeAApu4vyXpdo=;
        b=hQcc/9xody5O8hUkmBv5hW5FFhQIAhbDH3ytiOPvcL/imXoeAvZm81jeGqhF0mRNLs
         Tz3NM0Zaw3wah+uDZgDFWdMLeCJI6ryZbzUOwDkT5A3WOchUFBmw0O0b09TOaHsdh113
         2ty/s/njqgoAIK3vRObywFYVkuyIlvvcOG4LGJB43sCVTEUGO6swkHNSrSC5rw4xF5uw
         9JLNdM1hAMSsIYb2XChYZ4ze+AMFcBnASYLefO0m5IYCPk0zyqoojoc/oirOoGt5e50J
         VUSa48S7YXEjI1gM/oodvHQd0v1lmvj23t99Zafb4ABY/5plKQKHpxlb53v5FhUeH/G/
         lZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4PSF1qKJn9d8H1hOu0YBwxP6y9n6SgeAApu4vyXpdo=;
        b=DFDlfVJNODPt9cr4drYnrOPM791gyXzLtuqIzwiaQYH93JDWdIbAAlvZVXmueAovj4
         jNGSLsdhZVuM/xNLT3GcLzK5R/q143tW/02GzVXlzATVt61208fpAbLcfPYFB3sJfUd2
         nAJ2ZZVNvyX2JQihOcNUDgnIf/vo+Z1qVlpHC9RlQI/xQ0w6W8LsB65RAIt/KeY/qNYx
         px/AhA7j+pQGf0YffIl/D57yg/l4q9PkTNCOciHaoA3zRjMPRFr536ktK3Og7aCk2dsp
         L5fDGsNY0HZz3pYSZSWMlDI8kMf3/QHDsjsjWt6AiR8T/977E7NfCjDlpiXoCl9QPLdL
         1TJw==
X-Gm-Message-State: AOAM533z/gseovM1IjpbmNmFzJCxIuj1aXy+hh14vzSf+Ah+n8+beMP8
        Xw7IyHkpNVGR9bsCUumQd2LzeWFrlbBTnuqze5s=
X-Google-Smtp-Source: ABdhPJwaWvvhYZt95uzkBI3IFBkQpOcFZp0j2qe06DezXWmKxadseVJf6IkwVafwifBmW6WnftXxvuzZuDhyU5ENUEw=
X-Received: by 2002:a05:6602:330e:: with SMTP id b14mr2794462ioz.192.1641921739232;
 Tue, 11 Jan 2022 09:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com> <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
In-Reply-To: <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 11 Jan 2022 18:22:08 +0100
Message-ID: <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not see the point of marking this as doc strings
=E2=80=A6
> and neither this one, nor anywhere else where "**" is used.
> The resulting "documentation" is just confusing and provides no value.

My editor shows nice tooltips for /** comments and I did not realise
kernel doc processes
all the source unconditionally. Anyway, I removed them.

> Why not just "sensors" directly ? Is there ever going to be anything else=
 ?
> If not, the value could be added to the dmi array directly without pointe=
r
> indirection.

I once had an ASUS board where they changed board headers in some
hardware revision. I suspect the EC sensors
interface is valid for their other boards too, we just need users to
collect those data. It's quite possible that the DMI
board version would change in that case, so that we can add another
DMI match if required.
So, I'll take your advice and move the sensors to the driver_data field.

> FWIW, MODULE_VERSION tends to have zero value since it tends to end up
> not being updated.

Setting the value to 0 then :)

Best regards,
Eugene
