Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4A574E64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiGNMwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbiGNMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:52:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9A459A0;
        Thu, 14 Jul 2022 05:52:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3046247wme.0;
        Thu, 14 Jul 2022 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u4ugeqgS8oNiEPmK0faxgp+6Xv1PdPQ5ncM+QcXUeqE=;
        b=fqIP8onwSrBMK89r1MWPkBmOktzH1hgpq8N8F0ThwMUvw8mAnD5jDItek2DQx6dFbC
         HlaWZ9gumc4Wj0Udnpb7pI3C6jcPyueIP97oTabU5ZdmDLRSuOPh/aM+fN/Xz91TYcvP
         Ue1qIjY8ijhDuBwGvhC/rQ2dy7lKVfdhK9Y4ifS6M84ImucYN6cF9MQdjBfvL2S+s0bY
         9k2gDEtsRGXe6KGw+cI66H3KrJA4zsd+vAdQfmCtgihl8T+tK7gU/PafOV9XlDzwOdrM
         Ekf+NjdM/g+rswZBwlIkoHm1pVy7SePhyrpM1q3vhX5NQaqrrc8o3m5eTIe/diRlqxXB
         lkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u4ugeqgS8oNiEPmK0faxgp+6Xv1PdPQ5ncM+QcXUeqE=;
        b=GbXYRSRblxpzdldnJEbrBMqxDq1bi6AwjLw/+A03mKmib2M3CvhJGU/Syt6lirYhwF
         Z7w4IRE3k0ZjnNNlQEkP3/bIggJ8ZLQWBVjBTUhkovsT2oWYUE+l/hM4WsEfKwbLKpzU
         DRgkceZbmK6kKyxN9J+f8JgdcsjIPlIKvK8PAIvhBbvOj+WM7gPnDghV7nBAvIUhyBVm
         c7ZaHqkgx8yASy8sr3iRWI3e1UrxW6Z56ZRsgxbvViILqShIZXVXOgA9qUL4TCVddSz0
         SzZhKJQ4A0xtPmTsdLNZuqZ3M8g5S2YUqJUMPuJRzek1AJYj/yyazg/dSgw1oeRIXU2V
         dZLQ==
X-Gm-Message-State: AJIora9nGalP/2ul7wJM6++bbIwmGpdEDqJf9oAJ0oNjT4leQo7tKXxV
        kW15qyKLCCDzZydI6ERc68wxqjPipvdVmw==
X-Google-Smtp-Source: AGRyM1vJE04BUonkgSjBWmTmQJsaZEMB+yKaEMVvvJmBlJ2tnOkQuR1cQ4E0E8haEL9G76P5zaPIJA==
X-Received: by 2002:a05:600c:1e8a:b0:3a2:ee8a:bbc9 with SMTP id be10-20020a05600c1e8a00b003a2ee8abbc9mr14186371wmb.6.1657803150334;
        Thu, 14 Jul 2022 05:52:30 -0700 (PDT)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id o42-20020a05600c512a00b0039c457cea21sm1962415wms.34.2022.07.14.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:52:29 -0700 (PDT)
Message-ID: <d6aa0c5f-9a7c-7534-1825-d0f4adae5170@gmail.com>
Date:   Thu, 14 Jul 2022 13:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] objtool: Fix spelling mistake "teh " -> "the"
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714102856.22512-1-colin.i.king@gmail.com>
 <Ys/0cXFRssinOqRE@worktop.programming.kicks-ass.net>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <Ys/0cXFRssinOqRE@worktop.programming.kicks-ass.net>
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

On 14/07/2022 11:48, Peter Zijlstra wrote:
> On Thu, Jul 14, 2022 at 11:28:56AM +0100, Colin Ian King wrote:
>> There is a spelling mistake in a WARN_FUNC message. Fix it.
> 
> That was so on purpose... :-)

Oh, my spelling checker tool is not advanced enough to figure out the 
nuances of bad spelling humor. :-)
