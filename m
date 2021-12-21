Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3347BE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhLUK4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbhLUK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:56:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26287C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:56:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v11so8210100pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NCsrps1VB7zv4WoOsC/DWIopmzq24bKQXov1cHCoSE=;
        b=dgYeMu7+MhdFVkYweWszhr9AQkrcGVMxp3EZU07VL3Ok8r0pvZuPqMBdnnjJuHsqm+
         7BZoafwe0BJ2Y5+SLIFInQntcdXSMHGZg2jnjHr3juw6D6E5kjFkLcnUbZpIG6qa9TyT
         Reh6AibWU10O/XqE9fNEjAo85ByZSqbJAj1EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NCsrps1VB7zv4WoOsC/DWIopmzq24bKQXov1cHCoSE=;
        b=VLA035XI8SZWaDNkJX8vI3qDUHyaD74EzaJr63wLLrv4UhVllmayaQInZhqycojfPt
         vAu5+Q8xYRrAeHU40Q63AEYJ8fwBweEjzBZXTGgpArn6MGA6k1hfqPEi2BCCa2NlnoIR
         fzdnSJl+i+Ow0AkFV3ufPsmf57AAK4Kvyrv3IulAjF8aWrPrUAlhwude665mUPfbARdR
         8AX+gIWUI3qrjVMhcJIliynhpVWsmr9GrtTaE1ZhgSH1g3bTg9279GiSdLwZFIbCHUVt
         rfyeo5ZP8tbhr3wztSxBmUneZgI3265o06N1rT5UNmIO9/LKV2QIYJnZMtkn2MD2L7VU
         1Afw==
X-Gm-Message-State: AOAM531SirBbTPbwbjEE3LnEIoY6gmLlQTHjIUS6Yh/LZVRxlyJ+0cky
        dpjxo/GXaCyU7CYT8ZP7RALI1A==
X-Google-Smtp-Source: ABdhPJymrs4hgP/Wh1S07nIz1KLV8v0OS0zz/u4I2xbmG2psObUFhqMdRTtycPqO5hDcRrkaMGSDbA==
X-Received: by 2002:aa7:88d6:0:b0:49f:dd4b:ddbc with SMTP id k22-20020aa788d6000000b0049fdd4bddbcmr2663799pff.31.1640084211426;
        Tue, 21 Dec 2021 02:56:51 -0800 (PST)
Received: from 9d766e42b9b9 ([1.145.8.37])
        by smtp.gmail.com with ESMTPSA id k19sm3108216pff.5.2021.12.21.02.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 02:56:51 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:56:43 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 000/177] 5.15.11-rc1 review
Message-ID: <20211221105643.GA1117674@9d766e42b9b9>
References: <20211220143040.058287525@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220143040.058287525@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:32:30PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.11 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Dec 2021 14:30:09 +0000.
> Anything received after that time might be too late.

Hi Greg,

Looking good.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition: build tested on:
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
