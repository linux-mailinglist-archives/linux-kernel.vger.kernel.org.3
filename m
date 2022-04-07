Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B34F7B83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiDGJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiDGJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:25:46 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF86130C30;
        Thu,  7 Apr 2022 02:23:46 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-de3ca1efbaso5710770fac.9;
        Thu, 07 Apr 2022 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1w6g0t9FF80meM/9r7z+LlSCIy7b2uDRiP07nJn9L0=;
        b=J6p8c79vkyK244uIiZ/IBFH4dh2YZ5jsqsA8b1VUzQuKxDDC2yfDFAAuqFls+g7wAS
         PJttXpW0nCmBj6MFi6MUfxkRNFpx+jxE01M5uAlZ05uPAdxxj2ylXp0gNztaPyFd8Vc1
         uGHfaTo7G/pfJcjc/G/xQe9crjLpJl4VNdMg+HaTbILFGIDplqA3TLr8KA2jDxcACy4n
         BvZBmXrewlin9ebJmDpXqDIvETvlnH884Lcogvg2gHcE8NyhC6a+Qu/LVsxUU1erPEhj
         X9O2Y15C+axDopkbBJD819NChgSbITcwQteJZJL8tw9rkPkqF4weB6oVXJrnuif5q7L3
         jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1w6g0t9FF80meM/9r7z+LlSCIy7b2uDRiP07nJn9L0=;
        b=evDga7ZSeoYhYxAPpKXuQS8TBd9+C6Z53Y90xB5fRhx2zGT69mG6JFj1eVf7VKoDMo
         bf3pjB2pzuu3DChK0Tbm2SDGeEZZwr/ls0co8HNwvT2rMHkVsPO4wMHsvznP6s5Njoix
         N7uJkN32GfOtmvEEjyOCXSECRk3lV4Uu58qo846ZNd019CnlHrgnJSij2taFLWP/NZI4
         nLAm7WmqruZr8MqwXFiVGkt0cfA3n3FvbpIgkVoVVR487h76U2vHurbgR+GS3X5b8Pgl
         I8wrzqahnO9EK2f1wKgp/YM4YWt9pEBgQeh5vpYdqSTA8wt3gg9yZ+8byO4+bYzDJra+
         BVlA==
X-Gm-Message-State: AOAM531lZNiCf/x6pA1yYXNVLGBsRdv3i4W4pyLUvxDYFhaUIZMNWcXS
        JBSs7/3BEBee1G1Gbj7tOn0=
X-Google-Smtp-Source: ABdhPJwrmKKcltCph41MdlupwYebDSCmSwCE2jQhwB8toShtovejm4ezDZKUJI4sngvRzFaiJLPKIg==
X-Received: by 2002:a05:6870:232a:b0:db:360c:7f5a with SMTP id w42-20020a056870232a00b000db360c7f5amr5576580oao.230.1649323425082;
        Thu, 07 Apr 2022 02:23:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1-20020a05687015c100b000e210c5170fsm3741232oad.6.2022.04.07.02.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:23:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0202486d-cf86-c9d3-04bb-8b1e596462f7@roeck-us.net>
Date:   Thu, 7 Apr 2022 02:23:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] hwmon: (adt7470) warning when removing the module
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, Zheyu Ma <zheyuma97@gmail.com>,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjmTObCwaF=enLNkRSzxqSzK6KdkHf+4cWo5fqOO7B40iw@mail.gmail.com>
 <5f3a3672-6b99-7e24-9003-443c571f2dcc@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <5f3a3672-6b99-7e24-9003-443c571f2dcc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 22:01, Armin Wolf wrote:
> Am 07.04.22 um 05:17 schrieb Zheyu Ma:
> 
>> I found a bug when removing the adt7470 module.
>>
>> The following log can reveal it:
>>
>> [   18.459479] ------------[ cut here ]------------
>> [   18.459852] do not call blocking ops when !TASK_RUNNING; state=1
>> set at [<ffffffffa006052b>] adt7470_update_thread+0x7b/0x130 [adt7470]
>> [   18.460857] WARNING: CPU: 7 PID: 365 at kernel/sched/core.c:9660
>> __might_sleep+0x96/0xb0
>> [   18.461523] Modules linked in: adt7470(-)
>> [   18.464568] RIP: 0010:__might_sleep+0x96/0xb0
>> [   18.472577] Call Trace:
>> [   18.472778]  <TASK>
>> [   18.472957]  exit_signals+0x2f/0x3b0
>> [   18.473251]  do_exit+0xcd/0x18c0
>> [   18.473534]  ? __mutex_unlock_slowpath+0x1b8/0x740
>> [   18.473927]  kthread_exit+0x42/0x60
>> [   18.474212]  ? adt7470_detect+0x140/0x140 [adt7470]
>> [   18.474622]  kthread+0x272/0x2e0
>> [   18.474885]  ? adt7470_detect+0x140/0x140 [adt7470]
>> [   18.475277]  ? kthread_blkcg+0xa0/0xa0
>> [   18.475601]  ret_from_fork+0x22/0x30
>> [   18.475901]  </TASK>
>>
>> Regards,
>> Zheyu Ma
> 
> Please correct me if i am wrong, but i think the issue lies in adt7470_update_thread()
> leaving the kthread in TASK_INTERRUPTIBLE state when the second check for kthread_should_stop()
> returns true and causes the kthread to exit. Since kthread_exit() might sleep in exit_signals(),
> we get this warning.
> Maybe moving set_current_state(TASK_INTERRUPTIBLE) below the second check for kthread_should_stop()
> would fix the issue?
> 

Agreed. Care to send a patch ?

Thanks,
Guenter
