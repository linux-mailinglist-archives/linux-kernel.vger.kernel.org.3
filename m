Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20510483BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiADG2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiADG2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:28:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB43C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:28:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i6so20395613pla.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=socrBGQfucWKW3aEhPqrm5BfPK116xS5lGaBWDAFhJk=;
        b=iV43JRn7OQ+HSMOXEYqL9n5OJhryxOqawWNv9jrQ6wM5l9g4CunIYJGJVEvhKV3WCD
         XBH2N62lJBTk4bnwB9HjEjJLstmsZAGrnIpcbubqpYqvE6+9OuCnkh4Un9KoTw2m23oA
         itVCSWJEP3alK4LVxVcPj2e0dHXCSqGUPIFJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=socrBGQfucWKW3aEhPqrm5BfPK116xS5lGaBWDAFhJk=;
        b=i+cc8mQgiRMlgYrZCiBRXMH4tPaLr9sO1pZI73xkFG43KzspBrAKXzpb2LgHI2quRH
         hzKEiWsHdE7C/MjoGoUvchpiKZp3W3oIuR4UCGkgIkolqTFX/F59vJ4RItMXlAye/ghW
         vr5PDB0TyChywS5Qdoiy/sWR0Ktf1g9PfkeYDpvwFScEU8cegCQg7xxo5jqMMFrn0eff
         ceUERIwKAM3j3qNAJjEjkMCyGzCIK4W5Ns5Z+wIp4n1U7wNHOk8799SogxRw8tcl6/3a
         TXdVNytgprzMlrVPxStQfuYowmt5x0RBA9Bj/PpeEa5HefVJVYOOg0J5hitv5HgebzGY
         a1gg==
X-Gm-Message-State: AOAM532RRz4Wvb/vt+9biXuarFo1JGXlXe8ky84VjsOGv/9DUfswAJUP
        xSLrsFOc+IxdBY2k1a7+6cbnwA==
X-Google-Smtp-Source: ABdhPJwgYMB9hhMvtj/o7ktnWoeTkYMWDf+dW9lNaqqPXM4+EE3Lcyj8QekwxGjNw4OCH6iZE9wNDQ==
X-Received: by 2002:a17:90b:4f4a:: with SMTP id pj10mr58544723pjb.112.1641277698600;
        Mon, 03 Jan 2022 22:28:18 -0800 (PST)
Received: from 12c50cb15705 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id h191sm34541436pge.55.2022.01.03.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 22:28:18 -0800 (PST)
Date:   Tue, 4 Jan 2022 06:28:09 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 00/73] 5.15.13-rc1 review
Message-ID: <20220104062809.GA2057326@12c50cb15705>
References: <20220103142056.911344037@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103142056.911344037@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 03:23:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.13 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Jan 2022 14:20:40 +0000.
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
