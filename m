Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E458F65B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiHKDTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiHKDTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:19:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819057D1C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:19:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x9so14351279ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2H2q+JxcdU2K5D6OGufSB8kzsC/T4lPmnkoeLSNkGtI=;
        b=Ul8VjYe6i/U3bGwtbHnbjXKWRZev/42zZbHBtU2xvelRy5LK6PmvpQBowKrs+dqc7N
         8SQSlYRYcK/i1dj2TD9X/n1wdiBkIK8RJB3cr7rvF5wmVoKxSzB++pzmitp54wDnul05
         DGDwiKMS9Z4hOgMZdvh19cKHlh9cEMAmEl9v0ZHpPQ7UTfQtnm90fwLIrEaejOv/BfBW
         vwaTYUok2ei1M7FrTwLbRe5U4cUcsCJ5hI1zjvOC/bhqCBJg4JweqSw3YrZPiMfMsXzl
         2sfoFEoEm4cF/BiIIkJ6DPQjwAcl1uU+091YwSySm+nFC+XmmIcB2XX23Xyam2g9GGZw
         HzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2H2q+JxcdU2K5D6OGufSB8kzsC/T4lPmnkoeLSNkGtI=;
        b=zaXY2kElEIIjFch0yAWHAXpYALG+uhsTmoImdI6czMvaDy0t7PBUCNhViMUBTMZU4m
         OMtI9XW6p5YyfUC29pe7SjSBGCS9pNa7j3SqrjrBwy6gAFQ5TDGMu8YfydB59wk3nODT
         QHJ080izfVsbnN/1fIrRKXqp1lfHQ6EuiJ20npzdvathJp460z7MS8ALYdQeKCKCD+6B
         fn9IU+oELlWgFs5yeAwfZpXZ+GSvUvDFLo7A3EvQXiXmjisZAo9fpQ3ZHZBy4ysHJg1s
         9kaFl2xiB78nyosJzD0tdfLKVYUNhu6cuBMWXA9HlPWdP15O3gQ1Xz738W65EUVni/+3
         zOeQ==
X-Gm-Message-State: ACgBeo3eYB4xUmCQ8fyDLJAT1e4V4czd5aDDDb9juUg0TKfoEqZ6wWWE
        qbkCp+0AKnrsuWkrMtd6K+Yorg==
X-Google-Smtp-Source: AA6agR6NDczxVNGCHPqXZw5iTtGttVIhXbkPh3A5RmevzYq8K4XxDqmQSU/hE3MqO0qO9M3BT7Kl/g==
X-Received: by 2002:a2e:844a:0:b0:255:46b9:5e86 with SMTP id u10-20020a2e844a000000b0025546b95e86mr8944682ljh.388.1660187953677;
        Wed, 10 Aug 2022 20:19:13 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b0048ad13756dcsm541042lfr.223.2022.08.10.20.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 20:19:13 -0700 (PDT)
Message-ID: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
Date:   Thu, 11 Aug 2022 06:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] enable memcg accounting for kernfs objects
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
 <YvKZ8zYJFhhFvRxO@slm.duckdns.org> <20220809174934.GC10478@blackbody.suse.cz>
 <YvKfxGvg5/J0+QoD@slm.duckdns.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YvKfxGvg5/J0+QoD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 20:56, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 09, 2022 at 07:49:34PM +0200, Michal Koutný wrote:
>> On Tue, Aug 09, 2022 at 07:31:31AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>> I'm not quite sure whether following the usual "charge it to the allocating
>>> task's cgroup" is the best way to go about it. I wonder whether it'd be
>>> better to attach it to the new cgroup's nearest ancestor with memcg enabled.
>>
>> See also 
>> https://lore.kernel.org/r/YnBLge4ZQNbbxufc@blackbook/
>> and
>> https://lore.kernel.org/r/20220511163439.GD24172@blackbody.suse.cz/
> 
> Ah, thanks. Vasily, can you please include some summary of the discussions
> and the rationales for the path taken in the commit message?

Dear Tejun,
thank you for the feedback, I'll do it in next patch set iteration.

However, I noticed another problem in neighborhood and I planned to
add new patches into current patch set. One of the new patches is quite simple,
however second one is quite complex and requires some discussion.

So I'm still thinking how best to solve these issues.

Thank you,
	Vasily Averin
