Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197C94689CA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 07:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhLEHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhLEHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 02:00:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14058C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 22:57:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so29888325edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wizery-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihtUddHm1mmpZX6mKILinJnPqhvWBjnk1DVyRj7DW/k=;
        b=ivYPueHJXr8G/tixCqpOnNNjr6hVYWpjVVhdx5eRQkBzn9DEf3V2WXDE/Ot9qCYjJM
         +rGTZbBiIZz88jpKYaj4R5wvKsq4ARmcBObObFUS4Rcpx4aAT49bHqxGHCMeJgw1FZX3
         rcDuxGEpp2FDmNkoARANvAb45kSP9TdK1j9e2dUXiXol2s3bCBaU291FQ49CruB3Esim
         4PbHtWjz8PP9koYc2wpGpPx+q/pPXaT46IeoGidLEnTTTwRWDf00vHlA0HBcXonHc4Wx
         w508nPLvO+Uk/CruDcGRus7ffM3+RzStu6IEW6BL8Ff9TZzeeavl5cJvMeNNBaY1wu3c
         Ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihtUddHm1mmpZX6mKILinJnPqhvWBjnk1DVyRj7DW/k=;
        b=feGf0YEUplMzcw4e6UgMObzfkutGuFHTQ6c3+OTJkD8+ibL3ha1+ROWGFXk4A922Tj
         Yk1RSD7ifabaokz3aG04s4LmwxqKB0LRG1ZO8GepBcQ7wBrFaNWeEj6MlHCA2tlLUZv5
         pa/91kPsuyu1N8TBQTOqVQNy6EcK17mOWlxk+I7DXbWrX28d2VmEZKPd/gMa3yTra5nY
         NEQRKcclvwMQpS/bXktceLgLbOtEmt4WWb6nu6/t9kEBbn6UjyT0pA4YbnZJlja2Sjeb
         62KTokxcTspmqru3NQ36Go2kMfiVVqCNki7LRtaDvv2YLyug+TyW06+mY5zdtl91oDLC
         xFPQ==
X-Gm-Message-State: AOAM532aH7rYR2lWOUrDEfnV1h4WacFBfk9uP2BeU7JUFL/JC9VHiA7s
        31MJ0a4E5NtReopz0Vrt0VcCHUx17HUD98vVOR8i2hVDmUXczQ==
X-Google-Smtp-Source: ABdhPJwlQVns3tde9ZhEG7WZB+IfUFwKFTGrch9aORXkrQvhDNwdkOc7OhOOmstiIZC8N/g8H9LARkPCDOsDRJvNV+Q=
X-Received: by 2002:a17:906:55d7:: with SMTP id z23mr36204767ejp.393.1638687439448;
 Sat, 04 Dec 2021 22:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20211202171125.903608-1-mathieu.poirier@linaro.org>
In-Reply-To: <20211202171125.903608-1-mathieu.poirier@linaro.org>
From:   Ohad Ben Cohen <ohad@wizery.com>
Date:   Sun, 5 Dec 2021 08:57:08 +0200
Message-ID: <CAK=WgbYTfrBfW_8R5Xbfd9e2DkqnfWAOTRv-DmjfADXsxqOqyA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Removing Ohad from remoteproc/rpmsg maintenance
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu hi,

Thanks for the patch.

On Thu, Dec 2, 2021 at 7:11 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> +N: Ohad Ben Cohen
> +E: ohad@wizery.com
> +D: Remote Processor (remoteproc) subsystem
> +D: Remote Processor Messaging (rpmsg) subsystem
...
>  REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
> -M:     Ohad Ben-Cohen <ohad@wizery.com>
...
>  REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
> -M:     Ohad Ben-Cohen <ohad@wizery.com>

Acked-by: Ohad Ben Cohen <ohad@wizery.com>
