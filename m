Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BD4F6E09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiDFWvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiDFWv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:51:29 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954A61FF230
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:49:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t4so2975273ilo.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaqNeZNR0Tv1iGHnD+rY2qbsI2k+OeA8Cb+KHc1e+F4=;
        b=SpI+vueUtuafS+TGo1aswjBExIS8Zq9LQ65vUBfUcweFBD6tJlBKPNangKSNcOOLHj
         T86RQaSD+2W3pocqXtil86It7NZdRVvuGX6ESX7iS3GDx7R/HT6ZZeXRb0AcX7sxm7K7
         aKGdHu1e4ONxeVg7msCxVT10FF3xV/paqvYNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaqNeZNR0Tv1iGHnD+rY2qbsI2k+OeA8Cb+KHc1e+F4=;
        b=j8fesPshmfHH/kHKevxDPwRg9JBtBcngL55qzJqjs8B+uMWQWnShlRZW2WsMQw2rdc
         LBta1/BIIwhrQf53KYt4orOgZU81Zo6VkduZQngTG0h5xdGEgQ9haPZkpjMGRdTfogfp
         gXo3eK+vfF4ZtkFhsGPAB8m3wjPAkjmxBdODTiv6+C0Wzliu6kSLNU1S5NoD+itbRntk
         bEcl0tG3f9B2E4+wjDAOl5XZJduN0LiuJI50gqx65kaZ3dso0mln2TI6bkPFu/CJY7sJ
         LnKQBp+XdrpzsOPqX08uBmRZBjCyB3R5/8aTQZFa5wdKHqMp3ZY3lCzlR2Y9PlE9TGVP
         i7lA==
X-Gm-Message-State: AOAM533ynMir8eg7tytHo3sN9bJtH4eiStebj69clSax5gOxC1Ape3Y4
        99ExiFxB6hkqU+P7wxG3z4P+kA==
X-Google-Smtp-Source: ABdhPJxri6CIo7JXEr+MXsnC4CDVRt+besauhw4IfnvccN6HCidQUHLRzM+6SRuKD2Glb8njKqVUAw==
X-Received: by 2002:a05:6e02:1b8f:b0:2ca:9c6:434a with SMTP id h15-20020a056e021b8f00b002ca09c6434amr5561481ili.303.1649285371011;
        Wed, 06 Apr 2022 15:49:31 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w17-20020a92d2d1000000b002ca3e5fa428sm6342817ilg.51.2022.04.06.15.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 15:49:30 -0700 (PDT)
Subject: Re: [PATCH 5.16 0000/1014] 5.16.19-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220406133109.570377390@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <658296a1-7377-816d-8acf-f5d535931dfc@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 16:49:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220406133109.570377390@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 7:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.19 release.
> There are 1014 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Apr 2022 13:27:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.19-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
