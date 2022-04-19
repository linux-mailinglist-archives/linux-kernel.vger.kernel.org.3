Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFE506783
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiDSJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDSJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:16:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830820F6F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:14:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c10so21564044wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wlU8M4gYS5LeCbtzPJl4Lfr1jDQkU9hKqrRIF5G3bxg=;
        b=xfBb/lHsdTDKx1vyKfgVgZr8dYZkRa8kLsgKvO0VEWybZhp7MDvaSI7vA5rUD/99OH
         hwg4xDKXX0hcabKHmkTqatL/7GY4UzD7z5a9kDnY6kOum8ZJjLBSpoD2WLk/Sia3jxEb
         dsl75hJGGgE+B5uJ+IT0tIseqjm5BJrNki41bVmGRvg02Z2Fb1LkADUgqD0hLkq+IktO
         +2o3YPOpM3IZlEzSQVLQJ5cPTMNQ9ARbdgCwJBQsr6VKq9rzPQyl3KrQ+txpJl9E4rul
         //6m9AJVMRJz7Tz5txeDgDlFxDmt2by/Q/7GAKmVm6WIg7bZ55eahCJroDGOviMHwvKa
         Tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wlU8M4gYS5LeCbtzPJl4Lfr1jDQkU9hKqrRIF5G3bxg=;
        b=TWDUS8dUSgKoTmHe0N5cybo3s0WzHv3MOp3+3e7IxqNuimZrufNyHgqB2m+jWnLMF6
         cVcyX0YzbgUJHeDJmf8s3q+Qj3CGWeEHMMPtTXBpUZ8S4mLifcQy5BfBSG9FvqGItiFK
         3A6RnpPbtwe5wkLXpqFkVNC0iHfsJp7lFxkCDuVUsGAs+YvVfpQsugE2SGdhVvMi9Fho
         H7Rvuz7hXUqSS2YlH3ulGO0VishjkuWjjTLxrUH8TelEnW2JK83gK3asqsn8XwA52lvA
         3ZAZsxBZTr2ihzhnTBhviKr++8lNT1GGbgc0HsF8F9gqMorkqdQtgsNpnG8zXYVKDURu
         xcEg==
X-Gm-Message-State: AOAM5321cNcifj/CugLTO06iFPGkVFy/AEEUko4NjBuub+SKvW8u2E4t
        SYuWqmwafyWR1xPAnF/u4Gctrw==
X-Google-Smtp-Source: ABdhPJwmqs6iWpV/HHJLtIqELMmeNSuCreb+wRijH0qNNwQbANU1kvCkJr1fKTe3rCHUDPiNkxXg/A==
X-Received: by 2002:a5d:5955:0:b0:207:8444:203b with SMTP id e21-20020a5d5955000000b002078444203bmr10922330wri.433.1650359642939;
        Tue, 19 Apr 2022 02:14:02 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id i27-20020a1c541b000000b003928e866d32sm8454088wmb.37.2022.04.19.02.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:14:02 -0700 (PDT)
Message-ID: <01f72a07-6adc-4854-eae2-286786d33aab@linaro.org>
Date:   Tue, 19 Apr 2022 11:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal/core: change mm alloc method to avoid kernel
 warning
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Junwen Wu <wudaemon@163.com>,
        rafael@kernel.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220417125601.18535-1-wudaemon@163.com>
 <a7861e9a6a311f09c03b2e6e47dd4d3283cb58e2.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a7861e9a6a311f09c03b2e6e47dd4d3283cb58e2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 10:48, Zhang Rui wrote:
> On Sun, 2022-04-17 at 12:56 +0000, Junwen Wu wrote:
>> Very high cooling device max state value makes cooling device stats
>> buffer allocation fails,like below.Using kzvalloc instead of kzalloc
>> can avoid this issue.
> 
> When a cooling device has big max_state, this patch can get ride of the
> warning here, but still we end up with the read failure of the
> trans_table in sysfs because it is larger than PAGE_SIZE.
> 
> $ cat /sys/class/thermal/cooling_device8/stats/trans_table
> cat: /sys/class/thermal/cooling_device8/stats/trans_table: File too
> large
> 
> IMO, unless we can fix both places, I'd suggest we skip allocating and
> creating the broken trans_table attr. Like a prototype patch below

Why not create a thermal debugfs with real useful information and get 
rid of this broken code ?

I've some prototype code I can respin to RFC



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
