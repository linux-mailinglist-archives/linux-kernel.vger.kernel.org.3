Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE354BF771
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiBVLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiBVLqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:46:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309913D906
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:45:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z4so16775750pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xom4nC8pW1AcFzySdJHXdQiMs2JCuJfm0CowvEiJlNg=;
        b=UGQ2VRGOn90iAqIS+431vunzUtIrFIaXxEs3pFCQGXMRj1v+/RrxMV1gwODvaoUwBE
         Kn3DgZ3hQv3/PdmWUwm5/o6V+7priyaG5vmcSo1DFcr853Inc7OqICzv+UQdWkUVh/Kz
         5rci6+LQb6Zfi4jKPxYbpyk7RQDURlxD7cN6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xom4nC8pW1AcFzySdJHXdQiMs2JCuJfm0CowvEiJlNg=;
        b=pKMAp2eV3H4w1RGBwB2PyMCDRTJJ0slOANSn1h+lEgkW2+k1tjb4oqcxLELnIQH3Ip
         tr1VOQ6H2sNBBUbJGByLFEO/+RMPygU+v1QDi60hBfgARnnigH21+0DByTH2dEVoqkZE
         gHXe3Tb1L6qfgacum95SRL3xaNFC+KNraCzWAOkXJ8PEklBItLbTVWCBo+e0+OxFp5oV
         5xASTBf3qOn3xY5D4ZNiQIyc21hKQqvG9jcmiS3C+0/wt2qtF5h8qHOh7hd9ItcYnCNv
         Nh0V3ev++B61o8qXsDg7pRMePb7bSfyPvap3cw7II+r/7TviDLAzkjPClN4Yjq++6TBt
         eDOA==
X-Gm-Message-State: AOAM530cuwrh48nN+qqE2rYtIKh4/mOsdwYmayKg9B9PmLxRB9BbmboP
        j3ldp0kQXYxsGVSalFO2DzjBNA==
X-Google-Smtp-Source: ABdhPJxEmqwscdjRuK80gk8z2oss5gUS/AigcjXn78Wi+8h4nCrhNArljQFu3ZlP+ckFHrPsdMyt4w==
X-Received: by 2002:a63:2142:0:b0:35d:a95f:d1e9 with SMTP id s2-20020a632142000000b0035da95fd1e9mr19283903pgm.237.1645530354956;
        Tue, 22 Feb 2022 03:45:54 -0800 (PST)
Received: from 7956e3143303 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id t3sm17534132pfg.28.2022.02.22.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:45:54 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:45:45 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/227] 5.16.11-rc1 review
Message-ID: <20220222114545.GA690805@7956e3143303>
References: <20220221084934.836145070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:46:59AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.11 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Feb 2022 08:48:58 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.16.11-rc1 tested.

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
