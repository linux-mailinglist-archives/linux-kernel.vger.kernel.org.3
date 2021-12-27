Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37132480149
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbhL0P5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:57:40 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:33575 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbhL0P5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:57:03 -0500
Received: by mail-qk1-f176.google.com with SMTP id de30so14812339qkb.0;
        Mon, 27 Dec 2021 07:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMjwqvI3oPgoDtspnzeQqaAzAEUbhEHL+9feOV2faXI=;
        b=CO1cRJS9OozbvaXjJw8k0q9aqu7S8HsOCLvDrMQfpZftVtlVx8P/AHcb8FhiyEQ+Ox
         5Qce8EQPG1a31/L0d6Vmsbq5Ebm4do1Gvs7TkBp4PHqXx0bSDC2fm+Vttox2HXYz2Fz9
         ZNit73hJ0R98PIOlBZlJH3PJzf5+nF9Xd4/O+gm3q2uEyq842gjya3tCkTDJghkyHtaW
         c1ICrm0cEpKfBw7oZ8qDKYuCEo+gf9g+nk04irS5b4X4ajDIA3RH9qSiw/4Im6yIV3fM
         Jk5vAjQ0MDblCqDxEJcl8W6j1qJP1WY+eCeJPdxGqM11mHpIB7ixnYTpIt8iF7m78uH2
         I71g==
X-Gm-Message-State: AOAM530Vi0WruoJiW/X/oGjKrFBmq//R3qN8YpXs8O1TI607sHYwbobD
        AZD8iTqJ+Zb/1Uaq6aegBOubaYRvehKeT98w8dQ=
X-Google-Smtp-Source: ABdhPJxUqbylvZ+oSGOC4Njq/NWVZT7SvUWo6lTrvSnVw3y6ewrloKmIJu9NgzhyU9EVzo13J/S3Xpz0hnGgOhHNJAs=
X-Received: by 2002:a05:620a:2001:: with SMTP id c1mr12237712qka.374.1640620623008;
 Mon, 27 Dec 2021 07:57:03 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211224064428epcas1p40282064859748cd6735279bb7274a753@epcas1p4.samsung.com>
 <09ff8415-0ebb-c8f2-026b-65af27f58f44@samsung.com>
In-Reply-To: <09ff8415-0ebb-c8f2-026b-65af27f58f44@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 16:56:44 +0100
Message-ID: <CAJZ5v0jQ_JyEAYK73ZNvyM_rwKPvR-Mk6UG5nPe+BQki42yjaw@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.17
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 7:45 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.17-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:
>
>   Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.17
>
> for you to fetch changes up to 4667431419e93b63b4edfe7abdfc96cefcbcc051:
>
>   PM / devfreq: Reduce log severity for informative message (2021-12-16 11:29:54 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v5.17
>
> Detailed description for this pull request:
> 1. Add new DRAM controller driver for sunXi SoCs
> - Add DRAM frequency controller devfreq driver for Allwinner sunXi SoCs
> in order to support dynamic frequency scaling of DRAM frequency. It
> calculates the supported frequency list from source clock in the range
> of full speed to quarter speed instead of devicetree.
>
> - Add COMMON_CLK dependency to fix build error
>
> 2. Reduce log severity for informative message about frequency transition fail
> ----------------------------------------------------------------
>
> Arnd Bergmann (1):
>       PM / devfreq: sun8i: addd COMMON_CLK dependency
>
> Samuel Holland (1):
>       PM / devfreq: Add a driver for the sun8i/sun50i MBUS
>
> Tzung-Bi Shih (1):
>       PM / devfreq: Reduce log severity for informative message
>
>  drivers/devfreq/Kconfig          |   9 +
>  drivers/devfreq/Makefile         |   1 +
>  drivers/devfreq/devfreq.c        |   4 +-
>  drivers/devfreq/sun8i-a33-mbus.c | 511 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 523 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/devfreq/sun8i-a33-mbus.c

Pulled, thanks!
