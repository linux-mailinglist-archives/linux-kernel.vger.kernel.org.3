Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A14E4332
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiCVPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiCVPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:42:26 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.61.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A68BF34
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:40:52 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 93380400F923F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:19:39 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WgINnjfyAb6UBWgINnzlWw; Tue, 22 Mar 2022 10:19:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CPW0jKKDu2ErkcxGpk3zLqZYpgPh+rOyqsZe2Y8TEt4=; b=YEwIwL3kI9LQjIR69kJnYUwJnx
        kFrm50Ke2/4YuDre3URXPm69vvo2XFbq8JDM43i+Ly6edQ9qaD0K2CFl+AcHL10v2aRROYtMgzK3n
        qbjLELTOs4xI2QNFJgiRzc/ECnSKlbm5iwjcjgYYBsShOxjIeqFDtOyQlW4sS4PSyJnWrQhqi/AzC
        txYek+g9vITOkNC/rOx3mhGcSPwK4DnVBDBcX7o2XN/uUWLJFbIpiBl0DcjjV18utxXfizoYV1K6V
        /MVpk7dqjMmDR8kQo2c2N39vIRQAPPzcmPDy0cF+4YhdRFeRDgkwzxu/Hrxmcrgf8XWQYcEjjYJY3
        VVGZZufg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54396)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWgIN-000PFB-28; Tue, 22 Mar 2022 15:19:39 +0000
Message-ID: <78abe69b-7914-1b38-c94e-7143f61f4909@roeck-us.net>
Date:   Tue, 22 Mar 2022 08:19:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
 <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
 <20220322130516.GA724287@roeck-us.net>
 <ccc25312-890a-a534-1681-5ecde56328d0@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ccc25312-890a-a534-1681-5ecde56328d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWgIN-000PFB-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54396
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 07:25, Helge Deller wrote:
> On 3/22/22 14:05, Guenter Roeck wrote:
>> Does that also fix the build problems now seen in mainline ?
> 
> No.
> 
>> Building parisc64:generic-64bit_defconfig ... failed
>> --------------
>> Error log:
>> arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>> arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
>> ...
>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
>> make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
>> make: *** [Makefile:219: __sub-make] Error 2
>>
>> This is with hppa64-linux-gcc (GCC) 11.2.0.
> 
> Can you check if you have the 32-bit compiler (hppa-linux-gcc) installed too?
> The errors above happen when building the 32-bit vDSO, for which you need the 32-bit compiler.
> 

Yes, I do, but that doesn't help much if I want to build a 64-bit target such
as generic-64bit_defconfig. Am I missing something ?

Guenter
