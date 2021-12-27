Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9BF480105
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhL0Pwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:52:31 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:44622 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbhL0Prl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:47:41 -0500
Received: by mail-qv1-f47.google.com with SMTP id kd9so14025427qvb.11;
        Mon, 27 Dec 2021 07:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUWEP8j8McKJKL6aAva3y2o4pzUd6CPp6n4sGa/ihoE=;
        b=Raa9XNMeRWq7P7+aPCkJ507cMIUPGZ4dFJ0z7WGPf3pq6jK1Utm073orBgfJM3Z67b
         UosYpDjr0p1QBd5X4fzuekm/nJnQzWv3LQK8tO6LiGfXQaGR1fCbNW2HKAv0n/5gOIH8
         nuejKk/22Fi9Aog+Ec56fyuM62OK0FAOMQmTX8cSrEeRqnoLe8qjgKF5mgJP0Pam7Lqg
         Wu4fDOo/LhXARfkC//Aj3npLZOlRkJkoc3XdfPCoISqnN14YiMo2PeGbZmcFR72aTXOu
         Z0YHQ7Ub/BE40k84wbgd8Cc0zn2FBmPUgI9mMUgkBdHtRFud7s6Y3WuuOTf05AUE1Qjl
         ymLA==
X-Gm-Message-State: AOAM533xoKh3JqPC0FVZtRV9fNtxNNBlQvKt1dP7XHkU4QuiaVm6j2qh
        XtZNR6yQUbaTId387WVLBjt391fiKEx0Cov5lis=
X-Google-Smtp-Source: ABdhPJzqa1f581bitu9IVaU5JkVD7hVKy0yE1mMS4Gm3R1cit0B53dB9m96MbfJznlwF4d8ioCP2VmO0Im3Nsx4wqLI=
X-Received: by 2002:a05:6214:1c06:: with SMTP id u6mr15558528qvc.35.1640620060437;
 Mon, 27 Dec 2021 07:47:40 -0800 (PST)
MIME-Version: 1.0
References: <d393e7d8-b192-ff15-65f1-35f11e1a06bc@linaro.org>
In-Reply-To: <d393e7d8-b192-ff15-65f1-35f11e1a06bc@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 16:47:22 +0100
Message-ID: <CAJZ5v0g86TxN1vp4aWexFHqVzWM6ZGzABvufrusOeAcM5ur+_g@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.17
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paul Gerber <Paul.Gerber@tq-group.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 4:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.17-rc1
>
> for you to fetch changes up to 8ee1c0f6526ce942b7595951c7bb0165010051c2:
>
>   thermal/drivers/rz2gl: Add error check for reset_control_deassert()
> (2021-12-09 15:58:09 +0100)
>
> ----------------------------------------------------------------
> - Fix PM issue on the iMX driver when suspend/resume is happening by
>   implementing PM runtime support (Oleksij Rempel)
>
> - Add 'const' annotation to the thermal_cooling_ops in the Intel
>   powerclamp driver (Rikard Falkeborn)
>
> - Add TSU driver and bindings for the RZ/G2L platform (Biju Das)
>
> - Fix the missing ADC bit set on iMX8MP to enable the sensor (Paul
>   Gerber)
>
> - Fix missing check when calling reset_control_deassert() (Biju Das)
>
> ----------------------------------------------------------------
> Biju Das (3):
>       dt-bindings: thermal: Document Renesas RZ/G2L TSU
>       thermal/drivers: Add TSU driver for RZ/G2L
>       thermal/drivers/rz2gl: Add error check for reset_control_deassert()
>
> Oleksij Rempel (1):
>       thermal/drivers/imx: Implement runtime PM support
>
> Paul Gerber (1):
>       thermal/drivers/imx8mm: Enable ADC when enabling monitor
>
> Rikard Falkeborn (1):
>       thermal/drivers/intel_powerclamp: Constify static
> thermal_cooling_device_ops
>
>  .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  76 +++++++
>  drivers/thermal/Kconfig                            |   9 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/imx8mm_thermal.c                   |   3 +
>  drivers/thermal/imx_thermal.c                      | 145 +++++++-----
>  drivers/thermal/intel/intel_powerclamp.c           |   2 +-
>  drivers/thermal/rzg2l_thermal.c                    | 242
> +++++++++++++++++++++
>  7 files changed, 423 insertions(+), 55 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
>  create mode 100644 drivers/thermal/rzg2l_thermal.c

Pulled and pushed out, thanks!
