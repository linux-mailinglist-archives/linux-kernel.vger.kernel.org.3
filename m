Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A8522717
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiEJWqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiEJWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:46:18 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED19C2EE
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:46:16 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id f6-20020a4ace86000000b0035f083d2216so329323oos.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6kRzyDljcmaAdLXR+UhbgSyuPcRA97V1sG9nQjd/jWY=;
        b=d5OxNZWqXM3Xcei7VuFEYNHD80E1TPyE1loC5BTq8mv3LXlwiQ9os2zBpc6Al2uRjJ
         auVlCjDN1ymoH4wUhZ1+/IzEcdo5U+AgKALR065BUA4qI+VOR+neAqzQ4KMbG10YPwG2
         qa2W974X8mwqUQHllEckQhsFRLwno6F2HTH/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6kRzyDljcmaAdLXR+UhbgSyuPcRA97V1sG9nQjd/jWY=;
        b=uAdoj1qznIZ/z+gaHaMcXdeRmWO/4BC8uxPb1LK1FAgjdtfIbB9oIXvDYhX70UkSDk
         iWVJirBwk/mbO/nmEp8WTER8hcNg2EClROA4Nf80WUXeg/foi731zTwCeog/0fycQyVH
         bTHDnz3VjHdinEVsJSbIwaC7L2uTT0tdc1e9NDsrfUTHepEPSlmwA3ptGwqt4GgIcU8L
         OK8xAZ68wwLwiTpWqGvCWKBJsHtBHnsGm99Jne/WeAFjyenovuAgU+9v5JOre+T66x+W
         hl2mdZ4VvskuPBq7oWntb5H1s3RC2bgDbKOWCP0pa8riIDCg/QslsBfnPPtVE4gphXO1
         +q+w==
X-Gm-Message-State: AOAM533snn8DG1r9mjOfl8H48UH/5ATaNEfBrhf6akPPzbhqvDQVGrNH
        1GlMLV1FjPmY8nJXmCdHFL2Kwg==
X-Google-Smtp-Source: ABdhPJwFVsBkahLsEL3+icVodIbph+1G+z90o+JYhu/o1HrDlPjGVZjlb9u7I1quTAmpOlAl9rpCwg==
X-Received: by 2002:a05:6830:1dcc:b0:606:9d0:c0c4 with SMTP id a12-20020a0568301dcc00b0060609d0c0c4mr8667526otj.164.1652222776003;
        Tue, 10 May 2022 15:46:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u18-20020a056870701200b000e686d13875sm115930oae.15.2022.05.10.15.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:46:15 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/88] 4.19.242-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510130733.735278074@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1c7081ba-7c3b-58d0-c68d-ffc273a1f5f0@linuxfoundation.org>
Date:   Tue, 10 May 2022 16:46:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510130733.735278074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 7:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.242 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 May 2022 13:07:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.242-rc1.gz
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
