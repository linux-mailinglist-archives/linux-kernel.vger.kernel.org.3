Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78CD46D801
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhLHQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:25:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47166 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhLHQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:25:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 98B8B1F4611D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638980501; bh=kBZy0MhyCeVN0zjxogJB0yUUignIh/dowudmupEIDAM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CLgY3Rg7E+se1/C0M3faZXS0B51ncQF+KuAEwUj+hpxxPyTewEAPpG+bUlhbGhKyz
         9vwMPvJKsx+yubELXWP5n91WWAHaPwIouQnzdBeClZgkdhLlUi0ZuOaQyGM7gKPXMq
         0AZcHwGVYwywM5E2yOAZhOORKpFx8w/t4KBqpDcmZgU3qtwT9ZvPFQ40TlVv4v6gWG
         46jHa0UeETod92P8fHAstaaOQCGcJih5L86YPXItbEaj/8RGVfyH9tpBwVteccb7Wq
         AHjC9xIiAwUQagO+FhghUCUy7MEJ5DUe/QOCLtZ1NkwKVs5YqRe8TN0oCfSb5+HtL/
         9+yew8jIR+Lhw==
Message-ID: <a2ae8ff5-b81b-398e-cb5b-7eb1279f0f5d@collabora.com>
Date:   Wed, 8 Dec 2021 13:21:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] futex: Fix a faulty comment.
Content-Language: en-US
To:     Jangwoong Kim <6812skiii@gmail.com>
Cc:     peterz@infradead.org, dvhart@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, dave@stgolabs.net, linux-kernel@vger.kernel.org
References: <CAF=mnpiEGXemtEEo_fbJ1pkfwZaaZNo9HPGKG5EZ1voaPqRaWA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <CAF=mnpiEGXemtEEo_fbJ1pkfwZaaZNo9HPGKG5EZ1voaPqRaWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jangwoong,

Thank you for your new version.

No full stop at the end of commit message. I would write as follow:

"futex: Clarify comment at futex_wait_multiple_setup()"

Às 04:03 de 07/12/21, Jangwoong Kim escreveu:
> From: Jangwoong Kim <6812skiii@gmail.com>
> 
> Clarify that "woken" saves the last index of futex awoken.
> 
> v2 patch had a typo (awaken -> awoken).

The changelog is usually place bellow the `---`, so it won't made in the
git history, given that this is only relevant for reviewers.

> 
> Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
> ---

[Place changelog here]

>  kernel/futex/waitwake.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
> index 4ce0923f1ce3..45d634dacfcb 100644
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -454,9 +454,9 @@ static int futex_wait_multiple_setup(struct
> futex_vector *vs, int count, int *wo
>                 __set_current_state(TASK_RUNNING);
> 
>                 /*
> -                * Even if something went wrong, if we find out that a futex
> -                * was woken, we don't return error and return this index to
> -                * userspace
> +                * Even if something went wrong, if we find out that any futex
> +                * was woken, we don't return error and return the last index
> +                * of futex awoken to userspace

I think it's the "index of the last futex awoken", no?

>                  */
>                 *woken = unqueue_multiple(vs, i);
>                 if (*woken >= 0)
> --
> 2.25.1
> 
