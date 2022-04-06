Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAB4F6BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiDFU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiDFU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:58:34 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069201E1F7A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:23:50 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-de3ca1efbaso4007999fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qOkCi6aBiGDNuil90fvbIVbrL6IcSa0yO6vUS1wbz/o=;
        b=VvcRTcX33AP76PhS9QCw6Mael2tfF4uBCzsjh+y38urQRPERv4w9KEsumBh9f4CU1M
         bPgGCRHGJKNY1RK7/nptKusGkKEzkoPYl479YrIa9NFGTrgngrYKtOZ2CEBgc4isltuq
         NcJMNYJMwef0fNL9xMxurQBhjq6jNXx3/H9rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qOkCi6aBiGDNuil90fvbIVbrL6IcSa0yO6vUS1wbz/o=;
        b=CNg2F9OH23CXuE9r8rg+gPxYjFky196mX5/XA6XhrC/xgblSmQ8FojhrVWQFsFWzI6
         B4lvi94bjfYwdXt71fHpX6t3b01GEd/wYaY1v9OHb1dUh+j0M0hm0QkdOZCxNBmcfnIE
         f0L6TQY4UhAzeGJPNM4tjpqxWgof0929R8njhMY/X1nfkUG5tVgfeQBlYciDNGci0x9R
         HUiMgD0RkqsCa3QSUMGrPiIZ8OaS5+k9UM7wzU9iho1h+i2AjZMUJxl7G/GZLrzpLJEZ
         2G5GJmyOsBm39ggYYxAAi6NM2fEIfH8KPPLJguAEL9ejBSE3Xq80l29ak5diDL0gimei
         oogA==
X-Gm-Message-State: AOAM530wL7NttP6pDato70YW53CJYpY/W1/eLO/ipsvKcMVPw9YOW1IQ
        LgJiYS1ABofzxLMYAvfB96Qitg==
X-Google-Smtp-Source: ABdhPJw5BfDj5IK8VYap1qNQKmFI6A86mQcaAfwliVH0VvwnHIvoFTzA4hdTv1Oj4uLPTxFi3jfBYg==
X-Received: by 2002:a05:6870:a68b:b0:e1:fde6:ba38 with SMTP id i11-20020a056870a68b00b000e1fde6ba38mr4659332oam.71.1649273029333;
        Wed, 06 Apr 2022 12:23:49 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id r82-20020aca5d55000000b002ecaaa13cafsm6755430oib.8.2022.04.06.12.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:23:48 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 6 Apr 2022 14:23:47 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 0000/1123] 5.17.2-rc2 review
Message-ID: <Yk3owzoZWLqdqqs/@fedora64.linuxtx.org>
References: <20220406133122.897434068@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406133122.897434068@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:44:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.2 release.
> There are 1123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Apr 2022 13:27:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
