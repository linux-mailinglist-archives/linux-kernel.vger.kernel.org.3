Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4170557130
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377618AbiFWCwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377600AbiFWCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:51:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E143AE0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:51:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1225359pjr.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lIFW9cAuPlwQZ+C7VMU14IUSbtewdAOYVyCoJAKjzlQ=;
        b=Puw8ineJwyWfy8K7QUYI04Wr8Nb2t3lWIHkFlB1hQQLzT5swZYV1wxZgu3zdmjVfn/
         L0HlSvtZI7htiCUE58+bs7E4/4+tXAl4qPsIqzEL5CBx2z2FY3FCEiyOZy4dNWbEFGfJ
         ublFUOJMhKzwCTubtZVlrCy4E/Nj68znJFRH22pBgRivO+6M2+5YmEof4fmthJB7pQ8J
         kUm32nyX6wMxLFRWHwDB2kb0DFF1JqhQvwdym6WuLQDI+QPltciJAr3kqmKG3RZ4UMoA
         yDoPULmJp2SmYl4/CECuVR+sWJJTkK1B1xyYqgojOt/3YvgnoPXmBGlVAYVPTb/tfVNC
         E1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lIFW9cAuPlwQZ+C7VMU14IUSbtewdAOYVyCoJAKjzlQ=;
        b=Mwsg3QxelWofyilP7/TtII33NFWak1yVapq6Q5YC8FlBpd1dJWxUwEy5I8obf90zX7
         JFIJmTynpOG50I30OGtxmXIjuw8y8APlGrFcBTu3/LHnG1RQ8fpBnghX1CNTb6e9TfgK
         t+K6NAMIetfOOH8ZZlITn3rBhdO5Cm9LNpLV/0dWkaxjE+w7vzvHrJJ0gaPmcjUv+71s
         FQiFR941t1lZmIXh4dyKVj3/bXudSh4iVLKje20tGIipgiSM8g/wwfVynWOt5OeMSlH1
         xulvbn/f20YIeg95HwLMheGpmEUNympBZSUmFaHIsmfW0tlqE5Vk7JFxupmPNDXXSCLC
         9/hw==
X-Gm-Message-State: AJIora9wKnfgypSJJIM9wc4HXGDJSxjwRC9l7sKLPA8F+d/Gb8HzPm9o
        1V/wW0lKuZW1GMdVy8bLa0Q=
X-Google-Smtp-Source: AGRyM1tGh13XWNJDm/Ne6cIvj9Kvnz3BzixxtTYVsFdR6x6xDxp58nyO22rT2LXODqdOE+tQ9eT2JA==
X-Received: by 2002:a17:90a:8d02:b0:1ec:a006:ea13 with SMTP id c2-20020a17090a8d0200b001eca006ea13mr1595429pjo.229.1655952706208;
        Wed, 22 Jun 2022 19:51:46 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b00166423df3cdsm13510665pls.209.2022.06.22.19.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 19:51:45 -0700 (PDT)
Message-ID: <09ae5fd3-2276-5d76-a0bf-46dbffeeeade@gmail.com>
Date:   Wed, 22 Jun 2022 19:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARC:kernel:Fix typos in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        vgupta@kernel.org, Julia.Lawall@inria.fr,
        deng.changcheng@zte.com.cn, libang.linuxer@gmail.com
References: <20220622075204.35329-1-yuanjilin@cdjrlc.com>
From:   Vineet Gupta <vineetg76@gmail.com>
In-Reply-To: <20220622075204.35329-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 00:52, Jilin Yuan wrote:
> Delete the redundant word 'call'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>   arch/arc/kernel/smp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
> index d947473f1e6d..6c22a53711e9 100644
> --- a/arch/arc/kernel/smp.c
> +++ b/arch/arc/kernel/smp.c
> @@ -393,7 +393,7 @@ irqreturn_t do_IPI(int irq, void *dev_id)
>    * API called by platform code to hookup arch-common ISR to their IPI IRQ
>    *
>    * Note: If IPI is provided by platform (vs. say ARC MCIP), their intc setup/map
> - * function needs to call call irq_set_percpu_devid() for IPI IRQ, otherwise
> + * function needs to call irq_set_percpu_devid() for IPI IRQ, otherwise
>    * request_percpu_irq() below will fail
>    */
>   static DEFINE_PER_CPU(int, ipi_dev);

I'd prefer to have this is the other fix in a single change. No point 
increasing commits for trivial things.

-Vineet
