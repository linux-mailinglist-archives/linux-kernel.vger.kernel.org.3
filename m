Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0319F50DB67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiDYInt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiDYInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:43:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB179384
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so24874829lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZcdnWGM8WkBye6IUjfNt0fUtbN96fO579MEnhWi9EhM=;
        b=K4v5TTbl2/F79DPQrGs+oZfZRincVtGYfnQS3HuIuM7IUwaaE3UdzuQkCSCKDqfRk/
         zLXNq6eb82PhJ3vdh+o2hGp/reJmKlpA1qcxNyCY7jZywHAWqJh2FAf5R5pGmI1Hqn5t
         dWdNVXZVGElQfQDVIOm9VYoARxV40i0pFGEgPLTPimRElwnKDx9eDPwRTdDg9nAOdWLB
         qDicTP+ZMB2hPCm6RwIZtbHNzxO+bUDQNUGe2eNJDb3TVsh6Uqny2nIXBPsUwDevOcVD
         3syzY5LeqfDOAkMlu11vi1Dc2X759cTUeHa+S3MsE4pUCk2DUgNz4CVH78rRBWWAYJ+w
         O7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZcdnWGM8WkBye6IUjfNt0fUtbN96fO579MEnhWi9EhM=;
        b=yTxb2aHHqRNqOcTxcAP2PG/dk7cDChrAe2fn0pAg95t9edoFZUOm0qa1ehNh4Na7wD
         SLlv44ORuaj6fBZ5p1OUx6MTd0tawZLNtkdOWdnukD0K1bIwuGh6MS2+tTTmqgcAYl//
         STo5/crbdlSdSllTuyg8Kspxa37OJ0dy1RsdZhN88De66hvpQYZcYwVKyKyzMfzwPije
         veH0uv1Xqlu5zrsRZaMo8yja8kvRx2FxpHLR0hBHWXfmn7eEV7t/qLUKOjXRuq15/TcJ
         RYT4bgitP8M6R2a9vvSSjoP57NK/9Rf5xJpZT25V0fjdey+eL7lz9bqwiT6Jw8sC9J61
         0+tw==
X-Gm-Message-State: AOAM531HY5ZmweCsgOon4nmVyDljf6mllyWOuQpi1PF+k2wbnv6XTKb/
        nCSjYLGRNc0gpsIZCKobwgXgyQ==
X-Google-Smtp-Source: ABdhPJzRhr85jV6wQ8jKEJmnVHlG6Dn+JX1qu7c1cRwn6r4eXkqxt+bwSHlgUb2l6DqNpi3R7l2pKQ==
X-Received: by 2002:ac2:4c42:0:b0:471:a8e2:198e with SMTP id o2-20020ac24c42000000b00471a8e2198emr12044797lfk.673.1650876023282;
        Mon, 25 Apr 2022 01:40:23 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id q29-20020a19431d000000b0046bb8d1e4f5sm1335008lfa.262.2022.04.25.01.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:40:22 -0700 (PDT)
Message-ID: <791eca4c-8ffe-7ddf-cc48-7c3a29b858d2@openvz.org>
Date:   Mon, 25 Apr 2022 11:40:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/memcg: minor cleanup in non-memcg_kmem version of
 mem_cgroup_from_obj()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
 <YmZPqAOLO7XkBsW8@dhcp22.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YmZPqAOLO7XkBsW8@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 10:37, Michal Hocko wrote:
> On Sat 23-04-22 05:23:03, Vasily Averin wrote:
>> Replace leading spaces by tab:
>>  WARNING: please, no spaces at the start of a line
>>  #X: FILE: include/linux/memcontrol.h:1480:
>>  +       return NULL;$
>>
>> Fixes: commit 8380ce479010 ("mm: fork: fix kernel_stack memcg stats for various stack implementations")
> 
> Please drop the Fixes tag. The tag is supposed to point to a functional
> breakage and this is purely a style fix.
> 
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Andrew Morton suggested do not create separate patch for this change,
So I'm going to combine it with my next patch, which adds a few lines below.
Even if it will not be approved -- it isn't a big problem, someone will fix it later.
