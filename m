Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78A48F7A2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 16:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiAOPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 10:47:56 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50368
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbiAOPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 10:47:55 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D69040033
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642261674;
        bh=SCGx+pe7Mx58OJ6yNkGqzophzPntwDGYMFFr6horyKk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=l5bNrwPvPHlOVKiyYn1KV5H2/2xRzIZk7j2U8z5qTeRw6PF0k+MnAsDqwGrHiEw6N
         dUFiviCMr1BTX0sD3gznBYktrkiSMR3XKv6jBJRxWm2RPZYhg3sKGhiTEZvW643L96
         +TA/ASGm0Fg77AElXFwRBk0UQJFdKMdTTOfwumPeZNSqNyOcPuWkKGQdndScJacjQ4
         c7UZOZ2ElXLLzq8WU6zbaN60/or1wK9t0oB1EqbwRk9G98W3PaCzaGaZWK53icjvPW
         YQgSVDlJra3RrkQ+0ukEoDwkv3A1JpK+UA3Kg9L1AM+h4t63aIgn6dLXILAD8Css5J
         JvCQYXcznx/Iw==
Received: by mail-ot1-f69.google.com with SMTP id 39-20020a9d0eaa000000b0058f56d89582so2743006otj.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCGx+pe7Mx58OJ6yNkGqzophzPntwDGYMFFr6horyKk=;
        b=BeSx+d+HftZEWb+uScZ5LLsJ7+j1PFozA4LppO7exQwitLwF7KQb6pHpIzTLTFyFXN
         Biv4tcf+eBduiRgZ3DqemUKsW7l8/DLOGpBMucFACxPXOquqS6iuqwGR2/UZjpI1azm4
         50AHYefkyazGhaZieUlSGs+3RFQIUyCuLExVsjm7J9Rze9Zm0buggoCKEuMQ3POIYqpa
         U71DCT0qRVuRgONN1IMKQjb7TZ8EnB3zAhOhLUN4DCmxS75BpAoTfBQ7DUmNrkM4jQgo
         a3pr2dXNjQ1Wz2y8Zwl5xhm9G9MQyzo47Z9oPO6LUG3Bm5AU7uw3NY4IgPmfhYTbEVUL
         sjhQ==
X-Gm-Message-State: AOAM532b5S91hiE9UWUwUv9bovrE3vlGaeaiCVkWyQjETkJQvm5fm6rA
        1DfLhZQmuYIMlbdffxaA1D6RRRsrIPFR42hULAQiers//7Sw0a7LxbUvxCtgvUmHbJbPUPYNWQF
        hzjdEGVnoNYnhvOiqVl1W+WV6s01I9kIgYrkg53H40gIwKdCe8+SVnweiIw==
X-Received: by 2002:a05:6808:1985:: with SMTP id bj5mr5062757oib.146.1642261673190;
        Sat, 15 Jan 2022 07:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJws0fopQWorqJJDXM0Osf/+zxVftZOwozMAe4VcuVDfbySYsW+5BoINdwNBuJkmk16drIq87EQucC9uX2+1md0=
X-Received: by 2002:a05:6808:1985:: with SMTP id bj5mr5062746oib.146.1642261672871;
 Sat, 15 Jan 2022 07:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain> <20220114165050.ouw2nknuspclynro@localhost.localdomain>
In-Reply-To: <20220114165050.ouw2nknuspclynro@localhost.localdomain>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 15 Jan 2022 23:47:40 +0800
Message-ID: <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ALSA: hda/realtek: fix speakers and micmute on HP
 855 G8
To:     Alexander Sergeyev <sergeev917@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 12:46 AM Alexander Sergeyev
<sergeev917@gmail.com> wrote:
>
> There are several PCI ids associated with HP EliteBook 855 G8 Notebook
> PC. Commit 0e68c4b11f1e6 ("ALSA: hda/realtek: fix mute/micmute LEDs for
> HP 855 G8") covers 0x103c:0x8896, while this commit covers 0x103c:0x8895
> which needs some additional work on top of the quirk from 0e68c4b11f1e6.
>
> Note that the device can boot up with working speakers and micmute LED
> without this patch, but the success rate would be quite low (order of
> 16 working boots across 709 boots) at least for the built-in drivers
> scenario. This also means that there are some timing issues during early
> boot and this patch is a workaround.
>
> With this patch applied speakers and headphones are consistenly working,
> as well as mute/micmute LEDs and the internal microphone.

Does this issue happen to warm boot (reboot) or cold boot?
If the issue only happen to warm boot, please try reverting commit
9d3fcb28f9b9 "Revert "PM: ACPI: reboot: Use S5 for reboot"".
Many HP systems requires it to have a functional reboot.

Kai-Heng

>
> Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index eef973661b0a..668274e52674 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6948,6 +6948,7 @@ enum {
>         ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
>         ALC287_FIXUP_LEGION_16ACHG6,
>         ALC287_FIXUP_CS35L41_I2C_2,
> +       ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
>  };
>
>  static const struct hda_fixup alc269_fixups[] = {
> @@ -8698,6 +8699,16 @@ static const struct hda_fixup alc269_fixups[] = {
>                 .type = HDA_FIXUP_FUNC,
>                 .v.func = cs35l41_fixup_i2c_two,
>         },
> +       [ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED] = {
> +               .type = HDA_FIXUP_VERBS,
> +               .v.verbs = (const struct hda_verb[]) {
> +                        { 0x20, AC_VERB_SET_COEF_INDEX, 0x19 },
> +                        { 0x20, AC_VERB_SET_PROC_COEF, 0x8e11 },
> +                        { }
> +               },
> +               .chained = true,
> +               .chain_id = ALC285_FIXUP_HP_MUTE_LED,
> +       },
>  };
>
>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> @@ -8911,6 +8922,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
>         SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
>         SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
> +       SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
>         SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
>         SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
>         SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
> --
> 2.34.1
>
