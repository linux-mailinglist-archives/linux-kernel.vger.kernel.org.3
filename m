Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC757BC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGTRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiGTRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:24:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E852DDF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:24:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id u20so14825972iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xN1e0M5XNbM3KXA/S/AVCXjXEIe1l4nyl0ZTvEljnbo=;
        b=Rr2nq5m+Krs4sVN8nCvW6/o4rNl5tdcAGeUIumQyYDBH2NvuTfm3Icx7+k5AaLeozg
         +a+M1MUZo386SSMJ2ZLyuFV6Iq2zhuNV+sWqdv9L7u2h1586CfetE3gb43mCUApHEarJ
         Nx2k95EReDwVriGtREP4Ax9ZGAFavwvkHmKkdxbqiaReJ6H29zgWvzCJV28xxX6j6jRd
         URKgDmVU5c3A/53xYDZeyAbqTGO2R8HhLCprJs21x9KxJAk9b1Jyw1m+O4zCfVHgguP+
         T/uhgUe98BmjRAES/NKdM5J0a/Je2dZtz1pUbly2YIduT0c6uvIbMm5wi/4xYWDlom7U
         CpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xN1e0M5XNbM3KXA/S/AVCXjXEIe1l4nyl0ZTvEljnbo=;
        b=HkeSyr4J6nEVCqod2sKC4yqSEG9xLAbWorCopXe4ntJIo1vl38+j0S73iRV3XWFFG4
         YF/yAg+2IxOrzyfto7wlFACSVwwflDkq1WMg4rKlwOmc4Pi3dTowExjWTgDc9xVTJNfT
         C7B8I4ttdxdP/iLqfZr//3ifB47517tqyHqefk0bWVFqKCQEzpKzFHuLQPXwCJmcF/Yw
         N2KevQwu0Hz1tDjA1LQpwsSxkpSPHzVDwlYLC/rR5BwV8HWfBHkftWTbENh8MwQYxtwJ
         g1yXd3L9aRNiFmZE6KEqXs4+sgNE9+1xtkm11SYGk9HN8PiikLAi0u55GlnTUgT7wCwv
         GD/A==
X-Gm-Message-State: AJIora9l74vNOAA1oWHSdz0XCbVYsN9I9Qc5wOrdsk405Six93qCZunn
        FtsqoG6uUqJzwukcq6hMRc+o6A==
X-Google-Smtp-Source: AGRyM1uy38d9e+SjTB1Bwm0ezIHZDBfeGhs0SB7c6r7+g81F5cU5fxj4f4dvKsJVvkML9/S7imyLxg==
X-Received: by 2002:a02:9995:0:b0:33f:1def:a856 with SMTP id a21-20020a029995000000b0033f1defa856mr21611465jal.140.1658337855405;
        Wed, 20 Jul 2022 10:24:15 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n2-20020a056602340200b0067b7a057ee8sm4950544ioz.25.2022.07.20.10.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:24:14 -0700 (PDT)
Message-ID: <f5d20f6c-5363-231b-b208-b577a59b4ae9@kernel.dk>
Date:   Wed, 20 Jul 2022 11:24:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [LKP] Re: [io_uring] 584b0180f0:
 phoronix-test-suite.fio.SequentialWrite.IO_uring.Yes.Yes.1MB.DefaultTestDirectory.mb_s
 -10.2% regression
Content-Language: en-US
To:     Yin Fengwei <fengwei.yin@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
References: <20220527092432.GE11731@xsang-OptiPlex-9020>
 <2085bfef-a91c-8adb-402b-242e8c5d5c55@kernel.dk>
 <0d60aa42-a519-12ad-3c69-72ed12398865@intel.com>
 <26d913ea-7aa0-467d-4caf-a93f8ca5b3ff@kernel.dk>
 <9df150bb-f4fd-7857-aea8-b2c7a06a8791@intel.com>
 <7146c853-0ff8-3c92-c872-ce6615baab40@kernel.dk>
 <81af5cdf-1a13-db2c-7b7b-cfd86f1271e6@intel.com>
 <74d1f308-de03-fd5e-b7f0-0e17980f988e@kernel.dk>
 <2ec953da-78fd-df01-44cf-6f33a5e40864@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2ec953da-78fd-df01-44cf-6f33a5e40864@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 2:58 AM, Yin Fengwei wrote:
> Hi Jens,
> 
> On 7/19/2022 10:29 AM, Jens Axboe wrote:
>> I'll poke at this tomorrow.
> 
> Just FYI. Another finding (test is based on commit 584b0180f0):
> If the code block is put to different function, the fio performance result is
> different:

I think this turned out to be a little bit of a goose chase. What's
happening here is that later kernels defer the file assignment, which
means it isn't set if a request is queued with IOSQE_ASYNC. That in
turn, for writes, means that we don't hash it on io-wq insertion, and
then it doesn't get serialized with other writes to that file.

I'll come up with a patch for this that you can test.

-- 
Jens Axboe

