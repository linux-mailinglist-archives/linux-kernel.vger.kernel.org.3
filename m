Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26E4B78B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiBOR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:29:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbiBOR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:29:26 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4FDB840
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:29:16 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so24028553oos.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=njbqDSApNZJxgs8QUG+GJc2lRg8kr9qwNOtBMNrAGzk=;
        b=Hg3yzSGM6InbUrgXSxmZSoAqb6uDGrwrZKujnThQlviuJauC0iCJUExwou4yPKJifZ
         obaXgpqa/bOGF9trvOyYCD7dtImTql1VR6ZIOA+/hMzf4kq/egRB6LiVPtv8lXKIgkZE
         iFHUkTRTxq7zD3FxS55Cbd+wzzjO64T2oyNXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njbqDSApNZJxgs8QUG+GJc2lRg8kr9qwNOtBMNrAGzk=;
        b=FuwqGnTqKu8kHg7aNN1yTjE3HdtBiK82ta2Ff7IHLFu223mAw0cqjAFVrzXkjPL4at
         Uzv8jfiFxYdVVnORHHHdK2GrV71UuRWxdT5ece9OVbvVmGkPJRxOsgYT9DtEbw1bKnDV
         5/pzkX5DEKa5nNBaeW93v2XQ5FFWlip8lmcEJu9/8rZbCRRvGrIBwN/6fFyBojczc59q
         Z/TkokMbsBAGVOHOFcIt2fm2JwWyycblgC5MDTDVAnPff+Uon7QC3y5q1+N8DZekq6tw
         FcoSdEHt9ALa1SkvCDrXcLZn36toa2TvBLhH/o8takamgVRsrxaEha0VDIOA9I5TIrfw
         IpkA==
X-Gm-Message-State: AOAM530Wh3U4Fc5EIgsu78ACUM9j8JH2hA1vZ7Hn4tsQ/AOpnxJ4p5xX
        RCFHrrXjHDnvBGA1OdZ26EmoyA==
X-Google-Smtp-Source: ABdhPJxLqmCfbePiA5dJpCUgGhVla5Ir+4EqFudR5QZ5U0xtkChH47WQL72pJkS5oVWw5+oCNIb4Xw==
X-Received: by 2002:a05:6870:10d8:b0:d0:eaa:951a with SMTP id 24-20020a05687010d800b000d00eaa951amr1779644oar.296.1644946155821;
        Tue, 15 Feb 2022 09:29:15 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id s6sm16348289oap.32.2022.02.15.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:29:15 -0800 (PST)
Date:   Tue, 15 Feb 2022 11:29:13 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/203] 5.16.10-rc1 review
Message-ID: <Ygvi6YWU8QxV1ToD@fedora64.linuxtx.org>
References: <20220214092510.221474733@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214092510.221474733@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:24:04AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.10 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

