Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19F4FE49E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354537AbiDLPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357053AbiDLPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:21:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB25FF0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:19:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so32712817lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PSN/G7KoRGQAWHR4F43xGgEd8OPfGRRXsI08IvJD1iw=;
        b=i4SdmqPVAwCqWESWwmY6MXcUpY1VZFR2pdu7XSUg9+IOVt1o0bHs7m+/oz32NtwrhY
         j2CHxlntzJri+QTf/5esfdtWT/Yjqdm4ODWzvSF7QMOhavynjxTqRzr21KJX4y0Peofe
         MF7PxvB7w8bI1SiInG0DYbec8i/KE90EyWy7N4luk1pdmwYFwilKMQzVtHCyZXoMMQtc
         YVStWP97a8WXTff+ptMrI6pMRKxCBYQ1N88CPkx7lfgFAk5/ZUyDq9GyxYBCjmGJRxwm
         UIfihpHfVeOAILqaUlv5Sf8nnK+H6bwHondzj6rQjSIO0/rmF8PYofc9gwUsoAKnfGtt
         J9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PSN/G7KoRGQAWHR4F43xGgEd8OPfGRRXsI08IvJD1iw=;
        b=AzKhSJyImmduZy7nKYUWk+EMDQsNi1xv9QMnI/bd/MnpBdZQjxpOogIHbkF16qByTf
         r0EFlNELCf3IGMNkuI62hHF5KKFX6apWXc2wFyggdSYm5NYxsnhn7MdycjN+Ns+rPOJc
         zCvnz/pjyFgPDaov5csn86NGM96lRQ8YgP3XhuV+bLWy+mkQJeyV3jcr8c/i1BelnDDO
         WiT2qEuSp0xxFA+d4XHdubOwtGgbQhB0Dc+OYBtYg+R+KQzmP1MtkJlcTWBXvoul1YAY
         GUP89/vqDTVr1RDqYuMeXOI/HMt7gG8OGx3NmjfrYsNyavSeh8EgiaGDn5lbbERT5BDA
         Iwgg==
X-Gm-Message-State: AOAM5309vE+xghp+Zgn15tc11QTVf5C18Wfq5niqK33InZ84846xqW6d
        FTWboeLIDYI1JkgTziyw2hE=
X-Google-Smtp-Source: ABdhPJxCm/oN52YYKUHdQ98NAwlPo+Q75+UZ/FEhNqLjr1fqzc6EKelA9yoG80pZqkUHXfy/qTduPQ==
X-Received: by 2002:a05:6512:c01:b0:448:6aec:65c5 with SMTP id z1-20020a0565120c0100b004486aec65c5mr26121654lfu.193.1649776768427;
        Tue, 12 Apr 2022 08:19:28 -0700 (PDT)
Received: from [192.168.31.104] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id l13-20020a19494d000000b0046ba0e38750sm876671lfj.3.2022.04.12.08.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 08:19:27 -0700 (PDT)
Message-ID: <7d6893a9-01d2-e1ab-06c2-745aa8bcd2b0@gmail.com>
Date:   Tue, 12 Apr 2022 17:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ipc/sem: Remove redundant assignments
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
 <YlRNmXucZwNasoFq@thelio-3990X>
From:   Michal Orzel <michalorzel.eng@gmail.com>
In-Reply-To: <YlRNmXucZwNasoFq@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 11.04.2022 17:47, Nathan Chancellor wrote:
> Hi Michal,
> 
> On Sat, Apr 09, 2022 at 12:19:31PM +0200, Michal Orzel wrote:
>> Get rid of redundant assignments which end up in values not being
>> read either because they are overwritten or the function ends.
>>
>> Reported by clang-tidy [deadcode.DeadStores]
>>
>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> 
> Thank you for the patch! This should go through Andrew Morton, now CC'd.
> 
> For the future, having some history behind the origin of these warnings
> would make review a little easier. I'll comment on each below.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
Thanks,
I will keep that in mind when sending other patches fixing static analyzer findings.

Cheers,
Michal
