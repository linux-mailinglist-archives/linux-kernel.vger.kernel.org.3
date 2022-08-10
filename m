Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0C58EA09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiHJJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHJJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:49:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DB61DAE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:49:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so1574077pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=L9x7qMrdSv/1wGcarUtleKFhAaRLeutGdrlwPnar7sc=;
        b=kFi3CyUKLvlytYERKFW0I2aDqRjirN1sZzeKUHmZnAax6a50F6ZMCZlY1NRr2iFsBO
         nTd4coKEOCNSfZU0U24AICfljEiGmXWNobm+7Eu0DPTzmgrBWUW30fpvFQieSOBQF/kz
         lPbV4RR9kpSHO1sMqwgCYV+B2vGvNr3ZWBMPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=L9x7qMrdSv/1wGcarUtleKFhAaRLeutGdrlwPnar7sc=;
        b=Fcrr2f1Jx4k5JprUS60BcYbxjAI58KIiftd7Z+YUu5qSbzgHnFZb3X51L7JRhGcp+2
         rsonqF1F3vPOe6IYiruzdqsel4CG/dIxnFouSUPzi+aNA6pVgwiNrYAksBwObVaZHgAk
         1HQfNrBDweP0D88CwUG1tsW/fPVnUu8SqX5v9PeE7Heg8OPBAHibJ9IXQx+vwroiGxh9
         dPwxEKsvkn+KJawYJ+iDvmtPRFTX8tQnbhrtOO6F1wbZr6bVGppcho9jhidfsVSLwSmd
         BX8Ij2xlzGz6pLwvy+glxwHw8vnqlfTqXdtHKjMvGNETKMt5qLOzRQgzyw/s+WUqcbKF
         oltg==
X-Gm-Message-State: ACgBeo2UM8WVsSEH9J4ZsXeN+uvuS9qdEUGiTifodSmEbFUSrymDRkt4
        fQDrxqsdUJ5HnrjloB1NFAS0SQ==
X-Google-Smtp-Source: AA6agR6wworkHximCc8qqj2fO9G9aj/eSYic7cFWhlJ+wSdHjgYZtAqDBMfJ8h9Ej8TDM0i8Yji7MA==
X-Received: by 2002:a17:902:c941:b0:16e:fe88:99e5 with SMTP id i1-20020a170902c94100b0016efe8899e5mr27788437pla.38.1660124965226;
        Wed, 10 Aug 2022 02:49:25 -0700 (PDT)
Received: from 0d2831aaf7e6 ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0016ed52b79besm12228483pll.271.2022.08.10.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:49:24 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:49:16 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 00/23] 5.10.136-rc1 review
Message-ID: <20220810094916.GA109@0d2831aaf7e6>
References: <20220809175512.853274191@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809175512.853274191@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:00:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.136 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Aug 2022 17:55:02 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.136-rc1 tested.

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
