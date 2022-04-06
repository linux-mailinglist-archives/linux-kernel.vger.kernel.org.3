Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3D4F6DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiDFWb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDFWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:31:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D52E264
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:29:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so4253885pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V2ON/Deg2JuKHr5ktbgk30mmYYrzUj3VcrOoWnTHJ9U=;
        b=U25sHbOD7uhr6W2P+Uws+F7mhELHFt9MwgAcHTqBO6PljGO3y3R6bXqX0iJworuuE3
         0U0zaoU9y599dCuYzgAthVLzXkJ9udWlLNQHoHSTl/sf/EEvaMJv701ZWmL0PDLmzatP
         EupnH26pv2qee/8O6bOp/g3fj0X+5dg9/h1BJMoByuSwq+TzW24KfVIJHzk6bkpKYsIw
         bRcmUoWWBhuBOcl36ze/0jFEyhL7FswDQT+3EI/+JCP/ttZ3ZAAzRTf4yCTYDujO4IXV
         nf/JJtNvC7FU8JWoYn2WhNLclfmNxb+/QUHE9PLH0bKxlcFb6mPvQrujv94rTAsIOiNt
         1PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V2ON/Deg2JuKHr5ktbgk30mmYYrzUj3VcrOoWnTHJ9U=;
        b=s4pbcPy02nhVSKhNjqfQcmANED/a0whju8rf+6fcxeavZK5xTUahP6b71LrE+AWofE
         bCTtuV4e4yqah99SJBpx6liSAkoUo4Gps1TXaSW6EFmakswwFGuiYwe4TMdL4EsmP539
         NSfQ/R2lMVGBaNbKgk/iQhT1LMGihCZwFMNJfLAZFWprzoya+gfUk0QDEZP4oM8yzU5d
         fCEUj6BATt/alkfcK4d+5SpU3NiJ8yAljKQWiGuRhjqUZlTtcZ8TZJUQqyYfTMhFwikX
         8o1r4UxzA8CbT8ifTNC+eOlq1jP4+fmXrXWZ0GxZr0PZnm5t1UKH3Hs9k//hq3mB9ZKT
         ISPw==
X-Gm-Message-State: AOAM533pXCwjSA2OBBRHTdhq62c8kx1mMphc/gMq39LCDPLWlYwIMuoc
        ySjmU5j9XPVti2hnGyDqRug=
X-Google-Smtp-Source: ABdhPJyNUcs7GUC+IT/KIrkfzOQb1s4Q8YdGesaFE7LUTPSUOtPAlDV1ZZIfTy6iivXiurGVclHDbQ==
X-Received: by 2002:a17:90a:ce8b:b0:1c7:7567:9f7e with SMTP id g11-20020a17090ace8b00b001c775679f7emr12480088pju.10.1649284166949;
        Wed, 06 Apr 2022 15:29:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:2c1:200:be1c:593c:43fb:d0a8? ([2620:15c:2c1:200:be1c:593c:43fb:d0a8])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm6993196pjb.16.2022.04.06.15.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 15:29:26 -0700 (PDT)
Message-ID: <7bbbf503-01c8-737e-fa25-37a6d89d3354@gmail.com>
Date:   Wed, 6 Apr 2022 15:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220404182236.1caa174e@rorschach.local.home>
 <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
 <20220406153907.GA1994259@roeck-us.net>
 <20220406114654.3c0e17a8@gandalf.local.home>
 <59941012-6eb6-91f3-ac79-cca759fa53d7@roeck-us.net>
 <20220406124645.3a1ce66e@gandalf.local.home>
From:   Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20220406124645.3a1ce66e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/22 09:46, Steven Rostedt wrote:
> On Wed, 6 Apr 2022 09:36:10 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>>> So we have a chicken verses egg issue here?
>>>    
>> Almost looks like it, unless I am missing something. Maybe some flag
>> is needed to prevent the timer handling code from queuing into the
>> destroyed workqueue, or the workqueue handler from updating the timer.
> That's exactly what I was thinking. I do not know all the code here. I
> could try to write a patch, but I may likely miss something.
>
> -- Steve


Take a look at

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=1946014ca3b19be9e485e780e862c375c6f98bad


Ie, use an ->live  (or ->dead) field.


