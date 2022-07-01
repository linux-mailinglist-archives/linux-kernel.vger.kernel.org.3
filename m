Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD6563306
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiGAL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGAL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:56:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8583F22
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:56:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d14so2408662pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PR4t2lbs5ROKA67qBXbhqmcN8/VsW31hI+3LjJuCmDI=;
        b=l+CxE3B9PduJ3nKf0sLhhmLajZfhxV8Dpzx5Sgqrnr+YCi6ylOMU1Ffumuq4gmicsq
         EK+clE8xKzWkT5FSSYI1sN1zMDaAOc/zg4bvWhy23FviKDNNjnB5MbJcm/gaPQplK9sh
         N8PTCI/+S06uV7hTHtesyj3t4jDmM2jl2I89k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PR4t2lbs5ROKA67qBXbhqmcN8/VsW31hI+3LjJuCmDI=;
        b=2eQx4HfaOdJtbiO4GUh9CM1pX5vL5Y6UkUV05WREyXmKatAtMP/icyeSvbt/5QNTNW
         gWRZaU2btFd4xt7rmG0Du9PuE5z8ydz975J4Oi+BcHWejAgkexDj8FH/Xk2n4iNdEK5f
         murBG5z8T9j3PaVO/Tk+G9oePHwX94C4431GQO+1vLU2mpVQ2DAQFHW05UUrWCG6LDDc
         KxLIBiEoh47osYxU2vxrhZsaE0W+AQc25VVxhT7jcmXp5E7l8jfRsQ9qG5BSIrKg11x6
         IpSHxiOL4cxeSdYXi3+OaG+4RCMRlOfpbRRdIjSfaOnnybnX8UvRPe/Z1ZGT/3FP3PE/
         BZBQ==
X-Gm-Message-State: AJIora9fs7tZy9Dk8MSxIY6/yu9EztPPdu6vzI1vNFJKW9b87Z1bl9R+
        +c5jjopdkSiXlvSOJoy/4IOF8A==
X-Google-Smtp-Source: AGRyM1vs8MTSp6rS/AbiELZu+/UVlmPjHaiDAU/hHl6UUwKYaoxqd4BbKZTAYRyjX7jY8fEWylFeCQ==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr17883093pjr.62.1656676618003;
        Fri, 01 Jul 2022 04:56:58 -0700 (PDT)
Received: from 792b621d1c2d ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id t19-20020a63dd13000000b00401a9bc0f33sm15041607pgg.85.2022.07.01.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:56:54 -0700 (PDT)
Date:   Fri, 1 Jul 2022 11:56:46 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 0/6] 5.18.9-rc1 review
Message-ID: <20220701115646.GA9141@792b621d1c2d>
References: <20220630133230.239507521@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630133230.239507521@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:47:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.9 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.

Hi Greg,

resend: 

5.18.9-rc1 tested.

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

