Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49F4F0671
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiDBVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiDBVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:34:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D54927C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 14:32:53 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id b17-20020a0568301df100b005ce0456a9efso4587402otj.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OuxBTZEviYeN1sMz66IprCGLA9hb5Nx6rXTjFA3rNN4=;
        b=UUdp0QnvOdDZpMvTZD2fAUtdk89HiNaA/Yp846JGS9ftpyaiv+KyFxkWN3p7YHobY4
         pqMhGC74Y2XBx5CKTjugeHhTgTmUdhFNfWyEVO6sw9H+n44jRaj2Rp8b7/c98lgsH6DJ
         zVPH5/hyAibGvwg3+C1ALNT6Kidqo2bUAHjTk0UWXCul/Y7zK/58w0s7O3VriASM6AzQ
         /7UDPNc4vQVxnU54ZLvBgh93Mhr+qcyE8SMcID83HmwxTgAqedCzQLQr3psnOiqp/hFQ
         OuS977nP0gfGHjGtVs9FAm/A6BhgeWLXxLtRVyEvBAaG+Dj4KtU7UNI/nzN6jR4GvY8O
         MFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OuxBTZEviYeN1sMz66IprCGLA9hb5Nx6rXTjFA3rNN4=;
        b=R415fpfK3gpqkU6wjxh4TUiAt40eDRtHndEIBVdiGOz5ZT1bZlaxpC287B8PWjY7r5
         miuQh+cW0h7AmEVMPIw3LVDfa4tYSYUxo/Ho49ODzBkfvLaLonLjGTkTbK8Lz4XhUWUa
         dMffUn/sLpaxHzQmCF187q2S3V0MKmJAgNrx7UUZ5To4bbaoJ/cwGw6uKbdh6ZvTTq1R
         BMfO4UMAU/S+hDRoLluKac+TV/rUn9/tEBlN9RfoX/TvLtWDsDqmLZEzHMc4fzXmyuLg
         rP4HOKw7eL9xYh+1HLS0ZMPJp9IjoiO68/g3KU8TzPWNp8vuUXbwsLYMKVNm/CL3KcOJ
         GTKA==
X-Gm-Message-State: AOAM53137jRoGkrN3VlvHxo+3ZBhPvA80LUdQuVX2Sa2k9EDZwAi+WQK
        I/IDWuKdVZe+gp0llGF7z4g=
X-Google-Smtp-Source: ABdhPJx+JbqluJ9nIsvXP1fqha9EZvzEFi/2FGjrQlYIN7fB7NULUTOKPgOSoyZ8PaSoP/dTstmeTA==
X-Received: by 2002:a05:6830:1484:b0:5cb:4a65:c91b with SMTP id s4-20020a056830148400b005cb4a65c91bmr9769156otq.121.1648935173030;
        Sat, 02 Apr 2022 14:32:53 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm2443817oou.10.2022.04.02.14.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 14:32:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d9c7a2ba-288a-d81a-cd59-5b002489d821@lwfinger.net>
Date:   Sat, 2 Apr 2022 16:32:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 15:47, Michael Straube wrote:
> Hi all,
> 
> smatch reported a sleeping in atomic context.
> 
> rtw_set_802_11_disassociate() <- disables preempt
> -> _rtw_pwr_wakeup()
>     -> ips_leave()
> 
> rtw_set_802_11_disassociate() takes a spinlock and ips_leave() uses a
> mutex.
> 
> I'm fairly new to the locking stuff, but as far as I know this is not a
> false positive since mutex can sleep, but that's not allowed under a
> spinlock.
> 
> What is the best way to handle this?
> I'm not sure if converting the mutex to a spinlock (including all the
> other places where the mutex is used) is the right thing to do?

In drivers/net/wireless/realtek/rtlwifi, we had a similar problem. There it was 
handled by putting the lps_enter() and lps_leave() operations in a separate 
workqueue. In this case, the routines were rtl_lps_enter() and rtl_lps_leave(). 
Each of them sets a variable to indicate whether enter_ps is true or false, and 
schedules the workqueue. In the workqueue's callback routine, the routines to 
start/stop ps mode are called. The code is in 
drivers/net/wireless/realtek/rtlwifi/ps.c.

This solution is only one of many, and there may be a better one.

Larry

