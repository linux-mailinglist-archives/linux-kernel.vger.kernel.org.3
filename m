Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97216571072
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiGLCq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiGLCq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:46:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F1C88F08
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:46:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d4so2865713ilc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2zqwrilwWJFn1MWS5NC3zRRQytleqfbDvTL79CoEkU=;
        b=XOoynbLzAi8cKMnaqQs/QtLT2Y0dn13yeuv+LcJK7jUeLYM62Ik9+RnVY6f/zJxKgr
         Nr3mH1WSr3KFn6YUY5Azw0jBxqRxuOd/xqFSQltBorldtYERB4L8f32keSxNA7d9hZV4
         lsuohj/fb9WLlpNEzho+09tMcvBVIsijOaaJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2zqwrilwWJFn1MWS5NC3zRRQytleqfbDvTL79CoEkU=;
        b=TcWqJvHeSpSs1w+rjvmonibB9dNVEmYR2OoUWAdpEcTEzOH+AI3QnctZ/zIKrdLX2P
         HH22XhNQpzMAILoIvJKcxfz2rd2HrKnYC1ndM5oWikM4Zi8w4oW7nJl8C+5uru4tInme
         NfzLHCfYYI55P9Q2RKatmWXNP5ggcEWPuSk1vE7qOcPonwNSQsAp7oAz1DL20B3YuDX5
         K6P+znC0lvwXQRo9OBb2kxkfsQ9iLBVKqYLcebB9lAFJLRa/9QiF3XY2thRvglon5Yo1
         UdQa492l9ogF6d7VKZWj0P+wHvQ9BPx9Z4IMFBRBasEag3hNkTPTzxvb/S/UA9faM0O3
         sRHQ==
X-Gm-Message-State: AJIora8BfNDbf2FMr89NuYm2rqWeOf65Yube4lhl9QqvGKc9pJrP//wg
        dLqRRZ60+ZH5Hk6BoHDbuTNtBA==
X-Google-Smtp-Source: AGRyM1uZNnkjwp3gD5E60dyah5H3ZffEInP/mP8aQ29pg3Nnn7qB/enz6kjunR2PDKn786LAijZaLg==
X-Received: by 2002:a05:6e02:12e9:b0:2dc:4e72:120a with SMTP id l9-20020a056e0212e900b002dc4e72120amr11335770iln.14.1657593985235;
        Mon, 11 Jul 2022 19:46:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g38-20020a028529000000b0033f1e23ab20sm3604724jai.125.2022.07.11.19.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 19:46:24 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/14] 4.9.323-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220711090535.517697227@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <370bef86-9c35-d2e2-bd40-13b7546ed7e5@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 20:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220711090535.517697227@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 3:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.323 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jul 2022 09:05:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.323-rc1.gz
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
