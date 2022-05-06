Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1351DF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388577AbiEFSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388545AbiEFSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:51:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6B63533;
        Fri,  6 May 2022 11:47:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k2so11115942wrd.5;
        Fri, 06 May 2022 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vt0OWBct8YhWCch2+2OkXoGqDKSr3TcXp5y1WslSxb0=;
        b=Cjo/YUaxkMwPxpg/1jrCgoxVaa0657POk8MVPJtu2fSAfdjI9N/0OoJ8AMA/b5qVBF
         NhjbTxO8G7FOzu+75usLEAjKTwDOxFC9pMH94Y2sWjRxRuRqXzh9MIdC/rBP8uAhE9vu
         wpZWRYwVM36ejJ4OkCrsMyiKKRCWPaxivl/2pB0eksZ/gGQQBycu9nzwrU6Uc9Jla/uh
         AAjg1kIsvvuEkmRyQZLlBrHMQHlpjmzmfjIhKDdBInawqPxEZbK5CtxsyeZoo9eUdeAX
         SKoCrIfnb+z5xt5J4shDn4p32/zUzn1qhxlkb+Ecz4Dla2jKxDvywirWavYdpD9wgCZX
         mamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vt0OWBct8YhWCch2+2OkXoGqDKSr3TcXp5y1WslSxb0=;
        b=pN6PqhPwbIAecp49E6SzZUZQ4+kUqUyHLu+Q4SHOoWyFFiwXpt1yepr1Wr9vssWah9
         /EjnwT45blLKbx5vz51u+CgtRZsgx+ya0oMVx+7WiHaX+h623uqi1sd4xV0b9Ormuk+q
         lASHapa5aS+iGZSS50JSxOK2GMIfDQ+QoQwa8YcR5VrCmxaGp5ms9Ih5f5O++2EObhvq
         u2MDdIhFCf6EPizOQvU7ZFyI4kY7RHrV/Jyavn8VKHcRlwqw7/VV2E8qfsghp7p2HqCm
         qd9CPy0zNXur7VUCdOz051whwuFcsoUqzjUgiiBn4B24ZVX7F3DBnQEa2tHoS5DAu3oh
         RpjQ==
X-Gm-Message-State: AOAM530IBM4IhMMGskux1wV9xhYxxsZiQzFectfC+5k1KZeCluhQKKRo
        r99+iP/6gOiwFZgKBV7fKxKUAhzXJDg=
X-Google-Smtp-Source: ABdhPJw5T/i5wLRQpeYYOhW8GC1eO03llyK9BZ8FVVykkMSjfn1KbnufqxCOOZAjOvJxiOjSC7dMjg==
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr3894091wrn.409.1651862840866;
        Fri, 06 May 2022 11:47:20 -0700 (PDT)
Received: from [10.17.0.15] ([194.126.177.12])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d530d000000b0020c5253d8fasm4276785wrv.70.2022.05.06.11.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 11:47:20 -0700 (PDT)
Message-ID: <40c3033e-b9d8-0cf6-4009-35701f02c8aa@gmail.com>
Date:   Fri, 6 May 2022 20:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ACPI: battery: Add "Not Charging" quirk for Microsoft
 Surface devices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220429174114.1277799-1-luzmaximilian@gmail.com>
 <CAJZ5v0hoE0vn5BX586Ag4oLFRn3WoZJCUQZ1+jM1O6Vm+yyc4A@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAJZ5v0hoE0vn5BX586Ag4oLFRn3WoZJCUQZ1+jM1O6Vm+yyc4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 20:43, Rafael J. Wysocki wrote:
> On Fri, Apr 29, 2022 at 7:41 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> Microsoft Surface devices have a limiter that sets a fixed maximum
>> charge capacity for the battery. When that maximum capacity has been
>> reached, charging stops. In that case, _BST returns a battery state
>> field with both "charging" and "discharging" bits cleared. The battery
>> driver, however, returns "unknown" as status.
>>
>> This seems to be the same behavior as observed on the ThinkPads, so
>> let's use the same quirk to handle that.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> For what it's worth, I don't think the ACPI spec explicitly states that
>> any of the status bits need to be set, or that there are only the
>> "charging" and "discharging" states. As far as I can tell, ACPI only
>> states:
>>
>>      Notice that the Charging bit and the Discharging bit are mutually
>>      exclusive and must not both be set at the same time. Even in
>>      critical state, hardware should report the corresponding
>>      charging/discharging state.
>>
>> But that does not exclude the case that no bit is set. So, strictly
>> going by spec, I don't think it's necessary to put all of this behind a
>> quirk.
> 
> I think that this should be covered by the patch I've just applied:
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/20220427154053.499203-1-wse@tuxedocomputers.com/
> 
> Shouldn't it?

It does, thank you!

Sorry for having missed that one.

Regards,
Max
