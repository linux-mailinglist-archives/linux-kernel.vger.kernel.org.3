Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47973478F93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhLQPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:24:23 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:37415 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbhLQPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:24:22 -0500
Received: by mail-oo1-f45.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so805452oov.4;
        Fri, 17 Dec 2021 07:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+w5h1M93UWtmY9hH7My0tyNbNOCAQZkDwC3Gd8hvRg=;
        b=yhrSNxJMoqp8YzTjzs17PwzJWHycxpfE8u4WCvDQdnbtky8rLwpICdwr++MNAe0FCC
         2umMYyUxJxOIxzzm+YVph6qeMs7KVHjZxpk1jY6gy1I8Np8FigW4jeKmsWbZwoI9t67W
         h4jkrDgoRux7S5D/SXo0u1FYrSVOk3aYEcfuW55fO/jC1wVUtoRc9RXk5hK67FNFyut4
         ZJr1ZlLviCZP3gCpsBK1At2ox/Be0hy4KuMTmb+YHA/ka2ljX8v7XtL3DFwpledbfYFZ
         BtXRcReGMwu4Ap3z9j6jBzLEZUn7Y9UU34D2Pa2XCVMhh5VIShEY/wh/7e4h5tCkV82L
         diAA==
X-Gm-Message-State: AOAM53154IMj5St9ZK2bf7obLBzTqbDu6tl/GOHb7+4W5NRkghn2T90g
        cWXRR5wL/T5hQfxVWL94b2SvI9rRDXF5creoBUk=
X-Google-Smtp-Source: ABdhPJzYKvhAnol5dXY2Qa5x2UfoxOGV83oQ+9AGm8OpSH5QZWsH9hpuzhk0WN3g8QATytJ+EMmhFIIbuU97Xm7FQw8=
X-Received: by 2002:a4a:1d82:: with SMTP id 124mr2202848oog.91.1639754660604;
 Fri, 17 Dec 2021 07:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20211210042849.79924-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20211210042849.79924-1-yang.lee@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:24:09 +0100
Message-ID: <CAJZ5v0hM41gPb2epxtSRN=cseBrtf1DLtp8eExdJoa_ZwXXoww@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] cpuidle: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 5:29 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in sysfs.c kernel-doc comment
> to remove a warning found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
>
> drivers/cpuidle/sysfs.c:512: warning: expecting prototype for
> cpuidle_remove_driver_sysfs(). Prototype was for
> cpuidle_remove_state_sysfs() instead
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/cpuidle/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 469e18547d06..e708e593db88 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -505,7 +505,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>  }
>
>  /**
> - * cpuidle_remove_driver_sysfs - removes the cpuidle states sysfs attributes
> + * cpuidle_remove_state_sysfs - removes the cpuidle states sysfs attributes
>   * @device: the target device
>   */
>  static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
> --

Applied as 5.17 under a more precise subject ("cpuidle: Fix
cpuidle_remove_state_sysfs() kerneldoc comment").

When you submit changes like this in the future, please always make
the subject precise enough to allow the given change to be easily
distinguished from other changes in the same category.

Thanks!
