Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E54F55FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380049AbiDFFwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361378AbiDFE3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 00:29:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E626AEC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:35:39 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id b188so821082oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 17:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWFuKJuXH3JpCWyGBa6xx2LmvwEnKcbXduTsw7Z7YIU=;
        b=MoK0YPGtjdXPrEZkSIakvUvOkhjS8gFgVHjaXfyedLGWqCMMWcU91qZsRHV/h9d791
         sx/VPcDjdNXlb6E2kw+w0SchCneFkGqcrRzFje8O3lmg5zK/Du2gF4ky2iPmmUSThLAL
         lM4rEnMOotds5JL+QC1zcz5Y0IOYwjHBDMN1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mWFuKJuXH3JpCWyGBa6xx2LmvwEnKcbXduTsw7Z7YIU=;
        b=Wcs7uxG9Qef67bfc4IqT8lbW+FJTIHJs5k7Waml5XUVqS3ZaH5rEC3Yf5B6HlsTxom
         oBFVYEKIUvWazmFcn3GXe95X6CbUQGTD7Vt9HleMUCfqHMszuHw5Hl1GROUsJ3x6DhRu
         ZcnPbu6/TaCOl4mkoN875MET3zEiTCpZ7HqfjPFzz9Lc09mWW70XphmFWbxUeuph+uuv
         PP/Ip400zrORP9kOQahsLdounFki62UQDzOPhRUS8Sok5sloHR7X9tPdR6YxWlGnorad
         jkqqwTPDnGlpoZthUdBCjmj7uEn8b1j4Jtn1wIXq/8ZoJBG5rZebyx72WFoNhBq6Mq8z
         4NOQ==
X-Gm-Message-State: AOAM532anWS4lQor6oKfhNKdD65F9bWKqddgKJT2RTIhcIQ8fe7dpbqh
        uc9ny+acZoVSe33HXx5sCT9gxw==
X-Google-Smtp-Source: ABdhPJwliHIC9NE7w1F7CKSJlSP+1lFiaaLewtPfqwixit7GxL6/WB3UnFvvPC9MtZEUbujO4o8ANQ==
X-Received: by 2002:aca:61c1:0:b0:2ec:d091:ff53 with SMTP id v184-20020aca61c1000000b002ecd091ff53mr2617124oib.235.1649205339029;
        Tue, 05 Apr 2022 17:35:39 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id r19-20020a056830121300b005cdb11a7b85sm6385572otp.29.2022.04.05.17.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:35:38 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 5 Apr 2022 19:35:36 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 0000/1126] 5.17.2-rc1 review
Message-ID: <YkzgWEyDZXFrCbju@fedora64.linuxtx.org>
References: <20220405070407.513532867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

This fails to build on x86_64, but builds on all other architectures for
Fedora using the fedora configs. Specifically 
[PATCH 5.17 0943/1126] ASoC: Intel: sof_es8336: use NHLT information to set dmic and SSP
is missing a dependent patch, upstream commit 679aa83a0fb70dcbf9e97cbdfd573e6fc8bf9b1a
ASoC: soc-acpi: add information on I2S/TDM link mask.  Applying this
patch makes x86_64 build again.

Justin

