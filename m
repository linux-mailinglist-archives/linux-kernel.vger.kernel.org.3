Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10144962B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381766AbiAUQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351427AbiAUQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:20:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89579C06173B;
        Fri, 21 Jan 2022 08:20:49 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g81so28983799ybg.10;
        Fri, 21 Jan 2022 08:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMLla9J2INC0Vjwi8Lph9kO0OuNVjhQ8NGl6/GPtYik=;
        b=I1DkqQiisObWIoRLxUT1Q/CBxP+yf0P5bmeTa2AZP6svHXmb4OvJt7EGDuwWQZPAlx
         T4/t0Dz5pezEgh+X0ARuIs8N2pBnN9/uTF6+Plp52J/cVozLGNtjGLu0PJpawPA290iG
         qau3z33UpCJogjrQ8KcJGJUQNcaEhl3P244zNZA9LrBu9mOHMgATS4sX+Hs/KL0nmIBf
         Z4Vqz9DnZwHxaNxAcvmj0osELWznATh0JJzzX3z0mgwcPRrKiwYPn8YEqHH3N/jYjnAp
         +Jf9rA8NzC+LGe6A4Z/fsrZtmk9arm7JwU26zjiPLGUILjsABq9rXBqYa218b8nahMWX
         RjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMLla9J2INC0Vjwi8Lph9kO0OuNVjhQ8NGl6/GPtYik=;
        b=0vJ7fRmuSOeLvP3if9U5anLEHf7LrYYEY4OZlM0Yq/c8P9QcLPNTBPQWk+2KXKtLuH
         Jkr/GmaL4gMcjmyHMNYQiIrNquOSMqO40v6gX77HfXzOUdPu9rCZRaNttpV+blQxeznQ
         uFiTG0ETFCAuhAozgtheNVSY6r5nYnlKa5SqNodUpZnkYtU2ZxyoScNUGO6Ektc8sKKG
         ZSkaNTdVQPRMhAG4qwF5nR7WD5ei3WM6G4FBk8M5+FFzOB+hJQrM7ZVokP07Uh6Xrc9p
         4I/OP/yqVOK9TSK8wJwpTLQAd2DM9GyCSMLCwbdoO+KM/seD9+d3DeA1hVFthJ6kGbDY
         +C5A==
X-Gm-Message-State: AOAM532T0IirQRpD1nlMFjxCNxJLRG5QD6GyGS6WBO0LhQKN2HHCyiOi
        XWfHUUXqra2MuL+uQtjVaeFlbbmD1+99+Ha8HQqyLTDS5Yw=
X-Google-Smtp-Source: ABdhPJxujopegNMJe7IXwxvo9WoiX5lHP73EK+e41btqwJdPRQlwHBqzQ8UfWswuqNqLifI9iDL3q+yYKYe82RrP3B0=
X-Received: by 2002:a5b:281:: with SMTP id x1mr6963572ybl.41.1642782048593;
 Fri, 21 Jan 2022 08:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUbK4BoYo1+L9DF9f12HSuAjR-wfE5GAi2EfftPnCEknA@mail.gmail.com>
In-Reply-To: <CAMuHMdUbK4BoYo1+L9DF9f12HSuAjR-wfE5GAi2EfftPnCEknA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Jan 2022 16:20:22 +0000
Message-ID: <CA+V-a8sg=A2ntsurfj9vqjsUu-G-Jrpd7HJ+4+nSV6rgkL8mvQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: clock: Add R9A07G054 CPG Clock and
 Reset Definitions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Jan 21, 2022 at 2:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar, Biju,
>
> On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Define RZ/V2L (R9A07G054) Clock Pulse Generator Core Clock and module
> > clock outputs, as listed in Table 7.1.4.2 ("Clock List r1.0") and also
> > add Reset definitions referring to registers CPG_RST_* in Section 7.2.3
> > ("Register configuration") of the RZ/V2L Hardware User's Manual (Rev.1.00,
> > Nov.2021).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Before I queue this in renesas-clk-for-v5.18, I'm wondering if you
> want to add the DRP_M, DRP_D, and DRP_A core clocks, too?
>
Good point lets get everything in one shot, I'll send a v2 including
the above core clocks.

Cheers,
Prabhakar
