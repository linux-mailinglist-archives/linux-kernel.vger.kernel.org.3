Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8168F4D9335
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiCOEH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiCOEHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:07:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549CF1D307
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:06:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so1191921pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3TMNtHxozI8oB+z1qPhuCb+opQbKNP8iLpQvJgcHJb4=;
        b=AZXdQd5CrqpNUjcu16jAMFlxTffnHtkltA0D4c32O690li0Is3on6Qr1iU7eCnx1vJ
         213aCtsfyRMgP7Lmp1vVVndipVn1VLj7fa56LwZKB+herfxk1aPZ5oC1zv+9vMf8BXv/
         fAvaDN2vb1QD0yOe59mjL7tRXaU8yzf07/MpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TMNtHxozI8oB+z1qPhuCb+opQbKNP8iLpQvJgcHJb4=;
        b=xnuOcXgr6oklFSKECsM7M1Qp1OrJW9XnZF64p5aOQAZEwL+MS3SCGeaW/SA7ruuEje
         NkAZQAZ3eRFz+KnCAzxqsLMJ3wHlvdBUONG1VKZYqO0//43aXkxRkaV54BhNVwVfGqHY
         26ixEJcblZUE7AWyBl0FiBh/jDnijELx7a/qFDz2Iib8z3hJ0g+3bOGun+22TgcLDl/x
         GO67/rZUg9PrhhbPHNrlTxpqdg2D674FKD7zaNevKBLR80Pp125RJxzCT02nz8rAK+6L
         4C8JxKqXkSVORg5W5g7+0jmIoAgP/cv1bL6nEJkn7Dia7s5+U4iQsJ9Q2sq4hKi2G/1Z
         samQ==
X-Gm-Message-State: AOAM533+RRuEUUc3kX+HuHDSqYBZE4XXvqAEuMcd5K98uwvYMDvWHlZQ
        XJtEGNUPBWuhD+UuqyZN1KjSrg==
X-Google-Smtp-Source: ABdhPJxL5rtr/nbC7oeF7qecn+rcYxGdyPDCb2fGQCrNIQ5rh0lliC0+T9/k/09JxqN6W1xZjV59EQ==
X-Received: by 2002:a17:902:7886:b0:153:3a40:fe82 with SMTP id q6-20020a170902788600b001533a40fe82mr17977086pll.19.1647317202777;
        Mon, 14 Mar 2022 21:06:42 -0700 (PDT)
Received: from 76824917ecc4 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f6fe0f4cb2sm23088080pfj.14.2022.03.14.21.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 21:06:42 -0700 (PDT)
Date:   Tue, 15 Mar 2022 04:06:33 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/121] 5.16.15-rc1 review
Message-ID: <20220315040633.GA6@76824917ecc4>
References: <20220314112744.120491875@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:53:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.15 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.16.15-rc1 tested.

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
