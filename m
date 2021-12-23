Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601A47E0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbhLWJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:51:15 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhLWJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:51:14 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmD6U-1ma6gj1Y0W-00iAq1 for <linux-kernel@vger.kernel.org>; Thu, 23 Dec
 2021 10:51:13 +0100
Received: by mail-wr1-f41.google.com with SMTP id s1so10408054wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 01:51:13 -0800 (PST)
X-Gm-Message-State: AOAM531MjOmy1FTJ4z4HyFCL1TkjGaRny1x951cWWow0Ai61GCgRBIrZ
        nI0EoCwQtBVNMDpuH5ySmXCI6oxP4zy2TLbFQZc=
X-Google-Smtp-Source: ABdhPJxbiy67vbIKF+PC0Ortg5gYqzho45Ifd8/DY0eRSUq4tS0MenQuAZO8f9A3NCeKMTzXS7GoNge5psxiGbsTnGc=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr1164430wrs.219.1640253073035;
 Thu, 23 Dec 2021 01:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20211223094040.15349-1-vigneshr@ti.com> <20211223094040.15349-2-vigneshr@ti.com>
In-Reply-To: <20211223094040.15349-2-vigneshr@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Dec 2021 10:50:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1s7Ekhvwvt0DtndxwkzMwCD-2Y7Va58T_8gDdL0vZNVg@mail.gmail.com>
Message-ID: <CAK8P3a1s7Ekhvwvt0DtndxwkzMwCD-2Y7Va58T_8gDdL0vZNVg@mail.gmail.com>
Subject: Re: [GIT PULL v2 2/2] arm64: dts: TI K3 updates for v5.17
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC <soc@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aKTQaG+P92TP9AtOLZnlfu2uO1iHqZ2pD7FookFK4FTV6ihEGjG
 z+TSsImE0V33sC40MAhoI3u0CQlp+G4JCW99UvUsw5stQBtSI0d4BY3xjwqR0/iUTVDnQtU
 XxY8D7ANOgxiKbkeABOemoccE+4ru4C1ZnVqyZ0olXJXOT7NIDGmYpskeU0m88HY4Z3qRne
 85QTrOsVnLNIlFbdUeqow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2kBImYeKfms=:uhBxSpalWql/B8RInOW7Ez
 BhKkPg5Mwi3fF/hYP8FhQRN6JSWMqWPEkFcb2MmHLD5w2AFc6454fd6XQI3S2gmyKp8x3iJZY
 Ax6Q2qG2rTaY1PvCdwpxrOIE0tBhxjLfnV+W3JD2pAc10oIJwhSjxwXyx6IkPRJ5OBEH/Tdjz
 Ila/hZVFtBVPuWdSM2fY4jaFjv5eXVrrP+I26GWZcNTJ3Wk0gJJYarGO3OpXQhYb6HGlxEri0
 s9fNUhrz3l/sZsPWpKS+iZJ6SyOeMtWf51ld24IDfpO9MssM/j8mCwzfkrfcYV8rsBqlB0jwT
 U1N1K4AlvkVvbEt34YNz8yi5mWwR/IFb5HNdDjtC9swnmUbgAlqUaNi4DSTBI72buLo0E/fgx
 /ajWhOFPKkzVQNHnSiEW7sh7UoN/YKw9/qllz/JF8YR0WOzndEqXVI0dYCsPuE4hg/x44bM2O
 VlO0D3f0SCnrWuS657a7/UJR0s6z0prEUgVfJArLZZDHHgctYmsnDPLlXZ3+YwDKJTd8B7oSC
 9/oZ0+JIa50pwx3ndqjsAh87A27CCv1fnVFV89gB4kvTyfZMLpFpWfApk09f39yn6Ew9kTVAN
 Xr3JxretpqNYSUoo7RuRmBMD82L0P12xfyR8q3gWKDbJ4wtA1J3MthxAZ84Xs1tBaXrxvfFqV
 +gZxfqZF1qHK1xp8bkU3vGhf0deFEB4GWGjmgU+HR/dOgjIhybEW24yOVOlLVxNxkaJY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 10:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi,
>
> Please pull the device tree changes for TI K3 platforms for v5.17.
>
> Please note:
> This adds a dtbs_check warning due to missing YAML binding for pinctrl-single compatible.
> There also a checkpatch error for complex macro usage in dt-bindings
> header defining pinmux marco which is harmless.
>
> v2:
> Moved aliases from k3-j721s2.dtsi file and trimmed the list
> as per Arnd's suggestion

Sorry, I should have been clearer about what I asked from you. I have already
pulled the first version of this branch, and a lot of stuff on top of
it, so I can't
easily replace the contents with a new version.

Can you send just patches for the difference between the two versions so we
can apply that on top?

        Arnd
