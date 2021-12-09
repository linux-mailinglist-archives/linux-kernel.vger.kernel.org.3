Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CFE46F179
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhLIRWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:22:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60288 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbhLIRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:22:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id F0F201F46BB6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639070309; bh=vDVEfEHhlVmm/1Rr1Y+Oti77//4ZEAml2oLr8RB7pj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NvCzpr0K+zXXlGAvtC2u/tmSU+0Z0ipL8EmGHuilJAAGucpcMsoHpYq8UAHsURHJB
         TyT+PsyKruGRZCFs73JVaqWx6lFLIIqOXkWN/p+M9Su9y9gPnQaG4NjxKcF4G5v+fo
         tnqQ78soyUlZp0kZwUPiukZfbewBK6A9cybpV0iDyQKKgtOwjvNdf0vRXDgvYHjPal
         7dnohJCQSPWYe8Vuxi56aEiX12e+IvX/Z8BpWdrYGagHy1usc63yKzV0aciG8DJPqK
         W07sp9MQas8GQj/+9clC8v2XzbybFsRoNNYE2+/MyN/99pLjMKwOdTj7NM/MxDir3t
         RjABYiX+s6whA==
Message-ID: <a5d23118-f796-9552-cf58-54155a6f347c@collabora.com>
Date:   Thu, 9 Dec 2021 14:18:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4] futex: Clarify comment at futex_wait_multiple_setup()
Content-Language: en-US
To:     6812skiii@gmail.com, tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
References: <20211209171404.478-1-6812skiii@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20211209171404.478-1-6812skiii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 14:14 de 09/12/21, 6812skiii@gmail.com escreveu:
> From: Jangwoong Kim <6812skiii@gmail.com>
> 

Almost there, this time you forgot to write something here in the commit
description :)

> Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
> ---
>  kernel/futex/waitwake.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
> index 4ce0923f1ce3..c7a14ebfe61d 100644
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -454,9 +454,9 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
>  		__set_current_state(TASK_RUNNING);
>  
>  		/*
> -		 * Even if something went wrong, if we find out that a futex
> -		 * was woken, we don't return error and return this index to
> -		 * userspace
> +		 * Even if something went wrong, if we find out that any futex
> +		 * was woken, we don't return error and return the index of the
> +		 * last futex awaken to userspace
>  		 */
>  		*woken = unqueue_multiple(vs, i);
>  		if (*woken >= 0)
> 
