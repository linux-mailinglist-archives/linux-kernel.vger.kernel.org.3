Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE04CB51B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiCCCll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCCClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:41:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A76328
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:40:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so2451660pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:cc
         :references:from:to:in-reply-to:content-transfer-encoding;
        bh=WKpgUKvbgmgS/+XZIYcGoureDOsojTAGGMqwpMVSdx0=;
        b=WkDu5aHPpmG3JoGrcKXOSVtPyVZqVsnK9TfxUoj9Yj3PEpa6J+V/9fQwamFkioHzpi
         GfDxjNVajhLweHzfHllvGWROpleV0ERKGRiDG21o9iU9qu1YjprDnWiFRcatw9XQC1rM
         7sg4g4v4ucriVtTOi9A7iZ1PpUOhOET1ALx40wMhkt9JLGx1rqA7RfYuNcLxag7aq98/
         KcLZKC4flRjOBeebXDCRsK5wGicPYjIg80LIBmi25TK/xcQQqYjtNnSuK6ls/CWInWJ2
         a+AM1y8HzMvC5pKjQmwpWGBoprOZm5xBsply77UPufQIJWTVWaNIU4DMAjALn8ot1XPS
         ShKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:cc:references:from:to:in-reply-to
         :content-transfer-encoding;
        bh=WKpgUKvbgmgS/+XZIYcGoureDOsojTAGGMqwpMVSdx0=;
        b=AVM5J23UdicffnqsXzwOYNfmRTX2Cwt6EWzNTLoGwN4aMDkxeVdXGiTif506Km/1B1
         DofPOIw/JxRMpKKQ3WISkfBhS57MFlWL0I+Qre26eq/iKl5cWVHbVppPfbQSntThPSVF
         L/8tDnoCNtaijkfutW+hkzl/lFrjuucUevQABqQmwN3x567Ihb7bZqe7UzblatjDuwDy
         BKb/iu88QOMS7QvWki4Cm11BJyf29Z7HMv6CDOdO8Dhksr9ouQjp+EwBCXTxnj/z76UT
         RmzccRK1FaSdsNwfe1UZJmMbGxqudyLNCNnUCYQki8lU6LlsBRpOpDrOFHH8i1J0oaIf
         YtYg==
X-Gm-Message-State: AOAM53264vMLtN+tpcPRrNgSXf0e8MrAV9AzhvtR/nerwWixcXMMlgXj
        89pC6sLhBHIggVBuN7Fu2vP+dA==
X-Google-Smtp-Source: ABdhPJxOdMLArkpmLe9NJIzj5q5ePqZMNN5SzGfTtRGy/eUE2Cok/FhJL8qVgYMzK4uz3BqAkLF3Xg==
X-Received: by 2002:a17:902:7fc5:b0:151:863e:44ee with SMTP id t5-20020a1709027fc500b00151863e44eemr10350330plb.163.1646275254888;
        Wed, 02 Mar 2022 18:40:54 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b004f357e3e42fsm546095pfs.36.2022.03.02.18.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 18:40:54 -0800 (PST)
Message-ID: <b31b0c6b-4a97-e03a-0bc0-4bf17d2ed946@bytedance.com>
Date:   Thu, 3 Mar 2022 10:40:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/numa: add per-process numa_balancing
Content-Language: en-US
Cc:     songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20220224075227.27127-1-ligang.bdlg@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
In-Reply-To: <20220224075227.27127-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter Zijlstra,

On 2022/1/12 22:43, Peter Zijlstra wrote:
 >> Set per-process numa balancing:
 >> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
 >> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
 >> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
 >
 > This seems to imply you can prctl(ENABLE) even if the global is
 > disabled, IOW sched_numa_balancing is off.

I have discussed the semantics of this API with Mel Gorman, we both
agree that we can prctl(ENABLE) even if the global is disabled.

On 2021/11/10 00:26, Mel Gorman wrote: [1]
 > For symmetry and consistency of the tuning. Either there is per-process
 > control or there is not. Right now, there is only the ability to turn
 > off NUMA balancing via prctl if globally enabled. There is no option to
 > turn NUMA balancing on for a single task if globally disabled.

On 11/18/21 4:58 PM, Mel Gorman wrote: [2]
 > On Thu, Nov 18, 2021 at 11:26:30AM +0800, Gang Li wrote:
 >> 3. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
 >
 > If PR_SET_NUMAB_ENABLE enables numa balancing for a task when
 > kernel.numa_balancing == 0 instead of returning an error then sure.

[1] Link: https://lore.kernel.org/lkml/20211109162647.GY3891@suse.de/
[2] Link: https://lore.kernel.org/lkml/20211118085819.GD3301@suse.de/
-- 
Thanks
Gang Li

