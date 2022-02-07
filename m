Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F24AB65B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiBGIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiBGIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:05:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7362C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:05:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso19654766pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=o3qTNosVZQO2f4HKnte6agqmT/loKQHuPrlvEYzARPs=;
        b=TiCoV1OpHd3Gb0PEZzdF/s7Qwi5EKT2CXRieeJdwAD1TlDDoOXXPtfn1ubhvYe+iek
         0lZjC++MAFZUK9jJ7qqccdXcVCCwo8AMuVm3yHu7W6Is5u2dLKfPhh4Du3nDqfyBNENF
         /VmzzVvegizifokf8PvnrtzyOCxFAt0jxSGJVcuvncg8gMmsAoeH9SaqHoDSWFUpgG0K
         qYiscZahXGn+pchZioZKMB/DiM2Tim7FQOEJK0VcT9Rnn5gEOOJL495/SUfTPA0gtmQJ
         rRb7vCeC2AySKA5VLAn32oV0u2vtadO5+1W+T4BxTndNPGt1fuu1RemqgJiTpwe9Jzoz
         A02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o3qTNosVZQO2f4HKnte6agqmT/loKQHuPrlvEYzARPs=;
        b=P49UE/Vxv9qeOf38TXGdYyNeRQNh97kktRfb8f6HU5ELZwtCvbrMsTIga5pnBFFJ50
         z8paMIZayxxnP59fbqHjBB2ZicGVke2H8OMNP3WT99zWps/BixZNySfHxKfKUgcLr6kq
         PEMnnyvcuaqTSCtlszElSSmoY+W1H2ssuTG7h2DkVyqMBaDpOCnO2mfnXJHHIItR7EP7
         1UEWc9l0Jxm+KbuY6COhGHBFQT1ZXj1PpzqedFI578xnAwZObm5Gf7u3ygx03c9ndNsq
         mhtC0k8rs1tIgnUBkH/f8tEiMElxd/ugji21HCuks59cxr/EVm4Fe2KyEhe6dmCQPYjo
         UOgQ==
X-Gm-Message-State: AOAM530F0s0P0IgPOanShpiQVf651SP12MJhNnjaFw22LebF2PpWhlsO
        4nJmP5YdwvMjF1oIubjXVZV2ejY4Jiw=
X-Google-Smtp-Source: ABdhPJyY52lgEeJyUGNSXnaqEQCimOMLMuu0f9iv0Xhl3PnIS3r4iVC6k1y+1HLwW4BPMCjE6atVcg==
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr12988971pjb.152.1644221123269;
        Mon, 07 Feb 2022 00:05:23 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-44.three.co.id. [116.206.28.44])
        by smtp.gmail.com with ESMTPSA id nv13sm10498209pjb.17.2022.02.07.00.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:05:22 -0800 (PST)
Message-ID: <63b6f2e2-e9c6-e0eb-b668-b5cd4696063c@gmail.com>
Date:   Mon, 7 Feb 2022 15:05:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Linux 5.17-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/22 03.40, Linus Torvalds wrote:
> Please go test,
> 
>             Linus

Successfully compiled and booted on my system (Acer E15).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
