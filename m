Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27881526BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384489AbiEMUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384511AbiEMUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:40:17 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E891CA064
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:40:15 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h11so6534181ila.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9U7IF8Ez4ASLcDALNaHak7TxdaN1NI8C+9qbNu0DnNM=;
        b=YlzOC48GR6+LtROD4c4bDPZe7MYai+hGz7jzQFiL9WaO0y383azJF7ODat6mPW/WhF
         O3hIScsIJzXuLDZorFkqvM7SqPH53JSgTMIju1bJmewpvsNvoVUjDCwLC4Pvp134gJG3
         npZVs7HwmXvtuylfpeokS5Nek3x1/dhDc5uqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9U7IF8Ez4ASLcDALNaHak7TxdaN1NI8C+9qbNu0DnNM=;
        b=yos/uu7blDqiljUhwrE5V63GfNg9hCohwzSTtMkx9IIEOWf00xJ/2GTxPCEYsBAeg+
         TSp29rHwNcWTZH8DZj4RSUqY3gQaEVTvYvs4sLnHsN0Rx1T+WxZwqG3zuk2LcV4dV9pE
         MWQZJaobnMnIcDsP0yRnK1RPAo5bgUfMNV6S8gdhue7IGjlUgw8dVCu+RLMh+RA9dwIi
         n75eEZSoq8VOzjGhXu2qfbdS04IMAydKEKaSr9KiPm1WfwkCYJrLwYkpWerif2c90ze6
         uQBIPcQxsriuPedPVQSx7JG1LWpDPUKi31gpf45cvuTJ+49idUa9kwHqbEB/rWlZ3tJS
         TY+w==
X-Gm-Message-State: AOAM5323fGsgyynofsdxMg3SXx99ld9JXj6UErRGZ+sWns5mxBi02nhY
        t1OxFjANZapAJOLzL3csxgPJ1Q==
X-Google-Smtp-Source: ABdhPJzJCjcz01/584Kt6YerjlbCaS2rGcazr61z5HY+9DRctgu0OieSt8xQKeALDg04mAS5+lJepA==
X-Received: by 2002:a05:6e02:1d0a:b0:2cd:fdde:a28e with SMTP id i10-20020a056e021d0a00b002cdfddea28emr3536871ila.228.1652474415000;
        Fri, 13 May 2022 13:40:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h9-20020a02b609000000b0032dee7810cbsm927744jam.45.2022.05.13.13.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 13:40:14 -0700 (PDT)
Subject: Re: [PATCH 4.9 0/7] 4.9.314-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220513142225.909697091@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fc47df8-5b82-e386-e881-ba397e87a8c8@linuxfoundation.org>
Date:   Fri, 13 May 2022 14:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220513142225.909697091@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 8:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.314 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 May 2022 14:22:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.314-rc1.gz
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

