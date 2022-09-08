Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1D5B158C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiIHHXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIHHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:23:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6147C199
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:23:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so16957496plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4ATJ0k7KtoLKHz24ma687N0bV6rG4dmH0nTzWuRiGiI=;
        b=eQoGDF65VNt3JfPPjWROgm3RLsX/GDgBdw8MfXmOGgm1MNIN37j4gvGK6CQGunr1VH
         1OWMQl3VTD/wZODwCMtNnMiaS8e3EDptVNhgMjE119PQikIqu4z1oLIloAbGdywUcijB
         sRgN9ZQDihMd6kaY6k96YjGHq3vc6Wek7TAlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4ATJ0k7KtoLKHz24ma687N0bV6rG4dmH0nTzWuRiGiI=;
        b=gLFuIaSHvczvo3NNQS3a5dS6W/UP1XfROaWbbFtxwLc7GXRUnRtzYOc+Q8ssRFbAKw
         K54Hq5kS4dQU8LGSvAg9++jFZhnDGPzRVY6QeJyKhIh5L5DMwMx8M6WZPGiFrciq/RwF
         dD6k6USYkoohkPnVvrWlMVfrSYfNMvSFI017QIgUmBYoSFCjk4yrUHFgEsyHs7y6G+HM
         TEe32yr6Bn2g85Zv3zr2kZOk0XLha737SYlvSUxoTFKY0D9jI6Rfq8ji+9kBycnrcNg0
         jyAjoqYcKUHeZXxUdq6w2dzTY4s5WBmqWo3ENWZY6ShQCa1GTQUmZ0PEwM07f1HDsaP0
         d5zA==
X-Gm-Message-State: ACgBeo3lhT8PI+SBahbutLkJpvzi/nKmfS3X6ScMFwtnjUU/Z0GfWuBf
        odoCV0NxjTW94Jr8N+cnEhbXkA==
X-Google-Smtp-Source: AA6agR5auJnsVYbI8XVsTcE1glBPnHXMCGp6adMtpDI/c6F7cTxjtmcMRWtLiBREO1LlP0SFUmgHZQ==
X-Received: by 2002:a17:90b:388f:b0:1f5:7748:9667 with SMTP id mu15-20020a17090b388f00b001f577489667mr2773667pjb.158.1662621789506;
        Thu, 08 Sep 2022 00:23:09 -0700 (PDT)
Received: from 9c4a42ebaaae ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id u195-20020a6279cc000000b00537eb00850asm14091177pfc.130.2022.09.08.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:23:07 -0700 (PDT)
Date:   Thu, 8 Sep 2022 07:22:58 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 000/155] 5.19.8-rc1 review
Message-ID: <20220908072258.GA1830588@9c4a42ebaaae>
References: <20220906132829.417117002@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906132829.417117002@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:29:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.8 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Sep 2022 13:27:58 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.19.8-rc1 tested.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested for:
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
- Samsung Exynos5422

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
