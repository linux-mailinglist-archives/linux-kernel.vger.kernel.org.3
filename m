Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81F547F36F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhLYOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLYOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:39:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BAEC061401;
        Sat, 25 Dec 2021 06:39:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so43668051edv.1;
        Sat, 25 Dec 2021 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2bUIZoO1LTjs9P034v8mo7g1H7+ZUkysS901UGNzKI=;
        b=B/kDzmxsObUVatbe6u0feIYFNfZpt3yH/DQNRM8+f8qqUjlxUNklWEx2yfDOVGcU0q
         ZULKNYyeVm9A92gh+g6xUEbrZQpsiCbdGifA+BJUND9ygQKWoWcWWs8Nf0mjbfV3DwH6
         WMCeDxbQRTuvrjzoMIFN+sEmkoNPlqsNC80JINPm4fwAy7l2z9Ov/D10dwUwDpj6EPFG
         RboTm8q/sBO0jnS6yV5nxuvs8hzl6LvrAv1ytmIxnXZCsibAt2icfrXrwxmidqUcsRlD
         4XsDI5kSy1JaaYePdQ5CdFkXLJJlH66UtbjikOfXDaEXAfl+1yRqMl7N8Qky+KK5Jb9p
         4ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2bUIZoO1LTjs9P034v8mo7g1H7+ZUkysS901UGNzKI=;
        b=AESMuqWPjHpwwqBttjwaZ9+wY0Sz3NUGO+DjtNtQfvloc/otVi3pALBq8cK67TCT9/
         UVDjkFcTRpGk3SYaoYUbUNB34TEas7p4C0YGPrqLBfTLxvQ9fi0zWMYw1FAR/HYHzSRS
         KrFlEgo+uifftJWBe2Dml8FQbujKZ+GhrJ7GhEuSFhCk6QiCv7PXGSSDn8k/Yex8SA/Y
         cicUzcELZz6DwsUPSPkwEszONRIkEhp/1EQdQg2Icfg+QucrEgk6S9ZOrCk6tZ96YUto
         Tzdjfb9eAF8xHA8Iz1zjVJ+Jlzo0w87XbSgpikeA4RaJOsAj7yVYAq6IE8kwXUUuW8pj
         dBdA==
X-Gm-Message-State: AOAM530KRFzXzEYjjnfajk8SzdH7WBkBjHtIgk1FM4LYjymTCB7W4jmf
        a2gNr7uNoEKjJR7JBdTSje13kB0eUto6uv4+xI0=
X-Google-Smtp-Source: ABdhPJzDbBEcNMR26xfQC+5QGcjMNoWmKgwYskdtG+EsZIxm48U4qiVJUT5hrtioYr1hKPjroGDu+Aut0rjBM31UHMo=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr8307096ejc.44.1640443184967;
 Sat, 25 Dec 2021 06:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20211225115509.94891-1-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 16:39:08 +0200
Message-ID: <CAHp75VfFfoWVXu_=58xfTF95nK_YFNPM2vrRnOZ-ekeo=BXVjw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> While doing a hobby project getting the mainline kernel to work on some
> x86 tablets which come with Android pre-installed and which clearly have
> never been meant to run Windows (or another generic OS) I encountered an
> interesting setup for the bq24190 charger chip IRQ, it is not connected
> to the main Bay Trail SoC, instead it runs through a special
> external-charger IRQ pin on the CRC PMIC.
>
> This series adds support for that.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

There are a few non-showstopper comments, though.

> Lee, patch 4/4 is included mostly FYI. It depends on current pdx86/for-next
> and I plan to merge it through the pdx86 tree.
>
> Patches 1-3 can be merged through the MFD tree indepdently.
>
> Regards,
>
> Hans
>
>
> Hans de Goede (4):
>   mfd: intel_soc_pmic_crc: Sort cells by IRQ order
>   mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell to BYT cells
>   mfd: intel_soc_pmic_crc: Set main IRQ domain bus token to
>     DOMAIN_BUS_NEXUS
>   platform/x86: Add crystal_cove_charger driver
>
>  drivers/mfd/intel_soc_pmic_core.c           |   4 +
>  drivers/mfd/intel_soc_pmic_crc.c            |  35 +++--
>  drivers/platform/x86/Makefile               |   2 +-
>  drivers/platform/x86/crystal_cove_charger.c | 153 ++++++++++++++++++++
>  4 files changed, 180 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/platform/x86/crystal_cove_charger.c
>
> --
> 2.33.1
>


-- 
With Best Regards,
Andy Shevchenko
