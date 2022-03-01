Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6C4C8CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiCANiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiCANiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:38:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2E9D0DE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:37:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y11so14222473pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4SQZv7AFd28YJZdNAkeaE4ZEJafa6z+sYCo2GCtKzZo=;
        b=MULJkFnV/faTIU/EqETCI2bbIxQ1HmBnzDwbK/mIfKacmih25rscy+eWV1xZNEbOnI
         8SJNz4pP4C6M3AmYvUv8Hbb+OysJqcUujWDDfx3SYNh1+oo+PJiAxSRigunBT8Iy54qu
         TKvwz32nx1DJ6hK0cm5YH3jVwUpgi6XeJxt2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SQZv7AFd28YJZdNAkeaE4ZEJafa6z+sYCo2GCtKzZo=;
        b=NdWfgrEB75L1WFU5DFI5DDsyIr4qCQ1SnsUVRSRq6j+jEJA1rj6mqGzVlFAUP/pE5z
         U8WT2ILitteDZSD6zwEqXCAEYBZ8GoHTK4FpT5GVwYd64Zz/RYeusNak1geYT7kdppUp
         HfZmwjF7YmklgKDVwWhOxj/XaG5j9uxy4FmLqKRuJUrUSy8MxKX4BGYdgd83dsd1DJ0i
         vG5aPVEGZxN1xOKkFg0VXjEgmRxxdIW7wzPTTQAtcLjeYH+kyLP4wmagLS9FEBQQya3u
         0CiIzglM5yMUgPaLhr0kP7q/b01DvLFmswuZRNie4owqJphvedlbEBcZVgvXYOHav9ki
         XrdQ==
X-Gm-Message-State: AOAM533bsGjSWsNpjrTRlW3NJRu9D83WubVUh4mwgr+JNAxbkG0YzHCW
        J/IbB1c+ym/4Od0SrBLE+EQAVw==
X-Google-Smtp-Source: ABdhPJw7ozfi6OXOEt5oALjEw9sd6jogKZOmjMaqBs7eRekOAtiQvmQVuuZjfSUsyaTpYkgMVTlxDg==
X-Received: by 2002:a63:cf09:0:b0:372:d564:8024 with SMTP id j9-20020a63cf09000000b00372d5648024mr21821140pgg.251.1646141837813;
        Tue, 01 Mar 2022 05:37:17 -0800 (PST)
Received: from 1bb6de2becdb ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id n42-20020a056a000d6a00b004d221c3e021sm16932998pfv.55.2022.03.01.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 05:37:17 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:37:08 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/164] 5.16.12-rc1 review
Message-ID: <20220301133708.GA91@1bb6de2becdb>
References: <20220228172359.567256961@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228172359.567256961@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:22:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.12 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.16.12-rc1 tested.

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
