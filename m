Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1F495442
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbiATSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:35:12 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:35763 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiATSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:35:05 -0500
Received: by mail-qt1-f169.google.com with SMTP id 14so7178081qty.2;
        Thu, 20 Jan 2022 10:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHUSnLFWVr68wK0Ueu0o2cPAOvYPnfmPNV0janXaZlA=;
        b=Od9DBn+/TilX42LQDllS2dZ+9svRWhDVSKGssMkOwWd/RJQ+M5F11U3+hl3oKAw960
         6G2/pCpR/bFHFrJ4Q/lWW6sSYi6XaLJ731DzlDfHkLrc5pIa7H6Pau7vxr86qpdX9EPU
         74sDuBPYV0GpKNDXz2m+J55zT/QIcd3YcBpZ6fqA5B9mK92pIgfv2HtW/MwRTJofEFUH
         XP5eqPWA1/GVXLoVA4kYINJgct3IGiI/Q9JrNu4q1bxCHO04A2/rTkJSpBTqHh6/1LJh
         kgLzXrsurTnbnVA30/qJV+9IXjDn5Vt5oPfomTRAouIlPeDEQRmdHGyGH7PODH9W0HVN
         WKfw==
X-Gm-Message-State: AOAM530LHMfZZihVYwElgmqfBcPbBCXgyFlmXAm646n9Snud9sOkTVMD
        CTfZe0oObLRrSOul/KLvVOyWoMy/76kJ2x6BMIIFNYc/
X-Google-Smtp-Source: ABdhPJxh8V2QeLQ/nWDipxCe0AWBLibWjl1rR7AAvTNd5Zde1YaKr6zv8pxnq0y9HBHVpHGY9eLCQVr2gN8l/fCMgfc=
X-Received: by 2002:a05:622a:1881:: with SMTP id v1mr256994qtc.327.1642703703992;
 Thu, 20 Jan 2022 10:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com> <20220120134326.5295-6-sbinding@opensource.cirrus.com>
In-Reply-To: <20220120134326.5295-6-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jan 2022 19:34:53 +0100
Message-ID: <CAJZ5v0hMdfnu5PUk3sPvzF_f+xvWaRkE=BUpSAFx_DJ9sB+JDw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] platform/x86: i2c-multi-instantiate: Rename it for
 a generic bus driver name
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 2:43 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>
> Rename I2C multi instantiate driver to bus-multi-instantiate for
> upcoming addition of SPI support

TBH, I don't particularly like the new naming.

Namely, the "bus" part seems overly generic (and the "bmi"
abbreviation brings something totally different to mind).

AFAICS this can cover serial interfaces only and specifically the ones
where serial links can be represented as resources returned by the
ACPI _CRS object.

I would call it serial-multi-instance or similar.
