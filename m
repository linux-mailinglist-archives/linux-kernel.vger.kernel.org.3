Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2E587B99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiHBL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHBL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:28:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A5313AD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:28:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t22so5447181pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=H7FLv+g+HrT2ruIOMeV4n5xPG1bX6rGXZvtrf3Y8n08=;
        b=Ud3dUUP9vNnB36t2HkbOVN0YSBsQwdk/4ZDmdhGHgWYSrUx37RcmrOAG0g8AZixVrH
         yMNODhYKywy819T5/opovgrSPbWVSrfPHg515gHHkVee8ptEfoW8228SfJ37eFyOCizv
         3wVip79nEatmhbGVsSUkh1buB3VLzeHccVg7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=H7FLv+g+HrT2ruIOMeV4n5xPG1bX6rGXZvtrf3Y8n08=;
        b=LmZVDkjoaZLLvauHtjYTLrlR8YHF2w7lMbk29xKN8qmHHJYU6a0qSPIAnbURWes1up
         PZd/pdAoo78x19fgRL6fi7K+NntDocePrGD7X4ViMFqNmU/z96dl2y3mx3+bUGkjZYYj
         74luEW67OzG5z3an29lc8f2UoxT7VeD21rEbuO5TnkibcwDK7RfQiuG+9VuNltNDrPK7
         fy4npc/IKOykxpkqJxXyyp5f5T2kNFB0uGeyaz86tOGkf1PpGPXy407WZ64Zsha4WhCk
         g2JWGY7rWJXelnVuxc8J85rWfcJXH4CwKnUicW87eBFCpAtE5Hl8KmtTsYra3xD2HNI0
         XIuQ==
X-Gm-Message-State: ACgBeo3oQ1JNhGA8Jy0zFNq/oK+XrDkVK1Y50R1p11ffArEc1Sav50xa
        wZmbuWr7VtQqVj9ex6G6Isj+V0S6PEQ+tM5s
X-Google-Smtp-Source: AA6agR4ihKSOfbQu2gENpRSO/07pyOkcoT3oYLHdxCfOdFGe0y8TB1AsbYtqMTko7eh1k4X5Qxe/NA==
X-Received: by 2002:a17:902:ab14:b0:16d:c234:2bb9 with SMTP id ik20-20020a170902ab1400b0016dc2342bb9mr20565143plb.83.1659439694733;
        Tue, 02 Aug 2022 04:28:14 -0700 (PDT)
Received: from 45f01dcb456f ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id o70-20020a17090a0a4c00b001e29ddf9f4fsm10702932pjo.3.2022.08.02.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:28:14 -0700 (PDT)
Date:   Tue, 2 Aug 2022 11:28:06 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 00/65] 5.10.135-rc1 review
Message-ID: <20220802112806.GA8@45f01dcb456f>
References: <20220801114133.641770326@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114133.641770326@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:46:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.135 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Aug 2022 11:41:16 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.135-rc1 tested.

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
