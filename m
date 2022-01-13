Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA748D07C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiAMCkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiAMCkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:40:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007CDC061748;
        Wed, 12 Jan 2022 18:40:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so2270144plh.13;
        Wed, 12 Jan 2022 18:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JoKRBnT1aSEAFNkcPF+/qny7tM7I8hSefs8ekQNOZv4=;
        b=njycsCtXyUBVACORzb6K3ZlGuXAhESVTJ/F6syqGCjZ1FAFBAMfUDtnwgyGShnfVTW
         /JmTQPG/X1zXegbpzluQ03zUSjG9q4Sqo3q4ogTzMi9v7lX7EJGVp3yRjqLudEOqMVt3
         SGosPPiY1T8PtzE4kTiWt5R1ILnnc4UP7wGaPVcXyCfoz71sobo2RtLM0vh3s5A905Bq
         vHGIcR06L27EJnpn8J1ffam9fP+CnUqhzjX015Q/YjUmUwy1qH3wEjYNLovlNO3IMhEu
         A+/8wlnAT4pyeH1dboOolHue93OcDWa1c06tHMNddSSgeF7sLkO/Oyi1WNWI+E17Buy2
         XNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JoKRBnT1aSEAFNkcPF+/qny7tM7I8hSefs8ekQNOZv4=;
        b=bFgGoTAz8jF27Oe5nAR7Gv9FZZCG+c9zTMe8ogY3InAVUTYL40HVXfXigQb2aD7bWn
         2apjjONV+ctDza5enSrmhASu8nwx5PoJuglfK8G+eqBoSENR2qH9jWSMHpxE+0MZoN0u
         ukBbNDivMuzLJFAt4iUM1vAPUAvU5UGLtm+kWnInvGM8Nv7cM2OIX+W2PDxDnpNXryGN
         L4UBMgt25O0IqcfuXPeISumOjLJ46ovdk5n0CRF/eSvZ3SHUoSkcERUOqIYzlKx5lWiB
         SsIbqkqdb4nuHh2CcL/qnW4JbKVk5DjZiP+CK46uVZcJhBpni7sbiq4txgbKSYQNS1Cp
         iETw==
X-Gm-Message-State: AOAM533EkVcbe55RK9bBHb20UI6SG4NKNMh5jvJMQ3xqgpb81OXNzpnv
        PBcRX/XqvcAuTTQuNrEH/ks=
X-Google-Smtp-Source: ABdhPJzSMmK82zqEL6l6FJRtP4b2XtGIQwoQI7SYCZSyS9jfjIAODTqmOKKjgFr1SnmWRVh2QINIRQ==
X-Received: by 2002:a17:902:6544:b0:149:8222:4b62 with SMTP id d4-20020a170902654400b0014982224b62mr2610422pln.114.1642041631524;
        Wed, 12 Jan 2022 18:40:31 -0800 (PST)
Received: from [172.20.120.1] ([61.16.102.72])
        by smtp.gmail.com with ESMTPSA id b12sm903557pfv.148.2022.01.12.18.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 18:40:31 -0800 (PST)
Message-ID: <faafdf29-6d8b-82a8-c69d-4ab3e623b489@gmail.com>
Date:   Thu, 13 Jan 2022 10:40:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 13/13] blk: introduce iostat per cgroup module
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jbacik@fb.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
 <20220110091046.17010-14-jianchao.wan9@gmail.com>
 <Yd82dJMxdQkssu4k@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yd82dJMxdQkssu4k@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/13 4:13 上午, Tejun Heo wrote:
> On Mon, Jan 10, 2022 at 05:10:46PM +0800, Wang Jianchao wrote:
>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>
>> iostat can only track the whole device's io statistics. This patch
>> introduces iostat per cgroup based on blk-rq-qos framework which
>> can track bw, iops, queue latency and device latency and distinguish
>> regular or meta data. The blkio.iostat per cgroup output in following
>> format,
>> vda-data bytes iops queue_lat dev_lat [ditto]  [ditto]
>>     meta   \___________ ______________/    |        |
>> 	               v                   v        v
>> 	             read               write   discard
>> In particular, the blkio.iostat of root only output the statistics
>> of IOs from root cgroup. However, the non-root blkio.iostat outputs
>> all of the children cgroups. With meta stats in root cgroup, hope
>> to observe the performace of fs metadata.
> > I think using bpf is a way better solution for this kind of detailed
> statistics. 
bw/iops/lat of data or metadata of one cgroup is very basic statistics
which kernel could provide especially when cgroup is employed everywhere.
And we love to collect them all the time during the instance in cgroup is
running.
> What if I want to know what portions are random, or the
> distribution of IO sizes? 
This looks really detailed statistics :)
> Do I add another rq-qos policy or add another
> interface file with interface versioning?
This iostat module can not provide all the kinds of statistics we want
but just some very basic things. And maybe it can provide better hooks
to install the ebpf program to collect detailed statistics.

Best regards
Jianchao
