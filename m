Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F45712E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiGLHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGLHOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:14:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7D643EE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:14:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so6836272pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMreW5eGuFVvOYr05yXN/MmRKeCw6m+Yo80wN8GeX2g=;
        b=Y0NLuwIaUmmT9xp6Aj1li2W+gPligTJllQnBREwnfOaCF1octg2rwTpCoMUjN6rTua
         s0efPXxeseIBb8WOW+mIlA35ns4qrzHL0GjhYLuNW/glGCOK1Xz7WrEx0ZX6gVe4dtL/
         5cvBZEt4ywK5EODgHtrF9Nu/jq3oXwIAKrxMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMreW5eGuFVvOYr05yXN/MmRKeCw6m+Yo80wN8GeX2g=;
        b=Y6YU8Ilsfxeb0BqRJQAiSUhqoLit+ltL/6y0g/3d6x58Eg3O+3AG8va6QWcfOIm/BS
         8z5XRsQSab/w35IVw9a+eM/AqT/2SrSwrfBu9YESYfcgVQOhpEaB4BsdI9GJd7z3xmeB
         HLkX3oBq6NUN9bu9yGJhgzBfq4yDcKlc38+7Iqrza04VeS32tbYBrxLooPWIRH/yVQ1E
         YYqq7Qw1Qz8lW/ljlA0o0YcDBRh7pP5IDxtIkAmlkF9EUxYW9c8rTBQHUv77wi7tg4KQ
         wf8YTDSvDmYiyA+wrgWUUKBB/rBj6cSxxCfE5LRJhOgw8CPHPWpr+WqJYJ4yOZZzqKSI
         EPdQ==
X-Gm-Message-State: AJIora+s8/2p0vLWKJ8sFADkSzwTmFvDoThrdTzFJi4omCC6UaxhRhbH
        VovxQjdjMyc76GlmWO9loMgBhCSpvEYCKTPZC2o=
X-Google-Smtp-Source: AGRyM1vQ0OIKy/h8usrtTKp3KzhRbevhNvjMlpSWVoEX/9ilPzC45+YahgzZ4+tgR3vzHRsZv2BN1w==
X-Received: by 2002:a17:90a:6741:b0:1ef:7f62:6cd1 with SMTP id c1-20020a17090a674100b001ef7f626cd1mr2590182pjm.89.1657610056397;
        Tue, 12 Jul 2022 00:14:16 -0700 (PDT)
Received: from 84a0fe815f2e ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902d65600b0016be8d6fc15sm5982822plh.104.2022.07.12.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:14:15 -0700 (PDT)
Date:   Tue, 12 Jul 2022 07:14:08 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 000/112] 5.18.11-rc1 review
Message-ID: <20220712071408.GA8@84a0fe815f2e>
References: <20220711090549.543317027@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090549.543317027@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:06:00AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.11 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jul 2022 09:05:28 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.11-rc1 tested.

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
