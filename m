Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9E4F52BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 05:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1851038AbiDFDCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841121AbiDFBRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:17:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74648193C2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:10:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k25so1000019iok.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+Ivtg5pKoltKvJ46d3+6yYAIRcj64rTYJYvVX/xCjE=;
        b=VBTLYQiwwEWtJaKWyH8SrAw2gJR2T2uiY2GBIbaJi75SCHq7sUutGpEG+98gPaUa6R
         GXCVPsZXMsk6uOFgh3wAmU2vqsZ3ETCsQ+j3eixiln3NLdTMkf2gHX/qvazYCtTxCCEt
         FKT3BwRXTImn6DFqire06gKsB9LPklQ0lSdkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+Ivtg5pKoltKvJ46d3+6yYAIRcj64rTYJYvVX/xCjE=;
        b=uTDAjjt+KI99y6hWEgHyL1leal9yS7IaM4Pm7nU8rBNvHN4rvApd8XycyMNRp6+wlP
         y8koJ24asngAdi2xwG3OhJWK1nG8vvedKKZoX8Ad5JL9Jdq4QctaSMAZOT9i7GiquA1V
         ueDgEJ/rSzRZQR98W/GZDBES8CzinL11zGK3TT7KnWTG5y4tb2kqDlHU6wXTTu8AVIF4
         0OCu1jNR/kvYSlC5Bki5ZwvaIZIbUIX2ZVND2u+9ZcuT8fDkGT/1WOBUfXIkuGwI+f/5
         D6ZFm+IMjJwgUMVAjMhfYBxJsIF8Y7NNy+lFJdlqtSL/y6VscMBIhwhgw/rMvlGA0e48
         3OYg==
X-Gm-Message-State: AOAM532sWOQdyTjYJJohnZyZjjFCxG1cL/J9qbeZHDmyZdHYyQkONLsW
        yxFbL8RpOsMr22yEB/lc/txWCQ==
X-Google-Smtp-Source: ABdhPJzXe7Inoe5P30IZe++e3ZdQhUIC0BQKbn5qFsf+P5D0pL3zrierzfYF7+JpL3Owz0WPwKJpJQ==
X-Received: by 2002:a5e:a717:0:b0:649:6328:792b with SMTP id b23-20020a5ea717000000b006496328792bmr2801638iod.54.1649200222863;
        Tue, 05 Apr 2022 16:10:22 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l10-20020a056e02066a00b002ca405211c7sm4252491ilt.12.2022.04.05.16.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 16:10:22 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/599] 5.10.110-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <09201c80-bc6e-36ad-a4dc-82f54486b434@linuxfoundation.org>
Date:   Tue, 5 Apr 2022 17:10:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 1:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.110 release.
> There are 599 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Apr 2022 07:01:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Build failed on my system. The following is the problem commit. There
are no changes to the config between 5.15.32 and this build.

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
     ASoC: SOF: Intel: hda: Remove link assignment limitation

sound/soc/sof/intel/hda-dai.c: In function ‘hda_link_stream_assign’:
sound/soc/sof/intel/hda-dai.c:82:24: error: implicit declaration of function ‘get_chip_info’; did you mean ‘get_group_info’? [-Werror=implicit-function-declaration]
    82 |                 chip = get_chip_info(sdev->pdata);
       |                        ^~~~~~~~~~~~~
       |                        get_group_info
sound/soc/sof/intel/hda-dai.c:82:22: warning: assignment to ‘const struct sof_intel_dsp_desc *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
    82 |                 chip = get_chip_info(sdev->pdata);
       |                      ^
sound/soc/sof/intel/hda-dai.c:90:35: error: ‘const struct sof_intel_dsp_desc’ has no member named ‘quirks’
    90 |                         if (!(chip->quirks & SOF_INTEL_PROCEN_FMT_QUIRK)) {
       |                                   ^~
sound/soc/sof/intel/hda-dai.c:90:46: error: ‘SOF_INTEL_PROCEN_FMT_QUIRK’ undeclared (first use in this function)
    90 |                         if (!(chip->quirks & SOF_INTEL_PROCEN_FMT_QUIRK)) {
       |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/sof/intel/hda-dai.c:90:46: note: each undeclared identifier is reported only once for each function it appears in
cc1: some warnings being treated as errors

thanks,
-- Shuah
