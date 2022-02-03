Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD314A8893
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352230AbiBCQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352222AbiBCQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:31:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:31:55 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p125so2701108pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rS1D4lu0sOU1IHUZQp6i0H/GpSQuXflt7aoDlDpnaNI=;
        b=pybM/Ou6JAwOl3YzZTPtCw1hqRse4+oTsSMHeUjIlXyhDIn5IRZ5GhMwa1a2mir98Q
         /Bqf1/pE7ccML/imrSO8Zu3mJawy/fjd7vlmtsUgTEc+jLlN1DOfijAaAIcR5oCevhRT
         8BoQ3nqzu8IdPxI6PQFjXQ2+UwsdimsJuDGkHVWpRJYe7ZjiTL7rVlgQauy8oJjXQYMa
         2fO4DrWjprjy4lic6CVh4TeZ5UHefasTvAM1fBhH8XSuEPNFWTdosXtOmSrs2CvjNMR/
         q1Su2ccCKTNJpJ/mBinW9aC7qgbzgjGPNHyb8wGDRmLw9F1HA66biBao0LfleWYaxaTu
         OAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rS1D4lu0sOU1IHUZQp6i0H/GpSQuXflt7aoDlDpnaNI=;
        b=pIob3zWV8L5rFKJmyolfRv95a93mi+gMQNEyrhF7rLoyD8p+Exg+0sPoQ1SGuxxSGg
         XSqITKznU4CblY6CENp25anrHsPfsJmPnjQBGFAnRhViOu2lI0ORNMhd1UkHbClCtDu8
         NYZcRDboqK5aaBFkDtyhrdk7N+1IemDyiueL1tIDes0QHzI8XDyXTEo3gRAagWd8NU6l
         jno9uBBqgWoC8ivgxO/EpAqVJ65Ctw9H9QAdhf2OJbKdOdn0rLQJRVqL1/jD0sgmNhTV
         ayrcsnk57IX+rFj+h/6EmgYbqM5Cv3OGBbuUWLKfQp6/FUZ0sfc3wllZO2v9yN20ynYe
         KKHw==
X-Gm-Message-State: AOAM530rEkepQtzfhz3sDW0Mg2G8BNyIHqTH9OqMsK359iL2wRYEr4pb
        KQYCM91zdEhMqQY57ky2vCA=
X-Google-Smtp-Source: ABdhPJzwAj/7aXbHDJ/m930ahMy9szhUht0ESltA5rIjq0NK2HrrbL11QIQegT9WQEwKdLPoSDl8Fg==
X-Received: by 2002:a65:6296:: with SMTP id f22mr28296863pgv.320.1643905914968;
        Thu, 03 Feb 2022 08:31:54 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:7c90:e76c:242e:a6ab? ([2600:8802:b00:4a48:7c90:e76c:242e:a6ab])
        by smtp.gmail.com with ESMTPSA id f12sm17194582pfc.70.2022.02.03.08.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:31:54 -0800 (PST)
Message-ID: <80777e3c-385c-d481-167b-c3491273019f@gmail.com>
Date:   Thu, 3 Feb 2022 08:31:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Updated git tree for MM patches??
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Berger <opendmb@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
 <Yfvn2gatF0NA1ihp@cmpxchg.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Yfvn2gatF0NA1ihp@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2022 6:34 AM, Johannes Weiner wrote:
> Hi Florian,
> 
> On Wed, Feb 02, 2022 at 04:21:38PM -0800, Florian Fainelli wrote:
>> Hi Andrew, Johannes,
>>
>> The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:
>>
>> git://github.com/hnaz/linux-mm.git
>>
>> however it does not look like it has been updated in the past 5 months or so
>> as master still points to 5.17-rc7-mm1
> 
> Oops, that was a bug in my script. I had to work around a behavior
> change in wget and it looks like it started failing quietly in the
> next wget version.
> 
> All fixed now and the tree is uptodate again. Thanks for the report.

And thank you for fixing it quickly, looking good now!
-- 
Florian
