Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AF4EB0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiC2Pgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiC2Pg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:36:29 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F05CA0D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:34:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x4so21404089iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=htBX7L4Dsxnz/XrjDNY+IIiit4PR6UfEgdlGlVmAc10=;
        b=BOJAerkdMLPAWF6Fbj9L+HP7t58FctG3RomHvcwAWryDr9qR9qTFEpQQjin0iETsIJ
         Ia2ObqXDWctfEOP0NvX5V8SljA4ZkrWCJ2tj/qjxfhBIV73T4lQbAIcxPe5/zk3AISkL
         VSmlGK6sjnyL8xKCH1M0Jm62fInohQXJhqq6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=htBX7L4Dsxnz/XrjDNY+IIiit4PR6UfEgdlGlVmAc10=;
        b=Ri6lqrlLHF9Jz41jltgxMJ8Zy00YJKSsr/QIrzSQFUU9VXw4fcTQWXLRPhcjC9QDmd
         92iOLUROMkgNSTVbP+KyU0wwGyd8yfwwvu+s4VS96YK6bY5+WU09KLnHrheIgjcXLJWd
         Gg2SYiripS3tV+vf+Fy5bjY/pzso3ksOPsn/5TmOB3b+i//YTkTKu5mHgORVwGZ7Bf39
         dYjqjbt5lcufW2gnq+YKNCdUyH2PF1Kx4WtVKIQaNM6yKkhgnwggdqLQBvNQNCVJGgKw
         FjrCW1spGhUBM1d3OhNAenRZcRSoWU2RDAzFXA4ZbX0itn9DdgI1/GH7Gei3EBnRDmpq
         M0qw==
X-Gm-Message-State: AOAM533+8UsJBbtD/BzwGHC9Uo11wFNfl57OFmjyhWljmx520sYoD8L8
        ZSydku2PlbGTWvLQRnaSdVip5w==
X-Google-Smtp-Source: ABdhPJzfhtLxQM1xtXtWtwV8YaGmygkTHU8Mm5KMZbG7uj4B2Mq0NA/2DemnGbPpL3OV6yk84Uq9Ew==
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id z14-20020a05660229ce00b006094f6059cbmr9539011ioq.183.1648568085905;
        Tue, 29 Mar 2022 08:34:45 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v7-20020a92d247000000b002c9dd3a2d38sm255450ilg.31.2022.03.29.08.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:34:45 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <20220323080928.1586408-3-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <61b7e805-975f-d273-58b5-46ec9ee723d6@linuxfoundation.org>
Date:   Tue, 29 Mar 2022 09:34:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220323080928.1586408-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 2:09 AM, Shaopeng Tan wrote:
> According to "Intel Resource Director Technology (Intel RDT) on
> 2nd Generation Intel Xeon Scalable Processors Reference Manual",
> When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> Intel CMT and MBM counters may not be accurate.
> 
> However, there does not seem to be an architectural way to detect
> if SNC is enabled.
> 
> If the result of MBM&CMT test fails on Intel CPU,
> print a message to let users know a possible cause of failure.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
