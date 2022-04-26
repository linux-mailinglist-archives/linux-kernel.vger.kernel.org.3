Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D3510A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbiDZUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355005AbiDZUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF1252B9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:16:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e15so3768088iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jpknuK994R7nwl2/EFObemUAi9JpZ9Lj+Bv8LrmsWxw=;
        b=H1/Zfzjzn+y9aOIt5lHNHgc34RZnZFUa03JhkNRVoxKH5QzpTRTGPAfIgifmCAETbe
         2hS4uWDZGkd9TnMLHdBbw3BkRIlolBSZp6VVck9RkgolEdAlWE2A7Tt6p0z5aDeNQ11U
         WMJnnPFUztt2pO3k87KJEeD/K4/Abtc8M2gIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpknuK994R7nwl2/EFObemUAi9JpZ9Lj+Bv8LrmsWxw=;
        b=w2WYoSOVvn6kEesHDIDm0F8ipFqILD3CzdVbaREjiHRb8scSfF+TswgDhmEYneEHmH
         Bwhl4OIUqw46w+9NSyFczmet8dVeOMshvERbB/U3Zi3+3EOL19fWAqd3APgHR/6VctaG
         7hF4cOOhpdSxOSlxWfYY/WZzbJERpNZjB9vTFpE4pD2I7I5r6BPOwwp0m5A3QoSJ6Dgs
         mEspiLJroS1E3dZ6Bv/S3d2ukTLTK9P2Z2syO351JjIOmankogIQJFIi4mr8sEVrDKeR
         GynVi7JEb31gjyWdXk9jqTXf5PGl+TgD1pII8rvd1vwVTQOxtE8ogLWFySptR6OH5pDt
         LaVA==
X-Gm-Message-State: AOAM532/MhOc8NBxp3ukzAt5JVSD2XqPpiMF8wtJP9t5EOclmm9Qk0d2
        dt0BU/4D7Sof6TCCO+R+UQrmdQ==
X-Google-Smtp-Source: ABdhPJw0nLjlx3L7g0DAnYC3MxBFITvVoD0ycUy0ok8LYbBbw7M9Te9BEDVat9X0kC1CrtZPCPvY/w==
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id q10-20020a0566380d0a00b0032873fbb1d1mr10330130jaj.132.1651004176076;
        Tue, 26 Apr 2022 13:16:16 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bd315000000b006573987c4fcsm10127375iob.3.2022.04.26.13.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:16:15 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/24] 4.9.312-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220426081731.370823950@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2f66650a-8cc9-4082-4ea7-160cd66c5b7b@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 14:16:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220426081731.370823950@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 2:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.312 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Apr 2022 08:17:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.312-rc1.gz
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
