Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23DD5AF876
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIFXgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIFXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:36:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52674DF5;
        Tue,  6 Sep 2022 16:36:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12243fcaa67so32033892fac.8;
        Tue, 06 Sep 2022 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7fI7GSQEqzfTbxrtg0p1r0owGwfzmjJSW9DpLrWCgIc=;
        b=d9TLgsDmvl68FCD/rIKT+9o+eHronhkechLJbLPFu0/PmQ2az8Yi+kDsA2+lJReMRj
         7wI3BCJGIvDKg3YsvpdhbBtQP4r9PIl5YohE1C6cO7Y0SNNurt+6o7QGugTfNzvhHcxr
         bRxbKNfSozmNHBJLbkvXkwuDfSQ5Wa+QX2N6cGNLs5NTRozcTQ5UDnwFBbcd4a/tJ9Gk
         E5osJPfJJUbVDHVZsxQRsDl42IwvvNH0Nmm+7VsHAuJt4BiHELS3S/T+jHhyltYOL6wp
         6HeEQDWSyuxj1n/rB3o/Jhyfb7iSOd1pnZQFG5H4L/fjLo9AfWfvgmzfTFHUUMIRJZWa
         heBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7fI7GSQEqzfTbxrtg0p1r0owGwfzmjJSW9DpLrWCgIc=;
        b=FxxsBdwgNW5lgrzLQ3gWV59XZxFnEsuUYWQ4aD8yYlUCFv50u6NVMlInvNTtwgRKdM
         P8NeHwl1P5aVk6P9govBXt/lxNL+49P2uv+veAQP4jp7R66i3APuOs0jkpd9CYlz9HzJ
         j549le6N6YhW9ssFeMO3md0jGRLYhjgn2xTLPt4u+sQkSyuO4WXvmtDvpWB5GB7zGm+v
         L4Rr5ZHkyCJ/42XKUVYmTR2jgBJsD8XsgkPggamGAPBF0Mf0yb0ApUnBySc8Taviuo/7
         hQ06OmNtH/TFtfoyxntzZJ73aahzLnPxd8e+jA5+qjmgPrIU4j6l+pI4WESjK73TGuXk
         mNOQ==
X-Gm-Message-State: ACgBeo0BxTGRJLu4RxcpcsMNb7WB9XJvQaPipQxlQLQ9iKZhgohoVbp6
        +nuY89OXS0hg24PP35zqLEA=
X-Google-Smtp-Source: AA6agR7zZb77ZwaCfAlECdF3kNlSriboTt5SSacEBTaPERsG+TCNe0XQVOt1ni6Y2tZrTzaz5UGcag==
X-Received: by 2002:a05:6808:1389:b0:345:fde:79eb with SMTP id c9-20020a056808138900b003450fde79ebmr10790885oiw.21.1662507366364;
        Tue, 06 Sep 2022 16:36:06 -0700 (PDT)
Received: from ?IPV6:2804:431:c7f5:f684:ee06:25a5:3122:5cd3? ([2804:431:c7f5:f684:ee06:25a5:3122:5cd3])
        by smtp.gmail.com with ESMTPSA id x2-20020a9d3782000000b00639443424f8sm6405852otb.8.2022.09.06.16.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 16:36:05 -0700 (PDT)
Message-ID: <8e4350df-0c73-6ca2-a25f-28a40a1856db@gmail.com>
Date:   Tue, 6 Sep 2022 20:35:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: build failure of next-20220906 due to 396369d67549 ("drm: vkms:
 Add support to the RGB565 format")
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
References: <YxducgSzR6/zyHD7@debian>
 <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
In-Reply-To: <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 18:26, Sudip Mukherjee wrote:
> On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
>>
>> Hi All,
>>
>> The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
>>
>> The errors in mips and xtensa are:
>>
>> ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>>
>> The error in arm is:
>>
>> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
>>
>>
>> Trying to do a git bisect to find out the offending commit.
> 
> git bisect points to 396369d67549 ("drm: vkms: Add support to the
> RGB565 format")

Are these architectures incapable of doing 64bits int division?

> 
> 

