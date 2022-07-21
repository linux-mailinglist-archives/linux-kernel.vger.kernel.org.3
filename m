Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF757C485
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiGUGdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGUGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:33:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA55245F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:33:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h8so823399wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bdgIUTgWVSqi06RsvNkBcf0051hhAqR9ftkbGQTxG3Q=;
        b=QHn9etkitv5cR1cWD7ChI9jvUxvO7cgTPdf08q64qOEkmxdAYC6wvPX5eDKHSAJBYe
         zVwI7CxMLyoHNw8tobr4GVsZa8YTsipuMlfTFY/GQZ1e172s6JbA7BogfBoxoDTh05Im
         lbwcJp8gq0BVHWXx1F19eeCI/AgVkkDYoViovn3S9whZYfuPhUgLi1a33+w3kwcNMGkD
         8Ild/iTp+fFeKTPJ/Af71jpnsebpNeQ4BQPn/jYwSMjB+RTBz1KFBa6omF78h8Pew5M9
         s75QtB5Xkvfs4tPHHrYAKlpwTZYU1caasNT9QgQzAPynzv4Jw5iXoENIYekAIw0PrFl5
         naSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bdgIUTgWVSqi06RsvNkBcf0051hhAqR9ftkbGQTxG3Q=;
        b=Bd1qKQlQhe0sSA2N1tJgiDqMZSr164WUQtIas+hbwMUt0JlxVZ1BeFf/hhMV3oq6Q1
         somNEgDO7QyWpUVtWu3Wmo6pOthbOoXAC6DvgjdPsjqpcTpFMmcla6E7VZtg7VOwY0C6
         4UzpmHC6Q4tXn+UEfMXdLywFt8TsBmTxx0JCBqwAJKIVm9Po4QsGQzkn9u/YeoGbeeLx
         EXpeZeTtGDbUKB4uW6yCUL+/w/v4aRAzpxAKfJkG1S3JTFrjQ0ArH1p9p1H/Xp57fdB2
         35m9c/Z/ft/uqdv/EK7+qDvhNt8bi4E52Q+YduKp997FAgSaFQE7pSxhG/R0BtykGBjK
         RZtg==
X-Gm-Message-State: AJIora9/EkhKIiyLnzxQGb2ag6j+ApuCZ1vJ2hvh1lQs+5QOnoyAxdW+
        JD/2qoKfKPbW2OMh87Pi/AzW/g==
X-Google-Smtp-Source: AGRyM1tE63WPUnR/TGWgDYOJxb0I5/6yrUMkwd96de7huWM+FU+mvBvxobndCnljMkRIQd0jFCeSDw==
X-Received: by 2002:a5d:5a1a:0:b0:21d:68ce:bc88 with SMTP id bq26-20020a5d5a1a000000b0021d68cebc88mr32330128wrb.527.1658385193022;
        Wed, 20 Jul 2022 23:33:13 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm842644wrv.94.2022.07.20.23.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:33:12 -0700 (PDT)
Message-ID: <f55b4d0b-c9b8-e4b8-9a1d-468f6a22128d@conchuod.ie>
Date:   Thu, 21 Jul 2022 07:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] microblaze: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, monstr@monstr.eu
Cc:     linux-kernel@vger.kernel.org
References: <20220721025158.21856-1-slark_xiao@163.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220721025158.21856-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/07/2022 03:51, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>   arch/microblaze/kernel/entry.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
> index b179f8f6d287..8651fe351276 100644
> --- a/arch/microblaze/kernel/entry.S
> +++ b/arch/microblaze/kernel/entry.S
> @@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
>   
>   
>   /* This the initial entry point for a new child thread, with an appropriate
> -   stack in place that makes it look the the child is in the middle of an
> +   stack in place that makes it look the child is in the middle of an

This is /a/ fix, but I don't think it is the right one for this comment.
Surely this should be "s/the the/like the/, no?
Thanks,
Conor.

>      syscall.  This function is actually `returned to' from switch_thread
>      (copy_thread makes ret_from_fork the return address in each new thread's
>      saved context).  */
