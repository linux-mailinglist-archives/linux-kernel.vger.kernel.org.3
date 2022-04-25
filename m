Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4450E2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbiDYOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiDYOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:22:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A91F610
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:18:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d15so27276925pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34R6TCm5dOXxCSCPteYCdV9oQ3SrvUL6TjoVApRAPyA=;
        b=rKhoq9rj7V21/dSBiuO+irr6LlHbxDqcCLQpYECeIGt8kL7By/MR3EyWj84oZ3Qm+K
         7J8o0eRSX8Pff3PswT8uq++deAWHjgx4NGr6B9gLD9hGl0ZmbKsH0D7LvWtmYtzN0KKp
         aDsh1jjczDoNpAGXlQqJSHRfwI1dDyrILALAkxOMP9+Ng3hYFcjTN5bVxYD/5QRcdcjX
         hOsEF5De0EhGuBOZVXEdTuUAQFhUAN3IMDAgo0xpW7eDhWqpq9grcVAMmAcTbNOy+zFP
         YnQKvIfsw0Vy33sbUX96qeU8wMzj5Mon/I6G18wOD03RGON/RbiH2SEcqA5xJgxHQrF0
         f5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34R6TCm5dOXxCSCPteYCdV9oQ3SrvUL6TjoVApRAPyA=;
        b=xQUcuiZ7d9BoXl9kL7k3Lzj1EOYDEWdkH8HzPHfJFaQsO6KNJ6kWVei3yZIofJU3zS
         NeFHdLvzVxeS9bBRGl7a+lPodL0pktVVdBMzxEX2zhhFoKA4f4WvEPrqvhJMa5qMYlGK
         pb5gsYear6HEZABPRKiy9AolMJlaj5dzlpYCyKfWnBqiA4oI0hEF9LdAPLtYSs9qslGH
         jw3sJuZh75tXUSLF+GBF9eLFarQe/TCmYwZwHHnF0Ldddab/Gt8W8Yr90jQ30mdLaZMr
         MxhlUTiB7YEI+AKmOp36POS1Kqn3Ud98V2kMlhEj1yaGbXJY+YKE5lhKEzg3brfvlqwJ
         XX9w==
X-Gm-Message-State: AOAM530bVn5Ed8l/1KedS9RE/SMsnH5VVGPSfFK8ZPrch8JNl8d6J15I
        LgK7HwqVWV2CoGkyKjn2ZO6DTtr7aSHtNktOxa7u9CL8KP4oZw==
X-Google-Smtp-Source: ABdhPJyM5CmdcL/mAU2sTH7BML/sQzHjXqgWVTuTNWDJV7jfPvh4xxvZIToS71OCDcD4V+vpkGIku1/FqIQtrUM52Mc=
X-Received: by 2002:a17:902:9f96:b0:15d:1ee7:4231 with SMTP id
 g22-20020a1709029f9600b0015d1ee74231mr3161790plq.131.1650896337383; Mon, 25
 Apr 2022 07:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220425141617.23925-1-afd@ti.com> <20220425141617.23925-2-afd@ti.com>
In-Reply-To: <20220425141617.23925-2-afd@ti.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 25 Apr 2022 19:48:46 +0530
Message-ID: <CAFA6WYN7GG6ZgxQ=AMinZ91f7QDh+aEPhL-Obx1s=zqReViAew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF
To:     Andrew Davis <afd@ti.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 at 19:46, Andrew Davis <afd@ti.com> wrote:
>
> These look to be leftover from an early edition of this driver. Userspace
> does not need this information. Checking all users of this that I have
> access to I have verified no one is using them.
>
> They leak internal use flags out to userspace. Even more they are not
> correct anymore after a45ea4efa358. Lets drop these flags before
> someone does try to use them for something and they become ABI.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>
> Changes from v1:
>  - Removed flags return from tee_ioctl_shm_alloc()
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  drivers/tee/tee_core.c   | 2 --
>  include/uapi/linux/tee.h | 4 ----
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 8aa1a4836b92f..af0f7c603fa46 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -302,7 +302,6 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
>                 return PTR_ERR(shm);
>
>         data.id = shm->id;
> -       data.flags = shm->flags;
>         data.size = shm->size;
>
>         if (copy_to_user(udata, &data, sizeof(data)))
> @@ -339,7 +338,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>                 return PTR_ERR(shm);
>
>         data.id = shm->id;
> -       data.flags = shm->flags;
>         data.length = shm->size;
>
>         if (copy_to_user(udata, &data, sizeof(data)))
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 25a6c534beb1b..23e57164693c4 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -42,10 +42,6 @@
>  #define TEE_IOC_MAGIC  0xa4
>  #define TEE_IOC_BASE   0
>
> -/* Flags relating to shared memory */
> -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world */
> -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memory */
> -
>  #define TEE_MAX_ARG_SIZE       1024
>
>  #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
> --
> 2.17.1
>
