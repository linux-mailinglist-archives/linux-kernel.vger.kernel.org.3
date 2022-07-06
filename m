Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B595683ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiGFJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiGFJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:40:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6326137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:39:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m14so13205636plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wkUncWChWMjH/KXGh3cLGpEyxJsV1EsrVeVziFrzmfE=;
        b=lsOt8ijvBEeA30z3aDBGZSbwzSM5Sdr+Xdw1m1nrCGFfs5TA0gGhy0JObmfi3imkCN
         23IV6yw3Atruq2kZ7kIzdQlirCaM7RPm1Nq1hfQxsFto60phF5Sz7iQNbUUnBVv8/+Kq
         hKIkoy0e8XslKKJhrEgmdOc7vIGL1oWiXgppw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wkUncWChWMjH/KXGh3cLGpEyxJsV1EsrVeVziFrzmfE=;
        b=WtYQE8qbTIeVaNufsv6AoSuin8mmjzP3I58iO++7Z6oLE1GSfezZmDQ4pdv4ZH+Aro
         Aj/skj2XY85Y/AFIvoVPd39L5bE+kcYCdEdZJXzCL3A5kxWPmvhIkRJ9CKfTODelLLYP
         ZFMiQGdUf8NTK+HyZXzyND3XsG5i66eClqukgzUJt6pHYoT8JSwRdllAUrlrt2CKy1pG
         N/4qPNcdrSybocrDikBDw+1zf5bW3v5vqRL6jpZBakJ+YoYddiEqJmJjOQruutE3Z9xe
         xfrKqBlEZ57TF6OUByhnN8Z1ngg5jKqicHwCPgDrgQV9o+HMBq7K3s7HpENGbNaXpDD4
         bP7g==
X-Gm-Message-State: AJIora9wfLBBQGO8XACEGLRL/3vG1R30cTbteIZwhbq93IzRkqbLbzuZ
        AzRaWRy5T9ExL7NXsmOxduVZQg==
X-Google-Smtp-Source: AGRyM1uyCGupWVMcspfbchtgIuqWUYEB6jHZzlAvfihxUyM0E/vNm7mRLtD0Vtz4CkjTEbR0z4teOw==
X-Received: by 2002:a17:90a:d158:b0:1ec:8298:40dc with SMTP id t24-20020a17090ad15800b001ec829840dcmr48360015pjw.51.1657100378941;
        Wed, 06 Jul 2022 02:39:38 -0700 (PDT)
Received: from a29cb3f04410 ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id c8-20020aa79528000000b00525135bd555sm24671945pfp.162.2022.07.06.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:39:38 -0700 (PDT)
Date:   Wed, 6 Jul 2022 09:39:30 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 000/102] 5.18.10-rc1 review
Message-ID: <20220706093930.GA745610@a29cb3f04410>
References: <20220705115618.410217782@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705115618.410217782@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:57:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.10 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Jul 2022 11:55:56 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.10-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested for:
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
