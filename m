Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB957ECCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiGWIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiGWIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:39:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51B4AD57
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:39:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w7so6326856ply.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uyq5TDHOhmXVHPsTps68pWtBrecXqocdN1+EdXeAXOo=;
        b=MERh7izAsRIX18mDFg6bC7iTHjlIYdu6+VE2YpFSk72x0eEQNzW0ZFHO8sH005FD72
         JT2uaPxVQpytSjnTCPOOjatLPPlMhB9zQkFjHHBp6VM5POgzz7LEuujKwjH1SC6W4cnl
         tZ3mz2zR9dqG26rXkATGseyloJa0V9r/2llpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyq5TDHOhmXVHPsTps68pWtBrecXqocdN1+EdXeAXOo=;
        b=U5SykB7I/MOFMFFwKejJYFBoP6yZzWww/gSlodNSyFWMEvM+WV4WpuetZdbMbPoZcc
         3fBEaFnsYbeIoTmeI941KtnEvNUUWWwluXSnVefIB3zrVNdkwLN7jha5/8fsu9b3Yd2A
         7FUqQMRoX7BFUr1tbc4AICAPF6p9t4pf7VujDVVZ8q0lGqRw/UuzkKSxxB8oAZrQZAOy
         ss4phzwKZfcd3PVQJC8D2OfXXcEh7aGz481YMCAuV0fA6B6ncjVHZc6kgtVgsswzNu+P
         x6y6UwYDdTlV1agC1jTSuJ4ohUSJg6sgHYxUsMoCg7a4EQhWgYTVwNMT+c31cAZtbeGJ
         aZLA==
X-Gm-Message-State: AJIora/dfpj6MC0OdcyieoKBqN3yArkULLVrYRL7b8aSbbDKXSQ/I37C
        +81v5IdXmaZUEfqOgBaKf000hQ==
X-Google-Smtp-Source: AGRyM1ugWPYoVdDs0ya49oV/J1k37aM0Tuj/KkJXpAibl+cTZlGmcZX4paVLUETPaMVnBbpLQq5Zwg==
X-Received: by 2002:a17:902:e1d3:b0:16d:be5:4b3c with SMTP id t19-20020a170902e1d300b0016d0be54b3cmr3372447pla.8.1658565589403;
        Sat, 23 Jul 2022 01:39:49 -0700 (PDT)
Received: from 65aba7cb18f8 ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id y14-20020aa79e0e000000b0052a8128699fsm5326769pfq.207.2022.07.23.01.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 01:39:48 -0700 (PDT)
Date:   Sat, 23 Jul 2022 08:39:40 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/70] 5.18.14-rc1 review
Message-ID: <20220723083940.GA22@65aba7cb18f8>
References: <20220722090650.665513668@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722090650.665513668@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:06:55AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.14 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Jul 2022 09:06:00 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.14-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested for:
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
