Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F275A70B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiH3WXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiH3WWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:22:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3B61DB9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:21:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d5so6449015wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kl+rI6b3liHnCQIWIxXAKPSVYAtssiKdL90maP+tud0=;
        b=rV34eCLfWaWChkkMn9CclOTorafupclcOXxcc53yJBuh2S/gyOsBYCbfeXqqyLqhyI
         t7LvDHJ9cm6rC04l7iLYDqA9nhaOMTLuLkNO4zvMZs9np/noIpAdWOMwMCPjkLyWPAEE
         r4OFos9bpiRy9zAXJgKRdh0nuiekym0ho784u4VA42PHCKgMM/Zvf7iA0Voje+XB0zPb
         7dkhMEMo/wx1pWCQUZyCmJMBAKlGOeC5VbAbt4yyQP7vZYdo0zyW28nqVcERbwllNrGY
         UWAPIiVDpDxjp1+hMcZg2f4hRYC0cUb0la2lT7E4z/6jdaW3/tGXRItzProD1Cqbb52B
         xpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kl+rI6b3liHnCQIWIxXAKPSVYAtssiKdL90maP+tud0=;
        b=UpaL2WjZoIKVjCO3tFTNQ0CXmXfnsrPVStk1T4ZJUZO978hvb/n2gU5UJhwj9SCzNO
         Tbhg7rznStrq/vtRjV1po6h/fu/HTX4BYNnKy0W3iR3WGbb+PVLwfF7ZrNHneA4+fPgC
         Yt6N1KxY8wBC1eJ2AP8HN3L9ur5kznY7BjQud/og4r9zeKbyuRfN7c6fpKXfFMwPIO+i
         6mCajZki6sNE+OgByPe0RZATfdShInOWMiRHZNKjF3qjI5osI23T/sXuHBK96qgjBJG6
         utW5naMDfIGYyZmqTsAkQT/4grf5pQM0X5/kjqX345QsSG/JUBDGkIPfWK0KlKm7dzIo
         49uw==
X-Gm-Message-State: ACgBeo2y63tOn4pYOXRGiSJdCTr5lfkzlmy9d3PZJiqSTBxqRgVy4y0K
        ErYKLHN5WHuymwCKdDZafh5zIfjbTxxd3zI7k8hn6w==
X-Google-Smtp-Source: AA6agR52H8PLI6OITssNgjSG/kFV6xTgWI4uQ1YHChM6A5pxsfqR3r3bnMB8ZeD1Cc4ow7fDAOrs8g71YvKtSmSZvOY=
X-Received: by 2002:a05:600c:4f89:b0:3a6:243d:3bbe with SMTP id
 n9-20020a05600c4f8900b003a6243d3bbemr90482wmq.16.1661898059928; Tue, 30 Aug
 2022 15:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com> <20220829201254.1814484-3-cmllamas@google.com>
In-Reply-To: <20220829201254.1814484-3-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 30 Aug 2022 15:20:49 -0700
Message-ID: <CAHRSSEwgbbu30fpFGJ4370UvA3CEh7WdhAqfpJPU6ycABCWLeg@mail.gmail.com>
Subject: Re: [PATCH 2/7] binder: fix trivial kernel-doc typo
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
> Correct the misspelling of 'invariant' in kernel-doc section.
>
> No functional changes in this patch.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 1e4fd37af5e0..0c37935ff7a2 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -75,10 +75,10 @@ struct binder_lru_page {
>  /**
>   * struct binder_alloc - per-binder proc state for binder allocator
>   * @vma:                vm_area_struct passed to mmap_handler
> - *                      (invarient after mmap)
> + *                      (invariant after mmap)
>   * @tsk:                tid for task that called init for this proc
>   *                      (invariant after init)
> - * @vma_vm_mm:          copy of vma->vm_mm (invarient after mmap)
> + * @vma_vm_mm:          copy of vma->vm_mm (invariant after mmap)
>   * @buffer:             base of per-proc address space mapped via mmap
>   * @buffers:            list of all buffers for this proc
>   * @free_buffers:       rb tree of buffers available for allocation
> --
> 2.37.2.672.g94769d06f0-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
