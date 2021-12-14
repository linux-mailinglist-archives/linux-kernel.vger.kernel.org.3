Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5093447492B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhLNRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLNRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:21:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D68C061574;
        Tue, 14 Dec 2021 09:21:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so16740788wmj.5;
        Tue, 14 Dec 2021 09:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xs9607BDx2T01u5LqyPaCAPyvesOcrbFjspbhqFitRc=;
        b=jZD4QsWD9EHLJLspQN8NnHR3EIUz/Vl4QL1JHjeRVvh/5MoYOixQoVvVBbfOl+JWbs
         wWUlX7dhyGC6F68DWdY5nsH3O/DjCR/M+1z8L5NpGJiA8gWffbveRPGQwS3aOK7ZMfIc
         TsmJM6aQNXvCqwFWsHQeuAoRubFg0ll5RbZvT/Kjaq12J8eGzxys1IA9ya1LVUavt2x2
         zxB9axRsPLshtyqAT0IpO13LQWYz5yJXWW5h9VehaUQyFRzoKAmDEKj4r/Bk2mX3EWQD
         qubt5CRWH2jvfFJaxQWlj3KUL0A0UK/52kVbhd/0jkCYakH+mVwgEzWNFPEMNoppOo2D
         rz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xs9607BDx2T01u5LqyPaCAPyvesOcrbFjspbhqFitRc=;
        b=WnZ4lR3cAq26TG4gOa3pqqW4WzUxux+gmcaT91AjLpze+zCC5bH9eDhwcmvuI+fYi9
         Y76LtTLwvSvYxO/2DoG/fS+STBHnHU//EGFSZS4543a3lZOp6fqiY09/KO08M2euOJiU
         l7HCJOGN7+tdweJFW2SeOLMx6+gXSlwGkqIoiasMQ86pO4aEJRrjPN1obnP0NdqC+w6e
         Uhy/uyxU4nbpURYbYRVqXswvAYZ4bBRyOi2o1Ve/C9QaNE9Zo9sZPVcBtN5jSSN2WnHh
         D+Q1R93CX/JEiOT8rVxbFuIrBWyURYSlWwn5Izgxkal536F8JwTo6kC559XtKC3XIosI
         sXeQ==
X-Gm-Message-State: AOAM5302wwZch5/q5s41Ti0NqaU/Ms3K7VOZ5Q/zCSxYeVBfmrAU65GD
        PLOhAClDdxJqohX8RzYfEpqxFFKwhQ1qVWphJBg=
X-Google-Smtp-Source: ABdhPJz2j774LLWhSct0g9YlaoUSrM0H3bM6tJPmvkDzP75CZG4hVTgym+YAuXScBjS4vDsslvt6j2Y7q1Y1Sr3VSio=
X-Received: by 2002:a05:600c:500a:: with SMTP id n10mr295300wmr.136.1639502499047;
 Tue, 14 Dec 2021 09:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20211214030215.3181149-1-broonie@kernel.org> <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
In-Reply-To: <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 Dec 2021 19:21:25 +0200
Message-ID: <CAEnQRZB9E4uBDuUidiJ+QJnQhGZp43jig4q93Pkw3pSr=K48YQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 13 (SND_AMD_ACP_CONFIG)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

This should be fixed by https://github.com/thesofproject/linux/pull/3284

Let me quickly send this to alsa-devel.


On Tue, Dec 14, 2021 at 12:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 12/13/21 19:02, broonie@kernel.org wrote:
> > Hi all,
> >
> > Non-merge commits (relative to Linus' tree): 5960
> >  6555 files changed, 277265 insertions(+), 120864 deletions(-)
> >
> > ----------------------------------------------------------------------------
> >
>
> on i386 or x86_64:
>
> when # CONFIG_ACPI is not set,
> so SND_SOC_ACPI is not set:
>
> WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_ACPI [=n]
>   Selected by [y]:
>   - SND_SOC_AMD_ACP_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && X86 [=y] && PCI [=y]
>
>
> Full randconfig file is attached
>
> --
> ~Randy
