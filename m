Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9995632F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiGALxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGALxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:53:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09E7C1AA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:53:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so6233659pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IXx8UMBs37XoCr/P34doCY5FYejV0CoORrXgAbU85YQ=;
        b=JFQ0s8zobdsMGnTI4K4O+OztMfyj1no/YtLtammtwj2DuYO7CqH2tknwvBhO64obSn
         Ef0HDvbyboVnJJOqM9ApksyD4tmiI88YP2ND2A6DDm7GZynad5O9RF36TUdsymib/q7Z
         zfGFmMU0MpjLqo9f3X0+mcl/6sW6/hWOTo4us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXx8UMBs37XoCr/P34doCY5FYejV0CoORrXgAbU85YQ=;
        b=Qyy13Fj6MJXKFPKmmbaNQL9Ut14R71Jgr6kUmkNG0eT6rCMh0Kun6lLvCmmPzYXq54
         eKj93AaDm4h6SFMwKLo6mHMyN1orszIflxIhcgtzvQiKgiX6j8ka0mIxmV0u9hTuwoxk
         bLsXw7rcqkELHiOsPKvndstrVg9A7ijj2UlDfTHIax/av7QJIoXeJUnAzth06mYydBDO
         txQ5RZwX/+hGgUYul4fSjTfQ70SLWT4sMBWXTZfbX3cFlgf1wyC4teISytstkW0GpYJ3
         RlYxSiU/kIYmxRHomXmwv6mTr7ueLK9VldfS4nuznrHgRyuuOWw4s4bYKbF8TQsQhMu2
         LguA==
X-Gm-Message-State: AJIora8xy3ePJRglGckx761lkKWasajROcvlPNHjXxpo/L5x6oIzeixc
        YWLzKqTPZDtXyPnm9PiYbbJe9A==
X-Google-Smtp-Source: AGRyM1vsDSInbm2Fvjq7cYDf0xMMom7pKw2+yFVZ8Cx2EsKFn9vyh/QyxEkn3kFHJxxRIkfNmJavMA==
X-Received: by 2002:a17:90b:4a0b:b0:1ed:4a56:d805 with SMTP id kk11-20020a17090b4a0b00b001ed4a56d805mr18346618pjb.246.1656676431516;
        Fri, 01 Jul 2022 04:53:51 -0700 (PDT)
Received: from 792b621d1c2d ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a7e8400b001ec98cc43e4sm6364383pjl.49.2022.07.01.04.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:53:50 -0700 (PDT)
Date:   Fri, 1 Jul 2022 11:53:43 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 0/6] 5.18.9-rc1 review
Message-ID: <20220701115343.GA9121@792b621d1c2d>
References: <20220630133230.239507521@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630133230.239507521@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:47:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.9 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.8-rc1 tested.

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
