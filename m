Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD248FFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiAQAMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:12:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48880
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbiAQAM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:12:29 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 581E7402A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642378343;
        bh=rwscmfN2VvXFl57KIDylnXT4uFX0erZr3MxoMOgqhYc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SJz9Egycd22hPcDWzZ0UTmn5X3Zsb1AFGwbtEu/lC67VmKAbUuLSeN+ZL4FzAljxt
         mHXXidOmlu/lO+BYHZfgWWACZyz0lfmefcxrQqxXvaGrbTM2okBJyQuguSjdZC11OI
         w9dNPB6xzHAIsD8HcpPrpfugD/aQk46q0SoXSykzgerHNePc8RCu941B50Msid9vgt
         ESY9OKiM52BiLJ8APfrK3KNZxVasmdRFZJuW89yxF+SSkiFV2N7XkRd2zbi1oAAdgh
         g8IJsZZmvdrucX7aag3LOIEzSFi2tpGCH7lekrG+BXOt4rjvo+e5PmWctk4AwHKul5
         HUGiSti8ZlY6A==
Received: by mail-ot1-f69.google.com with SMTP id v21-20020a05683018d500b00590a3479c4eso4988550ote.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwscmfN2VvXFl57KIDylnXT4uFX0erZr3MxoMOgqhYc=;
        b=xGk6wDlfObV5q9gTKULHvgR9aXnpwfMTfRJDMyxSEUlOZ6xnSCHMzJ/JLxZg2ULvGn
         k/TZYoBlwUXIITsz5CxLGhpaAsm5gsb50vUYg033ocUj/1E8qvCgQ5hZXd0AMRipI9or
         bi16C7GA9KR4QOC3qVURkcxX+AXrY+bLVO4gfK2anTBnycqugeigGILpjX9FW15zWKzA
         mFBIIdiWL/OEVmeD2cqCitpWlRIbdf1bigN0y2k7TIU92uB7zY0W9wNjpBk+ret/z8+c
         QsaEJ3fUXQrhqJm2cT3zSX84e8VDDS8+5B0pw9apjNVZSmuUT+F/cj1fgbCQuyK9WhAs
         zCxw==
X-Gm-Message-State: AOAM532L5fXWumTK7BNgDnkuKit8P6qeGgdwK9FgJGknYrs0zibK+0ug
        e8MGTMngD2boRpgSomXqi6uPVA2lYUaTyiT6lSQsm0Ix5QEbCO9KU/FQjg4z7z5BdmF10KG1W0r
        6K1mPY0OglPtXTY/vCK+4TUpRhlRjnKm/pLxjvudA1t90FXE5IrEaHAEJWQ==
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr14466569oth.233.1642378339918;
        Sun, 16 Jan 2022 16:12:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmTa4OSW+e+tPUzL+uPusjNQWVVyJk3wNYGeLJ1mjMfv2VVEg30AAbV0RtwuN/5IKjzG/RX3WJYkoKoLj6hlg=
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr14466553oth.233.1642378339620;
 Sun, 16 Jan 2022 16:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
 <20220114165050.ouw2nknuspclynro@localhost.localdomain> <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
 <20220115163208.xmvum6ehqcadonj7@localhost.localdomain>
In-Reply-To: <20220115163208.xmvum6ehqcadonj7@localhost.localdomain>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jan 2022 08:12:08 +0800
Message-ID: <CAAd53p64w38NCo7c0cnKCyjaswa0_Rns-CjWBwOnph3V5J2taQ@mail.gmail.com>
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

On Sun, Jan 16, 2022 at 12:26 AM Alexander Sergeyev
<sergeev917@gmail.com> wrote:
>
> On Sat, Jan 15, 2022 at 11:47:40PM +0800, Kai-Heng Feng wrote:
> > > Note that the device can boot up with working speakers and micmute LED
> > > without this patch, but the success rate would be quite low (order of
> > > 16 working boots across 709 boots) at least for the built-in drivers
> > > scenario. This also means that there are some timing issues during early
> > > boot and this patch is a workaround.
> >
> > Does this issue happen to warm boot (reboot) or cold boot?
>
> The issue is definitely not limited to warm boots only. I can confirm cold
> boots with no sound and also warm boots with functioning sound. With this in
> mind, the provided numbers (16 good boots across 709 boots) are largely coming
> from reboots since the testing was scripted and driven by SSH.

If this issue also happens to cold boot it seems to be a BIOS issue.

>
> > If the issue only happen to warm boot, please try reverting commit
> > 9d3fcb28f9b9 "Revert "PM: ACPI: reboot: Use S5 for reboot"".
> > Many HP systems requires it to have a functional reboot.
>
> Interesting. I haven't noticed anything breaking with reboots on this
> particular system (at least so far).

If possible, please still give that commit a try.

Kai-Heng
