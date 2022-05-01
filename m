Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC045167F7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbiEAVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiEAVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 17:11:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56526BAB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 14:07:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v65so13684861oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=/H502LPEzSt4GoS+P7zqwCislvuDj30cVgMVeYzxz3E=;
        b=NOWQRxW7LLkiODXK0OuF78r3yEFpwurW1VrEep/Qh5TMdcJ876d0sUX6n+POzXJ0ya
         /kEwjmcjaM5NwIi/o5wlmJwjtSEaccKEyvMcDdXpbr8y8nXjgMiebNnoODhH3J8b5481
         jdMCP9ziEZMW2j2xbJqitbUjZ/ZpGGf7GemB3tqcLe8X0gZeLzlvJV4L+yXErTIDVsRV
         88vn81JksuDFSMEujulUirg6Eay4Uted7J1dNS+Mf2d+eH2VcHOw2ppV+fyatDs5/rsD
         tSp2WxrLJ88A3kanBYgtWz+C8MZiGH7exiJPSuB5jVkcGFW9Jk8BheMRfJBPB+E0txsJ
         AN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :from:subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=/H502LPEzSt4GoS+P7zqwCislvuDj30cVgMVeYzxz3E=;
        b=8D04q1zV97deNZcDiLMWkzCUgRaIONVY0aCEal0riWU9Ico+KKvrSDkTtoUnKPLMum
         5nhGe/24pssv+fA3Hyu/hApRILLzYrU4f8w5pQRvDsTwWYN/h1vQjySylAhQJZV3Zncw
         LgldvHW4jtKgrxOkiawABYTwnU9+93l2aY22eskafJVFMtTI03meCL5gTk1mYt2jW6YU
         SS3SlUsViPr8ajVeWiz1WuW8+WYTy2YiBFDUWb639qwuW+Z3QFPWZ8tgR5MxaGwvriVQ
         F84Rn78aSP8erK3n7JZ4yrg3BY6XCRVwRT/FOxChhG2fAIGwkntX+oDSZyaeiWWPTX1H
         hrtw==
X-Gm-Message-State: AOAM532LtyYRpP5nundqCq75CmKIuBL5WkPgWi5tM62hwSnzwur6awha
        diOHAV+ej2QRJjJ9Kjb6qAP2a0O7zPZoTA==
X-Google-Smtp-Source: ABdhPJxLdeNOoyD+aZfSlQ9dL/w1A8C0kkskzGCYoohHimyZUO1B79w6AU2HKGq32O4DYY79+UNNAw==
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id ay9-20020a056808300900b002f96119d676mr4250347oib.205.1651439261684;
        Sun, 01 May 2022 14:07:41 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id k14-20020a056820016e00b0035eb4e5a6bcsm3253219ood.18.2022.05.01.14.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 14:07:40 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
Date:   Sun, 1 May 2022 16:07:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox Virtual
 Machines
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
 <Ym7Hw9GDPP838JoH@zx2c4.com>
Content-Language: en-US
In-Reply-To: <Ym7Hw9GDPP838JoH@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/22 12:47, Jason A. Donenfeld wrote:
> Hi Larry,
> 
> Thanks for the report. Several questions:
> 
> 1) Can you reproduce with 5.18-rc4?
> 
> 2) Can you send me a stacktrace from the crash or any relevant console
>     output?
> 
> 3) Does the crash happen in the guest or the host?
> 
> Question two is very important.

Jason,

1. Yes, the problem happens with 5.18-rc4 and -rc5.

3. The crash is in the guest. Nothing unusual is logged in the host.

2. My answer here will be incomplete. There are no stacktraces or console ouput 
on the host from any of the guest crashes, either in dmesg or under journalctl. 
The desktop just disappears. The VirtualBox log files show nothing for the Linux 
guest, and the following for the Windows instance:

00:00:57.908011 GUI: UIMachineLogicNormal::sltCheckForRequestedVisualStateType: 
Requested-state=0, Machine-state=5
00:01:24.502961 GIM: HyperV: Guest indicates a fatal condition! P0=0x1e 
P1=0xffffffffc0000005 P2=0xfffff8054c61e97c P3=0x0 P4=0x28
00:01:24.503053 GIMHv: BugCheck 1e {ffffffffc0000005, fffff8054c61e97c, 0, 28}
00:01:24.503054 KMODE_EXCEPTION_NOT_HANDLED
00:01:24.503054 P1: ffffffffc0000005 - exception code - STATUS_ACCESS_VIOLATION
00:01:24.503054 P2: fffff8054c61e97c - EIP/RIP
00:01:24.503054 P3: 0000000000000000 - Xcpt param #0
00:01:24.503054 P4: 0000000000000028 - Xcpt param #1

Running a 3rd party dump analyzer shows that the crash happens at 
ntoskrnl.exe+3f7d50. I have installed the Windows debugger, but I think the 
learning curve will be steep. At this point, I have no further info available.

Thanks,

Larry
