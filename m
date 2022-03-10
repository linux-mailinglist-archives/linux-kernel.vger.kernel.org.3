Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6874D5194
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbiCJTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbiCJTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:35:47 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15614D707
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:34:45 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d62so7651973iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikFy+g0Qff1RcPBTztueUofboGgJYJB+i1yAWEft3EU=;
        b=GycB/Cwzk6DtbT/p0r302LfzivVzangIFBLF0Erst+bYjLus5cOr3BD+WrZxH/XhI8
         Yunfwx20QGCXupDOmU1/gF3HcQzBtT74SscmpHU27guUSEJRms6ExBfSnjcJNg5VmX2r
         Ia2Qh/RagFEtZOAV62fZkQEsiv/9CjaB8FOts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikFy+g0Qff1RcPBTztueUofboGgJYJB+i1yAWEft3EU=;
        b=pLd497ygtF7IiWgUb0rg7Lj3yoIgR1uL/kO7cspLh38RYZHf4C/D+nabQWHvWXKo3N
         MYV+nXNcT3fG+1e0lDsURlX0RBD9FJlrUfc2ZQ0YEfXkHx9IpPC/7tfpSJ0ql303Ch2n
         iuJaVopaAIsbeBtPI5GFhZStVwOccoHGQfRGvotMTPcNBOLC6NZrvaXMmPcGzhiGdJxn
         sN+VA4OXNouA6mSPMawFl49z14rPfPnDqUt+os3F39LqPRN1gYK3Hp4PirwiI5aLj45l
         i4UyTh6cq9r5PqmhmuqPU3jLr5LC0y3tFL7QyxNzJLFZ5yx7B97d9rgBNmOzTMgv6TOs
         V7Mg==
X-Gm-Message-State: AOAM533kgxky1s6iz5eHs+qoYclv4CVp0Fe029IGv13IXDqdaKwKqVck
        Mbcfkm94FKoUJ60XNldYATE5Ww==
X-Google-Smtp-Source: ABdhPJy+/RMKT6ree9MSOpAB4dGDwQOukmrZ6ETZ/uPkhC0GmHgWJThOk74LTnmZcJrKYbteDp4LfQ==
X-Received: by 2002:a02:690f:0:b0:319:c67b:174e with SMTP id e15-20020a02690f000000b00319c67b174emr1163287jac.124.1646940884855;
        Thu, 10 Mar 2022 11:34:44 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s8-20020a056e0210c800b002c63be70db9sm3075916ilj.82.2022.03.10.11.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:34:44 -0800 (PST)
Subject: Re: [PATCH 4.19 00/33] 4.19.234-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310140807.749164737@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31f9721d-f91a-0522-fa8c-076526175c24@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 12:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310140807.749164737@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.234 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.234-rc2.gz
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
