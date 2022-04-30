Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E8515B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiD3Ica (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiD3Ic3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:32:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC1AC92B;
        Sat, 30 Apr 2022 01:29:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q76so5105570pgq.10;
        Sat, 30 Apr 2022 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gB+zQE1Fr82L3Ub205yd3lvblvXhsJRPbH6pXWzXle8=;
        b=bgPuwGzlkw++FhQ7dUv5XPLtnJsm61qI9YWiE9T+YyjCBlGt+RuhjFGZ3HjkeDuZbT
         TZBoWSUugNOQpEqtv390Mw81AzvUjwYwYTCNUskRFJB+bCYSC5Dnp4XPFwtF/SuPuOnC
         4su0QX7kfdmrAqeAcErlhwlrIX9jvBCoXwS8K8npVi8dN8PzR+RAR9xLeVJfpuP8Lckh
         eQEfwlKxntXeENwzq63luGR3CMJsWR73TZfzN/qBPfQNC7mqhuqClnT1a0vqgfUHKqbh
         WaZ0ssaEW7FEj7LuRBO4/kHvdRHm1BXb6OMiRTYgssymtfZOTOKlWjFLo/LUq0NGK8uG
         ErMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gB+zQE1Fr82L3Ub205yd3lvblvXhsJRPbH6pXWzXle8=;
        b=KZAM5O308igvQYENMIFtembNnt4WzU3n1EaOpmRuLPjt2BTQACpv6J410dJ8O86Qvt
         i7KAqURdS/S5JDI4o94tsUs6eCsARzYEHRXbKGs+1LxY6qkGmc0EyDCoLfU63d+WIyv6
         /4wZimyIthaWbh4y3vEBHCVSAjMrEG+6Pwa2l6FNJK8JuKZPGntwf/MsQ0s3uZGHFd0T
         UfLdctZS3uvK7/SSKZWwMN73EHzA5MMjamSBCtTFC5VUBNdRoWplkllzpNbZagD/iCTs
         yrwiHcGeHiJwXPz7sLJLk6I/5dFhTV3U+UuvrQLFoo6QQ8eKv/tOUJwra0UVrsFSfQFi
         HNTQ==
X-Gm-Message-State: AOAM5334Id10b4LU3jHq175ALBnqg/7Yuh5L7X5viwan9+jnSrd8+/Hp
        WpQONpV6YXxKBOW97Nho35U=
X-Google-Smtp-Source: ABdhPJzPR0x4GwArUE0bivFvPKnSAUUm6VCQwn8mzy+ntpCJ1BSnnkQyFkkt/C5M2WhZAja1N8Fmjg==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr2490030pfh.35.1651307346993;
        Sat, 30 Apr 2022 01:29:06 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78e48000000b0050dc7628199sm973304pfr.115.2022.04.30.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 01:29:06 -0700 (PDT)
Message-ID: <4a68c764-1467-d384-0b92-8dea03f914d2@gmail.com>
Date:   Sat, 30 Apr 2022 17:29:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and
 Describe details using table
Content-Language: en-US
To:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     akpm <akpm@linux-foundation.org>, baihaowen <baihaowen@meizu.com>,
        seakeel <seakeel@gmail.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        caoyixuan2019 <caoyixuan2019@email.szu.edu.cn>,
        yejiajian2018 <yejiajian2018@email.szu.edu.cn>,
        =?UTF-8?B?5Yav6ICB5biI?= <yuhongf@szu.edu.cn>
References: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
 <ea37d4f9-26e2-272a-01d6-fa7e8c62687e@gmail.com>
 <tencent_088763F35CE233FB6C9CEB80@qq.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <tencent_088763F35CE233FB6C9CEB80@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I don't read such a broken (no line breaks at all) message.
Please check your e-mail client settings so that it can send proper
plain-text messages.

I can test the receiving side privately.
 
--
Akira
On 2022/04/30 17:13, Shenghong Han wrote:
> 0) If you have received a similar reply, please refer to the latest reply.1) Accidentally used Chinese Input Method Editor, leaving full-width symbols during the test, causing the double dashes of "--" changed
[snip]
