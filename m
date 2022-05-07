Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0551EA85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 00:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379158AbiEGWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 18:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiEGWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 18:32:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D60B1E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 15:29:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 16so13014343lju.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=29mmpw9oHWZftwf6PSHqPToRdFpEollKDtx2EGQfLno=;
        b=5z6Um3Do2czICqz/SXtnSq5Zm4qqMWHDzuXyhdzax5Ql7L7Agly/lwrgTBpTNk0CHs
         0G2qdeikWTJQhuO+pOZArQov36vAb2wXdXQoZcg6tD3PBv8KeLQSMlTQtRSMDBsrCo9y
         p5busCOoIw+btO/ZphTtwnEkCrQ6a7NnmpQ8lsTIUW6P/dDHlSV1XhaelaSMuoClt2Xv
         9q6UFyFVEllJDZ0Gm2y8asHjRLHihFRqavCYxnYV19Tn/X++PW1eDbQPWVjjbpvJX8S7
         /roRJnSvkNJUkLTBFpJAvzquJ1qQwNioJYecAw8csWpNTaWl1xod1BL9BetIyR4VqzJ3
         MfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29mmpw9oHWZftwf6PSHqPToRdFpEollKDtx2EGQfLno=;
        b=PsVjUmEytZcNR83NSO8TMy20qbAM2HKZxJSxSTEkzzhBhBtBy4nTZwxoMXyYVEcft0
         UjpR6s0gkj3WDeEJdUkZR9NpEBG2C/ixYP+DzQCKE7blYzAYgQXDvsieOKqqpl6EEc55
         /A0pIapTVxJWUYOsOQv9XFiyyk1fzydpupB+hdJZtFqx5SzlQ8nzFclC3k9gsOKMfbOA
         dK7rppozdnZnhRK8Ww8mMrK2q1DZyfcja9CIxjZpAD6rxlDZ1NuIJp1vN2LDVoutXoye
         sj0s2+PcfaoSPyVga7sWkyC+VeORuHc1j7w2d4VEVIctez29hqva6uwkPB8CGfsYzLy2
         EYFg==
X-Gm-Message-State: AOAM5303E8RFXGAMRdzSG9YhvO5ZhJHH5GPsBVhKDm9Q1iNtP7lnFOif
        Wvta4iEsUff9YwnfagYxv2oaqQ==
X-Google-Smtp-Source: ABdhPJxXTQV2ogqQz9qNuvLeWR+WTkQMh2Gl3I9Ro58yRsNlhwVkfX/KfJneP86+8zZtKtio+0cAow==
X-Received: by 2002:a2e:9944:0:b0:24f:1286:c318 with SMTP id r4-20020a2e9944000000b0024f1286c318mr6187060ljj.146.1651962540100;
        Sat, 07 May 2022 15:29:00 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id p21-20020a05651212d500b0047255d211dbsm1271401lfg.266.2022.05.07.15.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 15:28:59 -0700 (PDT)
Message-ID: <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
Date:   Sun, 8 May 2022 01:28:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mm] tracing: incorrect gfp_t conversion
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
 <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
 <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/22 22:37, Andrew Morton wrote:
> On Sat, 7 May 2022 22:02:05 +0300 Vasily Averin <vvs@openvz.org> wrote:
>> +	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
>> +	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
> 
> This got all repetitive, line-wrappy and ugly :(
> 
> What do we think of something silly like this?

> --- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
> +++ a/include/trace/events/mmflags.h
> @@ -13,53 +13,57 @@
>   * Thus most bits set go first.
>   */
>  
> +#define FUL __force unsigned long
> +
>  #define __def_gfpflag_names						\
> -	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> -	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
...
> +	{(FUL)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> +	{(FUL)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \


I think it's a good idea, and I regret it was your idea and not mine.

Should I resend my patch with these changes or would you prefer 
to keep your patch as a separate one?

Thank you,
	Vasily Averin
