Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500149F84A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiA1L0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiA1L03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:26:29 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D989C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:26:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 192so5858307pfz.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GTL7/BOv4lVDxBXnM15feo6pVbCDvXp/AEHcvXWMhq0=;
        b=Vl8GzlaXNMauRoFrr8MSGPbBazgV2P1d319wiEwCBCg4ID+JFbPAsJiV8csyJyWx4W
         JNWsMAVixQ3VfeKUDKgctI0FVmdu8khqu5/6HTGPQsNNFqkkKgAHNC1u9K82O8H5TUV4
         zrVZyMONaHX8gunW4gC36FFEv5sCTJUIeZijo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTL7/BOv4lVDxBXnM15feo6pVbCDvXp/AEHcvXWMhq0=;
        b=o1t5MO+WNeqwq8HjOk/543pCiXyXSvNEg0HCPVJIBGTnPbyFHlcxdA+2PFm55AnhdD
         eWJF60heBYDYz6dsoLrClEH6mekN1OJRXAXl1fMYQQgs70mDBYdSdEgIdcsj0L8q2Sgk
         V1jSvdutVn7bZw4y4eBsGGAwIj+yhW2cHzoYJj5uIv85YjPX14r5k4ULIdvO24cwxpSc
         nmFJk2edW20SVkZYoU2jFCvbuyZsbxFBEAQ906fD95O9mgt2yg+vV8Igq8a0J/N7yho4
         Bo7d4suBo6DTqiMvzi4aDETPFoV+n2UJrXE0yC53DkuL0AAjjddWx+57DLYO4In2vs9c
         8o2g==
X-Gm-Message-State: AOAM531Gx0ucp3DsRogLxQYsC83VDVot0Mgg2+XT6JIVFZnh0MtZvUov
        tDlOx7mDJR7DnmxFDKT2zONMWw==
X-Google-Smtp-Source: ABdhPJwhxu9x3MJkeylqe469WLcp+17qBESHoJM1w2UppQkJPO3ok9iJS1Mnw1UeJp4y4KmG3LSxLQ==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr6168244pgd.230.1643369188831;
        Fri, 28 Jan 2022 03:26:28 -0800 (PST)
Received: from adf6a34bf206 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id a1sm21503721pgm.83.2022.01.28.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:26:28 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:26:19 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Subject: Re: [PATCH 5.16 0/9] 5.16.4-rc1 review
Message-ID: <20220128112619.GA7@adf6a34bf206>
References: <20220127180258.892788582@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127180258.892788582@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:09:35PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.4 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.16.4-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition: build tested on:
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
