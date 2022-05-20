Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E223A52E1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiETBLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbiETBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:11:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A460075
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so6627434pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QplhEKZuHzkbzY0mq+8VH1xKLoxdCAGggywT6a8HvFI=;
        b=eAXk77fJPSdKOCTtoadgSQuvjzmXihpnuUe9yEi+k/GNauE/4mZOsnKc+2Dm/sJpJG
         gYpcfdBuL7edDWIx+rBORzDPWHwi2geZqGY9KOSj7Lym5if5nFq4WF6ARReP1kGKu40c
         NZHuqP8KQl6TuTPWr0Ea7xipd5ChEgxkH4g6soxPFX1FVBaCMrvouJkWpLpAmjoma+Nc
         faF7qonaBuIaFVcV0HaPFOO/GBVqlZRaadJEFhDH7+vnkuoTTpTt58l3cL1+PE78VErJ
         jkNrj3P7tEVFQUFAQMgs4kLzhETMJjpg1mLOKB0dg5tJbI+C7phAAcwELlR8XLr+5XR0
         scBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QplhEKZuHzkbzY0mq+8VH1xKLoxdCAGggywT6a8HvFI=;
        b=0ZZ9mUqbGHO/8nTtfLfbD2a5EUlyuyTgRU2vVhBYMOZq2gG5VnTQzH3z4yO4ghx2NB
         WIzyq5smQLi1qkSsyWEN+jFnZntCIOeCfNORdEoE4+HiLcMOpjqrO0BIk9pPhvEE1dXp
         ZI3hNVchIQk+gLSciK4oAsBiE3vLsRbBlaroU2RvBb9raIeGtuAE7zGAOZpqoGkajV0g
         RWiD4N4xvDxYMmhDcFsDvr+GA+5hdJHx0o25Lg/1Xox+kJgAJ+KRy7+pY7sRrg1L6338
         +h285Uu41Vy1Hrh91JgL32DtskIDj7atRuNLeS1fVFt7qiGdoBDjxzWno881zFmlYlyE
         EHfw==
X-Gm-Message-State: AOAM533grqNfwu3yg5IEfT8tVklnTKyj016MVHv1OkT9Jvde9DNatz9e
        xtUOmKfqaskwCCkhaiNYowE48w==
X-Google-Smtp-Source: ABdhPJyLXE1COXvDVFeDobqdJgRJErWtxhqf/a+V50pP5duS9bxZKyRD+lkzQ1bnWlolYtynZEuXjg==
X-Received: by 2002:a17:902:f789:b0:156:5f56:ddff with SMTP id q9-20020a170902f78900b001565f56ddffmr7168731pln.116.1653009080543;
        Thu, 19 May 2022 18:11:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m23-20020a170902bb9700b0015e8d4eb25asm4383732pls.164.2022.05.19.18.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 18:11:19 -0700 (PDT)
Message-ID: <1a6d2f32-5ff9-4df8-36ba-c3bd1d675b47@kernel.dk>
Date:   Thu, 19 May 2022 19:11:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/3] random: Jens' {read,write}_iter respin
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520004058.96691-1-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520004058.96691-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 6:40 PM, Jason A. Donenfeld wrote:
> Hey Jens,
> 
> Here's what I've done to your patches. Could you let me know if I've
> mangled anything in the process?

Looks good, just one request for patch 1, I'll send it separately.
Feel free to queue them up, thanks.

-- 
Jens Axboe

