Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4811D4A59E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiBAKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiBAKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:22:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA890C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 02:22:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c194so2923631pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaMzrp6CD4pfO3e5Ep+eXwdfnB7JTyIu6P8uVnKFFrU=;
        b=N1oMf5jw9LrwWQqfKsvprnVPewxZi/NS23yhShpDQrHhyP4UqzhPdVOcrPSFLXxXIH
         62JXGjyJCiU2eBsVqTUZYoC7bvfprbX4GDY+hFEGwYJwDodhkzXRRV1S4bkwZhrcV1Vj
         NtOoJdDCMQSDaRdqTkfNxtPDhTueWaSTAr240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaMzrp6CD4pfO3e5Ep+eXwdfnB7JTyIu6P8uVnKFFrU=;
        b=eVPdYmy4zLN7g+10Gw7RRC9pEDb7j1joFeYl7ONNvl9SEAipGUZKZl+W4MhKgUvJSp
         QVAu+Wf5Jd+NMG1cpJrVTOXXDv80cgwebqZC9Bj7vOLpwcwlqE3bmxQ0BLxAIMi2tz1r
         AksnyXxe93B/OZbbOstKSRealWHuH5ymb2lWHQDlSDziPQkYoH6CROqLe/+SodUBkYIj
         IwcqRa9b5VkIXnKawk4QWEPUnlNLBh7yQtTfjx6uZRbI5kYe2OzMhvv4ZFzH+Drb7Kmm
         HNJMyIPsfstC/RCAuQCsQXUtx0SQQehV0FMuN/pjO635e3niCRTNkBRGxtGrqOYSCu9Q
         DreA==
X-Gm-Message-State: AOAM5325w3EkeCb+eXqBQb2LF6XZRkHYZDl/4VH+NO2mS2My22W6T9/y
        IV3YMHzFJru5LpYFSBzE0npm9A==
X-Google-Smtp-Source: ABdhPJwpqj5Cjaud7YJwIt2CFU4GZOe/GYVTB6r+TfkTtxWPKJ5Lduqatqn4YkysEWKcyD10QGxLHw==
X-Received: by 2002:a63:e302:: with SMTP id f2mr20232686pgh.451.1643710942130;
        Tue, 01 Feb 2022 02:22:22 -0800 (PST)
Received: from d7a09e6e3461 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id b22sm22471758pfl.121.2022.02.01.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:22:21 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:22:12 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Subject: Re: [PATCH 5.16 000/200] 5.16.5-rc1 review
Message-ID: <20220201102212.GA26@d7a09e6e3461>
References: <20220131105233.561926043@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131105233.561926043@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:54:23AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.5 release.
> There are 200 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Feb 2022 10:51:59 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.5-rc1 tested.

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
