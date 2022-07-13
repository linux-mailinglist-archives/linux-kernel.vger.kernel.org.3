Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71490573B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiGMQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGMQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:36:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7823BC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:36:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so12861076pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ItKnbriqKUGJi50cU88gaVhly72ngfljKMGXtWnuHAI=;
        b=CyV6rMEL2jtqvWttADJIETxjexdkKis4+nr3kdlX0oT4KPb8XhPZ8ayOX8GRg1bLbD
         rcz/e02kU6BO+2voCrVHZNbSzL2XsW9N8tnRGdB/5Sluolz4qJCGKe9twW4HqR6HxVIR
         zOugybnj0BQah8+MnYv8e2nezSg5QQXuBaxYqnB3xM0vuremDaM5LM/+cgL8F8Oj1ZCA
         LYrveVg6N5UJgBKRig2xqZqJL5qxvetvWw2cFG6hgKCAyQdIwKQ9+8zO+K3tpVwiNDNR
         kWfNhsYaLlkcrquk4NwTx2zniBsHcHYiw+/VZFoJwvjzoFjIRTMXWR7txf5ibQza8Smp
         D/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ItKnbriqKUGJi50cU88gaVhly72ngfljKMGXtWnuHAI=;
        b=GkFgfnChJzbFwrOSkrfZ7vzK3Ca3MwfvQJRNSKhroAgDZzJRRD6O0JfzVmOIa8n62v
         36zmD358vk6pQunShAMzuK/9aq9sM2NjcAS+hA6n9RhC28pZNcEqCqezps1goOutW0qH
         c+5cs10r+eZStcmum5F5Uga9AbUr26fJ88s5e2BlT+mmXagq4U+i652B2EsPMtS1GaAL
         szi2RlIJAhrrqQiQN3PF162mOcCTPpQX/j7zxIeqR36cZXwzEPPDVVilZvi64wbxwc0u
         8DF/B1Jom+MGae1q7CXMi+VTKQd9ETMm/SiOflppIh2poDaAF8nDBJ9swf1XFWsQU0ti
         qUtA==
X-Gm-Message-State: AJIora9JzvFC++sVAfQFR0O8/d00UbahVe+mlW7xtl3vXu8m/zfg2bDB
        UkxMv3YgBdarXWXK9+DBVcM=
X-Google-Smtp-Source: AGRyM1vhi+uwVryoe4QNCEr6iP8FleiyH97tNUlyZIi8LBjhAzMUdzukwohcmkQ1KW67m866y0zT+Q==
X-Received: by 2002:a17:902:e848:b0:16c:41d1:19cf with SMTP id t8-20020a170902e84800b0016c41d119cfmr3872775plg.40.1657730200206;
        Wed, 13 Jul 2022 09:36:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w9-20020a63c109000000b0040d87299ca3sm8248700pgf.54.2022.07.13.09.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:36:39 -0700 (PDT)
Message-ID: <97256a3a-6d54-9d60-06e9-480a8f2aa9e5@gmail.com>
Date:   Wed, 13 Jul 2022 09:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/8] arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to
 ARCH_BCMBCA
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220707070037.261532-1-william.zhang@broadcom.com>
 <20220707070037.261532-6-william.zhang@broadcom.com>
 <3cc9a340-1403-9a90-0d2b-49f719ca31fd@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <3cc9a340-1403-9a90-0d2b-49f719ca31fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 08:31, Rafał Miłecki wrote:
> On 7.07.2022 09:00, William Zhang wrote:
>> Remove ARCH_BCM_63XX Kconfig for BCM63138 and merge its selections to
>> ARCH_BCMBCA. Delete bcm63xx.c as it is no longer needed.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> What about ARCH_BCM_63XX references in
> 1. arch/arm/Kconfig.debug

That one was dealt with:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fa0ef5a086a05306fc5322bbda73459725eda923


> 2. arch/arm/configs/multi_v7_defconfig

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a65ee523a9e41d0bf046cf0107e6bbf05d068af2

patch 8/8 of this series

> 
> Did you handle them in some other patchset?
> 
> 
> This change is probably going to break "make oldconfig" for users. Is
> there any kernel policy for that? Do we care about it? Should we leave
> old symbol as hidden and make ARCH_BCMBCA auto-selected if it's set?

I do not believe anyone but me was enabling CONFIG_ARCH_BCM_63XX so this 
did not have any users until the BCA team decided to take over.

> 
> 
> Finally it'd probably be more clean to first introduce
> ARCH_BCMBCA_CORTEXA9 and then get rid of ARCH_BCM_63XX.

That is fair, however a bit late now that the pull requests have been 
accepted by the soc maintainers.

Thanks!
-- 
Florian
