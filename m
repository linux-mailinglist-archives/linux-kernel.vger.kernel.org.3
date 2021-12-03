Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93F467EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383042AbhLCUTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353691AbhLCUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:19:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D52C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:16:05 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u17so2855091plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzMayMOi/4q+dZKuw1AxUkOVaUAd0cVshLCLqLI2BG4=;
        b=lreUV9VEbNGfRas91u94k6ncIVq6GCBCdtF3ziIdTDKAWkXIXXn6jE/wuqQ57BgCVn
         dR1CFDB64g6eZdq7Y6gKENiLOKpCkgrB+OXDfTySunPazv9ugyHAf2kgQv4z5FFMRC3P
         etYoxz1IXWh4Zx4zJbRtHMC+ZoR8Zsl71I3xE7s2eNH6hCNNP8SXGt11tgPUYQ8C1j/3
         dFzTsgYfhbEP01I7NEDREGKSHEjeYqoYTBg1EgGH8mnXMFUY7j9KshmoKCmlW3ZBOFHc
         QThcL+WO9rqYyJIyn8GRYDDYeqPrCZ7Rgnb3zRS9K8MkCpmPUC1gprwahbtz6Vx38oJD
         wafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzMayMOi/4q+dZKuw1AxUkOVaUAd0cVshLCLqLI2BG4=;
        b=UcpxE5BRaIwIYymreFAFHP0Csb2TbwRAqGpTKB16Oy9gFF/rGxbBlobyCQYBalm5WF
         /2v2qBflThN1b5wZHXIAdF0xp4T2zX7SIN3WBwGXT3z3EgVPX6rjiKUbPWUXVfk1PgK4
         nNaZhWD6T7h0DWPPOM+Cr1NANDjWj/eqXjyvzn9ljXetWgDzu23xoRRPDIirha4hioAh
         dc+UGEnXEyRaD4tKGD0QBmbeiSMUjFulpt1B1hZM7fp/DjeX4ggz0165Axye8bGRwSqV
         j9aef5qUCkOxCheUNlj5KGx7Uk9LlrNZ+QCmZeVc82c5o0ir6u80iXoJCclUs2MUG/n7
         RmFw==
X-Gm-Message-State: AOAM530/KUabJitWIjNPU3q34iObHw9bsZ7mWp0oIxExdL3jCZq0OPNw
        X97sMGv2GuM7IUJL1qV7aZ8=
X-Google-Smtp-Source: ABdhPJwv+6x/fMuTn2yttDPbHFIh7nzCC5khVM9K0ysHfvUeHcNm/RU/RsNOUrP9m+f9V4aRWPT6Ww==
X-Received: by 2002:a17:902:a510:b0:143:7fd1:b18a with SMTP id s16-20020a170902a51000b001437fd1b18amr25316854plq.2.1638562565358;
        Fri, 03 Dec 2021 12:16:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9sm6128791pjs.2.2021.12.03.12.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:16:04 -0800 (PST)
Subject: Re: [PATCH v7 04/16] include: trace: Add new scmi_xfer_response_wait
 event
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-5-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8404258e-517e-e5b1-d4d5-b65a92996c2e@gmail.com>
Date:   Fri, 3 Dec 2021 12:16:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Having a new step to trace SCMI stack while it waits for synchronous
> responses is useful to analyze system performance when changing waiting
> mode between polling and interrupt completion.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
