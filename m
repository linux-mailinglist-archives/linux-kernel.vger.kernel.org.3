Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8A48A0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiAJUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiAJUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:16:35 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55216C06173F;
        Mon, 10 Jan 2022 12:16:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d7so8306971ybo.5;
        Mon, 10 Jan 2022 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0xQEeMfYAZWWLfQ25O7XnIoPfBpVaJVmwR4FfAbgLk=;
        b=PTLk8Dmkr/y6prAl62pFcK4STJOH3jrgkxpECkEj2HXVob0FHdLQ5JOBkL12TSk1oM
         tH2L5pIY+yhSGwwUg7WkgvlEgoTJkrs6ZFG+RVyeXoWNVPk1sufy+eMrhX/T3EPbBMqW
         4VZ0xujB/NY+2glfLjzV7W7iigh3P62QaL0Zzll06XqCfMZYAp8Iq4xgHT8tg0SzbG69
         MN4AIO5+tmaTqLz44tCrGYskywsLteutyI572lVGnPPZ+qZb5nzjmdBcLwAVj3w+P+GK
         bs1hpoXXpR9vA+A5j9GEOYUM0P9+Mx/W3A+I8FpgAmx0ZEFeblf6jP0Y4nTDBRvXfQRD
         EzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0xQEeMfYAZWWLfQ25O7XnIoPfBpVaJVmwR4FfAbgLk=;
        b=sAiJ2SsqK+7Yx5boqjBRYKO0YGqfX0R/Wxf6qeQzIKhndo411oVxyULNkT6Zhf5Wxk
         /IpaDdxFi96URvfk+uwEgqosIDWi+nZ9jCgxnNvWyKi7AfynwBhEKX9nuM1i6YPeDT64
         UUBE76j2yJZFScIo0sbvlRWD2F+X7kyLHBs/Ly26hQiVVYXUb4C1DkobuXdUjDjpTX0H
         7f6bf0uP4qYS8BryUU++9k0CkiekpYgBeghVo9cpjnkVMvAnIPN4SCj6GWMkVKuv3+gT
         gPq9iJHYRFih2o92qHnDnUcNBvFKP5sAhbIrnkFpT4+Ju9PtZcs/+tBmOLXPIQnAr5N4
         DL4A==
X-Gm-Message-State: AOAM5301v91qD3fDIrImJv+zmC5p7fOTzHhlWPw7vuGUyjkMcP1OfFej
        P4sE2ZCt6ls7Bnc2G3rVxttjTBuNCGZCsLNHo8NVm5rOatc=
X-Google-Smtp-Source: ABdhPJy5SZlMpv1Hol2xQ3klc0XaWlDB9uAoLFo2kw5RT28K2/HIw3OnQtl5+wJXnX8uTL6DGxNY2Mlh7fJ+wMLnC1g=
X-Received: by 2002:a05:6902:4e9:: with SMTP id w9mr784708ybs.186.1641845794594;
 Mon, 10 Jan 2022 12:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com> <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
 <f69a0650-174f-1b0d-ba29-7fe04c7cf211@intel.com>
In-Reply-To: <f69a0650-174f-1b0d-ba29-7fe04c7cf211@intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 10 Jan 2022 20:16:08 +0000
Message-ID: <CA+V-a8vJzSPxpy0Te1XUiT_zkt4wd=NvFJGvwGkgwcNnibjbhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:48 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2022-01-10 5:03 PM, Lad, Prabhakar wrote:
> > Hi Cezary,
> >
> > Thank you for the review.
> >
>
> ...
>
> >> Recursion and loops are means for doing something repeatedly. Could you
> >> specify _why_ such change was made i.e. the conversion from one method
> >> into the other? I bet the code is not being changed for the sake of
> >> changing it, the reason is simply missing in the commit message.
> >>
> > I had feedback from Pavel "recursion is unwelcome in kernel due to
> > limited stack use." which I did agree with as a result I have come up
> > with this patch. Also to add this driver will later be used on Renesas
> > RZ/A2 SoC's which runs with limited memory.
>
> Adding that reasoning to the commits message will prevent questions
> (such as mine) in the future. Thank you for a quick reply and a
> transparent answer.
>
My bad! I'll update the commit message.

CHeers,
Prabhakar
