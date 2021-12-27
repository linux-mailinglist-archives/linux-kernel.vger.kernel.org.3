Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B0480135
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhL0Pzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:55:42 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37602 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhL0PxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:53:08 -0500
Received: by mail-qk1-f171.google.com with SMTP id t66so3283205qkb.4;
        Mon, 27 Dec 2021 07:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFKpJ6n3LoVE/fmz9n2YS1AqKNWObFYFkYe9I6ztYm8=;
        b=UHr/hbAMU2WJ7jwHgqewe7DhEjRKT5Xun9KouJXFjFIjp1jhi96NJ3BfxZB6iw+vFd
         OoG9A2so7IPM0dUnfFzo2Ue0JIAIVn8uJiqnp8d9wos9/rRcuk4uQK6yhNuCLGU8J7Fz
         TjcWdmSuA0w6O+jLs3nM3ohQkQjBhj5SDgE0vmfA3pmwFZ+LOqH00UiQdgGQXHlwADEg
         iTjWRduqzMX5vU3BJgW+b+VKzwz4nlEQFt7ljuhkJKQnV628u2c+46s6WtQ3KBbqC3oC
         dMr1GDN3Qod4HRyYIJ74XqH0nrAVzwcaNbkBS/wJFygrtTGhZKun8rRFKm7EjO+7KAnV
         swxg==
X-Gm-Message-State: AOAM531rWpuukUFvLs7nHK4/UaEIeuphNiZGcWXHjDNVPA+KPHpQiImv
        wEVA0EMxo511nfNgFBSG6gqUzqml1Vmoq2yXWKETKv2P
X-Google-Smtp-Source: ABdhPJzH5+5YaWCdYqXzpxbwlEUwnWFSavWOurnfrdLoz1d0PynSuRGYUYaUiH8A019SPVWejlJ17fq4vMPcDllLXzA=
X-Received: by 2002:a05:620a:40d1:: with SMTP id g17mr12693132qko.621.1640620387203;
 Mon, 27 Dec 2021 07:53:07 -0800 (PST)
MIME-Version: 1.0
References: <ffbefd9a-5dff-5c3d-8a24-2d42b3aa42ca@linaro.org>
In-Reply-To: <ffbefd9a-5dff-5c3d-8a24-2d42b3aa42ca@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 16:52:49 +0100
Message-ID: <CAJZ5v0isp2Gyj0t3bDLP329fqOEPpj22DsG7WWnEv3Rht7_qcg@mail.gmail.com>
Subject: Re: [GIT PULL] dtpm for v5.17
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 5:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling this little changes for DTPM
>
> Thanks
>
>   -- Daniel
>
> The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:
>
>   Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.17
>
> for you to fetch changes up to c1af85e442278fe120974358cf71c41bc48e0580:
>
>   powercap/drivers/dtpm: Reduce trace verbosity (2021-12-23 16:57:36 +0100)
>
> ----------------------------------------------------------------
> - Cleanup and reduce trace verbosity (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Daniel Lezcano (2):
>       powercap/drivers/dtpm: Remove unused function definition
>       powercap/drivers/dtpm: Reduce trace verbosity
>
>  drivers/powercap/dtpm.c | 6 +++---
>  include/linux/dtpm.h    | 2 --
>  2 files changed, 3 insertions(+), 5 deletions(-)

Pulled, thanks!
