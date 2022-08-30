Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9A5A70BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiH3WZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiH3WZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:25:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF549C8D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:23:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d5so6450380wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lDyMY3Kd63gGOahoIVXGkZY9C3sG3UhA+s4OmVc4QS0=;
        b=AxqA/OEEm3sIfKfLpwkHwa8/SaubJN92QAcHmC/sSlhx0Rrv9/nmhsb9vRf+l+Dc9/
         HyZKejKhZ3YkLhXt/aGgCE5lh7vvY+HYrATv8SJeYC14DxfCJiKqeaum7A2EKeED4zE+
         UdLkMEsndtq1U5W1b3uCo1imuGBxNVrcoeaZ63sgf7HKlR00Mp1BjCPnhxfBB5k/oOOz
         +I/bf8xD9petjCOhV1UQ9yYpwTI8hlKU/beudwSWSjc9LNyb5Z94e2SIYLp7krqUj+YZ
         201pgYG7jjNW6zFHdUIBUu6wJA7bbvZ2j3EVV5h3ETmw7LOLWKHU8J8MtJCEyKfDkpLm
         wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lDyMY3Kd63gGOahoIVXGkZY9C3sG3UhA+s4OmVc4QS0=;
        b=CI5MnzUe42QYgFaNN0071WdvY1+JwyEuKWCJSSXkGAUE8AhCOW0TpBNltrzPv3ZW6K
         ylElSp05ds6GYip9iNcCf4eUwv1I3XLVif5hHFWpk5paJS6ND++SrDPNCsH6GxxjVBYr
         0qbKH+A40ugdT+FPMs5KZE4Wx4FJb41lksD2xSLdCpz8IUpSmIvA54f721ORDG2XI0Fa
         VI7uJl4nAwcR5Zqw1ee86Z6VEHkI/7khTBibVTCciFRNV6IZr8AbBSTnD42brHSr2Wp2
         KKasMSNUZc9f9GEEOGiDUElymzADrk9nNlZs4gugUZTlScM6Sv/m5Q7xpl2ZpOTK6smM
         kQUw==
X-Gm-Message-State: ACgBeo3QEcmEVj0LN53QiT9/Tx3+fj66+e88P1PRg1AwDiKYcCY+tG8N
        Ye31MlNfmONDphQf7Vzb9VvNmCxakfAKy7yX+Aq8yQ==
X-Google-Smtp-Source: AA6agR5xokru4cXuDT08Gv+r81xyPtauVcsqf/0VwfpduIwMKQgONsHh+WjmuaN5NmUg5wGcGITie9m7ZQgXtbNDPK0=
X-Received: by 2002:a05:600c:25cd:b0:3a6:811f:3a0a with SMTP id
 13-20020a05600c25cd00b003a6811f3a0amr76542wml.53.1661898151205; Tue, 30 Aug
 2022 15:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com> <20220829201254.1814484-7-cmllamas@google.com>
In-Reply-To: <20220829201254.1814484-7-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 30 Aug 2022 15:22:20 -0700
Message-ID: <CAHRSSEx=zpjue8NdVS9-gWWoua5MNyaXLjBtyn4B6ACJ7FCSEg@mail.gmail.com>
Subject: Re: [PATCH 6/7] binder: fix binder_alloc kernel-doc warnings
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 1:13 PM 'Carlos Llamas' via kernel-team
<kernel-team@android.com> wrote:
>
> Update the kernel-doc section of struct binder_alloc to fix the
> following warnings reported by ./scripts/kernel-doc:
>
>   warning: Function parameter or member 'mutex' not described in 'binder_alloc'
>   warning: Function parameter or member 'vma_addr' not described in 'binder_alloc'
>
> No functional changes in this patch.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index ab3b027bcd29..0f811ac4bcff 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -74,10 +74,9 @@ struct binder_lru_page {
>
>  /**
>   * struct binder_alloc - per-binder proc state for binder allocator
> - * @vma:                vm_area_struct passed to mmap_handler
> + * @mutex:              protects binder_alloc fields
> + * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
>   *                      (invariant after mmap)
> - * @tsk:                tid for task that called init for this proc
> - *                      (invariant after init)
>   * @mm:                 copy of task->mm (invariant after open)
>   * @buffer:             base of per-proc address space mapped via mmap
>   * @buffers:            list of all buffers for this proc
> --
> 2.37.2.672.g94769d06f0-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
