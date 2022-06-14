Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A654AF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiFNLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiFNLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:47:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B425D7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:47:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w21so8404633pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yjCf6oY3gJS5YNfh+t2xkU3PyOSCOkeJrjT3Jr85cM=;
        b=CsOKP9DatAjY5ULn1fGBTaFBmXY9q1bDyoUJkLdt8pcLNG+jg8zcWSdECEqagQgv9f
         9NUv02jJYfl30AI+RjDo+TVdnSTbeN6eyjchgdnP2U4r+epXoaE049dEaQBjBMNEaT9k
         VSWjg0OznvQcuuCo6Uk/o/3VT9XnbQjHbmVEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yjCf6oY3gJS5YNfh+t2xkU3PyOSCOkeJrjT3Jr85cM=;
        b=heqDYmxcr9dWU7jEvhv8x03F18ybm+1pAxo/7XSWuzjghjKl/auv92Mt0lIxRiAUyV
         ASr6rl/4KdV1DQJlcdTy+g2bzP/9MNE5L8V3UhxSzIsPfoXOqGK1Q63VrMnAOFDfwEus
         SPF0JJrEbl+WMKQvUTpyDCYpzHGxHiJmJyxipusfh6GlNs/EFfBgzaz8RKCoa4L4hcvW
         3Hdht5mAEVw71Li2AyT3fwVGL1v4X5qkRli+XzHBpI1ir5m+X+HpK0Bx2aQvvWFGH5ZD
         uckSppeVUteDOH7Pbc4IfsxeQYVzS9v14kCfihLornz1Cv3vYLloNX9fTAIk10ljACua
         mRpQ==
X-Gm-Message-State: AOAM532nQlUZQdezOepDSmYgVEtq8idOuZGfvPPzFp7OP393D1YgFQke
        YvXLCF02qbhHDuzDzLdpkxulcQ==
X-Google-Smtp-Source: ABdhPJyS2jpnvZtL2c84oCGG7GjdOJvENERd3a1AmtOYUUk7rt0xRQr3M6SYy0NcwUttJzfbYRg4RQ==
X-Received: by 2002:a63:864a:0:b0:3fd:97a1:79f with SMTP id x71-20020a63864a000000b003fd97a1079fmr4237636pgd.51.1655207244652;
        Tue, 14 Jun 2022 04:47:24 -0700 (PDT)
Received: from 4207e2866154 (194-193-162-175.tpgi.com.au. [194.193.162.175])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902bb8500b0015e8d4eb2d8sm6992433pls.290.2022.06.14.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:47:24 -0700 (PDT)
Date:   Tue, 14 Jun 2022 11:47:15 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 000/343] 5.18.4-rc2 review
Message-ID: <20220614114715.GA31790@4207e2866154>
References: <20220613181233.078148768@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613181233.078148768@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:18:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.4 release.
> There are 343 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Jun 2022 18:11:39 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.4-rc2 tested.

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
