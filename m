Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF94B1FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiBKIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:17:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiBKIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:17:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3963B4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:17:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id l19so9127472pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRhdyHPO6pxhmoZenbCd5DFkYFwKSkq+xX2G7rJZdJo=;
        b=VTkf35datGbME5I3ZG/ERx6IBxNf1TBSegS6CtlX7Mc79lYH6FbUzSylxY7iVzFeUm
         WfqKI25lR86njWGpabHfRIvHAlE2lr2i2R3gk3KDhrxkx/m1R/UqBd7Jw1phWBDuUhOD
         R4g1G4PIYf0KHCFbVOeCMYK2zWQJedDrde77Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRhdyHPO6pxhmoZenbCd5DFkYFwKSkq+xX2G7rJZdJo=;
        b=nMahM72ZVDkZa1JvCKV5bXBBL1GBpJTbTHmis8tHVCSp8c1vcbayupvbcTF86qyCJ0
         S5MhHDEZfS+e/bQcfe3AoS6cdqM9odhmIrROwucF8DsMIhm8+56YQg30+auCiuiHo57M
         MLfL6z+O6jdvKE09uZ7ofd/gAWvEzaz1c0o/dBezjrjChbdLCmDRr9+gInG9WG9Q9iFK
         /xRRC+CMZ4ZVcftwsT8SQS+3zAuFGIhi9UzwLnJOkvoN5q7Tw+Ea2f394hyK3VV0fMaO
         dMg8o9a5MRH+QPr7TA52Un3tEzf0YUXRF3uSzzYd7VB3uVrjbw4cFNo6u035fqgAarVc
         QKIw==
X-Gm-Message-State: AOAM533Z9tXimPl6IuGqLukaYsGFo5G9ihz94pUU3fMKvhZ4MEAK4fmj
        HolKCbLtmIED8ILUv86b70r36g==
X-Google-Smtp-Source: ABdhPJwpu9qZKsbrkfR+8XnpPW1JuZotWgf3UXc8UyRjii33cHyKXSo0dBFRAfDvg/WTr6D9TKC7dg==
X-Received: by 2002:a63:2322:: with SMTP id j34mr388612pgj.583.1644567440615;
        Fri, 11 Feb 2022 00:17:20 -0800 (PST)
Received: from 02a66449913b ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id k16sm26260605pfu.140.2022.02.11.00.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 00:17:19 -0800 (PST)
Date:   Fri, 11 Feb 2022 08:17:10 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 0/5] 5.16.9-rc1 review
Message-ID: <20220211081710.GA1189530@02a66449913b>
References: <20220209191249.887150036@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209191249.887150036@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:14:32PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.9 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.9-rc1 tested.

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
