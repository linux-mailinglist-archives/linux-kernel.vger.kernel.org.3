Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39F4AD695
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358836AbiBHL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356311AbiBHKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:31:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5DC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:31:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d187so18083531pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n2sPaAfs1e3r3EaCKrH3flEyvxcUKOyg9+DSgqzK2kY=;
        b=MW9d5dMmZamQEEDqf3yut7WOOWrRcS9vhDUuzD2Qffdf/ZkuPQhYNVJrqUO5rQG5Pv
         kn3LuLy1MF4EdVeySja+iqHd3GGUdxUdGhtaGb4++TeB9bN24bxPl81e7bMbbLxkMuYZ
         n0dIQqRgAafGZ04HEA3KQBKFpMY/BIIwW9rF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n2sPaAfs1e3r3EaCKrH3flEyvxcUKOyg9+DSgqzK2kY=;
        b=Tgz3XJaaTzevvjsSeu8IhGMMud9D2uw0O9I/cmxxFH1qLoyHO7Oos9zePhqY8Gk+AI
         XOyrgLBxm8WsRC+9nWTZZJ1TbFY2oeMnXqhiXYvcod2wQSL8+UEsayyFzea3AqAeFRx4
         Nf64fsc5ne7LoELb6i5npvzueE3ApzbVZCMSitI87JaS4fbMFN9/VCAwqFT5UDtjHrKf
         4ANP+l0dXTiu3qk4e/UwSBXhgJgXQbU8udu2Ab3MlzED71j95lG48X3LFB0yEfnYgJHN
         RIh5MBz8FP8XKldJrJj4Z6jAUBKqBNamxvT+Uza5bKizyDbQPySEQ5gjrRztIyY0A9mr
         iNcQ==
X-Gm-Message-State: AOAM532fJ2qd89Pyhp/jJFL3isQGlkfIcY4XJcx0ib4twXGbSpIo1kal
        9bqlHEP734WF424mpPrhojr4Dw==
X-Google-Smtp-Source: ABdhPJw5CoJJ5j92QzzAFiXKwho86u7TKH2Dj9d4eLJJvDDSEUpwHs5VzBuY1DioqejlBbgmzCMXMQ==
X-Received: by 2002:a05:6a00:d5c:: with SMTP id n28mr3738935pfv.9.1644316267474;
        Tue, 08 Feb 2022 02:31:07 -0800 (PST)
Received: from f59db626e9e0 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id q16sm15514674pfu.194.2022.02.08.02.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:31:06 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:30:56 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/127] 5.16.8-rc2 review
Message-ID: <20220208103056.GA29@f59db626e9e0>
References: <20220207133856.644483064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133856.644483064@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:04:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.8 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Feb 2022 13:38:34 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.8-rc2 tested.

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
