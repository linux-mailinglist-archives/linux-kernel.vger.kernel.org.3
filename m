Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09B533ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiEYKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiEYKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:46:30 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4D3883;
        Wed, 25 May 2022 03:46:17 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id s28so29406746wrb.7;
        Wed, 25 May 2022 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q9O1OGub18poRLHhomCuCLAnpIgun6gCJciHoCwZhXQ=;
        b=wA/YoIextkItkfmZItfuS7mejwxz8PsmEAKDT4vZx8EpiRHx1TE8gFkLmtX9xheRc3
         lK5I0eUiyUKznBvKrM7SH+UgwyXhcoyIB6XIcIUvO/ziJGM2c98Gt+1q+F3U7g3gRgJ8
         LVYhMIAUUK4PVtoICjP224JC6a9m+RR3JJPS+DzwQ+2YDdQrTAUWL1tTGDQxh9WTBnVQ
         vwLTo/ozhziXa95gH/K2rFR21SnYalChKlM3KNvAXoRDKA893YMhTOUiPUwuFRhHNE0M
         1+HbRL4weXl26dZWHv2GekwdHogexfuZWuLgxFZayXrPO/OXY+VnjafyXDRPeikKjtFG
         OMlQ==
X-Gm-Message-State: AOAM532XuZTFeb+6kIXgOGq5zzgN1ZyWYcaujBL86lVNcZy0yy5Ufgsf
        3X3iaXxPlcGixlH+Q8kDmzg=
X-Google-Smtp-Source: ABdhPJwhLX2ksgGaO2ZVtVM7fwP7bpSx5WD8AGN1rT0/bqTlC+CbpGatSQsTaU+IqjT+1iHA5Laoig==
X-Received: by 2002:adf:e0c3:0:b0:20c:5672:9577 with SMTP id m3-20020adfe0c3000000b0020c56729577mr26101094wri.466.1653475575536;
        Wed, 25 May 2022 03:46:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b003975c7058bfsm1895136wmq.12.2022.05.25.03.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:46:15 -0700 (PDT)
Message-ID: <e17cab70-66cf-492a-fb8a-dca091768345@kernel.org>
Date:   Wed, 25 May 2022 12:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL for v5.18-rc1] media updates
Content-Language: en-US
To:     Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
 <Yo3ddVHgBBlvJEdh@gofer.mess.org>
 <8093277c-5098-e5e3-f606-486de5b2f67b@kernel.org>
 <Yo3yfIim58IWf64z@gofer.mess.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Yo3yfIim58IWf64z@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22, 11:10, Sean Young wrote:
> On Wed, May 25, 2022 at 10:09:38AM +0200, Jiri Slaby wrote:
>> I don't understand how inability to build software is not an uapi breakage
>> -- care to elaborate?
> 
> So here is a good compromise suggested by Mauro.
> 
> 1. We add the following to the lirc.h uapi header.
> 
> #define LIRC_CAN_NOTIFY_DECODE 0
> #define LIRC_CAN_SET_REC_FILTER 0

The code would do "if (x & 0)" or alike, so I'm not sure this won't 
result in a warning. But as soon as that thing compiles, I don't really 
care much. If it produces no warning, in fact, the code could be 
optimized away out thanks to "& 0".

Just looked up those defs in the debian code search, only lirc and 
v4l-utils care about the defines. ANd the latter seems to define their 
own copies.

> 2. Since lirc daemon is unmaintained, I am happy to take on maintainership.
> 
> This may require forking, depending on what the maintainer says.
> 
> How does that sound?

Great.

thanks,
-- 
js
suse labs
