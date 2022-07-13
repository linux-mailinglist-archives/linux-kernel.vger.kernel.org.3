Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B14573F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGMWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiGMWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:21:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189E2A731
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:21:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s27so11662082pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YV0f0ZUDtXgh+rkwchB1S8BGOGkZ5Nr0lRYASzOI2Ks=;
        b=IfaAjz/raAjDmGQffenp0vzLhy5aBPVe8Fsd5AL1ha/m2a9WT6PJgZ6zDo8xlTc/jG
         CyULkDT4WsaQyMu5vO6hL5dbFuOtcvU0kMioDewAYwVillI6PIoELtiU3r5nmXFlbaMt
         Ybgx/Lwd1k/fvXlrW+bBh33+haXENK0ld3oo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YV0f0ZUDtXgh+rkwchB1S8BGOGkZ5Nr0lRYASzOI2Ks=;
        b=f20TloCQIn7kr6oLyOTTLDmimpMS2AUyZnUu8G2I47PvczfJHLO2bWiBMrjHXt2PuX
         jYf5dgySA+7bJ51heVVxW5RaKpfsUEiFqmKZQPmaw3Ry52ueKs4AsasYXKqjTQiG6D7Y
         RX3Cdt2uvxZvDX1rz1Qn7+eHFZbk5nLLIZTKkPlL29K20apayhbef6U34nfplQ0pFJ9y
         SKwySDJhGOdyplHKfDJWCoWNnXsgX/ZVPYSiGFHNL3yq8LsPcse48OL196MOhwBtKwml
         KSW9k/u/04cnW4lcMDGT6v5YAqx08kSvw7Moc30CrTMPtNVeqRHS66KvTM+CsIRfvBjJ
         Zb2Q==
X-Gm-Message-State: AJIora8DUWsBZmvpZe8kUFCEiZNzvjtQdrMszJaalSMM0Vb4tVddeHtQ
        dZ06XE/7ENQjmEKpDfzBe1cy3g==
X-Google-Smtp-Source: AGRyM1uZHDjlLGhMAFQPgi18UIkvCqAWdH/KVV0/q4oHFpAbuObSD/pvgMIczcVtzfevzHn7PdoKXA==
X-Received: by 2002:a63:1208:0:b0:411:9b47:f6cc with SMTP id h8-20020a631208000000b004119b47f6ccmr4639921pgl.79.1657750913984;
        Wed, 13 Jul 2022 15:21:53 -0700 (PDT)
Received: from a5decbf3d67e ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id 125-20020a620483000000b00528c4c770c5sm40783pfe.77.2022.07.13.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:21:53 -0700 (PDT)
Date:   Wed, 13 Jul 2022 22:21:45 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/61] 5.18.12-rc1 review
Message-ID: <20220713222145.GA8@a5decbf3d67e>
References: <20220712183236.931648980@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712183236.931648980@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:38:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.12 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Jul 2022 18:32:19 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.12-rc1 tested.

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
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
