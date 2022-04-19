Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B0507AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357648AbiDSU3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357634AbiDSU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:29:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D637BD6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:26:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i20so23938253wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a+z1D78Gbz3cAV0zdLWG71fldhmePqsyHjdT7ED1WtM=;
        b=H6eovkAEjrrUdalXqH9x5o5ANwXAYXx7CLvPnFawTQCH6SmGtjjyiOqfvqrdRtoBNI
         RssQb1+UpVSO/YjwFkymfQ2OMs107CLvnV3Q+ExNysayQpmHX5T6YKdo3iqM5G3akcUV
         agfHui+RXf4FsBFmQ8ZFXKc/2q6DdBGnbSwGMFnAYaKDw6jpFuvMCdJq6IHAQd+uQ4Uh
         5v4MxG9ws8gUx9QapfOBBYWPCEDNcyWSaFoJQ9mPzBnP1VxHVpeF98OjUZZg6xkTRo4J
         CGIiEAWLGbFbVIb/lPLFRDpBQIbf4GUZCi6HUGlEBuGk6/HyQIg5P3+mSqALyf0TIxtW
         eiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a+z1D78Gbz3cAV0zdLWG71fldhmePqsyHjdT7ED1WtM=;
        b=cA8+mrBH1wV3/pmwH9eAQ6r+MjQY76SXjltCyFS23Da7dRECCWItcV/Mz40HqXx1yy
         q9HslEsgresg+XEhXjkz116wqUqnPKNTqsSoZykMcDjqLVQPQs02B4koY0Cgg16gTd0/
         LGJWyrCUIe1qeCIrjKPLMcpuAw8uZvmRyOLNfZ2SZ9sbwbCNsuEFUZKnQX2skRQCsaFy
         A7zCuvOQlLNx/BG2oEecrvEHMkM4uf952r1+PBWLIkrgCmF7OmPHhmk24e8XAavnmADX
         qZIA1ng2R1rUvsPB3l3F/m/ihKOECb57SLmLFKVv+sc+QLZBa0SNqaq7s5ZzD34t/0Ok
         3Sbw==
X-Gm-Message-State: AOAM533YmeXv8vJPqRVXtzIoWRdpwEKDRXMbz0zap4Z+1CqVL3oihg5E
        6U5yE2R332iNiKONH2Z0gjCDKfuZhYqSdQ==
X-Google-Smtp-Source: ABdhPJwadU/RPjdcz9vJPtrUlDEVudxpsmovS/6ztZj6n6p7UGQGVzfxzpSfgmyJBLoSxNrZaMeufw==
X-Received: by 2002:adf:eed0:0:b0:207:9b35:62c4 with SMTP id a16-20020adfeed0000000b002079b3562c4mr12799484wrp.509.1650400018109;
        Tue, 19 Apr 2022 13:26:58 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce36esm5574680wrc.1.2022.04.19.13.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 13:26:57 -0700 (PDT)
Message-ID: <51d63f20-4834-184b-2ac2-30c399bd9988@linaro.org>
Date:   Tue, 19 Apr 2022 22:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
 <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
 <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
 <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
 <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
 <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
 <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
 <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
 <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
 <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
 <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,


On 18/04/2022 05:36, srinivas pandruvada wrote:
> Hi Daniel,
> 
> The attached diff fixes the crash,
> 
> Also when you run in daemon mode, you need to use some pid lock file.
> Otherwise it launches multiple daemons.

I've been thinking about it and I don't think it is a problem to have 
multiple instances of the daemon. The netlink allows multicast and can 
be run as non-root user.

If the finality of the thermal engine is to manage the system and has 
some code making actions on the system with the root privilege, the init 
scripts can take care of the pid lock



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
