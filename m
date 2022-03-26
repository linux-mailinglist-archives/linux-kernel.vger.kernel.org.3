Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5C4E7EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiCZCz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiCZCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 22:55:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E581ED06D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:53:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so13849432pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PSIzA3SpmPoH3dTegWNfD7Vv70zoBNgsaVOFtt43/Bc=;
        b=nSJzWQN4BaeFQPoqBygBN0ITz429JEufgDJi4BftxutV+8zfgJ5iUqWqjZ2i6nIcNx
         2EIkKIA5YrtYVGL+YOBrdwVExrNw9uoN6cF9p8YaNqx056uOnuSf/PfZlUIGbOMH9tKC
         3fwbBC4aWEx+aqf1Pz9u6UusYRKeGNff13BlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSIzA3SpmPoH3dTegWNfD7Vv70zoBNgsaVOFtt43/Bc=;
        b=DViSSHEXbxBbOAUreqXsoAzSRtk/s7KVvMfKMWU0FIXF4qXwCnq3WAi3EvA5mswtCC
         9MxxKwWsuEEyVAAAXRzh04fcFZHHa16UIDte/Yfnkj+caEABzZxCJtqgwc0cXMgy5EGt
         +RvspHlo6lyIJxtnfaCADmdSTjeAfuZMxynyl+dhbUBYfEDWhyb8CxuiPG4F7lHsrQOp
         orh8IYYO5GwkLTJOv6WAisSaeFmr9iyUnWoSOQ6L/Hzcp1wMLxJo6MPOwaptZK6joYEu
         CK2w8QTF++KA444iJm2rdCVcgZOp0ldvPZA0WVdtNSey9ozosYBbbRuo4uxIF5ReL0ga
         9DIQ==
X-Gm-Message-State: AOAM5333hD/GR2oQT7YqKrkbmM245mlg8xAZnQuH6zQIkHrBPWrsHUCc
        uDKItWol9PVsnmKy/5aM4P2cji2tOy217SuiJV0=
X-Google-Smtp-Source: ABdhPJzfibpB6rdR0T7HJKExSnBJpuF/dDIcZ9CCmazvIpUr+AOvvbX2lfRPbxAu3iDexWWwFIX1dA==
X-Received: by 2002:a17:903:2444:b0:154:13b6:8850 with SMTP id l4-20020a170903244400b0015413b68850mr15054628pls.55.1648263230255;
        Fri, 25 Mar 2022 19:53:50 -0700 (PDT)
Received: from 86f5abb19214 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm6751036pgm.28.2022.03.25.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 19:53:49 -0700 (PDT)
Date:   Sat, 26 Mar 2022 02:53:38 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 00/39] 5.17.1-rc1 review
Message-ID: <20220326024843.GA7@86f5abb19214>
References: <20220325150420.245733653@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325150420.245733653@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 04:14:15PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.1 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.17.1-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
