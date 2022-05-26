Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB07534C27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbiEZJBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiEZJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:01:38 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D71D91;
        Thu, 26 May 2022 02:01:24 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id q21so1836309ejm.1;
        Thu, 26 May 2022 02:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8QDaO4aB7hVic6zw+bEVhFdtYbIuED8UQISkuSXvfx8=;
        b=RDxJcPs6PmagRPzAOPPfXKWVSfpykxw7RbKNYX+tiBVATB6uPtuVL8gVMs7+iFoVtK
         EDnVwsTDtlEHap1iPGZMnjwm27vJ5Ypn63kbjiumUC/VMhWmrYWeJwMHr9U3t5saYCLb
         eRi7rfVtvmru737tpscAj6sLiH155qouxQvNH+pXxE/iyzWQWiSGkcvqaYUxnUtaWmz5
         YizqW6LRVQghJDwtG76vl4nW4X4Ndf05jpk3XuK/wjOMCCUrAB9xNJiURajHYEv/G9JI
         i0xwgbhgFEN8alAhljKcHzsBeF6f2HzCZPUqIjL4l6sWZFErQ3w8DkW7T2gPnzjQ6dbv
         +D4g==
X-Gm-Message-State: AOAM532xr3Edc4yo2M99TIBmJK61WOCccgeAnuPEGhcfU4wB+cQXf+pn
        zz6iTwo47dQ/Rg/NkSQN8EE=
X-Google-Smtp-Source: ABdhPJw060DUPL2/XBk854PqFJCU+r3TaXXexkgaJC6/wtCx6sdXUSvnVrJ72RvFze4HZl0ICUAFUA==
X-Received: by 2002:a17:906:5d06:b0:6fe:94f7:b187 with SMTP id g6-20020a1709065d0600b006fe94f7b187mr33770241ejt.591.1653555682841;
        Thu, 26 May 2022 02:01:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906501300b006fed85c1a8fsm317838ejj.202.2022.05.26.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 02:01:22 -0700 (PDT)
Message-ID: <e74e2b70-5628-7ed2-76ee-56b663fc3abf@kernel.org>
Date:   Thu, 26 May 2022 11:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] media: lirc: revert removal of unused feature flags
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Yo4qTnYYT+55vlQ9@gofer.mess.org>
 <CAADWXX-rcvHAXEn1PVScSmDf9kZRVf=Z2R3nyEuNdsqL+z3pEw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAADWXX-rcvHAXEn1PVScSmDf9kZRVf=Z2R3nyEuNdsqL+z3pEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22, 18:53, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 6:08 AM Sean Young <sean@mess.org> wrote:
>>
>> commit b2a90f4fcb14 ("media: lirc: remove unused lirc features") removed
>> feature flags which were never implemented, but they are still used by
>> the lirc daemon went built from source.
>>
>> Reinstate these symbols in order not to break the lirc build.
> 
> Applied directly to my tree. Thanks,

Works for me, thanks.

-- 
js
suse labs
