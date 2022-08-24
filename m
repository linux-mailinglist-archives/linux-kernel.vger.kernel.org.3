Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935425A001D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbiHXRMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiHXRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:12:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AB63B9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:12:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p185so2629120pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5vMlpqF4uchxRz9nRlu+nbG1ZWJEWykhLsSWI33KOcE=;
        b=cdG4rt0Thdi2yrVwst1w8/+IzxcEYbzIuYPuGl41PzQxJyjbviOFDtG8mMWYyNuS/n
         R5hnMof+VXhZ6J4YRfzCJOvsHcXFAsHH4cypr/40luSEhceIdS6yNbWIq5FEIAlaIzeV
         gF9BQ2DN42onkjt1HW6r+pkaO+GbDr1Hy+eWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5vMlpqF4uchxRz9nRlu+nbG1ZWJEWykhLsSWI33KOcE=;
        b=iiuuAoVNdkrbGPebRbT/h9eod8pniWbfwbMGHm/9PElLpcqs3t6mAcazyMQrzrbnai
         3nD5D7QxYphiw2pM17sMyna2+/ZheSzVv3VqnGFBBKRYOQVUvsgqEGfFIggdKCRbO5ni
         xkcQTogBHB+s6XyyWErtbxmTD3YUr8HnGNxtHoo8eyYJX9dvJ6PWIRnNOEo2o3H62n3c
         qfNfap6zFSvHJAC+Y6R3+n6r0zfow9KTBinmXZiIpsQHKaMFZHjVCJ02+lEWyp6M6h4r
         ubU5gEdoJLmNqP9D+antBrxVpS/3C1XWYYwVWFp9+aV0HSMYP73ex5HFc9WkgoHtQqT3
         VNKg==
X-Gm-Message-State: ACgBeo2EloNjmmbRdTysKCwvFFG3kWe/QvzuC1eZdk9pSiTmF5wcfhjh
        TBJvkAEZgJIgiquHGL/xRWY/BQ==
X-Google-Smtp-Source: AA6agR5oufg8VQ+GbXwnnRQMwizZMaD2QZfb9V2z1jHcfsQP0Y/LuKHuQY+aWacd38dGHcMoiu2UJw==
X-Received: by 2002:a63:125c:0:b0:427:a637:3414 with SMTP id 28-20020a63125c000000b00427a6373414mr2189pgs.80.1661361134569;
        Wed, 24 Aug 2022 10:12:14 -0700 (PDT)
Received: from 51aa44355c3d ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id v2-20020a626102000000b005361708275fsm10780673pfb.217.2022.08.24.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 10:12:12 -0700 (PDT)
Date:   Wed, 24 Aug 2022 17:12:04 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 000/362] 5.19.4-rc2 review
Message-ID: <20220824171204.GA1669513@51aa44355c3d>
References: <20220824065936.861377531@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824065936.861377531@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:01:14AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.4 release.
> There are 362 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 26 Aug 2022 06:58:34 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.19.4-rc2 tested.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
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
