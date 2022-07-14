Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD29574C70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiGNLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:48:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28D5B046
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:48:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so2929823eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ0fCq0ZyyLcCu2RaWJmjAKVYgnq2Ry9Qz7y6l9Krms=;
        b=K/nOeGDGN++Gsq4Rj5Uy0wMI4/nxZVXiUITEjCOaFaWl+/RPljyJ0JK4g5RhkelyN1
         1QhYynVk/wFdutgWXpEGdMFXfxeRESAHAiEg17dSzeC5l9W8qq+2JM2/JAIUQCJRblJ4
         knckvzkZveeCYfSXnyxrn3AO9w+Vv1zA2Gi0NWSzQWdXw1i821Hn+Eadw2Bohis11GjP
         QdgLEiOPpibD1jELa+gIGfB6Zbyd844Q8dnlecbComnMHcUhdX96BdEMwCWUCWCkpTEK
         f0ZOXf//d0XKiIweLQ9WoopzZnncaFiF4hZkoxr2KEvJ7vMWEiPtvWFBDdGuuYf5QM66
         BELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ0fCq0ZyyLcCu2RaWJmjAKVYgnq2Ry9Qz7y6l9Krms=;
        b=uAQOihiDRusnvy3tWn8slqHobwuA0XJAXhzlYuzK6QFijTdctwyl8s3+6WHtVc0yjQ
         tc+j7Qe+ZzP6QdWIhO5vqOtSNmSok24IERVMfxPwan61ryiTcSbP8YWQGzZJ0/4J8NyC
         Hx4PMe3oMyk1GVOswfxm6Hctle30Ia0PDE9YAr6oWjzNqrMHIbpnNhduhgdx6OdXnwDJ
         PSsmLY9YMz7OnOiNDVFsFX0upwkfdpA4QR7t2xtHAg8bLy9gpANGx00COgpXCxFXPNhl
         UtDptBs2s/1zZg1DfrGOeyGKrxe//1E+wE5ZNBEOS7EgvF5cyNg11DDWH9cDPo/zJFE2
         EhLQ==
X-Gm-Message-State: AJIora9BtokTFs3Q0SQdL7HhkAgATBwdDMgkAUNv3RO/ZTeT4r1xwh5d
        VX2wF75OuLKLHjHSUMDLrXiw/hEM7s7yeHw+vSDFMeeOB9s3iw==
X-Google-Smtp-Source: AGRyM1sAmuGPOa/LunsNi0GiSrbOj8H+RlLYQEoG2ZcAko018Odq3/IonxMSKHyCcOiCXMz3XdUqUewDhN1ftX+VmXc=
X-Received: by 2002:a17:907:7294:b0:72b:1ae:9c47 with SMTP id
 dt20-20020a170907729400b0072b01ae9c47mr8209782ejc.253.1657799285189; Thu, 14
 Jul 2022 04:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220713094820.698453505@linuxfoundation.org>
In-Reply-To: <20220713094820.698453505@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jul 2022 17:17:53 +0530
Message-ID: <CA+G9fYs0E4tAty4hFBCNOYLK9zwCQAZ=nWJHx2a1NvvGLYScDw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/131] 5.10.131-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 18:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.131 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 15 Jul 2022 09:47:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.131-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
FYI,

With rc2 the perf build issues got fixed.

but we still see
Kernel panic on x86 while running kvm-unit-tests.

- Naresh
