Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1144E4BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiCWDyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiCWDyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:54:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E52734
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:52:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u22so501049pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i9z7yZacWRkLylWFke4s2mCXFNcEKYyLkuB20g6qhr4=;
        b=WxY6ZPLXcxsQsKaHlhoOZGOvTJwC5ukkQYN8Qyge/CBk/gjRBnaAOxt/6VtXdrycAf
         61xZI7iGBQ+IV3pBuR1yMrOgSyore4TnIzO/1d9Q38M0YlyAZcswdY7dMw9rIIHaYFg9
         6wYsZP2z9JHQ5QBgE8T6+quPCp6dp8r3OalvdzlYmrs2T9XOkhGqgj7AMHcB/wTYXLWH
         Mw5Aj9DVQtRP3/6JutIHaeiEcklidPTpECkAgSxI8busPyasAoiOmRBeSM/vkHjI1Q6k
         dPEabnXDjg1IDJYRsr6fWVb94XpNbTD6ocfop/C/3t2dj/+SbS1sm10a7LMfoEe1OJyB
         qf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i9z7yZacWRkLylWFke4s2mCXFNcEKYyLkuB20g6qhr4=;
        b=KL7MFb4KGcGTFGaR5qVMLWLngJVHEAQP5MZQ7v02o6F9Puymv0TJERBKtAiyb24cc7
         cjkwiyrCnaNAosykUiJJ+VdHEp0ilMs8P8HVi5js9UJkXkGIPFX3xhSy7YU71UwmqObR
         RKFLKZltuDc6uKgfzsumvoJfBjlQB/NA1uYugInThaKS+ov4Q4TmsHVkgh59j09Sz7Fq
         UMsqidDPZqMITnx5TsTIQ418avQ1/2UMlgjqtetbBPSk98gE2STbM9wFsEBYjsbHgN0o
         iB3922TpV8F6QIW2tdw5A6Djm4cMhSuntg1PEvnfoWt5J7wIflk/qlKuYY90/Fmx0cDV
         3L2g==
X-Gm-Message-State: AOAM530d/F2BbcjC7kF0kfT+glW7T/Tfx66tJMw8pTonkY2Bj9EvdgO2
        qfs6K45OiuuGQthe+03rUio=
X-Google-Smtp-Source: ABdhPJwoLc3/fdWlAyUT5xHD+y8U7NQLHTCJiy1S1QZlY+mFEhci9SZUI600gss1XVbDq/thuFChHA==
X-Received: by 2002:a63:ec4f:0:b0:378:d43b:2272 with SMTP id r15-20020a63ec4f000000b00378d43b2272mr23917896pgj.29.1648007554839;
        Tue, 22 Mar 2022 20:52:34 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b001c701e0a129sm4202055pjb.38.2022.03.22.20.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 20:52:34 -0700 (PDT)
Message-ID: <ef8f8d44-5fc6-5f8e-c33c-c514eb455596@gmail.com>
Date:   Tue, 22 Mar 2022 20:52:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drivers/bus/brcmstb_gisb.c : Remove the
 suppress_bind_attrs attribute of the driver
Content-Language: en-US
To:     lizhe <sensor1010@163.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220320064529.12827-1-sensor1010@163.com>
 <CAHp75VfkDbO3J=MgTdRF_UyMvZ9XCJEQcEOUEBuyqEwnrNwbsA@mail.gmail.com>
 <CAHp75Vc5FZ-N68vDhyGhCObUdek6JFccotctH-C5KmZ_boL6Wg@mail.gmail.com>
 <531e91bf.3734.17fb4e3150e.Coremail.sensor1010@163.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <531e91bf.3734.17fb4e3150e.Coremail.sensor1010@163.com>
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



On 3/22/2022 8:47 PM, lizhe wrote:
> HI Andy Shevchenko
> Even if it is loaded as a module, its execution flow is still executed 
> through do_one_initcall(),
> __platform_driver_probe() still invoked.
>       So, this suppress_bind_attrs = true is redundant
> 
> https://github.com/torvalds/linux/commit/707a4cdf86e5d6a2c4fad51fb98a6ff3425f820e 
> <https://github.com/torvalds/linux/commit/707a4cdf86e5d6a2c4fad51fb98a6ff3425f820e> 
> 
> 
>      The author has simply added some descriptions here. Nothing 
> substantial has changed.

No HTML please, and yes I have seen your patch, and yes I plan on 
applying it. No need to fuss about it however.
-- 
Florian
