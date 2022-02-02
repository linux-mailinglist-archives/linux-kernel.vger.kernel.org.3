Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05194A71D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiBBNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:46:39 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:38735 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiBBNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:46:38 -0500
Received: by mail-yb1-f178.google.com with SMTP id i62so61086523ybg.5;
        Wed, 02 Feb 2022 05:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMfXKNSp/PKEJRO6B8MpNpobz40F/YsHkwSpV9zn3C8=;
        b=lDqyTDS5h04JRpKy+KaxHIxkqDVNYL2ign6cPmvv/oVsOHXWny1rk2quPCveTw/dqy
         87MBTH9DJsImL3DoMaNFsVvFqPIsbFrCuJDC36/Apda355+2AkasQq0TWkPkJPmSMmFb
         ntfufLgaVN3RqOysSnvu8kKei1xjEQcloqM8gpC+crsTM+ks+8Dl5Dh6iQc/WiS1mSnB
         6i39ESgEeIBUlZu5mh3yjV/hpL+z+2RtzPY6Tt349otU7ZZUIC7uN05jwFanS88dIt+h
         OrHvHoIBQ+ugpuvOi7dQSMcpNwhLfVrVl5QoVBpVAPWwc0/FDBwXNTGxfjpxs8ZTLp/G
         B+xA==
X-Gm-Message-State: AOAM5300xRBPp/fFoTuQgAvzZL6535Ump5KMG8KGsgdBH4VHCU95e/NA
        wpSGS5TJm0qMYyfCw+4GOH3iRRes2++DVq24Nuw=
X-Google-Smtp-Source: ABdhPJxGneqVqvLbtm22adzeDHhuQjRs9yliiA/EmP362d17O6riUVorP/6DSgn9/SzfH5eCOLT679ieDKIMN3uNb7Q=
X-Received: by 2002:a25:cc97:: with SMTP id l145mr4526945ybf.272.1643809597658;
 Wed, 02 Feb 2022 05:46:37 -0800 (PST)
MIME-Version: 1.0
References: <1883502.PYKUYFuaPT@kreacher> <YfpQlQ6CH5eoRjuD@lahna>
In-Reply-To: <YfpQlQ6CH5eoRjuD@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Feb 2022 14:46:26 +0100
Message-ID: <CAJZ5v0ifQJ=XxXHUSnACzd2cTLRB+ncwEFrwLP0ybuivX2ORAg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Replace acpi_bus_get_device()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:36 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Feb 01, 2022 at 08:12:30PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Replace acpi_bus_get_device() that is going to be dropped with
> > acpi_fetch_acpi_dev().
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Let me know if you want me to pick this up.

Yes, please, if you can.
