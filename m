Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A594A584202
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiG1OmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiG1OmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:42:08 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F368DF7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:41:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r6so1024699ilc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHVdLHTLmgFe2akRBUIu4PcEhdufN5r4A+NHKCOopGw=;
        b=LKbvDfhlpM4XYKYCWvsp2mOGqa+kvhnz6nEMtjTjOMintnXhaWsFlqvUzRA4B8YBXF
         FuyjzouudCJdAc4AetYcMK02BYnEMMMov3VUmG/n2QeApUG2UxwIGNN3cV6BlUvnEkW2
         tQLupTi/5v3vu++hChnQYYJpZiUQcgn88DEpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHVdLHTLmgFe2akRBUIu4PcEhdufN5r4A+NHKCOopGw=;
        b=YX8FuJthVkKDwmMxxhdi/kdCay69mYNBoW+KDh8Bw6eKKhH5/rAT3H00ubXRlEsSwH
         AZSXMoLm63i/hiP3RtG09sUXa5U00aezf8+76ESM2ZGeiS4fIoAuDJbRB1ibCdCaveHV
         gcqz3GirhCLT36zukSHffcPZJnYjUHQD1uC9tIwlF3TVfzZzLy6RdpiaWR9nOOds7azT
         tiXrRCG/M6bPBhI7m9m0I6ammp62P68EQMm8vy5bj+GvC5B05Pr9zmqPEL+YlKrXGR8b
         JDetfxwGgExiuiCAt26Y1ZGXeBX/ANLka9rHQLM33RCdy8kzR7TQ32O8JIlU7o+9AjjJ
         lRDg==
X-Gm-Message-State: AJIora9Q29zxAC16/BhaljEfaAjU1ysCY9SsKDZ5MuaBhkp/XtDXxOHH
        3B8+AbYF9eRjFbWBwACbYlsfSQ==
X-Google-Smtp-Source: AGRyM1sUFBYDswiH6UyZ/aLyOfx1zsVicc9zuK8XfpVKkUmTgVD+VE9b81yteaC1bzk5AhpmW+HPaw==
X-Received: by 2002:a92:2a0a:0:b0:2d9:2571:f57e with SMTP id r10-20020a922a0a000000b002d92571f57emr10603446ile.154.1659019287736;
        Thu, 28 Jul 2022 07:41:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t129-20020a025487000000b003415b95c097sm447510jaa.42.2022.07.28.07.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:41:27 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/105] 5.10.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220727161012.056867467@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9a2f10a9-b783-044f-a5c3-de5d6299202c@linuxfoundation.org>
Date:   Thu, 28 Jul 2022 08:41:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220727161012.056867467@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 10:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.134 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 29 Jul 2022 16:09:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
