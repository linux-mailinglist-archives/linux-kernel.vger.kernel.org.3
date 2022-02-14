Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D34B5BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiBNVBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:01:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiBNVBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:01:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2D9BBA6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:01:21 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z16so9444500pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uNlqPYCMD53jWiyYXdw9aak0gXKhbsSuXuZhyXCyHmg=;
        b=NoQiEClPzkJ+XRi6hmHI7774JKuLP1E6J/oyoThWYOq5Le9xuEEagPZFK5pGpZUwfd
         xHznHquGdtKJtk87zj95OL5aTurOmtI0yHvKo2bXXPrg9MdfzJmjHopMYad/7c+xl+sO
         3v+rVvU8U1FDaPm1J0U9rDeyUq98GgoNviIWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNlqPYCMD53jWiyYXdw9aak0gXKhbsSuXuZhyXCyHmg=;
        b=OoNq1uzKJ64VVwtD5kbGlfT+cf0KHZR+rxwPviXeXNzE13aML2o1CPlk2yymkkxY2X
         ZazvgrnWMGnHN61ixudWte/z1t0+U/jp30jlHW+ty+TQ5Krwx3zNUawCvJ+f4I8Orl+q
         DIO59vnH9H6eexuo7Qi41lQmHHX1TFNNgZ7xfYxWbPsD2rlJ1pH5liMTZSSgsTjYXoAJ
         c/yRNu0RP75ANqBeoY7qe8R7UPLeBh8xRFvWwTqEgz6SM/QYrQ6c+hKMVB9UqnKJPp5/
         sSSl1laTPxfl8P6EGsbDQNsH3MDuOHbJrhgjt6OkVnq1vrnWfMJ9qyR7NUclH85mupKV
         +lIg==
X-Gm-Message-State: AOAM532WNVifzwrX3N1GkYlJ69ChOgAOT+gM3/VYXKpthFINdT4La5Q9
        ZoLiQcBf3BoJ/ohpqqoClewMI01Yk9qE+kU4
X-Google-Smtp-Source: ABdhPJx3g62mmoCZharDwWks2mvOlhT7OdG28aRRlZ9wCSL27LNKps3w44wRU/SPAObV5Cqn4ljM3Q==
X-Received: by 2002:a63:d90d:: with SMTP id r13mr621700pgg.129.1644870621248;
        Mon, 14 Feb 2022 12:30:21 -0800 (PST)
Received: from e29534637f20 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id g126sm389283pgc.31.2022.02.14.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:30:20 -0800 (PST)
Date:   Mon, 14 Feb 2022 20:30:10 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/203] 5.16.10-rc1 review
Message-ID: <20220214203010.GA7@e29534637f20>
References: <20220214092510.221474733@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214092510.221474733@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:24:04AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.10 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.10-rc1 tested.

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
