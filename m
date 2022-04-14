Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642A5019B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiDNRN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiDNRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:11:59 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D865D1CF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:02:47 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h4so3481191ilq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GjEQSvduyN0/TJE/Jlki9Iezw71PlCdMxAXFTJZFBLo=;
        b=RJ0nifPqE99iCjBsuoGScCCHdETY7l8xcMXQF9Ee7dfna05JX1upTUPVVcd4zeL26q
         cUq5elDmxChCrW6+z/d2PBuqyJljOeTCQ7WA7kdLS47KO08JshV3V14dwFaPkRcUQLeQ
         3A86g4Bd0IA8HAPA4RIEGM2p8XOVn3XLaSi+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GjEQSvduyN0/TJE/Jlki9Iezw71PlCdMxAXFTJZFBLo=;
        b=WcnM6ZDixucxYxVfFeWldnCgrAQ2tnKEs31emmblXJT2oTjuiPyhehRQrkeqODRMz2
         g9FAhkDFeZQK8zOCnjX2XiBM3dKib13N4FyI876rvTYX0fBWZQD87pfDTsr30/OfUnrY
         oq1yL+LtnL+WsE0fHwLMkgQeKMid8KpmII1TwNYpNbuSOHKhe4xCxfDIcqiXzZjL1ARw
         fswBC0uAmZLLtj1mDcBkIdzxGiLQeeXL8iIOqe7hCgT1RcNfw4tWUtmLKV6lMn42jvY3
         uQGxyt587au4x7XdV/nCZWXOcIGo0koeZUD9H+zBWEHIxQz9mVnP7o4ejeNODxenmw25
         nG4g==
X-Gm-Message-State: AOAM5307pAIcghpeuZONTffNrIEkSxcXvYJRyqJMyJJkPSdspCgRQYkR
        2JvotMsJnPuRr0N7hd8HqXh7vQ==
X-Google-Smtp-Source: ABdhPJxVgar9TUDwXqhznrPjwmOujBp9CZo6w1rUoSqceF5rPn34WXzTYNw0w8QFQeJEZ5RDB42k8w==
X-Received: by 2002:a05:6e02:20c4:b0:2c9:a514:6a99 with SMTP id 4-20020a056e0220c400b002c9a5146a99mr1513400ilq.50.1649955766270;
        Thu, 14 Apr 2022 10:02:46 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p6-20020a0566022b0600b0064c59797e67sm1504152iov.46.2022.04.14.10.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 10:02:45 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/475] 5.4.189-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6bfcb678-5843-8557-b7de-9ced0defa881@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 11:02:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 7:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.189 release.
> There are 475 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Apr 2022 11:07:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
