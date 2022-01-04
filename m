Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB4484387
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiADOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiADOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:38:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E077C061761;
        Tue,  4 Jan 2022 06:38:18 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s4so42959654ljd.5;
        Tue, 04 Jan 2022 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QmMHi/Yre/UvJNCL2dThOVThw7jS7V0hu2mmbclV+BI=;
        b=jtGF+2+nKOBhGZ2YSUoM0HezwC5/hUsa45eaYe/TDnRf808bphxoMVyzds73Oi1hmA
         REKLjoxwZdEGX3ZQCTa3VzZ/ZKowsQr2j1vkVfqd5k87gw/97PK/atla+tnsEsdfl4r4
         ugM37WDj+x0W6iJO/FeeJpC3w1fY3QzIAN/J0oeZbC73rSI7qvkE4Gp48llEn7G9/MnA
         VqYeAiOV2tWZelm4VQT7iOvEXXUEoVT+fiYyUdA4HcIpdNhNTt/ihTgIflkMBTEobjSm
         2hRHU1COPnFP/koFs737hCFaCsmoT1AyNOZznc6QmeleFNK9WfQWTjQmvgqHGiL3tS+w
         uqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QmMHi/Yre/UvJNCL2dThOVThw7jS7V0hu2mmbclV+BI=;
        b=NF2BBub4+rl7BjbhpWA57VgCExHe/eWyPqfGStAUyESALv8wxtxxJi9xn5y/cLTJg8
         acK+r1jOislWtMzbucq1/+kqD4Xe6Hz9uIop2Zin4HTZxmYJJxh3Y8TrCBBqndtNMxPh
         jQLrd6yiQGCOFXKLr6AP637UE3NCec68Jeb46rWc2X5XWCcMmyIjooRLhEE8vsvgroei
         wAY5jOA4bqDQX9BbdTxFXVicuNw3LIjOMKsYqPS+OzzNBtO0uvSUAOSpJunE/iBG0wSs
         SAOsmL4tr3zO+nUdV8mAFUi6+60u/ywOh11cJqnoyg4OvcziWjLCc8KScEPAXnzO1EDo
         yDQg==
X-Gm-Message-State: AOAM5321ULtUt2MjCUQYbUcHNLpEhhSIWsyfZ5Do4lUUMplPeUmz32s4
        tqPG4ZoUrr6P0peRrCD9gSE=
X-Google-Smtp-Source: ABdhPJwwFTsGxRzatz9BIxV8yjARgio1lXfuEbGf1QxRZ5FV2Yu03x9GdT+vwQjYeEqYagadBvAv7w==
X-Received: by 2002:a05:651c:98c:: with SMTP id b12mr40706698ljq.81.1641307096662;
        Tue, 04 Jan 2022 06:38:16 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.38])
        by smtp.gmail.com with ESMTPSA id y20sm2468175ljn.69.2022.01.04.06.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:38:16 -0800 (PST)
Message-ID: <adaafb2e-ac28-5f48-eb0b-8b55560f3bed@gmail.com>
Date:   Tue, 4 Jan 2022 17:38:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: INFO: trying to register non-static key in hci_uart_tx_wakeup
Content-Language: en-US
To:     kvartet <xyru1999@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, sunhao.th@gmail.com
References: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
 <6338e7cd-80cb-11af-e3c0-edd740bb9e49@gmail.com>
 <CAFkrUsgEJcMAdVUP3aUB7-H4YmUjFeii5754nPpOVh+vo3bnLA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAFkrUsgEJcMAdVUP3aUB7-H4YmUjFeii5754nPpOVh+vo3bnLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 17:34, kvartet wrote:
> We are so sorry for that. You can try the following websites, which
> can be accessed without registration.
> 
> console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/
> 
> Sorry again and look forward to your reply!
> 
> 

Yeah, it works, thanks! Seems like removing "/plain/" gives an access 
without ubuntu one account.


With regards,
Pavel Skripkin
