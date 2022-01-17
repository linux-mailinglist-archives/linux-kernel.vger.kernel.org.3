Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D515A49107C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiAQSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:52:38 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34358 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiAQSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:52:36 -0500
Received: by mail-qt1-f179.google.com with SMTP id y10so20095079qtw.1;
        Mon, 17 Jan 2022 10:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIJ5TezUW0gOVcxYESXX/bvlayB02U32YgdHRb0vJMY=;
        b=Mmt760SCPkW1mF8N36Rl/DkPW/Jyfq8LiOXbS8I5ULFukJSy6LvljWDi/e4kJa/T41
         5YrNFOzyhZyzjLZRgsYkvsidnBkmRNcBdSuoLHrw1RXUduxB77yL+y2p1DUElj7Crlzt
         vtoUcToS6Z6qzlw6HTNRQS2+z6Qe7kr6st25RDATn3gH8lSj8y+3F/+CbbeSXUuX4KsS
         PKTePuItXo36MOZXyHL6bKtS/RXhFcu9IP5d2t4S/3c6O5jJ71zHi0VlRps1/PeCyH2v
         hkxAxYliSHd+raB2pZvChzS2tYItl583Wuhr4i9ID1K8j8B6t2jYZcuXookExuw79qaY
         A1lA==
X-Gm-Message-State: AOAM533X4RnhAJSDAayeqgL47D47dOdg0hs+1FSQPES4nu+nKN/1Uiji
        wTkyOj9i+k//tsCn+BkJFemdboeAcvvmeuQ7nX3q/t4D
X-Google-Smtp-Source: ABdhPJxH+SJ1sdZPrnz4zcNZsKQDXvkTBbxK0veFscyvWaZ0R0VeWmvRQzae1Hr9wAmknqAHDhuLelVNgL/WhiBV0tg=
X-Received: by 2002:ac8:578d:: with SMTP id v13mr4089436qta.472.1642445555650;
 Mon, 17 Jan 2022 10:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jan 2022 19:52:24 +0100
Message-ID: <CAJZ5v0iVXbXVnUA4=j6G+texb=KTXjipRigFbYb9tEL7E9BThw@mail.gmail.com>
Subject: Re: [PATCH 0/3] DPTF IDs for Raptor Lake
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 12:24 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add ACPI and PCI device ids for Raptor Lake DPTF support.
>
> Srinivas Pandruvada (3):
>   ACPI: DPTF: Support Raptor Lake
>   thermal: int340x: Support Raptor Lake
>   thermal: int340x: Add Raptor Lake PCI device id
>
>  drivers/acpi/dptf/dptf_pch_fivr.c                           | 1 +
>  drivers/acpi/dptf/dptf_power.c                              | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c                         | 6 ++++++
>  drivers/acpi/fan.h                                          | 1 +
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 1 +
>  .../intel/int340x_thermal/processor_thermal_device.h        | 1 +
>  .../intel/int340x_thermal/processor_thermal_device_pci.c    | 1 +
>  8 files changed, 14 insertions(+)
>
> --

All 3 patches applied as 5.17-rc material, thanks!
