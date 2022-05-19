Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5752D676
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiESOw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiESOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:52:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9485A5A1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:52:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d137so9405131ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3MaARWJ+5KG00Wc5nTbIiJMgENCDmkYALjE5uIyz6c=;
        b=eZT3F2+MWMucw2Gp0mVJ2l/DTHLIC06PRZzaRe1OHJnbYryPlNCia7J9bsGwiyGmjn
         3g/e9iJQKkg6kFwzBx41R/X3Y+dtjKjGeVUL8kYhuCUKJ962BB/TyzWZV1C5rHslW3rk
         VZXl3RRQrtXU8a5gGzthh9h3BxjwgRBGBIetAW65TSyNxsgL1o2RI8KMe5lZluVW4etb
         iw787C+ujVB2UEeP/Ioc3tkGMwz9ZSiNpZnAZ2XYjcFXr6dwytffJGipzgr/FkDLSXIg
         5wPOhnHFuTODIFBCzMbTBNKEYkhOm3iMo5C6wo/jdKXC3dKDcuqSvfz4W793aNqABquW
         mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3MaARWJ+5KG00Wc5nTbIiJMgENCDmkYALjE5uIyz6c=;
        b=XK1WB2VbdEG5pmIfGq9nT9Fb/KLKDC9Cnpe6JQ6qo6+Kdqu3SoC+/jebqAkmqjOmcT
         IIbaIxuEBhhkHNVL0Jdc6OwcT3k4UyaaZOxQN/wRMwTKIRXO8f7TgR3mLQa4oYHnrhOg
         xmDuiowLDEiieHX/dFelFMtoOiTLpK9dXBSOTrUk4RQpJcmagogcoAavdtmGddYfdvb2
         GMGjbIK2Nvaf2ofd+M8nP03W5+YGFLOfiEx2wzDaJEKfsKHjdpjx4DJPTAAdflkDhXmt
         dM+pT2KCnmo0A4YSrcaZVAJNyNC4Wf2be+zIYVFRLp+2iBiPKJfK3BGfwR7rDJEJQDHv
         gTbQ==
X-Gm-Message-State: AOAM532mETWLBwon6dNWWsnVBKu8O4Un738q64hLCd8kyH0PcDdjajTY
        z1RWh+KuN90SRU3V8YLa8LKBS0GOrNOV+W7zVSby2bHxC7A=
X-Google-Smtp-Source: ABdhPJwzEdwbgzGdTY5qz3Fu1PA8aC1IL8edBVPBKEfLmiuQatdgFZs8VIsANTshc9yZJSPdjZ9rsu0kIsQLGnOjL/I=
X-Received: by 2002:a25:c7d0:0:b0:64d:a15e:7599 with SMTP id
 w199-20020a25c7d0000000b0064da15e7599mr4650204ybe.251.1652971943711; Thu, 19
 May 2022 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
In-Reply-To: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 19 May 2022 22:52:12 +0800
Message-ID: <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 9:57 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f
> and exports the function.
>
> We need this funtion in amdgpu driver to fix a bug.

Hello,

Could you specify the reason why it is needed in amdgpu driver
rather than "fix a bug", please.

And there is a typo: "funtion".

And please avoid using "we" in the changelog.  For example, the
sentence can be changed to:

The amdgpu driver needs this function to cancel a work item
in blabla context/situation or for blabla reason.
(I'm not good at Engish, this is just an example of not
using "we".  No need to use the sentence.)

Thanks
Lai

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  include/linux/workqueue.h | 1 +
>  kernel/workqueue.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 7fee9b6cfede..9e41e1226193 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -453,6 +453,7 @@ extern int schedule_on_each_cpu(work_func_t func);
>  int execute_in_process_context(work_func_t fn, struct execute_work *);
>
>  extern bool flush_work(struct work_struct *work);
> +extern bool cancel_work(struct work_struct *work);
>  extern bool cancel_work_sync(struct work_struct *work);
>
>  extern bool flush_delayed_work(struct delayed_work *dwork);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 613917bbc4e7..f94b596ebffd 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3267,6 +3267,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
>         return ret;
>  }
>
> +/*
> + * See cancel_delayed_work()
> + */
> +bool cancel_work(struct work_struct *work)
> +{
> +       return __cancel_work(work, false);
> +}
> +EXPORT_SYMBOL(cancel_work);
> +
>  /**
>   * cancel_delayed_work - cancel a delayed work
>   * @dwork: delayed_work to cancel
> --
> 2.25.1
>
