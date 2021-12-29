Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAD48152C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbhL2Ql6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhL2Ql4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:41:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDEC061574;
        Wed, 29 Dec 2021 08:41:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so14889512pjc.1;
        Wed, 29 Dec 2021 08:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O2pbmS818arXigvBH3gLZ+98cJUFjjjLwuoZwBCC54M=;
        b=N7L/omppPMV1C0ehMzFhzNPNeqZA3VP/LFeXG2fzUnpA7oT+fQ5eHCVLFYLxB4kx4G
         5SidwXOxubPiDh7BsEHiytCsZfgbPBCrNIHVbBmvCyLlYeQVhSFz68wOiIKs95zmNMWK
         4ckShIPdJiKLQURmfcPITh+FoBrcGvGd0ItAscVNTuNG6KJf1ca+mNIZ8ngGG9wc6HQ0
         bXa5qVLrCeKWjle5tMbigdgU04SL9vczQA3sXr8FcSASgZUaIEBLx2TZ+KjfokX/vO3G
         ymzBwUYDi1NmlNiXUrQbUqnLWDwxmazyJD8sRKQyQTb+FXy5nu1AQfVE0FUvihzEMuNU
         XSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O2pbmS818arXigvBH3gLZ+98cJUFjjjLwuoZwBCC54M=;
        b=cLPc2QcjV+sD1PxgKzmSXFdZTrT6X3hPQkcVM7kEsFO+ZeTdyOwj8MHeYpLvVTwrB9
         RM1Yo8GaLHOo68AS8T8VPqSsXZTN3PRa/L0ltCBdH97P+mwq+G0euiXxlkQa31/6Jxll
         jCCMKAA/VnHICkhSuZjl4uDIo/IdIHvEdX0Ir4XYxFlqvE9N22LFpQas19Ey+iLADo9O
         KP779uBcdBvOVd+PxsFBpIcs0Vd306EllgVo0u1Lec7MvvqS7i0OsZVUxZfJoYkwz2lb
         0SDPqoDpLSuyzLPJAqNcl8OjBXSnLCpx3++m+OCZRQsUCg/c6UfY/CKNgs3rg0UAAp8E
         OV1Q==
X-Gm-Message-State: AOAM532Rys6JlaWgVLHxyS5IYDjJ/6uFTfB3T3/d/uvBGLCsFJ2uYxHw
        Rs057G5tgonjWsWtCsMYtcs=
X-Google-Smtp-Source: ABdhPJzR4LfeXTTm9rQzzjk9apUOFDuZ8ZDYkGLT2rBEW4l51w8K06POiEJOQ3cgVmgta0tUZxVizg==
X-Received: by 2002:a17:902:a408:b0:149:9055:98b1 with SMTP id p8-20020a170902a40800b00149905598b1mr9422261plq.2.1640796116250;
        Wed, 29 Dec 2021 08:41:56 -0800 (PST)
Received: from [10.230.2.158] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 145sm20757066pgd.0.2021.12.29.08.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 08:41:55 -0800 (PST)
Message-ID: <abefdc9b-bf5f-3ec9-4d14-172f525d962f@gmail.com>
Date:   Wed, 29 Dec 2021 08:41:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] mips: bcm63xx: add support for clk_set_parent()
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org
References: <20211229000553.32240-1-rdunlap@infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211229000553.32240-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2021 4:05 PM, Randy Dunlap wrote:
> The MIPS BMC63XX subarch does not provide/support clk_set_parent().
> This causes build errors in a few drivers, so add a simple implementation
> of that function so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
