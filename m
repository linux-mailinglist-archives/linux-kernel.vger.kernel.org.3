Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178249C23A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiAZDmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiAZDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:42:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A280C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:42:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g20so1921258pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T43DvUrN9xWow8cfUMvGWqvmG5Cl8mTDUqC17tM8PoQ=;
        b=G/0BmD/UCluTbBnd2TG4ZhCuv0qLgShP1gnDxpohP31JJLhVomhYk6PfAR/GNpTgKX
         V68sei9+X0JoJI3um9vAiwj5exj6BBwQGtJIOgk4qZRc5/2Xm/FIMAIQUZptUxsZw3lm
         sF1BzGN4HDrOnYKR1TV4CheJYFsyeI6iD571U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T43DvUrN9xWow8cfUMvGWqvmG5Cl8mTDUqC17tM8PoQ=;
        b=uk5xPMRVx5EBn+zbKCFLON0ZdGQygnw9ScKuH32sSwculVFiNPNX7owZEmDPJaDOE2
         2aGIKtXUZ/3zzc9F+Z1kH27cWYyQeJKEvO51+2mV2j1Pw3OsrLGJw+6Iiye0cvLW7KKm
         jYvxkh3bZbGXiN5fbLKUjw733KwYvqA1ZtR2YKFCBk+h9zZYVnOf59LL5u7cUo5/qrNu
         1F1gMOw0zUUk60i7y+PpWH1p0eZNSV2scd3+Iwuro2RNtU8TUkxSkSMat1ZWZF05B1UH
         UvTw+WYAAWx5dZ/7LCuo7NJLVAD5ZoGZly1grz6SqL/Vf7+6H9e83sja6acKwwpHfF/O
         NPHQ==
X-Gm-Message-State: AOAM533zIwJeYSxwdDcXyNa9xJX/h842kDGUbnNdL9y5mp2rVse12Pfd
        rTjTZJzy3tdN2yza0s5klZDOWp+WFdYZyA==
X-Google-Smtp-Source: ABdhPJwe932Ko62OThzTh3JeGBDK1+USV0wdpYrGwjnogRArdJ1UkAHc01o5YMR20G4FwWOBWZk8ew==
X-Received: by 2002:a63:8a42:: with SMTP id y63mr17648674pgd.251.1643168523761;
        Tue, 25 Jan 2022 19:42:03 -0800 (PST)
Received: from 4dc518405e3c ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id m1sm418914pfk.202.2022.01.25.19.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 19:42:03 -0800 (PST)
Date:   Wed, 26 Jan 2022 03:41:56 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.16 0000/1033] 5.16.3-rc2 review
Message-ID: <20220126034156.GA7@4dc518405e3c>
References: <20220125155447.179130255@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125155447.179130255@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 05:33:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1033 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.3-rc2 good too.

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
