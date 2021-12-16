Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229374777BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhLPQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhLPQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:15:14 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:15:14 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id 30so48017665uag.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ywxY5tdrdps9fttgpayP687vhVuBUauIZe1xmCWLRU=;
        b=tSpNkwVAUK+mf59orsKdbzn/4affyJHuYn8LmGSLh54mNq2jfSoWELqf7qOeGGaoz5
         gFDtMf8RhnbMB20y/XbioaY5TL3NOVGtDROt5SQP2EnyFHGw/8GQz/ETqF8sPU0q53UY
         bwwvtTOX/qwd8GHbCQPTsJpgNb4xAVDK3dlVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ywxY5tdrdps9fttgpayP687vhVuBUauIZe1xmCWLRU=;
        b=SE1XAtdb6Egk/FrnLgq4KuB/YcB3JC3iOF0z5i1qBZrb9AL8AToeUBMCuueXfNexUt
         UGyloFTcfwGW6evAwyToiVEtkNCR9iKHp70Jy8/3z2pXt+InaTY9jefLLkVhBEE+2L68
         JCl3AH6N0GcQj3NfDp058IEHOu2Eeqe8Miqf46latXBthjLTLUD3RsZu9WlEPrIIXTWo
         jOr5tgH/+/aty0PSk4RlRUTl1FeYZ9knrWAkZiKDmiybBVx672C+PxxqAuYEizSELGn7
         nx7sHBU87dnyKtF9kwhs7ZHxYeozrPJCTSjU44UJ0b9sUDyDfS3htK6/6b57Zbu/Wxh+
         Jizw==
X-Gm-Message-State: AOAM532p5dkBG1XKnDPcNSzEi1N3/+k78tG/xihECcW/NXVUsYw19omP
        bgOVMKX/WH73IR7DwQ+6HzAu4V0PXi5NeHUr4qheHg==
X-Google-Smtp-Source: ABdhPJxduTFNOMMXRodhEvw01iqWoZkcDRli6ZrQmghTHAkiqkZtC2PFQC4DFVKQDk9OOX8iYZXGR7WIP5K87LJ8Yfw=
X-Received: by 2002:a05:6102:3a0c:: with SMTP id b12mr5830681vsu.48.1639671313049;
 Thu, 16 Dec 2021 08:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20211216105246.3548133-1-daniel@0x0f.com> <CABgxDoKJRc_qORcpFx=eNPS=bGV68hPrbeH0VtcQ2Jjx2ruqmg@mail.gmail.com>
In-Reply-To: <CABgxDoKJRc_qORcpFx=eNPS=bGV68hPrbeH0VtcQ2Jjx2ruqmg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 17 Dec 2021 01:18:17 +0900
Message-ID: <CAFr9PX=AAssT1imCfpU_piGBOemD23RGBZzngznyia-4TXrK=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: mstar: Initial Miyoo Mini support
To:     Romain Perier <romain.perier@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Fri, 17 Dec 2021 at 00:53, Romain Perier <romain.perier@gmail.com> wrote=
:
>
> Hi Daniel,
>
> Le jeu. 16 d=C3=A9c. 2021 =C3=A0 11:52, Daniel Palmer <daniel@0x0f.com> a=
 =C3=A9crit :
>>
>>   - I've left the link tags as-is as using them for linking
>>     to background info seems acceptable.
>
>
> https://www.kernel.org/doc/html/latest/maintainer/configure-git.html#crea=
ting-commit-links-to-lore-kernel-org

The explanation of Link seem to have been updated recently in
1f57bd42b77cdc4b8e05ba9f4417872a6691b66d
(https://www.kernel.org/doc/html/latest/process/submitting-patches.html#des=
cribe-your-changes
a few paragraphs down).

My reading of the paragraph since that commit is: Explain what the
commit does in the commit message. If there is a bug that prompted the
change then link it. If there is some background for the commit then
link it.

If it needs to be changed around I'll do that but I personally think
it looks nicer. It seems like the right way to provide links to
datasheets etc without putting a bunch of long messy urls into the
commit message.

Cheers,

Daniel
