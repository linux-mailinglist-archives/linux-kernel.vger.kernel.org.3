Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAC581DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbiG0C4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiG0C4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:56:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69647357D5;
        Tue, 26 Jul 2022 19:56:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r24so11820215qtx.6;
        Tue, 26 Jul 2022 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tnVUfveHENcuNsM+rkNWOjb5mSPRIjYCSwHkGzsISFw=;
        b=jRydY8a62raCEIP2zW1yVhusvCE/TTO1NTCkdf4RwKvDeQLiePvqnyUgmBv7zW4clL
         CSBr+mg4EKts3IKmQPJ/IoF2SQX6sAV+7dAbkip7GxNXOt1LR0MDGuSsYSe2L3NbLJ6x
         eHT2YB4htn5rPhqC15brIJrrUwXUVuyVCR/cIP1tCW76EEoCE1OI53bIUXwFKj+nCi9D
         PPPmw1OjptaUN/MvtZZMrkSDSKQOPqoWaJ4i2+P+xE5ge9NycFGp54q7cH4jnblfjl98
         udZBRq4R2/5Ao/fPXkKD1qI0fXTiaEdvuZHUKkocyz/AVdiFK9cPE9s9MRwEXRPQVsuG
         IUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tnVUfveHENcuNsM+rkNWOjb5mSPRIjYCSwHkGzsISFw=;
        b=AkfH6XLAJ/PXJwyZGMeLBMK8S0QWbfxyxTocDPUopbehD9ac1rWpuY7H7IN9xdErNE
         DrFVdbVHR/qsp+saYqSTg8lI1Jeuc7OIbyF0yfVDLEmHZeQvr7zSc88o0I1KkpKgNiVv
         N31kdJu8scXV6IS9YNHejTBoc/a2d5+GtEl3AdFTTJT4pErW6QZnXQUl5pVbUNEeFQkX
         J5ZKnWczYpJoIDGgDiEvbmNrp9tD0Hx/h8wIrU3zJ//RX0ZbBWvUHUv6lEiQiWDFFbOk
         3CyVi/J3lO4b7903pQ4H5J8Hrb+TPc7XXbPAB1NBcxYJpFWBhQvYCnCtZ64v7mwXioc4
         NIkQ==
X-Gm-Message-State: AJIora/9aZuBJszaCelLog5T4JaWtQUDRbQro1T3Ex0SHRxm7UazkJtO
        qe82tm0HrOtJ6OWW1qnoA8JTLxaTUm/qVA==
X-Google-Smtp-Source: AGRyM1uqOZgdEQs40Dm6b/CDZFfYTmhoxiy5GsI+RRvlYH6CyNNRrjxamqVD7fU+DhEHpXsUeQCuBA==
X-Received: by 2002:a05:622a:287:b0:31f:32f6:1db1 with SMTP id z7-20020a05622a028700b0031f32f61db1mr13805911qtw.480.1658890595478;
        Tue, 26 Jul 2022 19:56:35 -0700 (PDT)
Received: from [192.168.0.9] ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id s1-20020ac85cc1000000b0031ef67386a5sm10550688qta.68.2022.07.26.19.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 19:56:35 -0700 (PDT)
Message-ID: <8a35df7d-a6cc-63e9-b207-6fbed05e32e5@gmail.com>
Date:   Tue, 26 Jul 2022 22:56:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary> <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220726214858.GA3202@elementary>
From:   Stefan Hansson <newbie13xd@gmail.com>
In-Reply-To: <20220726214858.GA3202@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>> Thanks for looking into this! Bisecting has been slow on my end
>> unfortunately. I built today's linux-next (20220726) with your proposed
>> patch below and my drawing tablet curiously still does not work as expected.
>> The stylus works a couple of times, but eventually stops working (unlike
>> prior where it always seemed to only work once). Do I need both your revert
>> and this diff for it to work properly?
> 
> You are right, I just tested for a while with the diff applied (without
> reverting the commit causing the issue) and after putting the pen in
> and out proximity a fair amount of times (> 100) it stopped working.

This part is peculiar to me. When I said "a couple of times", I really 
meant a couple of times. For me, this issue reproduces after maybe 10 
times at most. I have never been able to do it for anything close to 100 
times. I wonder what's up with this disparity?

Regards,
Stefan Hansson
