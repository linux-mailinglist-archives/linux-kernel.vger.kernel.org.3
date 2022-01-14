Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70948E255
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiANCBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiANCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:01:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5BC061574;
        Thu, 13 Jan 2022 18:01:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n11so10056442plf.4;
        Thu, 13 Jan 2022 18:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cd4/SGiXPD6hEhCacRdicixZc/0NYh6bUXzOA7/GX3o=;
        b=JWu8c3lStqL+MQo7BbsBXfiPLFpR4NkzcMrGEdxAfVT2ZHfzjTh8sdaHXU51JKCAtk
         jElJ+Ih5DWYPyePdga7pvdh4rZ2ffC0VHRVFUfgCojOY7sZvDjpB2iMTw/pnmfhTyArf
         I2Xp4MI5/mmLbjLfM4/fiDQSeNqdnfGhf3FyxdVW87p6Mgr024CJm5GphHmd6UFqfTuM
         SNve8z5aLwbMWtEQ7Ezqm0/XWSwpsuoHBdBSg7EbAaV6L92zcdGGuWIul3rEyP6aDO/V
         gk1BaAB4ZIs1tmcIgMb5jNgTg09BSBvY6BbsAtSKd3aWNQ9bESAJndGaRG426YQzM0+o
         woLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cd4/SGiXPD6hEhCacRdicixZc/0NYh6bUXzOA7/GX3o=;
        b=BEEN9Yf1qsc/x6ORsQqeexfLFQk+zYhI8/N19iUOoMrEWSuYJOfh8TQ13npft36kVi
         PY6d3nCH/d4SpE7ISh4O5CjrR5j5wqjewkxMN0BgGk8kXOuIyhpxktCFjipdq4nGFAMH
         JpowKmHIOwLVAv7yo+PlAW6vNsmtS34vSkLkzE/KH5tGzKxhge1y+c3lGrPhn7hAB3lg
         GidyjcDigVOaDDzmdmdXBI1cMGMY9SCktp/tMhw3/QORx4oUC9BNLsKkMJelK9/cBiiO
         ltwGsiKuUzoKTexYHYzh4IUf7QMSprB2msKygGzs1I/9Uns1TFwhmgTKtF8OLaW30M3v
         ioIA==
X-Gm-Message-State: AOAM531eSaHg9HGXWZngKEGeWhLLhOVu7V5cw7QfkM9x9Owm4esuCkLr
        7yjxq6ofNC7kwPQUt8oRVt4=
X-Google-Smtp-Source: ABdhPJwX2Hcolwy/XdrrGkyuZlufjRaG8CKEZxeLKgO81YwIyWXPmST1AU/6HWTQzh09lgsoLeI9qg==
X-Received: by 2002:a17:902:a404:b0:148:bdd6:d752 with SMTP id p4-20020a170902a40400b00148bdd6d752mr7274060plq.20.1642125694784;
        Thu, 13 Jan 2022 18:01:34 -0800 (PST)
Received: from [172.20.120.1] ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id m3sm3711300pfa.183.2022.01.13.18.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 18:01:34 -0800 (PST)
Message-ID: <13cad320-db43-99db-ed0c-61b27a9a3447@gmail.com>
Date:   Fri, 14 Jan 2022 10:01:31 +0800
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
 <faafdf29-6d8b-82a8-c69d-4ab3e623b489@gmail.com>
 <YeBa68w4nQQvBM9Z@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <YeBa68w4nQQvBM9Z@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun

Thanks so much your comment :)
I really appreciate it.

On 2022/1/14 1:01 上午, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 13, 2022 at 10:40:27AM +0800, Wang Jianchao wrote:
>> bw/iops/lat of data or metadata of one cgroup is very basic statistics
> 
> bw and iops can already be derived from the cumulative counters in io.stat.
> Latencies without distribution are often what we tradtionally exposed not
> because they're great but because exposing distributions is so cumbersome
> from kernel. Also, latency numbers at cgroup level isn't *that* useful
> anyway. There isn't a lot you can deduce for the particular cgroup from that
> number.
I agree with this. But my customer would yell at me because they really want to
see that....
> 
>> which kernel could provide especially when cgroup is employed everywhere.
>> And we love to collect them all the time during the instance in cgroup is
>> running.
> 
> It's really not that difficult to collect these numbers from bpf with pretty
> low overhead. There's the problem of deployment for which there isn't "the"
> right and convenient way but it'd be more worthwhile to put efforts towards
> that.
> 
>>> What if I want to know what portions are random, or the
>>> distribution of IO sizes? 
>> This looks really detailed statistics :)
>>> Do I add another rq-qos policy or add another
>>> interface file with interface versioning?
>> This iostat module can not provide all the kinds of statistics we want
>> but just some very basic things. And maybe it can provide better hooks
>> to install the ebpf program to collect detailed statistics.
> 
> I mean, "really basic" means different things for different folks. Bytes /
> ios, we all seem to agree. Beyond that, who knows? There already are enough
> hooks to collect stats that you're trying to collect. The examples in py-bcc
> might be a good place to start.
Thanks for your suggestion. I will read it and try with bpf

Best Regards
Jianchao

