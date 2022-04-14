Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E65019B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiDNRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiDNRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:12:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1510C2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:03:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p135so6061517iod.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OllXB12xYj2oLW47j16BPRteV5aGbcg+P8qWGLzVFgo=;
        b=Sg9Oj6fVMqHx4wGYatrCXwfVrgDCBdgSBuV8CJJEMxfZS8ADhOx0+9774BF3P5+0AX
         Y8VCnYXOJcbJNV3sIzmP2ZmeMkENdnB0B/S5DbU4fN1Jddewi35fOaiZ/4Vmp721Wefb
         kPLzUcZIjf8pTCrst7E2EVKghHegWxZZQOxOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OllXB12xYj2oLW47j16BPRteV5aGbcg+P8qWGLzVFgo=;
        b=i6YbEoyxhhAAwlKteFibFyxJtdPjq2hh78lDj41OBaq0H9BMfD4AP/SZZkDq0amqgT
         kS+DF+yoVMVnzPSiPfCRZN1WvD/yxvMvL3slmWWF3n8Ezx3zcPxDFyFoXRXo+Ubi84mh
         IpINLjx4pKloi685g4koV6E0Xjpgzjib5/vrhkg0uxOJAX5zOSBzT60T8el6i9SOcRgw
         DcS0L3IorCJUEhWLdzSaGykHtlHPXv6W/JOw81SDfmOy27uc7Beh+a1576ZriP1Zhl8W
         4f0LvlVEr48je2/hpOI1xp3G/xlFVkWQMDtnk1FF90BRBXUonyMfyHtQV4kb+kQ8RAID
         SUWQ==
X-Gm-Message-State: AOAM533pzkZCywHRV2VyxqtLefBIq/F+dxuxzbSsBKe2tqjoc6a8bEpE
        81v77lb5Lz+2ZP7CrNswlArT0w==
X-Google-Smtp-Source: ABdhPJwOfVPfya7xmiCQCpcRTJlx+/Ql+vs159c3+lqXwm1y2ZbNR8soXx4bWU1pNLUROi+wtJweeg==
X-Received: by 2002:a05:6602:c3:b0:64f:d28f:a62c with SMTP id z3-20020a05660200c300b0064fd28fa62cmr926382ioe.212.1649955796950;
        Thu, 14 Apr 2022 10:03:16 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm1445108ioh.52.2022.04.14.10.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 10:03:16 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/338] 4.19.238-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fe30f230-f642-ded3-7ca3-f70dffcdd8b9@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 11:03:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 7:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.238 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Apr 2022 11:07:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.238-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
