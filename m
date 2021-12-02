Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A28466248
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357321AbhLBL2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357315AbhLBL21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:28:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19AC061758;
        Thu,  2 Dec 2021 03:25:05 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id a11so28242096ilj.6;
        Thu, 02 Dec 2021 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U97NXkXMnWDrCjkhCrTSI8Q6yXefya2V7KMT5t4xUcM=;
        b=I6PEU2aVaTVUTX1OnzKBPKyVa8L999yDFs1+GW/EcADQr0sr41aEQ1cpdrzez1f6yC
         9qIX/a5ydbdfWLfFy/kf/4kxDqiUO9KtXTJBRS+JLxgQNCVpY0HAHDZJ6iAnlSjjg9rB
         ztpB7rlPIu5m23/7ZL/HVl+MNqL3mnwvLmW21KXZV/Z8naEYWoJlKsNbvLMv3endgPqs
         Mj/RANB9ZHYZtp3R486TIo8lysUdFlrb1jmReu9yJWLpdfTWUWzv63yHatzYZ8IRxo3u
         yefGyPLzDY0DQwamTwvz/tNIk3qPMTQdsGBBtQVeRmKxERSMISd12Wn84G/rh3Hn/6j7
         0SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U97NXkXMnWDrCjkhCrTSI8Q6yXefya2V7KMT5t4xUcM=;
        b=GYAAxeAHif2q/YztyE3DwRAuNZKISpjt9TAgMMZEKm/sjdZiWQiZPgxVGOMtbsvZ4W
         nEIz/LUB++hE593ED5U+hUI2UG0zn8FzCB4QvaMi6IFuX3b/e82mNFgnECrfdHvqVK39
         b3IRfMMcRuQA57/AyUrrkstWoN1jINI8gaBMj99zd+TG3EvXVYfoXtxPqu7S1xb+vlRw
         bQU6QxaMzjPI8Z236rgPTzECKcEtPqDtoPoYvV9YdCCOjJ2SF8dsQOjKhdqxmH64s6D2
         dMuO4pLzLHODknOQTmfOxsGrtFO4dk0ZoQ6PZzKdguJaIKeogqXVoTEzJeINaeFAIoL4
         OIQQ==
X-Gm-Message-State: AOAM5314wcagbb0DJdrK6NIhxu+PFU2eGMpvtwmxt14q720x0tt74PtO
        QxnkRW1wpqzUJ+MTYLPzdLaV9AflB+eAotWGTIk=
X-Google-Smtp-Source: ABdhPJy6HxVb8T3Q0N5gt9YmS0coT/tzCF55ptsNSTasFB93m4XHrM6KdaPYgitrZSge6lCNwAj+o/Bf3Id4SxSHbrE=
X-Received: by 2002:a92:c547:: with SMTP id a7mr16298203ilj.5.1638444304748;
 Thu, 02 Dec 2021 03:25:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638369365.git.mchehab+huawei@kernel.org> <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
In-Reply-To: <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Dec 2021 12:24:53 +0100
Message-ID: <CANiq72nu9TvLzxxj64b+EwFicwGexT7VTmVYVnVDzQgwkk+9ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 6:59 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Instead of having RTD as an almost mandatory theme, allow the
> user to select other themes via a THEMES environment var.
>
> There's a catch, though: as the current theme override logic is
> dependent of the RTD theme, we need to move the code which
> adds the CSS overrides to be inside the RTD theme logic.

Does Sphinx support leaving the selection of the theme to "runtime",
i.e. to let users pick a theme from a few from a combobox (e.g.
light/dark)?

I assume not, but asking just in case.

Cheers,
Miguel
