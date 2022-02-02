Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AC4A7097
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbiBBMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiBBMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:18:56 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD7C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 04:18:56 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h7so25176668iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 04:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOC5Tmt30CzfizoN0oFEa1A1Kpqnj7J/tOCH5xgA11A=;
        b=BK0eVWCi6zVAxAoWn+TTVnFYs3/368brae62p5lIgfRfQrMGXmYCkPIQu+VsRUJUqm
         QTqO8WFCslWOr/eA1S1yqXiMTsJCaRurIUmsiiGWoai+rdYlSCUR7AvqgoyQNRgf/vVo
         u91ECzzBOlrPBP9w9Q61/QuNk8N6tKK3wRWJ0V5KmZMTMEtmvJ78HCkczjWlPh2NK6xG
         /me9IZbnf5Q1EdTNaiaywYbnP1yp+8OofKHe5xlYMLrBThSjxZv9tZmfcq6ACu936gxz
         Is6Tf0grVg5XuFVPGdSPNN0RU0RzSsccsUYy91o2NasnJRhjPVIzOWmkVoTfpUWFsFQq
         WJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOC5Tmt30CzfizoN0oFEa1A1Kpqnj7J/tOCH5xgA11A=;
        b=SBLIdNdCDaiDHy78xvxfNofDO+3MybXjGCHNNqV6yfdEiExpxbiw3wFiux5dh6uWpW
         j35k++bSNwR7SMe7m7gKLLSpRocwNGq0uEAzoOrYh62cyN2CSdklzhBur80eFVGlIIG6
         Xn2dbVBI9uNLxcK5wyk9mQTW/+LwFpfFYlSnC4GPMsrIQnXX0HJgpj6ZSJp2/FqThorI
         Bf/xhNu94Xy7jpgB//Sd/jNgpf22ulKWYKoaNasXi6a6TzmTaL2p4JbZHlzu7Wn5aLEJ
         eTT1J5xZiyoc7O/bYbzRt1BEAipTr6Ts/PZ+mOkb3oeUiFRDE7LgmSR9nrb6Jo0A3pub
         YHzg==
X-Gm-Message-State: AOAM530SFHduqc839Fm+AvOMZhDiZYBn0ROPAz2JzQcXeOYEp/VaNsmY
        gRES4YB3veXVxDTZFeBLmR7UvPenG46Up96kSLFl3A==
X-Google-Smtp-Source: ABdhPJyb1kFQxJHRrVuLsNuntWdAPEvnx8N/ef0qqZfNV2gBpb0KXb5vZzrRPFnl76obquwgkBIYpLZ19n/4LNQC/Y8=
X-Received: by 2002:a05:6602:2a48:: with SMTP id k8mr1867911iov.147.1643804336224;
 Wed, 02 Feb 2022 04:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20220201180822.148370751@linuxfoundation.org>
In-Reply-To: <20220201180822.148370751@linuxfoundation.org>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Wed, 2 Feb 2022 07:18:45 -0500
Message-ID: <CA+pv=HNFGcink5ppTNPW8wmmbP_86emZxebDqHURme9CwkSWLg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/25] 4.4.302-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> NOTE!  This is the proposed LAST 4.4.y kernel release to happen under
> the rules of the normal stable kernel releases.  After this one, it will
> be marked End-Of-Life as it has been 6 years and you really should know
> better by now and have moved to a newer kernel tree.  After this one, no
> more security fixes will be backported and you will end up with an
> insecure system over time.
>
> --------------------------
>
> This is the start of the stable review cycle for the 4.4.302 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
> Anything received after that time might be too late.
>

First time testing the kernel like this, but I was able to compile and
boot on my x86_64 test system with no regressions.

Tested-by: Slade Watkins <slade@sladewatkins.com>

(Feel free to let me know if I can't send my Tested-by to you.)

All the best,
Slade

--
Slade Watkins <slade@sladewatkins.com>
