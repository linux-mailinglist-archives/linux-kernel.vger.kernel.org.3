Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6B5215F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiEJMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiEJMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:55:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE351DE57D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:50:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so1662896pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fzxrrRn7cvywNO0Eg0g8MebJNrUAMkIxCPWEMLe1ccY=;
        b=Knxf+25kcpEt1lD1GjOJabs6ZQCKEJQ1n2FOsMOb8tgxCcfH/p+ESdNWzCoSL1+JZf
         GJeXvj2N86c0tABjp6OcRXyDPuRRZH4Yl4mxe8CZCRmHyA7Ih6t82i+FRuPur6OIsTKs
         N+Dv4oCnBx00eIAA2ZFDmqu2KaLd8ravhRD89bEV8ZA/N73jpbgm1KkcJqJ8hwIMU52U
         KNFtaLh4+J6omGoToE9+9ufHGmSdB9xDT/7pp8dUUM2EWRnB/+j/68PY42brWlMwKkQF
         xvzRor0v+R8WiTFLbSeykXRu6H3uQo+Q5NcjcJfGoIJOYL28BR6tHhL4YMI1qSed5GRa
         8Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fzxrrRn7cvywNO0Eg0g8MebJNrUAMkIxCPWEMLe1ccY=;
        b=KaFG0G6HV/NuvygrNMNe1bjFBvOhwo/+Sb4RQW+XpQqPFhjMqnQpTT3fVxTlN7XAL2
         QSUVxddX4gXuJQ5GeW4P9Ab4pTZlSqUoQWFVFJRd+vdx9VM84EUNkLgQeomUDEK5GGl1
         EgrqqN8HAfiGnMP2xV8XMZgId63oEU5EhE8TunWv+Mipov2M6Y2YG/F/F1QvAXydTJKL
         F0gI/quFQ4Y3gJ3rV4a54Vi57zxSLOUnrc08QQbuWQO96jlFkSzS+Wxk1qSV5OWysmaD
         eF0y7WFMFd4XJPhk3th+HHjXJs0YRW8qlQpC+q0I49wFDq3J6zhRDysYZt0LrHVzfTMX
         PKpw==
X-Gm-Message-State: AOAM531i+fvv/NXjvmI8f+VnNGk4muABIStkaK6AORI1BYhJ2tlvctOW
        DrMi17fspVPhknZTnPinZR2yFg==
X-Google-Smtp-Source: ABdhPJz9xpmarjEYY69KKbBo6OrTUj6+f98YhVpTCwrY6O0JPMtCCCwu9m5ErVPx4i80Fdv6IHt7dg==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr20228734plp.162.1652187037457;
        Tue, 10 May 2022 05:50:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001dc4d22c0a7sm1719430pjb.10.2022.05.10.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:50:37 -0700 (PDT)
Message-ID: <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
Date:   Tue, 10 May 2022 06:50:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 5:14 AM, John Garry wrote:
> Hi Jens, guys,
> 
> I am sending this as an RFC to see if there is any future in it or ideas
> on how to make better. I also need to improve some items (as mentioned in
> 2/2 commit message) and test a lot more.
> 
> The general idea is that we change from allocating a single array of
> sbitmap words to allocating an sub-array per NUMA node. And then each CPU
> in that node is hinted to use that sub-array
> 
> Initial performance looks decent.
> 
> Some figures:
> System: 4-nodes (with memory on all nodes), 128 CPUs
> 
> null blk config block:
> 20 devs, submit_queues=NR_CPUS, shared_tags, shared_tag_bitmap,
> hw_queue_depth=256
> 
> fio config:
> bs=4096, iodepth=128, numjobs=10, cpus_allowed_policy=split, rw=read,
> ioscheduler=none
> 
> Before:
> 7130K
> 
> After:
> 7630K
> 
> So a +7% IOPS gain.

What does the comparison run on a non-NUMA non-shared queue look like?
Because I bet it'd be slower.

To be honest, I don't like this approach at all. It makes the normal
case quite a bit slower by having an extra layer of indirection for the
word, that's quite a bit of extra cost. It doesn't seem like a good
approach for the issue, as it pessimizes the normal fast case.

Spreading the memory out does probably make sense, but we need to retain
the fast normal case. Making sbitmap support both, selected at init
time, would be far more likely to be acceptable imho.

-- 
Jens Axboe

