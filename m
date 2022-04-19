Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51E5060B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiDSALC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiDSAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:59 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B4140B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:08:03 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 79so7782177iou.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7tF3c6TuAx2/gqKC2eSazVibSz9h+i31K2V91yIVOmA=;
        b=fZlC3O4715i80XRaOmWBwU3+x4X86p4smdf/gHbChB8zH9gi0UOXVhriGODXSYRrNy
         An6/mUOEEeUGymlWSiKIaaKetmXGTL+ZoEVph6wiknRmM48uyJIgSqN8ELf6JcSbRj15
         tw8AApGeHduo7bjMQsbnr+7Z86oZnEPE6hMAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tF3c6TuAx2/gqKC2eSazVibSz9h+i31K2V91yIVOmA=;
        b=XfCzlU8sIxJzHhxhqJLIL07HTmASzKVS9/bjRruNjwQeJN9g+KEWGpGoro5Gdj7fNO
         iekOCxd7dBM0Rkrh7qlHZ3AKyM1P0EevNTCFhgGF0hhD/9uFhhGEL67VmxTG17dg7ZdL
         8mx2T+gqPfYdGBhMzjZUhtXTQvGFIZlTxOofAgJV4vQct4251aWIXDQbsItux9GtbpFg
         /MooYcdCphF0/0BTQYg7ECE8I+io81UpM4pXkw4jIYiFajemlzR9UwXKRUR3Vbqbh464
         6kuFIO5jXSmuEMV/tZIPh9RN9zKTrINyS2gKz8ftW/4L46uMHzLrQfMeTn4q8yDBW0tK
         u5rw==
X-Gm-Message-State: AOAM532rrseYI6KmClT5fwfTSKDfzDNCQwksysXW3Ffdu011O6ppqMiX
        FgyEGF+gwfv1jWIy8HOIffnohA==
X-Google-Smtp-Source: ABdhPJwyLrEjl7dyWyFuPqzKlT6IcLHzzzasodqPCu2EXiRCwSUmvu2eEG3Rvy/FduzgNANfMTozmA==
X-Received: by 2002:a02:c50b:0:b0:32a:6fd4:65d1 with SMTP id s11-20020a02c50b000000b0032a6fd465d1mr523482jam.88.1650326882950;
        Mon, 18 Apr 2022 17:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c9-20020a92d3c9000000b002ca966b8961sm8005000ilh.26.2022.04.18.17.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:08:02 -0700 (PDT)
Subject: Re: [PATCH 5.17 000/219] 5.17.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220418121203.462784814@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <74014b97-0b5c-1a77-39ac-df097407fe65@linuxfoundation.org>
Date:   Mon, 18 Apr 2022 18:08:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220418121203.462784814@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 6:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.4 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Apr 2022 12:11:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
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

