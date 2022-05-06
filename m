Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079751CF1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388379AbiEFC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiEFC6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:58:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977725E766
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:55:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 204so2392416pfx.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3hj/jfOaQXOkC4b3O+Uwk43J8h5RNvR2pkooULEnEqo=;
        b=ZHWVqdJvM3snMYIQCQ03G97OmyaRbKSWVLPFV6RXnmCiaWbeNIyTkoa7bBbix9VOmX
         WHLmokvAOwlvsqgTukFucC0JKQ6549H2l1JJ5aYDY8KMJdf8cXH0MYgOuGh9Jx2J5rT/
         s0iUpSM5E1hPMNtulZETEay1z9nQihakar8oIozmgFNDD+KTksMwO8x9e0JFuBCJdatB
         4nx/VKl+f/RzcADM7m4Kni3mLbHw680egpnxxcc3d+22daJmj+1gHAI7f8EPHh2OJnUA
         TK3JQdxFh4hNLIukCLDgIQqpQhIYLFe7w9c1dt5Y11Yu/teWrSBZIHWGoTgmFsfIk34o
         eh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3hj/jfOaQXOkC4b3O+Uwk43J8h5RNvR2pkooULEnEqo=;
        b=3P0EciXcB3W91fqe6HjvF+HdCnS0krAoijVF3lf+1hyA/DY3MoRjmwnRGQ9OWh0pVQ
         dKQK8VwYtYl4TagJ/4yod8O/g3IM0temUm10ma2kEDUB4jYGv8A5InB0LXKqj1Kk0nW3
         g18TR+FjgLzYTZu7BGafp8w5YxJzRtk7nFrB3YqqaOclrJ3nZ02RDU75A9wnk+mQzOCB
         IWucq7ulEcNxO1r5Bekgz5GZxb6KA0fm2DDiVTXRbkqjimaUlT1+n27taqchRhBcO35T
         bj8mTbqThvkAt/8CF3kjTxjBJP9do0cUIogTD1QPoEywaWVs/mMfXAqpo0Lc2VpvGTyv
         SMBA==
X-Gm-Message-State: AOAM533eKX8fB8SQ1/l434Nv0pRGKrv/PkT/83al/hXKYM726NVrxQYo
        0ad0a9SsFeabTly6O091dNk=
X-Google-Smtp-Source: ABdhPJwKj9SB16lHRYLUthWb1REni4wQf/jwdMI/rg/2pvxdWrn/0GbG5PaBhd44x4u3YvSZ6E8g/A==
X-Received: by 2002:a63:4e45:0:b0:39d:4d2d:815e with SMTP id o5-20020a634e45000000b0039d4d2d815emr1032891pgl.198.1651805707989;
        Thu, 05 May 2022 19:55:07 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902f14200b0015e8d4eb1efsm372434plb.57.2022.05.05.19.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 19:55:07 -0700 (PDT)
Message-ID: <18d2ad1d-c2a5-682a-91e8-2d8067e62b30@gmail.com>
Date:   Fri, 6 May 2022 11:55:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -lkmm] tools/memory-model/README: Update klitmus7 compat
 table
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        linux-kernel@vger.kernel.org
References: <2b237126-88d1-17f2-ce94-2cb679f0b285@gmail.com>
 <20220502165058.GA1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220502165058.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 09:50:58 -0700,
Paul E. McKenney wrote:
> On Mon, May 02, 2022 at 09:05:09PM +0900, Akira Yokosawa wrote:
>> EXPORT_SYMBOL of do_exec() was removed in v5.17.  Unfortunately,
>> kernel modules from klitmus7 7.56 have do_exec() at the end of
>> each kthread.
>>
>> herdtools7 7.56.1 has addressed the issue.
>>
>> Update the compatibility table accordingly.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Luc Maranget <luc.maranget@inria.fr>
>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
>> Cc: stable@vger.kernel.org # v5.17+
>> ---
>> Hi Paul,
>>
>> herdtools7 release 7.56.1 is available at
>> https://github.com/herd/herdtools7/releases/tag/7.56.1,
>> and "opam update/upgrade" should catch it soon.

With the help of Luc, opam repository has accepted 7.56.1.

> 
> Good catch, thank you!
> 
>> I think this is worth for v5.18, albeit it is a minor update
>> in documentation.
> 
> Good point, but let me give it some thought.

On the second thought, as v5.18-rc6 is expected this weekend,
I'm OK if this update makes the next (v5.19) merge window.

This is more of a "news" type update and the "Cc: stable" tag
should work either way.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
>> Thoughts?
>>
>>         Thanks, Akira
[...]
