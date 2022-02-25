Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1224C50DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiBYVqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBYVqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:46:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05D1EF35D;
        Fri, 25 Feb 2022 13:45:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d10so13280769eje.10;
        Fri, 25 Feb 2022 13:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WUC7V+O3XAxmaqtMnQJOVveRn6Cuhyncuw6K66dwUqc=;
        b=J6IYE5vlhK+ylp2TLN0MIkJ7VkoKkzaDVW51e4oXPuRffwekpuI3j0SuhJhjDH4jsn
         89fRNsbZdw3Ot4NJQOumfJyErzdw8HPeBfQE/mJCJeoh5WXAFkjbXgnNNnaVdtOatA91
         MKxUDHPxaLo87a8hRWH+1IBRcx87385sFXAJ90X4+CPG4kgBOhuck4jmH1kkGcpxIU5o
         c56KIutfl9wIRasS7xNDicqvtFS1gBoFF65niO4E9QkdwceCFfY0r/dC6kZnoM5kPmCc
         TU/0E5jmqWIKBXK4Rs1vcla+Ma5rfVAfZQBmOQwRDzWKLv/E8MhUaI5OHCvYuSII83ga
         5f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WUC7V+O3XAxmaqtMnQJOVveRn6Cuhyncuw6K66dwUqc=;
        b=FvS/p3kr51E6qSs8McbQbkVMCw0zIMcPIbSSaOMO6juBRyVyZQwO31ZfR0sWHcJB7+
         5NAzLMfgw+Nn0IHuPROWtK36cmRRqaDjwv6/KXFTLqie8biq3LO6h2oYHO64AocKWrFU
         8lotjoUQanEotS2UfGqCZKGiSQVdBlbfBFqvoSLcgNk1bk769UUmz66bMzF/N22hwlKA
         X7wVVcHId8c5WIpY8c2gKo5jfimicJJ7iCko4vXM5vH38CY1ijpNzByr2utHon8MfgqC
         IIIIr5e+1TsTv1wQWdo3yGPiVwUHTY9L0n6e/BKfG7TU6hS6u5nofLRNMLulfMi8+TUJ
         BPgA==
X-Gm-Message-State: AOAM532huWXm7WrGPAfDCToi0D132HW+VMJ2xl9rV49a4XO8S/qbEooe
        N/A7GB1cMUh6GPPgXTi5nP0=
X-Google-Smtp-Source: ABdhPJwzHWtu2wcaSjUJUo74H7f7+j3BpIDWEyIIyY+Gn8nTEclUvyyXX2GyZNjkO0R+fazX83syow==
X-Received: by 2002:a17:906:3bcb:b0:6cf:cf86:28d7 with SMTP id v11-20020a1709063bcb00b006cfcf8628d7mr7652814ejf.274.1645825558357;
        Fri, 25 Feb 2022 13:45:58 -0800 (PST)
Received: from [192.168.2.121] (p578f0c28.dip0.t-ipconnect.de. [87.143.12.40])
        by smtp.gmail.com with ESMTPSA id h3-20020aa7cdc3000000b00410b90f3ffesm1892707edw.56.2022.02.25.13.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:45:57 -0800 (PST)
Message-ID: <15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com>
Date:   Fri, 25 Feb 2022 22:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 00/11] Restructure the rpmsg_char driver and introduce
 rpmsg_ctrl driver
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
 <ab97c2a5-7705-eae8-9bc2-908e7a9cb709@gmail.com>
 <670ee336-9ad4-401e-e3b2-02531e975e51@foss.st.com>
From:   Philipp Rossak <embed3d@gmail.com>
In-Reply-To: <670ee336-9ad4-401e-e3b2-02531e975e51@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On 24.02.22 09:29, Arnaud POULIQUEN wrote:
> Hi Philipp,
> 
> On 2/23/22 22:28, Philipp Rossak wrote:
>> Hi Arnaud,
>>
>> thanks for working on this! I'm currently testing/using this patch
>> series on my imx7d project because it adds the capability that the
>> remote processor can register it's endpoints dynamically (as mentioned
>> in the objectives).
> 
> Thanks for your feedback on this work!
> Don't hesitate to add your tested-by, this help maintainers for the reviews.
> 
I will do this.
>>
>> After a few tests, debugging, and checking the openamp specification [1]
>> I think that you missed the second ns_announcement that should be sent
>> from linux master to the slave after it created the channel/endpoint.
>> Without this second announcement the remote processor is not able to
>> send messages to the linux master because it doesn't know the
>> destination address until it receives a message from the linux master.
> 
> Yes I detected this issues, it is not related to the series
> but to the remoteproc_virtio backend.
> 
> As you mentioned, after the ns announcement from Linux, the remote processor
> send first messages. But the Linux virtio does not do the match between the
> local channel created and the remote endpoint.
> 

I'm not sure if we talk about the same. I'm basically talking about the 
dynamic binding, not dynamic endpoint creation.
I think I already found the issue. I will try to get a bit more into detail.

1. Linux: starts co-processor via remoteproc
2. co-processor: boots and reaches the point where it creates the 
endpoint like it is done in this ST example[1].
Be aware the src address is RPMSG_ADDR_ANY
3. co-processor: reaches the point where it sends the ns_announcement to 
linux ns endpoint
4. linux: receives the ns announcment, creates the channel, bindes the 
endpoint and checks here [2] if the source address is not RPMSG_ADDR_ANY 
and in this case it is not sending a ns_announcement (that's the issue 
when we use dynamic endpoints)
5. linux: according the openamp spec [3] it should now send the 
ns_announcement to the co-processor (slave)
6. co-processor: should receive the ns announcement and binds now the 
endpoint
7. co-processor: can now send messages to linux

This is basically what I'm expecting.


Do you think this is a bug or is the dynamic endpoint binding not 
handled? This line is there since ever [4] ...

Any other thoughts about this?

> This is a feature that is missing in the rpmsg virtio, and perhaps in rpmsg protocol
> itself (a ns annoucement ack message or something similar).
> 
> 
> A fix for the remoteproc virtio is available here:
> https://github.com/arnopo/meta-st-stm32mp-oss/commit/3e57fe73bd19c9bb835ac5a118e50727758b0b96
> 
> Don't hesitate to give me feedback on the fix, if you test it.

I added it to my branch and till now I don't see any side effects
> 
> I plan to propose the fix after this series.
> 
> Thanks,
> Arnaud
> 
>>
>> Cheers,
>> Philipp
>>

Cheers,
Philipp

[1]: 
https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_raw/Src/openamp.c#L242

[2]: 
https://elixir.bootlin.com/linux/v5.17-rc5/source/drivers/rpmsg/virtio_rpmsg_bus.c#L425

[3]: 
https://github.com/OpenAMP/open-amp/blob/main/docs/img/coprocessor-rpmsg-ns.png

[4]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcabbccabffe7326f046f25737ba1084f463c65c
