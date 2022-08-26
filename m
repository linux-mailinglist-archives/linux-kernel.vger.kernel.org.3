Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2C5A2568
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbiHZKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiHZKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:05:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA146413
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n15so1368151lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KzbOceaNTdDVnBmlwaML66Ag3gKl0lXdyJPKSYlfMfo=;
        b=q8eihlZNapUVxFRiEU7EF/LhPsaz08qpV4fS8UH0p1tLfCsASqzJK4ypoixw0h/ez4
         6CbzJZjfGhPUqbHSpQRiDIJB8GL9CW4LQ9rhDaySA5C3rKbjesmGRlKZZGdpL1dHr4wk
         I5DCiPc7BjD/AnmMdsmpgv1bK2A3gfaIxeEIayc5QCybaFZHgCslg8K3X8Qo+lBUjELW
         KghkIm4r/LbqnSdq2kXDtYmIlYQgTNNL1nNWOp3pL4RZuggBCGYsfnrivqnV8IoQQ0vr
         clpfazGqs60ASVHKOPHj5Gut9iyLthfuMtsm3eOYpIjzLb5GELVJEkyZvYDTSsImlrAR
         QBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KzbOceaNTdDVnBmlwaML66Ag3gKl0lXdyJPKSYlfMfo=;
        b=aCfIkrm9gg5qqydyNUsNLMuLwyl6cPVyG1HuOSn1BjzWk4yVPiiukyFI1ZSZjR3p97
         jvqHFrABs0V7jv3OMaT932De13tkS8nBZsvEhrcXI94izsA+wi9EXe6Hq20xvpkxdGx0
         36kfm5PczbVsU6VG0ZosdvNioN4RkVbEzDjAO8OBO5LeOJ/Q4cZ1LR+eyncGCnrOLpEK
         jbsB6dty2CPYwCarsudekwliqSGl60cQ+B78sFQYSoyfXNfvYKqaczVlcGP8BF7R3kXW
         Euf/QqAuwEhFeW4Iv74Ti7xL5dbN0RmwzmY+AxWnAJWixO2+vSGjAT8F7c4AZi/cXK3L
         lalg==
X-Gm-Message-State: ACgBeo0DLkKt4OvoHNeBSFoInIQtmX9VapNcCJ3PnR9+zV41/Pfe6pHA
        7KO3i905kYC6CzZNI7yPyv2ArQ==
X-Google-Smtp-Source: AA6agR7XBftW2NwzU7hLIQQlu/k8toww0vgW9/YoDFtF97R9hU26kKpJdaP34/aFNMlrNfNooKaMIw==
X-Received: by 2002:a05:6512:234c:b0:492:d9fd:da59 with SMTP id p12-20020a056512234c00b00492d9fdda59mr2174078lfu.63.1661508302738;
        Fri, 26 Aug 2022 03:05:02 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j28-20020a056512029c00b0048b17852938sm329074lfp.162.2022.08.26.03.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:05:02 -0700 (PDT)
Message-ID: <ca972ced-b4f7-2eb4-0381-095cedf5f356@linaro.org>
Date:   Fri, 26 Aug 2022 13:05:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] msm/adreno: fix repeated words in comments
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     wangjianli <wangjianli@cdjrlc.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, wangqing@vivo.com, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220724073650.16460-1-wangjianli@cdjrlc.com>
 <0e16e719-4eb2-bfb3-6b77-88d5314757a1@linaro.org>
 <20220826095311.GG2030@kadam>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220826095311.GG2030@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 12:53, Dan Carpenter wrote:
> On Fri, Aug 26, 2022 at 12:45:09PM +0300, Dmitry Baryshkov wrote:
>> On 24/07/2022 10:36, wangjianli wrote:
>>>    Delete the redundant word 'in'.
>>
>> Could you please:
>> - adjust the commit subject to follow the rest of commit messages,
>> - drop the extra whitespace at the beginning of the commit message,
>> - add a correct Fixes tag.
> 
> This doesn't fix a bug so the fixes tag is inappropriate.

Well, it fixes a typo, but I see your point. Let's not insist on Fixes 
for the comment fixes.


-- 
With best wishes
Dmitry

