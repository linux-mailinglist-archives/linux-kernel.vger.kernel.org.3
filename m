Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E748661F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiAFOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiAFOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:34:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E054C061245;
        Thu,  6 Jan 2022 06:34:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 30so8546754edv.3;
        Thu, 06 Jan 2022 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FobZFKR3ktosOzan7NztFj7JY9CFV7TYjbXDVZknTnA=;
        b=f0G+OVXckKpe5TRarnXTa3N7O2i0E+LM+JlAKrQda7V3sjkTpF4q0cDofAtWsOK13w
         y+LCfACqK/Ppr5Pvtrz5B30r5bBSM9rM/RBbd/6mwVdD19QblWDSXuF6DzE5Eiy9vSJS
         CVkfatmoyyBRu3f3J//6BNWXJxvtdKsmqcPChx1joxQ+Un76/Ln0YSWWICQnYId4M9+W
         ubYQrQCvzh2rIbB1wbaBeFlq5HjEsFPLHuWe+rijpIrdjvBWXQl9b3M1rI1xQ/sfe4Hi
         t4IMgx+pbGrGlM+LYT8CNbtnDsmG7ekkCwuUbRmBxAtXIJTBy4XOX1teN0R0b7r/l23d
         koGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FobZFKR3ktosOzan7NztFj7JY9CFV7TYjbXDVZknTnA=;
        b=ennaD7LikLZdYD4IYVj3NtsyapvHFx+g6ph6ZNIbIG0QaEjnTZ5V6A4x+sHQYKqNbx
         SNawSUCXhe7mh00fScpAl00CydUNWXoOvzE4Gvn3dJ/74ZGpxjc4pat9aqRiulCuXJrP
         WoRvcK+qz9UG8bwABFJoou/FnClfEtkDLVR5uguFLaMtnUx73iZV+RkUphXiOFBhPumf
         dQvKouVb9I36J6jZ/WwEZZZC9K9GkpFzTHTeX+ZctzkmuXb9yrAKF0Fij/l7SyDKjXia
         7RQlmLvc+rLiDEDQZJdmc5ZH+4q0u3yL8cgPhu4DVZ3mfoUAx2z9WQTSabCtKQMBHtNR
         +RvQ==
X-Gm-Message-State: AOAM531E+nM2zODKcAp3VJSK+3uLnMAs/O6iv+DkEgdgis04DHvIFNSQ
        1EtZaMm56xGXoMv6XmPyCf6ZsfJctrryV7fLSPfcyD1PfrZLhg==
X-Google-Smtp-Source: ABdhPJxFTTW5eEBwAQwjqvLVigTgsAyHhGmbRbQOwdT2va/JiYwDVTaHsnL0gfkBoGo103l3it4k7dOOl//rChRNfRA=
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr56420317edd.158.1641479646167;
 Thu, 06 Jan 2022 06:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20220106044350.930087-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220106044350.930087-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:33:30 +0200
Message-ID: <CAHp75VektuiaaR-MKJPXMXGUXj5wXrKtp7bqdAUqhfojdSnmJw@mail.gmail.com>
Subject: Re: [PATCH] iio: dps310: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 6:44 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "IFX3100" to for dps310 device.
>
> So add an ACPI match table for that accordingly.

All the same comments as per hdc100x patch.

-- 
With Best Regards,
Andy Shevchenko
