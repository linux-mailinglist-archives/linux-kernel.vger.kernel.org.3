Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E035531EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiEWW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiEWW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:58:21 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C0A0D24
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:58:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9so6307694ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l2oUkDKKrFkxRSKFbyyBVkdQ+dOB2nN/d1gZJ7qd9Oo=;
        b=SjNo8ofkC8RA/3BXAcKDpPgbV95oNBHJWvQ48H0cErymYsvjfj7L/69SPXgxi+Zu/F
         BvelEeFKDBzNGGT4ayM/TR727PohY4Xju4CKP1Nf30VLWGPEev6XF2h2XoPigFRhcuSH
         sIUAZQr9XeM9s05NFEKtxl7z8z23DmCAzx+Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l2oUkDKKrFkxRSKFbyyBVkdQ+dOB2nN/d1gZJ7qd9Oo=;
        b=V1x1lGH40PGn5VGsGQtG41bjmMaMzxRTa48DsWvvwCVCnc4isaC2fW+i15zAq1J7bO
         XzR4XESfBWBeejJHng/+qeMX0vdUZC6WJy8K7VJExu88EsHC5+PG1Ebiiv32edV00fhO
         6lWdNrjUIW2pCQoi4NvQOlZfRMHBiajJ6lrTdaDArHnxqWMV45wGbgOym3sHTjNFItCJ
         bT0ndaSZjIIEzMLw/woEWKdxkPlEra4NA79cDbEKa1dLqN6EzRdusFePd/JSAbZWQ1Jd
         sswI4uMGoGBvCsY/B7GAQuyYx3CtMn7gNmbRgPqdguh1pI607qmNRiqlHa+NDdDFTePj
         b8WA==
X-Gm-Message-State: AOAM531TZcHaNNTci9si+K7iX6JClGu50v+LLh1ll3VU4WTUX+lkYCen
        w0sNVdiIaVhuJL1g7G+39A6Vrg==
X-Google-Smtp-Source: ABdhPJyknf6T1snNCawhtk0tV27+m8r/B7IOJ5FeFwKhN2Q+AORKEYM020L7Q7yfBmMD6EZx9aBicQ==
X-Received: by 2002:a05:6e02:188c:b0:2d1:b91e:69b6 with SMTP id o12-20020a056e02188c00b002d1b91e69b6mr2075090ilu.118.1653346698745;
        Mon, 23 May 2022 15:58:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a927602000000b002d1be61eff1sm309506ilc.75.2022.05.23.15.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 15:58:18 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/25] 4.9.316-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523165743.398280407@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <96ef232b-5e06-2189-0762-47150f0569b9@linuxfoundation.org>
Date:   Mon, 23 May 2022 16:58:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220523165743.398280407@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 11:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.316 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.316-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


