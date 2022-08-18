Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65402598560
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbiHROGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbiHROFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:05:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9573065823
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:05:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z6so2256290lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HZTud9HkPPEAzVyeY78nhw8tkvX6/g6p+uFQLKmJass=;
        b=g5jltoZmuPm22HhvlKzhU538ah2HnvH2RfdPJH+8LBpsL6PqIFBXP8bFv+owU2X84Z
         xrpi7plX0z9kj2biIQ5zzv7tHzS3vz2sy9ZaGndKxaTgzx1twLki+S+pm8frvS3xEB8G
         /ejP/bccXdFCAETyonIwGA+r94XRwbeKRbNU/udaIRiSFOsUbGUeDCJOWvwH8etK4KID
         FuJrMJLkim01831RVMbDRNt5IuYe2ncVtFUp1exPYEiVp7pE6JQ6N1UWL/zTlIliis6k
         QKphLzXVtqps2ohCKutpncAp6gq8tHWyrW3Lcflj460lml8qFjOPE1MTSsxBQni3fXlW
         wIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HZTud9HkPPEAzVyeY78nhw8tkvX6/g6p+uFQLKmJass=;
        b=qCXtodDLc8mNEi34FQf7rseqEoTxk9j4ne2wKzqb17xVautvWsL/VWq/oAIcsNwdbM
         Ome9VjJj83j1BQf5pN/Vmx9a++EPsHa8pKf22DA8Ti56pm7ez/EImsY22GUy1uv3Il/x
         qDjfElVDvX+l2cTNFpMTbCapke6jAJ8lw+o2zcQDNuv701UJsUWjYeUUEyOhuV8rYiVH
         DsVzogR+h+U6/8tnX5ki2hgBNGxW06va9yrnEdvQt1KI9GRnV8w0+9gyPPqOACaGDRH5
         /POgyhfDtMFIXbEzl8kuTDNcfO+ec0gzOKkIaSAUM30MH8D9xOZBdRkKrxlINqXE6W55
         McfA==
X-Gm-Message-State: ACgBeo16bQ7CmaHPOp5QvgYG+QeuNYjn0bz8h4WT2wynA3KImI295A1c
        3Ut6qbKzPD9STsuhXr43dxFckQ==
X-Google-Smtp-Source: AA6agR6D/2UnC0hwovcHK7ksivh/Pr3BWIMRpuw1lkUvHNMYLIMKdc3dD0WrQHvxVoULFO+DF6w6KQ==
X-Received: by 2002:ac2:5462:0:b0:48b:2a7b:3c15 with SMTP id e2-20020ac25462000000b0048b2a7b3c15mr1025066lfn.489.1660831546000;
        Thu, 18 Aug 2022 07:05:46 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e97d5000000b00261b21ea8a6sm241714ljj.99.2022.08.18.07.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:05:45 -0700 (PDT)
Message-ID: <9453b5ec-250e-dcb0-b056-ba88a5121c06@linaro.org>
Date:   Thu, 18 Aug 2022 17:05:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-2-ben.dooks@sifive.com>
 <f07d2072-4056-bf2e-82d5-271d8b8792e6@linaro.org>
 <b3605922-a0ef-7d44-7e83-3146b6c17068@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3605922-a0ef-7d44-7e83-3146b6c17068@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 16:43, Ben Dooks wrote:
> 
>> Best regards,
>> Krzysztof
> 
> Thanks for the review.
> 
> I guess this is now too late for 6.0-rc ?

Code for 6.0-rc would have to be accepted by subsystem maintainer
between 3 to 5 weeks ago (depending on maintainer), so it's late by 3-5
weeks.

Best regards,
Krzysztof
