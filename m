Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38CC58E601
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiHJEHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiHJEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:06:21 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B27FE43
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:06:18 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so6872525vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=B0l9ibvW5BN5wngAgmB7O1y8/a8AyEHrorRjOBZ7hok=;
        b=lpiZOP5PsU2HdlHZhyRAw+Mch+kIer4vXI4u9zEqSmsHLuhkln76xHteisAhbkYosj
         i3gKSthmo/x5GE1eop5kb1nNxiOpVjBLUi9Pa6NxvkvtVXHxTvN/J1kVc5xxy0mcEHK9
         VspFqO8BccPD2ZZEf+lfSkGlYxKr5xmCuf9gOJeO3bvZplu/FzM0VmXxrJkSeD4e6WsL
         HPn7RwLuW0j+2DizZVNcj34n8Tn0v36BCF6jHfYZsfefEecEacl+ultZenevsSiZ3oiL
         R23PWN6VKXzrJxRRSzYBHvMrHDZsCPcjjrubeliJhUeIrddoSLtDWhhDo1XEgmMPzQvQ
         7f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B0l9ibvW5BN5wngAgmB7O1y8/a8AyEHrorRjOBZ7hok=;
        b=R+oDOnz0FTmeX4MQ7O3QYhyIlaa6Z6f1CckBXg4RGJy+Nygmb2HQF4EbAfJKsugpVX
         RIMbRnypMKymszSRPJxXphi3/QWySzWwtsb+GdDHPYsxRdk3FK1rq1uVeCJxEfFxB3Xa
         +ISR6ZkZhOtv7EGWzsmlfyOBx4ASer/9jxj0ePFkG8Rpk+ZjfHuYg+HFc1wlcskxgazp
         X2pUIsR+QZJ9Q4xQ6Zwfrd4O/H9l2KchuUvcT8kf6gknj71DAEhRNZdsrQJC5ZjRf4kS
         /GExjOimyFnEgUdPil+ddEoxwKPGvV64nJpwy3uJ1YHNN7ZWs261RktOS1X+L9WdPglh
         tT+g==
X-Gm-Message-State: ACgBeo3Wvif3yfnkRLoa5T3C3+4E5CZmwwxC8Nv35A3MN6J8bGCIQgO5
        T+Rx6oXW4Vw2t9Tei2C4jMFl8v3smfjFs9b9Z6CWcQ==
X-Google-Smtp-Source: AA6agR4RzpGLU/HcdwoIezhW2bgVoHEY6ay2gdngFcJCrVdzS3aw3XFfDOUBvfNgivTYlvWnSDD9uz0V4mgKr0EKYIo=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr11172696vkf.37.1660104376948; Tue, 09
 Aug 2022 21:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <7de8103cab9ef218e0216a66ab002a84ab66f9cc.1660068429.git.sander@svanheule.net>
In-Reply-To: <7de8103cab9ef218e0216a66ab002a84ab66f9cc.1660068429.git.sander@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 12:06:05 +0800
Message-ID: <CABVgOSnNzMaP0xFMGLaR=OY8u4gMs2GU0FzO36_9tXm_ABGQog@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] lib/cpumask_kunit: add tests file to MAINTAINERS
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
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

On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wrote:
>
> cpumask related files are listed under the BITMAP API section, so file
> with the tests for cpumask should be added to that list.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 868bbf31603d..21ff272c2c10 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3601,6 +3601,7 @@ F:        include/linux/find.h
>  F:     include/linux/nodemask.h
>  F:     lib/bitmap.c
>  F:     lib/cpumask.c
> +F:     lib/cpumask_kunit.c
>  F:     lib/find_bit.c
>  F:     lib/find_bit_benchmark.c
>  F:     lib/test_bitmap.c
> --
> 2.37.1
>
