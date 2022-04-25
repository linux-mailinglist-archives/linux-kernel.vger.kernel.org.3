Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02050E129
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiDYNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDYNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:09:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C331B784;
        Mon, 25 Apr 2022 06:06:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d5so5558508wrb.6;
        Mon, 25 Apr 2022 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lEv5+jYrj0q7Pl/6hwb1B3vffo3o9jubOYC/onWE6DY=;
        b=AUo6XnV+thU0M2HffAvNKN3RXHqvj9b2wX7+yY/B7PmYGPvGH8BODt0RBPPvAW3DRM
         I9eKpcz2UTpvIuJPl9n9OYGIrM5sSfh4kfYSe8yB0MWSQbXYdlLM3u8FXS6dvS+3dvNL
         7+VdknJxYxBns9CRVgWyBfjwIuKJK+VWIJ4iA1vUQUHwk8sfGRfVD9ztdF6LYHlapgT6
         dtgeKvaTElS2q/DDyMRwgBQTJB9vj04FjMq+rVbegSDlaoNX5p2/ZqYXSwnWecKVZrN4
         cdyVcXok9e2pkdVhrmLmijbgS3sB07EZUdQvKxPjGYOQRidiR7U5mpHeBGjJa2YDIa2X
         5+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lEv5+jYrj0q7Pl/6hwb1B3vffo3o9jubOYC/onWE6DY=;
        b=S4TXOQOtGYOAWtByp5p0xEjl4DkL0viIdjVkMs+H05y5zgIjamAkvBsAgXJRI83Bwe
         oGz8tL1mLCkgjFz5BZeD1wLQzBoO6biuXhlNKuOKmT/O+tsvhsZ7FNcCWE1BKo2w0ApZ
         qj2KoBxilqh2sPNhKK+TZdb6GTS0XEpR6w4+7nNwI8xUGRLxcXIVZlBGLj1bGD2M7vW+
         UTWi2KKKVSVQG5AetU3gZwpNy3UjHZppgRe3V48iFp122wPueJhHDcg4AdPLp1uk1jyK
         3vC/FMgG4K01JNpmWBaI7HeYd+/oyuvY5/Jk87jHwq7U6E67Wjzq3/RLr2/YFztfQzP3
         vM5w==
X-Gm-Message-State: AOAM532ABweUO+aZ9vjaNdq3MeKdIjrZxgly/We4IWXN+66X5a+9PMyQ
        zTUvS6xkqjLz1I8SGMBNJMDtmzLRvmkt7A==
X-Google-Smtp-Source: ABdhPJzFFaBx8LnydOc9WLE53TfXFxku7x50G2R5+TUJO7xCAHgAq61t/xgkhesT9w4bTgw17mw9aQ==
X-Received: by 2002:a5d:6806:0:b0:20a:db0b:ad9b with SMTP id w6-20020a5d6806000000b0020adb0bad9bmr4347423wru.294.1650891982346;
        Mon, 25 Apr 2022 06:06:22 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c2dd000b0038ed449cbdbsm11984698wmh.3.2022.04.25.06.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 06:06:21 -0700 (PDT)
Message-ID: <d9bc3dd2-e33e-6756-8493-50788057d172@gmail.com>
Date:   Mon, 25 Apr 2022 14:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] kernel/irq/matrix.c: remove redundant assignment to
 variable 'end'
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Tom Rix <trix@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220422110418.1264778-1-colin.i.king@gmail.com>
 <87sfq11fkb.ffs@tglx>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <87sfq11fkb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 14:02, Thomas Gleixner wrote:
> Colin,
> 
> On Fri, Apr 22 2022 at 12:04, Colin Ian King wrote:
> 
> can you please stop using file paths as subsystem prefix in the patch
> subject?
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject
> 
> I fixed it up once more, but you can really spare me the effort.
> 

Apologies. Will do next time.

Colin

> Thanks,
> 
>          tglx

