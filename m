Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287C4C218C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiBXCDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:03:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3B18DA89
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:03:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso4384697pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=znMwX4FScuV+4uHAf4bq87b0ptOrxpv09XpqfPjpHM4=;
        b=RIflPf3zIbeQxP71RJlTLXSqWgApaCmYWXWPjK0Z+lJpVKUXry9dWT6M+mBQYlXHbi
         L0eK3kpX2D90GBGgWV2zir6z2I5Rd2Yl4QSlWuC39DFldjfyUqZNhuGty9zP47jj6hty
         Y0HUBy6uDQ8+OX7JoWM7sZSKGNUthgATbl6tLFf/hzuP5BGkYwGVDWEX1dlknxYi8fFL
         3GFqH37Tu0xBDuayw5/AlF6w4BU/94wzYGZGyZvc652IrbqzUQC5LSN2c6vkSVW5dnA7
         ytDtF8c7XNYYLRqkLZ1exnGgZlv0IWvOZ27rnjCRbtzgp4LVpVoEb3cAIMlgoVCLdWW2
         ijaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=znMwX4FScuV+4uHAf4bq87b0ptOrxpv09XpqfPjpHM4=;
        b=fgVRYVj3Vjiq3KPUp/fIQOMp/j4NKNt9QwJci/9uFi313a5le5//50NBihSsJaYJ1s
         4lL+ebeUUNNZHKS+5uThQ0ugYW2voEyuKEehs0LD/K8zEx5rD2ekhbvXsojdfwf6jSn2
         jSlgaC0v4g/iz11sCjTZLUX1sCAWXjspGbkltJ62+zJad7POuvMwxh3qLqTknvQOQT2o
         4yggXik8LH/e5sAKF3rEn5JVubN5btXzZXiSunu5pTSI4vQuToRWDjyFBB7mM4aTifD1
         eWhzMVzLLOx2WYxcYFN55JZvlKxMoinptgdtvgKaZV77pxRgCKcC2OnNKE8+px/cabsG
         ipAA==
X-Gm-Message-State: AOAM533xSFmOGtwMWnCZQ0l/QkZ1CP1T/YfVAJNWrX80WD36fmvOrPO6
        XknTBIWIM1DRgN5ZWN93XmtZHg==
X-Google-Smtp-Source: ABdhPJxBK76e2gZc4yflwe2Y79j/oOrDnEdfK8zQN2xb8IkCIH0K59TSCXfiHV3Vyr1AE0t+ZO7GSA==
X-Received: by 2002:a17:90a:a382:b0:1bc:202a:28e8 with SMTP id x2-20020a17090aa38200b001bc202a28e8mr12204134pjp.131.1645668199753;
        Wed, 23 Feb 2022 18:03:19 -0800 (PST)
Received: from [10.70.253.117] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id q91sm739890pjq.36.2022.02.23.18.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 18:03:19 -0800 (PST)
Message-ID: <843a1a8e-51a6-3e96-b380-9f3fc28a2321@bytedance.com>
Date:   Thu, 24 Feb 2022 10:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH] arm64/ftrace: Make function graph use
 ftrace directly
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
 <20220222105218.28e3d5aa@gandalf.local.home>
 <5d64733b-8d2a-4928-c4dc-ce4f3b5fc561@bytedance.com>
 <20220223203001.1158d9d4@rorschach.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220223203001.1158d9d4@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/24 9:30 上午, Steven Rostedt wrote:
> On Wed, 23 Feb 2022 16:00:27 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>> Yes, it would be better to implement DYNAMIC_FTRACE_WITH_ARGS on arm64 too,
>> and this patch just use DYNAMIC_FTRACE_WITH_REGS to install return_hooker
>> for graph tracer, so it's a code cleanup, no performance optimization.
> 
> I'm worried that a clean up is either breaking the design or hurting
> performance.
> 
> You have:
> 
>> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>> +{
>> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
> 
> Now, technically, arch_ftrace_get_regs() is to return NULL if the
> ftrace_ops was not registered with ops->flags |= FTRACE_OPS_FL_SAVE_REGS.
> 
> Which function graph does not do.
> 
> But this is in arch specific code so you have more control of this
> "undefined behavior". But you really should have a comment saying that
> this needs to be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
> 

Ok, I will add a comment noting that.

Thanks.

> -- Steve
> 
> 
>> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
>> +
>> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
>> +}
> 
> -- Steve
