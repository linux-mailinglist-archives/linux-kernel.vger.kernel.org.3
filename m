Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264D4A4FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiAaULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiAaULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:11:16 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F6C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:11:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q204so18442422iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k64OavSxFZEHl07By0XQonH4BDXkrFVTNJoNMvwkj+E=;
        b=ANrt5tcRj4Kvndc3+2h/PvviNNvoAKmSVxPQcDMwylOWcEitCeEM8O8qyeAgWyokpp
         rc+Eti2LzM3x9Uaow6SLxrcvW+8mZQtpFEc1ncJN33nqCLVzSSkArxQhtZBuN4t3gfJM
         dGOEnz8wX0kDaDLQNDG6WZ/oEY1eUkHpcbwq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k64OavSxFZEHl07By0XQonH4BDXkrFVTNJoNMvwkj+E=;
        b=IKus76hCzR8TGyaU3DH7MKmChDmx3qVq2iKAVHxf97NBPLNVdPDEWYD1vguHT9Pa/d
         g4c2HPI5DbPmbuq8xpmyhhvKVhoOtCfkRMvnZpWxgQUeZXlMkxfzggf6GjpvTe4h+3Cy
         l72qFvXk48uZ556JrP4j/gagBAuamkjsd6BXCwFJ02tQcUBVe+s2tkMxHJOwaUSHxaar
         zMrwkkNWLgzwlluL53Qpm1u2aOF8gI+90GxCCO1/W8JIzRcK1V3AHb5mv5UOPIHbK8De
         6gdyFrq4dLs2WwH56OkI4WNuQXigvRZfCKj/3pjScTP+AwoN7chweySykviUMEmhxDk7
         Rb2Q==
X-Gm-Message-State: AOAM531LwAhncBmNMfl6Zydl1FgToy6QdCe/5zE1Nthi3cdf8jS5QNr+
        W0awRTrBCqd/nrIEXcFyv/4J974gLTLIZg==
X-Google-Smtp-Source: ABdhPJyjE4MvGxt3CpB4gBYLs36h7n8t+wrFm8HX9yFVnnrL/FMrF+hY/wqbupMBB/CTQQkFG42Egw==
X-Received: by 2002:a02:6d48:: with SMTP id e8mr11831187jaf.270.1643659875404;
        Mon, 31 Jan 2022 12:11:15 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h3sm3250133ilj.81.2022.01.31.12.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:11:15 -0800 (PST)
Subject: Re: [PATCH] rtla: make doc build optional
To:     bristot@kernel.org, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220131201030.446407-1-skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e3e1f013-a6aa-fab6-3c08-5909b234ce22@linuxfoundation.org>
Date:   Mon, 31 Jan 2022 13:11:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220131201030.446407-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 1:10 PM, Shuah Khan wrote:
> rtla build fails due to doc build dependency on rst2man. Make
> doc build optional so rtla could be built without docs. Leave
> the install dependency on doc_install alone.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/tracing/rtla/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 2d52ff0bff7d..7c39728d08de 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -59,7 +59,7 @@ endif
>   .PHONY:	all
>   all:	rtla
>   
> -rtla: $(OBJ) doc
> +rtla: $(OBJ)
>   	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
>   
>   static: $(OBJ)
> 

Sorry - please ignore. Picked the wrong file to send.

thanks,
-- Shuah
