Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A175A8DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiIAFyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIAFyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:54:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5741178F5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:54:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id az27so20871833wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E0h+4ukqcPWiSs+SEBzM01Cdvd6fCSITsOpksTq6c80=;
        b=j8oQgX/SV1VH2ZiSDr9xoYd4HnKn8nQe5TB5bBlof5EoRbNayt/lmCCcpjU+M63tY6
         uo9bRisVjIFAxzUot14T2Ao69wlVobS0YF9cQLb9YJEPgk8PPh+GnDdrGLcUFbumdNev
         cyDwMPedz/wJZZ6jq5mbVFkk/WfvBzIaZdES5DUjfvKkx1KWqXTdpreOZb9bIELWt0lm
         C9fk+AxkvXAC+teZVVoQ6uUlmamnJx9daji7sE+qo35L6gVxCua2LFP86702tDXHNCN6
         KWBqRWW24YIqi56xFEiM4GfRTllvEAbGzW2KITSHNC3pYbuXgGAIR/kML51SFfBn+iu/
         NmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E0h+4ukqcPWiSs+SEBzM01Cdvd6fCSITsOpksTq6c80=;
        b=BS+GJrCTPvbjI+GCls+dDX3/o8gE6kfH0ZM5aXbR7pO28DweY83h+a7y8JvIRdMoLF
         VbtBh2ACGubUu7lWdi5TaaP6RaK/hjHmY5vE6FrFdlq1o3c0Al5uZsw8v2O7ornYJyit
         MfYIC95CQO8qQKvdRK2VMC2Ay5THShuGlCNXS6zWxQfLIMBea6uoppySxiwPfcc5/DhL
         fraEZm90GL46a4I4xbcM+6ndWe5gESrTmVmpin7JqoysfNn/CuZzz/SfBeXZlVNnfV4W
         oWsXw/S58OpGx+16xAJhOirpU9JK3+8EAjihhtzdrdifo+oa3ArrS3WKmx28s7rDNQAH
         gH/g==
X-Gm-Message-State: ACgBeo24Ef1n3YBwOP7hCsTAKnZ4lZudirN6vhFqKevSvWvhBQj/XcEc
        ycIMgPqXd9//38F0UB0BedLkKg==
X-Google-Smtp-Source: AA6agR4CMzSXrSknaRIMfiiTvnVtkoXMUBvNkZm/KX79WL9nNplggkPvyDfgOauhxEryLDwTlpmClQ==
X-Received: by 2002:a05:6000:168d:b0:226:da6a:6d78 with SMTP id y13-20020a056000168d00b00226da6a6d78mr9869307wrd.180.1662011676066;
        Wed, 31 Aug 2022 22:54:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm11910858wmp.1.2022.08.31.22.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 22:54:35 -0700 (PDT)
Message-ID: <9a174828-33b2-268d-747f-c6dcea726e01@linaro.org>
Date:   Thu, 1 Sep 2022 07:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] early thermal changes for v6.1-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
References: <0fc7062d-696a-0794-8730-48ef08bcb8bd@linaro.org>
 <CAJZ5v0h0r2dW7xW+GW3=KDEZZEkyYOXVCOmD3fad=a2enNhddA@mail.gmail.com>
 <CAJZ5v0hNCezncvW-g1UVPoF-ZmeVWd192FCaZVWrV-+Ucsycpg@mail.gmail.com>
 <CAJZ5v0ipq3swfX28o4YTCgsX6oyAJfqe385tdYzZXF=2ysfuvQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ipq3swfX28o4YTCgsX6oyAJfqe385tdYzZXF=2ysfuvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 30/08/2022 20:18, Rafael J. Wysocki wrote:
> On Tue, Aug 30, 2022 at 6:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

[ ... ]

>> commit 670a5e356cb6dfc61b87b599eba483af6a3a99ad
>> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Date:   Fri Aug 5 17:38:33 2022 +0200
>>
>>     thermal/core: Move the thermal zone lock out of the governors
>>
>> as the first bad commit, but I'm not sure what can be wrong with it yet.
> 
> See: https://patchwork.kernel.org/project/linux-pm/patch/12067136.O9o76ZdvQC@kreacher/
> 
> I'm adding this one to linux-next right away.


Sorry I was unreachable until now. Thanks for taking care of fixing the 
issue!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
