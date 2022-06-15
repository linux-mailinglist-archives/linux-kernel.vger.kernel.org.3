Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA354BFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiFOCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiFOCrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:47:00 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6953049B70
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:46:59 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f9-20020a9d2c09000000b0060bf1fa91f4so7927701otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lC2aW9m+sCsaY8ENSg+Iq1e/uSllSgVY2V4gRPX05YI=;
        b=XMYWouVY01vv3esFUIZQsXrdCp0knmBSLJAs/HOot4ICBnzCJ8/1d7NNP8QP0Nl73H
         DmzhRa+X/+U7xZSFZrvObyZdLD3SLABY0xmR/LAEirOwqj2SPwhDC+r3dFXE9PzHqzK9
         cC4wImUdSfMF/FsuI9z2Eu7s57UpyjpDZm+NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lC2aW9m+sCsaY8ENSg+Iq1e/uSllSgVY2V4gRPX05YI=;
        b=gROBFr8letCkbyCbxMOVu08x0gJ2akBXwMozR89celi+IFRzPck51nPLwaKbPWlwEa
         lFyO7wZuViB9LA9a7YV0Lkhg9GwT2OrcZV9CzTld0HLy0a3QOrz3+UebLIflemwY6DZ2
         Gge+hVwtMdl4jkSktKYOxO+OefSMqN+MOutYgqkqpfWuiXs2LzV9LBNS7hCjqTdE2aUr
         iFA4ZpEhmXzQvVPjNSWF21mMEfVDS4E7sho3JY6PYGXTT11FfoK2KxvVO/emPgq1DdkG
         i9gq+0pQVc6ODXcGj8X/dQ3kQEaYXZL4hXXj34GZj/bFzYLTrfCMnpuz/fPGhcwKQOfd
         qQvg==
X-Gm-Message-State: AOAM533iOzA81JWAiZnsbdi5DIg7df82VOyRh4WIoGP6Jag4WiCbCESQ
        iUu13XjsXvLyPed3n9o1619Xww==
X-Google-Smtp-Source: ABdhPJxgyPr6uHsivdG++8B+MJPcLPg/AysQ+2MFi4kMjS/iOGFw7oyHTXDZwcqPOpC6FYioaCJ/9w==
X-Received: by 2002:a05:6830:925:b0:60c:6c96:2366 with SMTP id v37-20020a056830092500b0060c6c962366mr3348324ott.54.1655261218710;
        Tue, 14 Jun 2022 19:46:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bc15-20020a056820168f00b0041b8070a784sm5967882oob.5.2022.06.14.19.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 19:46:58 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/11] 5.10.123-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220614183719.878453780@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9d61d0f-dfca-b774-8c99-ba5974beaf64@linuxfoundation.org>
Date:   Tue, 14 Jun 2022 20:46:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220614183719.878453780@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 12:40 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.123 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jun 2022 18:37:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.123-rc1.gz
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
