Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDB5ABDAD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiICHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiICHgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:36:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1AD57554
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:35:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r22so3816367pgm.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oOpx8+S8W3ByJvY4eiWGxIeLAlsJyDYwXg3ZTvfYSuk=;
        b=ansQjWS2vcjaDkL1B4J95z64Aw0Ay6LLn2/tMHKQxo+iKmnEdI7W5581xozW9+3HFR
         1z5VlHqa7e3B0SujEvLF46EBG2K6tLjxAgn1Lu8z3WcA+QIi7RSRYiVgw3tgCA2wc0KT
         235IkGWkRK4QC3+JOK3og3vWRR9y2f0CwgZdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oOpx8+S8W3ByJvY4eiWGxIeLAlsJyDYwXg3ZTvfYSuk=;
        b=rYIX6i716ajOX36aKnDx3Cbne03Ql36DQTN68/1ITKKY5xG7bklxfilqtW2HcG8roZ
         xO/WzrwvsHGiqpHe5ApuMGO30q3juhzG7/3HHmCxkVT8f/u9Fnknlq68vIegHtB0nACT
         /vC82ZoUYdTslvKJKbMzfxPN+zbnsbgwLbaQikaWoE0ssXmaP69/rsS7l0TiB75IkBOG
         Vtd7xVZt2dxxkMF2qhc80OJVn5TwOVSC0Lz5i1E0E02hi1to0zzOjGHHPehY1yMKQ7MP
         KC0+UsIjmh5UDYwRUL4PZVeIsQudy7NFsj1AHE6zQil3Vdka56VJkgjTlyHHdxM9XROb
         nkRA==
X-Gm-Message-State: ACgBeo32YCrbs7Sx10/3xu3CjvX80qw7OzaAv4+vbMm3rKKAjPFBYrlK
        9nILb+SJM3Wd+wme32Bimi0jcQ==
X-Google-Smtp-Source: AA6agR4WdJurybDllLWQ0pl6TSzYJo9FOLBHE/C2Lp4xSVjNTNOe+ocv6DBmFwQlLyo+gdhJ9sAxQg==
X-Received: by 2002:a63:445b:0:b0:42c:7b67:287e with SMTP id t27-20020a63445b000000b0042c7b67287emr19479366pgk.166.1662190558842;
        Sat, 03 Sep 2022 00:35:58 -0700 (PDT)
Received: from 89268b632b57 ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm2911029plf.30.2022.09.03.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 00:35:58 -0700 (PDT)
Date:   Sat, 3 Sep 2022 07:35:50 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 00/72] 5.19.7-rc1 review
Message-ID: <20220903073550.GA253851@89268b632b57>
References: <20220902121404.772492078@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:18:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.7 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.19.7-rc1 tested.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)
- Samsung Exynos5422 (Odroid XU4)

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

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
