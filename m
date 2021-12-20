Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849F47A96C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhLTMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLTMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:22:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:22:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so6526989wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TSCuxY5wqMw0R+REWpFrewafdOovZ1sGHeMcm+IFJO8=;
        b=LW1kmrl01uNavpeUR+eQGG79Lhg+30st2BcLbsxDBjDezq5+dvLIkE0dW6y6YSHbFg
         evIVqfSTj9XOXN6oRFpoVGG8nvmjXUfZ0pVOmgYqNRc2EuYLCnbhQFXR3IAeb7ea1mCQ
         XVxs0nWfyF7vylGFUP7vfrCs39PmyC8o6RVRKLzVUh/fHhpBPqLHRkGc03tLJkkEnw3F
         lAxstS5F+E6tRFtRQuO+YPf+UT1M+BH7HM5W/m3YidHsLg4+gIjIBZTy7ddpUH+/RcBn
         cJYvrAGpYvvLysHrOqAlAEZ+/o55Maqnxq4vxDZrX+PxponvFtKqFk4fUS1FIiiDMu+9
         oZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TSCuxY5wqMw0R+REWpFrewafdOovZ1sGHeMcm+IFJO8=;
        b=faHYE6ttFRQoxeUAuMiW2HXF4OB/f3c4J1pUS5aDw8MtawDlIhsKFaZM4MIiPKs+uJ
         hDmDeHM34ZmkNn9OpvuFZQE94IiyPJWaNV0Y1aK0wAzSz50C7FyMiLhXMgcw+5YWzT5T
         aI/7DHz4LiG/nn0v7jDrhd0zuIpSwS4QT/LwtBp+rvX3ZNfvjrxSxZFJAYVcH/4xDRat
         JLfcud5YgXO0P9StHES9gAX0kUNfZNDecqvhMB7fGiMG6vMB10O79VK3fXNw1dFcCzdJ
         HWvN/QvJPAPUJQN+xT6HeD4E7wgapK580ScLF3OLCyYKJSkZklIGGjmG+He+hovH9nd+
         rKlg==
X-Gm-Message-State: AOAM5312OeTJlBcWKNYDWruYzpfn09JDLfzSHw94uwu2SQAanKcabu+1
        08NhR7AUBg7QTrEaUSoPcAAK7L6Con5Fow==
X-Google-Smtp-Source: ABdhPJwUebx4frNTkSpn3y/kryQAmzKe+4PoR1IZphY1WuZESeVcxGZ8e0fuyeiupuhBiP8RI2yZVQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr13754698wme.136.1640002957948;
        Mon, 20 Dec 2021 04:22:37 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac6:da31:b84c:183? ([2a01:e34:ed2f:f020:ac6:da31:b84c:183])
        by smtp.googlemail.com with ESMTPSA id j14sm15234410wrn.88.2021.12.20.04.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 04:22:37 -0800 (PST)
Subject: Re: [PATCH v2 0/2] dt-bindings: timer: sifive,clint: Miscellaneous
 improvements
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <cover.1639662093.git.geert@linux-m68k.org>
 <88170fb7-f348-1227-cf8c-863306986917@linaro.org>
Message-ID: <7269ab52-f80b-001a-abf4-cc4744747450@linaro.org>
Date:   Mon, 20 Dec 2021 13:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <88170fb7-f348-1227-cf8c-863306986917@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 13:20, Daniel Lezcano wrote:
> On 16/12/2021 14:43, Geert Uytterhoeven wrote:
>> 	Hi all,
>>
>> This patch series contains two improvements for the SiFive PLIC DT
>> bindings.
>>
>> Changes compared to v1[1]:
>>   - Split in two patches,
>>   - Improve patch description and document limit rationale.
>>
>> Thanks!
>>
>> [1] https://lore.kernel.org/r/20211125152317.162958-1-geert@linux-m68k.org
>>
>> Geert Uytterhoeven (2):
>>   dt-bindings: timer: sifive,clint: Fix number of interrupts
>>   dt-bindings: timer: sifive,clint: Group interrupt tuples
>>
>>  .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Please resend the timer bindings changes, the GPU and NAND controller
> series are confusing the b4 tools

Never mind, I just noticed the V3 ;)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
