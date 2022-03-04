Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362554CDFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCDVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiCDVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:36:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6A5F4FD;
        Fri,  4 Mar 2022 13:35:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso9078677pjo.5;
        Fri, 04 Mar 2022 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XsC7mU8ah15EW22L8EEXM/zZVwqEyUHDJiXvi6kLCqY=;
        b=qFn074RcGcxg2ckoRJn+fz2sN30sBmknx0Z6Vwi41mAMLl7o1Yrnmxe5oNXGm5wpgF
         AeK0uV1JQDl3pC8geGE6uEHLMtqaAolI4ERQT/kHsu5VVv+ChRoOt8uwqcV2CTO5HQ5c
         mV2bYAAh+9RPakw/xacPbSSI06uZfLVulmdUed7nOJcWndKJv6tVzh1jm7+1W2Pfcc7z
         6UvFIInTK/1GTOYzoVPaXu8BKXLt808GA1JfMBgbpveluw1eTZyqin4TRVQ3hmjkC9Ym
         97Rew6WtPlPTJ2DDtqJh6ij/1uDYG8Zt/e9rTGTu/ee7hTDqKaXjDKGzNuqPPBvnnMH8
         Rssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XsC7mU8ah15EW22L8EEXM/zZVwqEyUHDJiXvi6kLCqY=;
        b=ksCPJxz89L+ct4WSMh6UT9wSlapxK0RaMMItHiBA3fh/UBJ3cVARzeyd/j34O6xrTW
         NdDDmP3EntQXua+GLETZoHVKiDC6S7u8ParboMLrKe0JHkoRlK8nrdu6CtrfGLLjeafT
         EuSeNvuU5iey0Tlfa2SdMVR2+4EobHTHu7ph0LC6kFhzi6ctbUBu/tAeQ34nh3jisagm
         WZmTs9QWdghtb5xkj6X2iFIv0WXccPwkAmPa1fpXGAFck+mq+FmOj8Lz65Le1+tGhYJj
         0jDHJSXw48p1EBKbaHs8fDCXuVc1ckA2kCCsvVmvLzcMhLpfchhxZR7/mhgpmGfKnmfp
         S9mw==
X-Gm-Message-State: AOAM530nWTIXWN28IsIcxr/5NY4CQBeMgoaqZXW7ofx2WpVrLpH/Rjt7
        Ydb6ZxQRKe9ZBAm4gRzCcHw=
X-Google-Smtp-Source: ABdhPJyMrhGhQb/8noLZzOQ9HqiMRHUEzs0JipFyO3zkq3MO2iQ1u0rrVHOLRXdHbSSZUbxZ/26GHQ==
X-Received: by 2002:a17:902:7285:b0:14d:7f5b:94d0 with SMTP id d5-20020a170902728500b0014d7f5b94d0mr314076pll.25.1646429752348;
        Fri, 04 Mar 2022 13:35:52 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f0fbf3b524sm6771062pfk.206.2022.03.04.13.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 13:35:51 -0800 (PST)
Message-ID: <7a4c35ed-9a45-268c-c5ea-feba81855235@gmail.com>
Date:   Fri, 4 Mar 2022 13:35:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] arm64: dts: broadcom: Fix boolean properties with values
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304202551.317448-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220304202551.317448-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2022 12:25 PM, Rob Herring wrote:
> Boolean properties in DT are present or not present and don't take a value.
> A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
> matter.
> 
> It may have been intended that 0 values are false, but there is no change
> in behavior with this patch.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks, I already have queued up an identical change just a few days ago:

https://github.com/Broadcom/stblinux/commit/c953c764e505428f59ffe6afb1c73b89b5b1ac35

This will be submitted shortly for 5.18.
-- 
Florian
