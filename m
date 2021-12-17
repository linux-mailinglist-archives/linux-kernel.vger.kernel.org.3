Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E85479006
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhLQPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:33:31 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38753 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbhLQPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:32:57 -0500
Received: by mail-oi1-f180.google.com with SMTP id r26so4124909oiw.5;
        Fri, 17 Dec 2021 07:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbTCA1U6CGDYoB4bvNWOQLFFm4uwQTFGS2jDVYV+P3A=;
        b=iSBoLyKOtUrqant3Bj1RvkV/X3VZYZhh6rZANuxxJoc0cFUNfS7alkZDQZjYtvsl10
         EhqGUiY63Z6SheUzDOIEIWhcGLdPq3Rh6DxkFRZUav2uewvj+LNicedSQAYBbA6GVRB8
         4fgRY/D56caLQuD4N8VV0JgnerlEiC8NRU2/5bzTRzSVFVgLkdDlNJ2j8TCXdN1fqCJA
         8oN3++sEjcGOkh0GZ3IdMDtUBdgDH8/9Hm/7REOLwPMvH3U8/tGJQQkeUHMFM6gUnKqB
         rDOdqQI/vK5MZvp3BfktHzOXdEdM+2hosdfYEwk36BuAz3MZvRVGsWSNjSxhk1mT+eAt
         TMkw==
X-Gm-Message-State: AOAM533wisWj5zJiwesE+1ge21ELzF5Zpp77KwrAiR59egQ6PvZjN/0p
        Ir0wfQzyPv6xiUa5byegyyiT3d9IvgzhU+qK4Ac=
X-Google-Smtp-Source: ABdhPJwIo0COk+OH+EZ5GIkAb7EG3J+j4eV1bZ0//bCxssVjI4dhiOs+Xbvcv6kKF8TFXEKXvqZ+uDveLahrYj7qoGk=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr2408847oiw.154.1639755177167;
 Fri, 17 Dec 2021 07:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20211212030640.25486-1-wangborong@cdjrlc.com>
In-Reply-To: <20211212030640.25486-1-wangborong@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:32:46 +0100
Message-ID: <CAJZ5v0iV1ei_vpL2o8BhBoUJnRm3_XPUETCG_EmOw_4ff0gxJA@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 4:07 AM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `the' in the comment in line 15 is repeated. Remove one
> of them from the comment.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/powercap/idle_inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 6e1a0043c411..a20bf12f3ce3 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -12,7 +12,7 @@
>   *
>   * All of the kthreads used for idle injection are created at init time.
>   *
> - * Next, the users of the the idle injection framework provide a cpumask via
> + * Next, the users of the idle injection framework provide a cpumask via
>   * its register function. The kthreads will be synchronized with respect to
>   * this cpumask.
>   *
> --

Applied (with edited subject and a new changelog) as 5.17 material.

If you submit similar changes in the future, please use more precise
subjects, to allow the given change to be distinguished from other
changes in the same category more easily.

Thanks!
