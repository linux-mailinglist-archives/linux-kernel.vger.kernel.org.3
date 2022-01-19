Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44A493A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349057AbiASMU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354399AbiASMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:20:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DACC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:20:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c6so1997501plh.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SONpE0xkhPhwU0NnWNEU0+qJCseBQ8FO6j/Frn+cDLA=;
        b=GFX+NprpvsCDJkKVV7Sy9jUHEyZNRqPUxhzzZnaqeU+xE3EdqN9Oh3pR+0SM1l/d4I
         vXbHKTT9hDJ2pAmowtTFstc+0ff3R/IijtqANg131ekSzyAMzzow9DifBHWfnN2WKZH2
         u6Zl/MWnLUsqfuhCsNDORexldtW5zvWHkUXo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SONpE0xkhPhwU0NnWNEU0+qJCseBQ8FO6j/Frn+cDLA=;
        b=5dhjl1Bro8qtnha6CHFewkG127Vo0jiskq/4b/zPduYPaaQgRCDU5SNjTcfbLrtCvL
         eU6KG2s55zJtqUwo27XQVJdzN8lI6DcMvpHD3OZCIWjFpemoYtfgFURpvhv3JkGTy7Z0
         5GsKoVWiLXdofJSsEPZZImGurtvBUX5gmJWF0mjiSHzn97ahT2giuxAw1T1x+S9oTvdX
         gjB+IoKYDeSKdtDQrMndEt5gRAm+PkrzGa+/zNUToh/QlYnUIMwDYFCEIRPoALt1L3GJ
         S0CZstyBk3OG1kaGB18yVRInv+DXy5D3hIKGPSNTX+BD0X0mRGHFnQpHAscbdV4RoSFQ
         wdSg==
X-Gm-Message-State: AOAM5332Io2blU64+/fQPVJK2NhoBS+BAJlbHCvEIU74FKSJahlIKQQ9
        wIIy1zbIbbXkauFnKCsH01mSz1olVzh5H1g0
X-Google-Smtp-Source: ABdhPJxzE0DtsjY2ozFDylJZIGtRaYn4CTSFh68YFLfhSCG6JtNIw4v2BSRd9jbMzFKlHtwYB934Zw==
X-Received: by 2002:a17:90b:1086:: with SMTP id gj6mr3990784pjb.168.1642594836718;
        Wed, 19 Jan 2022 04:20:36 -0800 (PST)
Received: from 4f18b3450899 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id r33sm8315375pgb.29.2022.01.19.04.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:20:36 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:20:27 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.16 00/28] 5.16.2-rc1 review
Message-ID: <20220119122027.GA1380493@4f18b3450899>
References: <20220118160452.384322748@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118160452.384322748@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:05:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.2 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


Hi Greg,

Looking good.

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
