Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1658CBB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiHHP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiHHP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:57:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B06B1DD;
        Mon,  8 Aug 2022 08:57:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f14so6808553qkm.0;
        Mon, 08 Aug 2022 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qWt11qITzn9FmimPn0bMHjF81SjCsQx57ULbXVc2hTM=;
        b=aAlK/eVAK+zXuWHxzgOtyWCMFKNOon+RqH4/lL4NLjJz+BOoF7eAtf6jSx7dU3cx8C
         veFb929KO1BaeDQILUxPwXjOy1kExHpkw+I8Jzdsg/EtCXq8UvbctUj8rdi74I4SKq2F
         2hdycA3Uu/kEs+NtQWPSBHaUqNPCjrKjX92oYr2/rwvd9HTvNV2gajSodePZKGtHBrqH
         kU/actZ8NeI7FHkYQcWBlA7JHhJK+VSoZMbxSgfETnIZtxK2G1cSIEtKuTpvBsqBrkBk
         e6/LAVGNwA8/lFZxm8RLSFvQu1lexochD37MWO9f3S3aSIyz6hFI/tnHSRju4+GBF+DO
         EqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qWt11qITzn9FmimPn0bMHjF81SjCsQx57ULbXVc2hTM=;
        b=3ZfzwbXgo0y2KhrXE436vMT6GVbsiUqQqPlDudBm3e2btYUpVs0E75iHmk6ibkewAz
         /KZa7rAOS5WXnjozJPIuc+rtKJGPo3Q0/2b1YUPG5be4lVYe3SJwbSyfmQb+z19s/kyC
         kGb6ndeYi9kNYXbQ0IJ+xXU8bolCWYrHyCm7NqXHsYG1BXRdoY5Hojf2yIXbRjW855AX
         GfSz6zIv7VDHNbzcDlZCGxNHr4OD2jG5ht9+67ntgz3fDnViC2mtT3DEmMC3aXe5Y+Ol
         GVpqZzp+yK7vIUzFSR4M/J+bA4QNFP7f9zEIHNdiMhUtfAK7019i0MxmEegv6uafQtDn
         nXgQ==
X-Gm-Message-State: ACgBeo2JxT+EdQ+FyK+jTMEoLCoehFnazP2WTF5kFvBu/aueYaJnJnPG
        OnGcKr7dmRhCO8oIfhmOuYhJlGiSD3O8KZxAFDbXdk0MOlg=
X-Google-Smtp-Source: AA6agR4dauGfvodMcNk07bUbMB4WxEO8WvbwPh0gljK03tWtiawWx2IPYxd2zTisJ7r3ap3dxzd3QmfrB7YevywUwIE=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr14699194qkp.504.1659974262258; Mon, 08
 Aug 2022 08:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220808043643.1571932-1-luke@ljones.dev> <20220808043643.1571932-2-luke@ljones.dev>
In-Reply-To: <20220808043643.1571932-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:57:05 +0200
Message-ID: <CAHp75VfyfiWi-PR_j1SPPxjgjZFuDhp3R5DOVXNj=FV3E8t0BQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] asus-wmi: Support the GPU fan on TUF laptops
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 6:38 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Add support for TUF laptops which have the ability to control
> the GPU fan. This will show as a second fan in hwmon, and has
> the ability to run run as boost (fullspeed), or auto.

Single 'run' is enough, I believe.

...

> +       /*
> +        * Modern models like G713 also have GPU fan control. This is not AGFN.

like the G713
(Also possibly to surround this subphrase by commas)

...

> +static ssize_t pwm2_enable_show(struct device *dev,
> +                               struct device_attribute *attr,
> +                               char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%d\n", asus->gpu_fan_pwm_mode);

SHould be sysfs_emit(). If there are other uses of sprintf() or
similar in the cases when it goes to sysfs, you may add another patch
to fix them all.

> +}

-- 
With Best Regards,
Andy Shevchenko
