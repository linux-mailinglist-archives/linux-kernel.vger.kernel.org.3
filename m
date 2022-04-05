Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC64F538C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360065AbiDFDYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847587AbiDFCTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:19:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA94264F56
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:36:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t4so726083pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lljrXUFbagVeQhy8RP29MKKFHgUe/4Kwp5xKXHPRzY=;
        b=dGvRJCdJUlRc45VkNmI0Sdh3AdsiexL36YcyCO+Az5ochInbrORyu4H/8hjpeVoBdg
         JTCdbsx3p8vJka3z3HtrbozjGZv6OEO2wmDVthzLovFpZWy7LWedENYo9RjPzEC1uUjr
         KrHOTO23jHaA0t6dCE3OHQoWgr0a21n9tfY4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lljrXUFbagVeQhy8RP29MKKFHgUe/4Kwp5xKXHPRzY=;
        b=qDw1lzlU3w+zrfbQbQ/q7mhdAfVEpGR3x7kVeGz1hUsjMN21kn8W5UWAOcvG54//m1
         avwlGTQhgEx/uM2Jyr0vj3gyGuJsyj4VGTQ5gaIZhsqGFg8S/tSQTUb7jITG06MXs9aJ
         TGKzqwBQeSsgAuPh+jaP/i0qO+9G/nV9O8bLrNo5N8Ql2CoUIX9YbsdvH5VxRQzYYjm/
         3yBCbL/+kxpRrgeHw8jZ5kI67rOiiiiOL+JyQYiVowroHarrBk/3DnOmrjmPH/CdySkK
         d01BcTtZafprHsC8lFf3PYAwx173AVG9ByZG/KI//TMzFRWJ7JFdhGnwjVQ/c2SdMXIb
         2hOw==
X-Gm-Message-State: AOAM531x8+2oEw5luPANQNGFgxJARo1BQyORV0bcbkVW6Q6hhVSfYBST
        xlm41J6iMB3kyxgcx2Cf+v1bqg==
X-Google-Smtp-Source: ABdhPJxUlF0h6wSLBKFki0A2lv7nc1KXFZ58f5y3cc8o9aBNyNPF2ITMR9PpUBTloHb+3nLypC2CLg==
X-Received: by 2002:a63:3346:0:b0:398:5811:6b9d with SMTP id z67-20020a633346000000b0039858116b9dmr4717005pgz.137.1649201804007;
        Tue, 05 Apr 2022 16:36:44 -0700 (PDT)
Received: from 4acdf3643319 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm17099627pfo.155.2022.04.05.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:36:43 -0700 (PDT)
Date:   Tue, 5 Apr 2022 23:36:34 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 0000/1126] 5.17.2-rc1 review
Message-ID: <20220405233634.GA7@4acdf3643319>
References: <20220405070407.513532867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:12:27AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.2 release.
> There are 1126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.17.2-rc1 tested.

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
