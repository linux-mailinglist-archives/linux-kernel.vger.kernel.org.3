Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6049BA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiAYRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:43:28 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:44599 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384367AbiAYRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:43:14 -0500
Received: by mail-yb1-f170.google.com with SMTP id r65so60307289ybc.11;
        Tue, 25 Jan 2022 09:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5LCOpXnnaSA7LGKNVoZuc39uqR/t80O6SBc4Hc6VI4=;
        b=ZBVOj1vRN2LhTfdcajSNacAdHB7LrAx0J4U9toowaiAaSoKUld/YXy2hgSSuYV39l4
         eEI/8gqlJwGRzDYqdgUQ/tAKPXF/05C/bndEVEEyaYlattSMeXS+tQo/UWJG1aB7bNrB
         588C0Gl3Vlfqj5HokLRRn7SIHHHNJv86P6EGXtaJbnyOQEmnf/GIOEsm9cTJluqufPTZ
         gvoOmiqKie2/yAZUi4gJ50Kdx3gTRPaBRWHa5pPJ0Ams8Yp2IQTbXMYM5S1lCduPFji8
         gB4vhOkz9OnnB+4r2H3DN1J+lCKw3F9wSEBxnvxkL15w6LHKDaznWdAWVPAj2Ja8ce/Z
         EoKg==
X-Gm-Message-State: AOAM533v12XHPS4Q58S/uJliQVcoOQGVyW954Lh9ZnbIb8XR96iIM/Kv
        YDyfRgiiH06+FPRsaoxjYvuvClYyVTcpPkAycBQ=
X-Google-Smtp-Source: ABdhPJzWrkyhNzEHHGNrGilfHeJ24YAuVmnXrkjxry4FZ7IcPsq41xXQKu3Z2Ybiq2ilCq431lsH1ZuzYa7paG6SCW4=
X-Received: by 2002:a25:b8f:: with SMTP id 137mr19338331ybl.330.1643132593224;
 Tue, 25 Jan 2022 09:43:13 -0800 (PST)
MIME-Version: 1.0
References: <2614912.mvXUDI8C0e@kreacher> <CAK8P3a1vQj10a4ztj8KfSuxGkOfooB=6q0xj_s5pmhzoS00S1w@mail.gmail.com>
In-Reply-To: <CAK8P3a1vQj10a4ztj8KfSuxGkOfooB=6q0xj_s5pmhzoS00S1w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 18:43:02 +0100
Message-ID: <CAJZ5v0gGd-62R0uB3z+h96RFuvmOoHFGdDSjiFcJUvRg4BT9zg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use uintptr_t and offsetof() in Linux kernel builds
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 9:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jan 11, 2022 at 4:55 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > To avoid "performing pointer subtraction with a null pointer has
> > undefined behavior" compiler warnings, use uintptr_t and offsetof()
> > that are always available during Linux kernel builds to define
> > acpi_uintptr_t and the ACPI_TO_INTEGER() and ACPI_OFFSET() macros.
> >
> > Based on earlier proposal from Arnd Bergmann.
> >
> > Link: https://lore.kernel.org/linux-acpi/20210927121338.938994-1-arnd@kernel.org
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks for the follow-up. I can't easily test this at the moment, but
> it looks correct to
> me. I had a different approach that I had planned to eventually
> submit, but yours
> looks better anyway, so let's go with this.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thank you, I've applied this patch as 5.18 material.

A pull request for the analogous change in the upstream code base has
been submitted and Bob is going to take it AFAICS.
