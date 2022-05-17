Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A352988B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiEQEMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiEQEMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:12:32 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295D4248E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:12:29 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e93bbb54f9so22747548fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjLiBdEyGRr1DljigDWl3/nfTHcYtrO1CopjRQRVqo8=;
        b=GeYrAL8SxTcMe8urcAMnRLJNy+YSJtJVBM6UTvhFwBaM9lsTOkaIZByxBl3PkPsYQj
         DOfKO6keq76M64rPgffJKLa6Mk2RuH7c2WChh8mdmvci0z4/8KvaSOzb6WpU97T5HPFY
         hu3tgK0We9AIpHgb+Z8ECnYyK99u1uKD82B2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjLiBdEyGRr1DljigDWl3/nfTHcYtrO1CopjRQRVqo8=;
        b=8DdOV91/dCtIpGui+f5YmbKzuz2CZTvSO8GDWdXl4r90e2c3KbmTrOeZ1tB9JAxnzv
         eId0yPO0Ke81vkje9FJUqcZ/D996Ya/ZLS9JD818JE0qK8Q7tyhTScOArn6Ijizzs2IP
         HC0LvW/mP6hOlY+xj2nuPWpEeKCgY2ZxK5lJ5BzrJfKGQ9MVRl7Y7ePG5zKyJWM4DhxH
         n6cuOCl/cA+3G2hFoy9h6z1tfuDBqewOnhaGLQeq9u5wtEqZ0PdrQFDpSv0T30DGi2QB
         R+HbeboZs2oDjHcts0K0Cu227wnk5hlxuC9AC5q8VGKsNMpH6vBB22Lha858cLgAgKqy
         z3Uw==
X-Gm-Message-State: AOAM531ZjwyavLilwd1d0aYPvfjGBOAN6EKRyAkIDCnCstHLjbgX3kCG
        M4S++2svSsQahl9S/BJes0eAmQ==
X-Google-Smtp-Source: ABdhPJyWz9Av7MmLakiePzFOiO0VWW8F2X7F9JI/7B+Gew4JrGAW81n6GCL4JFoToikjQCb6eGrpGQ==
X-Received: by 2002:a05:6870:d392:b0:e2:aa54:9601 with SMTP id k18-20020a056870d39200b000e2aa549601mr18005446oag.184.1652760748797;
        Mon, 16 May 2022 21:12:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r21-20020a4acb15000000b0035ed382fb5asm4811760ooq.15.2022.05.16.21.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 21:12:28 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/68] 5.10.117-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220516213639.123296914@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6b15f803-69c7-f78f-f605-9f02efb2e827@linuxfoundation.org>
Date:   Mon, 16 May 2022 22:12:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516213639.123296914@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 3:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.117 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 May 2022 21:35:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.117-rc2.gz
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
