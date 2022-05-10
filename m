Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148E5225D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiEJUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEJUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:46:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A02985A9;
        Tue, 10 May 2022 13:46:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so147269eja.11;
        Tue, 10 May 2022 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKWBQ2F+cxIhz54zwjRVpvTlbyC6XpVNbax5yXJJLBo=;
        b=JBftJ5ZMCuQ8xAg+YdJkAjkvM+FeExP3AJf6FXHcwU2uWLR6K0Axnpkkhct8StnC4k
         MSySaTtFA5TbRUX7BDb5sz1U6nUsyzQWwNkpvacKzgyZprQZv5cxo602YTKiRUNZejrM
         T2NJlQDJhrDq2XmRa90t91v6VnZFoNyS2Ahzj6q/uWy6tWsu3fqkW2EraMSfv8EztS2/
         +wPScn5huYl8TeLozSTPIX4AI2rNCBKPQC2vQ+gwAf41sLCkeasbKgcz4mPHSqSUSqQ+
         qqnF5vIPd2HXtCgo+4HA3TTRCUEQOsBaClvKW8aldWSLUS9oF8IH45FcYA7XVvlTg4aF
         MOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKWBQ2F+cxIhz54zwjRVpvTlbyC6XpVNbax5yXJJLBo=;
        b=Zkv+4lUhogny19E4txhYYhMQUoyAgsjvQf3T/6Oj7b7PGzXSYplyY9Ix5GTcaQweHw
         pR5Ueh8QKI+wwRM95zDttmKAqWDWZZFG2m71IIFqlDbboT10B0nSl96T6Ujf3jgE0jjc
         SGVBZsBswCWW9npj+rSjFD2/ei5ejPS5ndYKlEMjGZnhOsxnCMDDPtXMHgj0nO0DKh1z
         HAxcyYXM1aYMjdPHItFVofKXYi5HtRDXx+5oW66glwSOk1k/MFHVMlfMSpbqwDmvnd+y
         4z/OOVw+CNh+3GWOYY6b+ebFwOQscbMArEbsVDhUAzlvU7ai/hSTwBZsgsJmQ6opmYkj
         zGKQ==
X-Gm-Message-State: AOAM532VDX1zB4JWajzlJhgLPteS8bxhTEFHAYh0yxvlGtOegoGBeW5W
        7dWRCWArezywmD1IBte6zJRN8AQdWdb9MtQcuEE=
X-Google-Smtp-Source: ABdhPJyFeVAtJNETUs8yE74umx1PP8VfPhg1EerOmcjyJsAlhL/X7I/mRXACEHM16D6tEH7cmHUtlFE8/hQ5eSM7xpg=
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id
 bh14-20020a170906a0ce00b006d1cb303b3bmr21485466ejb.582.1652215598472; Tue, 10
 May 2022 13:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220509205815.GA1885269@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220509205815.GA1885269@paulmck-ThinkPad-P17-Gen-1>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 10 May 2022 22:46:27 +0200
Message-ID: <CA+KHdyUqYM9oGfuUy_NE+jZ+mge7Up9cXn74TtHP=QnMfqTkew@mail.gmail.com>
Subject: Re: And speaking of avoiding inconveniencing users...
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

Hello, Paul.

Indeed the changed switched to 21 seconds. What is about just set the
60 000 for !ANDROID?

default 60000 if !ANDROID

On Mon, May 9, 2022 at 10:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Uladzislau,
>
> And I wasn't paying attention when reviewing this patch:
>
> 084e1c049a8e ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")
>
> Distros specifying 60 seconds for the stall timeout get hit with a silent
> change to 21 seconds for the expedited stall timeout.
>
> Unless you tell me otherwise, I will merge the following diff into the
> above commit.  So please let me know if this will cause any problems.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index 1d863b04727c3..794837eb519b9 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -166,10 +166,12 @@ CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
>  --------------------------------
>
>         Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
> -       the expedited grace period. This parameter defines the period of
> -       time that RCU will wait from the beginning of an expedited grace
> -       period until it issues an RCU CPU stall warning. This time period
> -       is normally 20 milliseconds on Android devices.
> +       the expedited grace period. This parameter defines the period
> +       of time that RCU will wait from the beginning of an expedited
> +       grace period until it issues an RCU CPU stall warning. This time
> +       period is normally 20 milliseconds on Android devices.  A zero
> +       value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be used,
> +       after conversion to milliseconds.
>
>         This configuration parameter may be changed at runtime via the
>         /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 34d44648f3f5d..ca9db809beda3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4936,6 +4936,9 @@
>                         and the maximum allowed value is 21000
>                         milliseconds. Please note that this value is
>                         adjusted to an arch timer tick resolution.
> +                       Setting this to zero causes the value from
> +                       rcupdate.rcu_cpu_stall_timeout to be used (after
> +                       conversion from seconds to milliseconds).
>
>         rcupdate.rcu_expedited= [KNL]
>                         Use expedited grace-period primitives, for
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 39dd4b9d647f8..9b64e55d4f615 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -85,15 +85,16 @@ config RCU_CPU_STALL_TIMEOUT
>  config RCU_EXP_CPU_STALL_TIMEOUT
>         int "Expedited RCU CPU stall timeout in milliseconds"
>         depends on RCU_STALL_COMMON
> -       range 1 21000
> +       range 0 21000
>         default 20 if ANDROID
> -       default 21000 if !ANDROID
> -
> +       default 0 if !ANDROID
>         help
>           If a given expedited RCU grace period extends more than the
>           specified number of milliseconds, a CPU stall warning is printed.
>           If the RCU grace period persists, additional CPU stall warnings
> -         are printed at more widely spaced intervals.
> +         are printed at more widely spaced intervals.  A value of zero
> +         says to use the RCU_CPU_STALL_TIMEOUT value converted from
> +         seconds to milliseconds.
>
>  config RCU_TRACE
>         bool "Enable tracing for RCU"
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 0a25a4ea6eef8..2464b0eccfd02 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -31,15 +31,17 @@ int rcu_exp_jiffies_till_stall_check(void)
>         int exp_stall_delay_delta = 0;
>         int till_stall_check;
>
> -       /*
> -        * Limit check must be consistent with the Kconfig limits for
> -        * CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
> -        * The minimum clamped value is "2UL", because at least one full
> -        * tick has to be guaranteed.
> -        */
> +       // Zero says to use rcu_cpu_stall_timeout, but in milliseconds.
> +       if (!cpu_stall_timeout)
> +               cpu_stall_timeout = jiffies_to_msecs(rcu_jiffies_till_stall_check());
> +
> +       // Limit check must be consistent with the Kconfig limits for
> +       // CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
> +       // The minimum clamped value is "2UL", because at least one full
> +       // tick has to be guaranteed.
>         till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 21UL * HZ);
>
> -       if (jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
> +       if (cpu_stall_timeout && jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
>                 WRITE_ONCE(rcu_exp_cpu_stall_timeout, jiffies_to_msecs(till_stall_check));
>
>  #ifdef CONFIG_PROVE_RCU



-- 
Uladzislau Rezki
