Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07254B5A70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiBNTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:08:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiBNTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:08:17 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439C1EC70
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:08:01 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so48708pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8oDDwvFNImY/VPR1iI+PTzO8EFCV3s3KPhPnO2c9qA=;
        b=rI4JOyp6IV6w3InslglP235o0EtoDitOmNELyKh8B2Up0oGYgaVOWRXqwKiX9TLfAz
         N/2ys8LUy0o18leOKmEw5jJ3DEvqQYHy3xxsiT2o5zWvHUved3MSXP9mu3GborQQtXay
         ISMq80DJ8Ou2f8/XmrMyr+/+LX4XC7wfhRYHA3Ja3a05N56J8PQ19wNBPzb0VM4rb6hU
         P7mxRkcgf0GCQZOnt3HteIoUDNo5wKZ1rbAxOf1AuI0pDIFeOk/FlgLUM9SCZoKhrujm
         yQxkuwheZRelQtdwNZ4htfATDkm299zk1VFn16AKkKHIRFeaDzwwkeeAQ+HmljxteeM1
         t4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8oDDwvFNImY/VPR1iI+PTzO8EFCV3s3KPhPnO2c9qA=;
        b=q7yczolk3C/TQei0o1QijetO8s7ft3GJoGv1M8+KpDZC8Px+nr0Qd/AFWGod6M69Uo
         oaMCtvvyaWq+LDdSRqvht8DrNWptVLLdCxJdkrCaFd+kuf3x9Jiyze/6qMb4VI6rSYWu
         nRez3xUbkApF7gKuUKlEG14uJKHC1G5P46R4NEp1hMOv0lG7d0K+ojpwsajAx7Vtxwzf
         O1BDANelTR3bD59nhZAH7RmudRyP8E7Upwh4ua+QX1QakLRAcECNN++Idh9FtOvlhOD/
         iz7PMIP4BDnKTVNGf+sPF4SGLTKGggnqiaQA8vdy8D5Xo9MAzz9WtfP27jRMo254EzWg
         hVSw==
X-Gm-Message-State: AOAM533+6kk1imQI0iPT2qV088lqJivnFsD/m4MX9SZ0//cd8/e2xtZV
        MQcFvd3aDJqt8LMtTVmZouPP+g+9vyedJpRownRey7DHkrGV/rN6
X-Google-Smtp-Source: ABdhPJwrV9PAaE833RQnSzliybCzTGC5tXIZJBODdZdXtN+MdiLtf7qksrvTJNixCwaxHomIyGnU/PinBMcVwG0/VPE=
X-Received: by 2002:a67:7206:: with SMTP id n6mr51013vsc.21.1644864661852;
 Mon, 14 Feb 2022 10:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20220214092448.285381753@linuxfoundation.org>
In-Reply-To: <20220214092448.285381753@linuxfoundation.org>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Mon, 14 Feb 2022 13:50:25 -0500
Message-ID: <CAG=yYwm=7zS0k9VY+Oie18LtmN1jemV0AP778+s4+wR5jC6N+g@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/49] 4.19.230-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 4:37 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.230 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.230-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
 hello,

Compiled and booted 4.19.230-rc1+  on  ...
Processor Information
    Socket Designation: FM2
    Type: Central Processor
    Family: A-Series
    Manufacturer: AuthenticAMD

NO new regressions from dmesg.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology  -  autonomous
