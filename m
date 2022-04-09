Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A754FA924
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbiDIPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiDIPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:09:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79CE3D494
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:07:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p25so4134717pfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1OhROX9BLIg+33Nd7m0ZiUo9nfM9qfLM6rAZR4231lg=;
        b=p2GGygpLp2VZ7J/NPDegfHr+Z93VwPpbxFli5Z2Xvj6W4vh2WqpowY91mFKa6wQ4iE
         ezpqJeb0T2uijQHGF9PI8OuNZrNYy9JLNMIh8VPNxaJTjdYtkfW3ZhFMR92TbKwG1wXt
         +cztJjdbtL7E5UsoJAHQl6Fk9NRXHlDp8AebepNEPJZx77cwfaziU7o1ebrv/cQX32No
         blxd8IuT2nUTAOCBEJw7zDyRt/h/UbszSXv+5rbcc6CavgFNT5ihuQHqVhdOCjcbmctn
         mB+X9hTum+gkGKAIPw1Zfbk1rOHWcfmkayXFPyM7mbf11oytWldpfYE0y9MU9bHYJYaJ
         97Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1OhROX9BLIg+33Nd7m0ZiUo9nfM9qfLM6rAZR4231lg=;
        b=M88JAwIAE5WyR/panc57XXcs0ELI6GaZmdJT7IujIiQAzjno7J7tuZt6O0CccDdnk2
         qI05CyGHsYz1kS0Hwq8k/Te+CXcaeaITyAKGfXUeove6Ch7V2xqoZnj0bW2i/wsZNV8K
         uxUiG2khwO7HzT0U/wx9dIZxj7Yea4tcRZ5YDtQRl9NFHn7J5Rs55yv25XmBw8LQ2CLm
         w73v1bPMf8shpH6S04ndhu5cUOBillL+ASNuPAcuntu6KnsYR+4i+G5aMCrFWh+zzmGs
         NQgOc4aOoEU7rjTg/eQMSxICVksSNZHecefsVgTXon4NGzCqgYe6+jeWGhdaDpfLgJcj
         haHA==
X-Gm-Message-State: AOAM532HCCxw3xDtOGKYv7EJVfJ+O+SuLAcSLM4rpeEe5T1Klr8M2WVg
        o0K4Osjl6ktTf08hO4RZGpSSeQ==
X-Google-Smtp-Source: ABdhPJxJIPcrriNlTD80qc5RrPXlNfxvw7vao+o1CQjuBBafhaoJNHF6E6pH8Gd7sgOLPxvea3qAXg==
X-Received: by 2002:a63:2a90:0:b0:398:4582:3273 with SMTP id q138-20020a632a90000000b0039845823273mr19655313pgq.402.1649516820301;
        Sat, 09 Apr 2022 08:07:00 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:f010:e956:3be0:d6a3:f6ba? ([2409:8a28:e6c:f010:e956:3be0:d6a3:f6ba])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm25056531pgc.80.2022.04.09.08.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 08:06:58 -0700 (PDT)
Message-ID: <1d62e977-2142-e2b0-9d4e-f181ee62f6f1@bytedance.com>
Date:   Sat, 9 Apr 2022 23:06:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH RESEND v3 1/2] ftrace: cleanup
 ftrace_graph_caller enable and disable
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, broonie@kernel.org,
        mark.rutland@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220409085500.4549-1-zhouchengming@bytedance.com>
 <20220409102300.4cfc9589@gandalf.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220409102300.4cfc9589@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 22:23, Steven Rostedt wrote:
> On Sat,  9 Apr 2022 16:54:59 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -2721,6 +2721,26 @@ int __weak ftrace_arch_code_modify_post_process(void)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 
> Actually, can you put this into fgraph.c instead. That only gets compiled
> if the above config is enabled. Thus, you do not even need to add the
> #ifdef around it.
> 
> I intend to move even more code into fgraph.c that is only for function
> graph. I don't want to add any new code to ftrace.c for it.

Ok, make sense. I will do it.

Thanks.

> 
> -- Steve
> 
> 
>> +/*
>> + * archs can override this function if they must do something
>> + * to enable hook for graph tracer.
>> + */
>> +int __weak ftrace_enable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +/*
>> + * archs can override this function if they must do something
>> + * to disable hook for graph tracer.
>> + */
>> +int __weak ftrace_disable_ftrace_graph_caller(void)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>  void ftrace_modify_all_code(int command)
>>  {
>>  	int update = command & FTRACE_UPDATE_TRACE_FUNC;
> 
