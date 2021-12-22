Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5647D3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbhLVObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhLVObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:31:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:31:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so802355pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ25Nfg2fMSokb+xxWVDgEZFconNFznTg4MsQbjfczw=;
        b=SjaIZ1BXa+otteg0t4IPMfXhUe5JveNmXofyGtHCo78TNoQSscL3awXIQCtr+bfftC
         IjhfMTJOq/3mw6GhIBfyuyrZjjqai4qCIZWsjO4Zukoyhcwi2FC9HY865F1jjPpEMotY
         CgWTKO5QZG+LlY0Ay/Dl7qhP7JC7OVh8Xl7H6VTWqLalKYwcR388PkXfOBdXq5Kfrk/F
         GP857m5bIoNciLZ7NYhwbV3fuCVQ9hPE00JirO18FNzIIhiaOgWt1ppzBnEf3b8/VOjt
         7wcrTee5DFbWueIP6VlWCTRDcl4W5jGNG/I6MZCzhARbyRy35bZP9z1Xyd9Ee03uiok/
         N3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ25Nfg2fMSokb+xxWVDgEZFconNFznTg4MsQbjfczw=;
        b=xBU1FkbD3jdxqqeBEiAkTWVhmZIPGgvy3YYko4WiTmX2xfx9xbwTTu02N5jtP3Bqj4
         A5en3Nh4SPBA5YO4kJYwZJPDPRhjCtzWaHcNVzx4VYK0BTRRVYcA4yyTFznOO5Nz8sfl
         5sPscY9lx9bJFk5KYPMC2rCvAlaYu+FElspTJ+nNr521UoU/kAETqFJ5ejvPA4TsaPXE
         YQTtBfIBZ8WMVmKILBQ5B9reDzeNw9Eqm6UFz8ViVY82G2a+ZT8kApB8st3IEEkpA6eA
         WhxeM7M0BMyhR77YUaj3AhlHhdkuOy9RlrvE23LMp5IaqpS1StEbU4mw0Ul6+EGwcW2n
         dwDg==
X-Gm-Message-State: AOAM533cT+RDvqn87lBBMtvPmzMp0TDjEqVFIJjC/VTd94OPEU2E5qhg
        HrSvorOeinHxrR2wo2caA2uAvU05j48pke5U/z7iMQ==
X-Google-Smtp-Source: ABdhPJw8gD7KnZbnNTVxB7uebJVM/vF/RvVWp1TUVNYyxEujbMljp0fcz/N0KBVSjdgR+sWcFRuA2PdJQh5j849OzUw=
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr1647873pjb.137.1640183467482;
 Wed, 22 Dec 2021 06:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20211220190150.2107077-1-tkjos@google.com>
In-Reply-To: <20211220190150.2107077-1-tkjos@google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 22 Dec 2021 15:30:56 +0100
Message-ID: <CAB0TPYF4zb3R+iv7hLdgmddtV98zu507WgJyeiN77RV9aFeiaA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix async_free_space accounting for empty parcels
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM,

On Mon, Dec 20, 2021 at 8:02 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> In 4.13, commit 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> fixed a kernel structure visibility issue. As part of that patch,
> sizeof(void *) was used as the buffer size for 0-length data payloads so
> the driver could detect abusive clients sending 0-length asynchronous
> transactions to a server by enforcing limits on async_free_size.
>
> Unfortunately, on the "free" side, the accounting of async_free_space
> did not add the sizeof(void *) back. The result was that up to 8-bytes of
> async_free_space were leaked on every async transaction of 8-bytes or
> less.  These small transactions are uncommon, so this accounting issue
> has gone undetected for several years.
>
> The fix is to use "buffer_size" (the allocated buffer size) instead of
> "size" (the logical buffer size) when updating the async_free_space
> during the free operation. These are the same except for this
> corner case of asynchronous transactions with payloads < 8 bytes.
>
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 340515f54498..47bc74a8c7b6 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -671,7 +671,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
>         BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
>
>         if (buffer->async_transaction) {
> -               alloc->free_async_space += size + sizeof(struct binder_buffer);
> +               alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
>
>                 binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
>                              "%d: binder_free_buf size %zd async free %zd\n",
> --
> 2.34.1.307.g9b7440fafd-goog
>
>
