Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C6F4BCFC0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiBTQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:21:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBTQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:21:05 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B03286F9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:20:44 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u7so3789184ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sd+XJEjoSk98m94XHap1yquvW+LhGst3/uvY4pex7eY=;
        b=CUU6jJZ59N80XBO9QMe3zzHcDlslYWwHcHUQuhy1naHQ6ceuEyX6viGzkhGwANpZO1
         Cx/Jzb6uiVaqcl8PE1MYieWd0r49rQVXrmISXDm+5SJuYZcagzlerPTBNn4hz0nuXJ7O
         g9X4ZKdRCgzYWaSKIk2dx3We4FEhvRZihEqfXPgr5YYKLwdepw8ijcfnS+ZBrXzYxeiq
         VLaSQ/Bsmq450iA1E/NBFBaCijTgMgJMhOhgijuHY3w2GMkEy4kip8kduTuh8Lv8+x+M
         r9n4Ts1Yljzx1IDk9hLt3zV/YLYXyy2qC/wuZwFylnpAmk5UMCEaURHMEjPeeJhq6Q+t
         sNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sd+XJEjoSk98m94XHap1yquvW+LhGst3/uvY4pex7eY=;
        b=pOcwqAlVTqmNgU3CWkKHj5AyrNvvvui/A0FLXCO0n0tUsixxciUYsDIfmuksksxz1Z
         6XkGpvahDT6LAWHvdzGUXnqAre6OGmdSwfsg6RthYu0xVQ5UQLFtydNBCbGVmVW4TSqC
         xOphcQwQvZ0KEBFkluwKhv863lyATu7Z8QnylDVD+S7QyXQTqeviqX3UGo0gg40YeYBX
         nRlBsiPwMuPwuteDrmVg+uJVBDDswha2UEz4qH8+nvlrtod6MFwBn8zoKJbWAc3KCIvX
         /1BEou/6oLAnkjYECjA77gm7qQTWUvXK9v9ppM1N4rSarCRNFnWKxnwxYklxxEIO7BEV
         8PXA==
X-Gm-Message-State: AOAM532iQ6h7Nj5noamURpbgpYAX0Jv2SaPYx1lRiDsLLWbw5TkLsoN1
        fv+FM2adXxpdZ0CmcqGjv6z3qiTfryk=
X-Google-Smtp-Source: ABdhPJxsetL+pqqLUYYVdIzCRdgBnVRU8O+CpeOX+YgF2EGcqlIfAmc7XTewMg9KJdrBuDQYtlRHyQ==
X-Received: by 2002:a2e:8890:0:b0:23d:1f76:aa with SMTP id k16-20020a2e8890000000b0023d1f7600aamr11835511lji.222.1645374042225;
        Sun, 20 Feb 2022 08:20:42 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id m8sm1040813ljb.131.2022.02.20.08.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 08:20:41 -0800 (PST)
Message-ID: <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
Date:   Sun, 20 Feb 2022 19:20:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220220154847.7521-3-straube.linux@gmail.com>
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

Hi Michael,

On 2/20/22 18:48, Michael Straube wrote:
> -static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
> -
>   u32 rtw_ch2freq(u32 channel)
>   {
> -	u8	i;
> -	u32	freq = 0;
> -
> -	for (i = 0; i < ch_freq_map_num; i++) {
> -		if (channel == ch_freq_map[i].channel) {
> -			freq = ch_freq_map[i].frequency;
> -				break;
> -		}
> -	}
> -	if (i == ch_freq_map_num)
> -		freq = 2412;
> -
> -	return freq;
> +	return ch_freq_map[channel - 1];
>   }

What if channel has wrong value? The old code returned some default 
value, but with new one we will hit OOB.





With regards,
Pavel Skripkin
