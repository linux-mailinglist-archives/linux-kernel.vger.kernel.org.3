Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629E59FBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiHXNn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiHXNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:42:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE858983A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:41:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w138so13899541pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ok6BTmgx7Bk3qyjMZTGoGgyj9UUM/y6+7UqYvurHQD4=;
        b=PAde9oUKhlatOPG3MPo3S3oWahMuhh7pxf8GjmdnqnSkgoF8SVnUFtzjWp8u+7ZPMk
         tZOBmOnvertWphQBmXJAgvyhDlGn0JN+NXaoO/yXrwNTNStLot4DGRBQxSDa0c4Xkmc0
         w2l41xx6YrEJpdcdGN2/pg9vdfeOBLE+KjrWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ok6BTmgx7Bk3qyjMZTGoGgyj9UUM/y6+7UqYvurHQD4=;
        b=grm9+HacmFIovmwUXfOBaBo5qj/b0IfEls+Ox8Er67NSWCZY0Oe21uNAJIfkygAbsT
         N41UCf5H6Os/SFqTb0qpRyRBeAirGWo+huAU55iQgiRI5XUOEfgQoiOGGDK6p96nHhDc
         zbm4z3e+iZGe+noJOSIC11J4wu8zBsW2O7IDzZuwOUE5bbbF4+e/sMPagmxq0UL/SYHb
         KMvti/dlSfc3MvNj5zAM/nuRxlxHQKS2nl3TDT0TJRUamXtd2wVajKI2Q1nYwT1b8/aj
         L+GeAS+Bwb8AZqI6zZ0dPG/mWKs1pBCpPqoqSMOwaON9nbRikkghc75ua3WVDWBTosIW
         FL/w==
X-Gm-Message-State: ACgBeo1EkG9nC1QZFuYKAdwgaX6OfYBuchrngXNJvjx+795fnFVSC0tm
        yss360Old2QXa5qI+UHDPLVoYA==
X-Google-Smtp-Source: AA6agR5CNgY3Asm/p0tgmzHKnt+tECPlAfzFc/ZnzpH/F9IlMnb9F8opAC97joPq+yLx8vGOWpGQNg==
X-Received: by 2002:a63:484b:0:b0:41d:9ddd:ade with SMTP id x11-20020a63484b000000b0041d9ddd0ademr23583966pgk.540.1661348510513;
        Wed, 24 Aug 2022 06:41:50 -0700 (PDT)
Received: from 2e380637d27a ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id f125-20020a625183000000b0052d9d95bb2bsm12903927pfb.180.2022.08.24.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:41:49 -0700 (PDT)
Date:   Wed, 24 Aug 2022 13:41:42 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 000/157] 5.10.138-rc3 review
Message-ID: <20220824134142.GA9@2e380637d27a>
References: <20220824065856.174558929@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824065856.174558929@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:00:52AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.138 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 26 Aug 2022 06:58:27 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.138-rc3 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
