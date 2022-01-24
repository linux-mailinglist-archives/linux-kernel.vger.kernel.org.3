Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE1498651
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiAXRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbiAXRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:18:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CCC06173B;
        Mon, 24 Jan 2022 09:18:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x7so51342529lfu.8;
        Mon, 24 Jan 2022 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLsUg6FDJGu3ZQCzAL6Mke2UDjBXWESzO9zt25xxlzw=;
        b=p70OjH5RbVKPPgBPYNpwJN6ahExMTCzhbrwbcr68F9zVzK3xK6bm8x7Pbj1pelKT+7
         8Vps8uCUaMrwTzJ2dSflfq1VccIyOkag05Y1u0RQyNhanL8hAnnfxKQhOeLTYYkF+76A
         Zn/yMcAxzl09eKLmbUiNVAjccc5ZPdI1Bd2LV15ibenx7jauQ5RCWHI/4T6r6UaLn20e
         0lSwlls/JlMpkhJT1KE6/6GX4pzRsKjGrUmWC9Rhf0PflWT503jJa4ir71G8MbdFK84B
         qr0m7N8ijmPb/8m25HtwtRGKFyvV8jwowt57pB3xmV0c908NyKkFy3miJ16Th95glrJs
         Aj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLsUg6FDJGu3ZQCzAL6Mke2UDjBXWESzO9zt25xxlzw=;
        b=sNw2AtqEgkSSK4zrKik90kFbLLxkZQtrUFoNi8SmdraWWUnHudEQxcObAnHVNn//qQ
         BU7w66HI/c8qij9tUqF+zJx3bJS1VGVdydn3e+sFFKTzJCFZO2yqQWgj1NnjF7TLG2nt
         4vKnUVhThVnDcKbis9itQFhTWEzR0G7YZ6zvdXW1fS9nfZw8IfEgBVrmYMBWYBjsIBC4
         wBo16qwuT6VcLb1JvAaamAMbHKb9xcYSgEbUucRWmfaaw8ZLuYFXeALMck4bqhTU87hh
         3Yoltz+6n4um6XgvZtmevjOhMk0Uheg9/sl9dAY5mZcQ84YgYQfYZs26LXl7wL/RuBlA
         qvSw==
X-Gm-Message-State: AOAM533XZFF9V9Lvk8Dh84SMAYDzzuDP4K1nD1P24s4NatWGLWxhTrlT
        BfJMXMQH/r7FTYLr7ALucrVqQg5THn4=
X-Google-Smtp-Source: ABdhPJxaC1nse2djJr5e79EXHoQFceCpBhhox5IYuTAIWw/gPFy8nbks4WWi1bQb4YjSMQTHCvT7zQ==
X-Received: by 2002:a05:6512:b19:: with SMTP id w25mr5361524lfu.690.1643044734838;
        Mon, 24 Jan 2022 09:18:54 -0800 (PST)
Received: from [192.168.1.103] ([178.176.78.239])
        by smtp.gmail.com with ESMTPSA id h2sm1126268lft.58.2022.01.24.09.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 09:18:54 -0800 (PST)
Subject: Re: [PATCH] ata: pata_atiixp: make static read-only arrays const
To:     Colin Ian King <colin.i.king@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220123221622.5543-1-colin.i.king@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <78ea807d-1bef-4eee-2ac0-ceebfb0a7db9@gmail.com>
Date:   Mon, 24 Jan 2022 20:18:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220123221622.5543-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 1:16 AM, Colin Ian King wrote:

> The static arrays pio_timings and mwdma_timings are read-only so
> it make sense to make them const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
