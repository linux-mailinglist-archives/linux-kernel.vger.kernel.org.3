Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6715785CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiGROvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiGROuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:50:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9414D08;
        Mon, 18 Jul 2022 07:50:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q5so9227424plr.11;
        Mon, 18 Jul 2022 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vWu6+Y1l1EuPBNVi8wHSs4XnZYKZiVD1hMz9Y5lMF2Q=;
        b=n2dNzfNjhPdrLUZX5nWmRfEj0l9h//NdNtGNq5oo8OgCTbbXa9VuUTr2OdSeFzH1PS
         8de0acKvfKfiYlgmnJeBz/etvBuCG44ocqCb4RqaRRxFu05q72Pxcd5AxLb9sFAsfAxV
         GOhnAkM3ZzlKhYvda86OKhVGzGy9GpNF0dVIVH54dLfgpIuqM1g5BT+JPO/fX/qoMr7X
         cVKT0aMz8B8aCQJFfCLOdkiTGJjwojpaYiYQCEO4dV8r3psD4TnvzATuJEQu1TE2ZHpp
         WTckI+vRQAGdy4/wfIXV5CQTYGc0bFDq4dixFmD3ASzx6/GL1fD8hHtEA3355eK3Amcx
         ZCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vWu6+Y1l1EuPBNVi8wHSs4XnZYKZiVD1hMz9Y5lMF2Q=;
        b=J1teOosMl9AVlCtGP8dc2e+8UTocg4XeMzcLrWlJbfMtRHUG0cTpIVFQLhTZlaN0YE
         kB3Whpal4vnewSPhPLwjsA8p1zCfji+RP9xe7sU3HsmwLDt22RFvEaMkr1VMC5iVfLxy
         hHr/zGYGVPGDvpdPfszIOk/W6see2vYoEXvWzlu8KKkccuo+oExLCCHY6rH77QFXWZY1
         W0HjU6Yypr7P2C0HaRYstZrgorFV1IrQJNIHfYeCiFZPw1Ja0nCZmMXwvUOVStUO1WQS
         hL6KOdYterm/tqQ0KbkYfNjPCxI6BugCFo7HIQhvz3tXl0kz/y6iVYTbD+uvL76aBdid
         tKiQ==
X-Gm-Message-State: AJIora/8asEneeP813if3KhDWrxwHPQqyzYtYtBkYDSXYNCgN422UrZT
        rAamq8VRSLIN2z0IQm17vzo=
X-Google-Smtp-Source: AGRyM1u8uSbXGcl4RxfyVEMJDiMbVqiw+axbZ5aPKidOI2WUuxJG/krmRO0RQGnwGAYXoeV9sS6onQ==
X-Received: by 2002:a17:90a:fb8d:b0:1ef:8d22:35e with SMTP id cp13-20020a17090afb8d00b001ef8d22035emr37829602pjb.229.1658155848837;
        Mon, 18 Jul 2022 07:50:48 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:c1c9:5ca7:2a60:8cc5? ([2600:8802:b00:4a48:c1c9:5ca7:2a60:8cc5])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902690b00b0016bf10203d9sm9585728plk.144.2022.07.18.07.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:50:48 -0700 (PDT)
Message-ID: <e09b7a80-7966-4c71-3139-d6b234afc25d@gmail.com>
Date:   Mon, 18 Jul 2022 07:50:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] mmc: sdhci-bcm-kona: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715051912.31180-1-wangborong@cdjrlc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220715051912.31180-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2022 10:19 PM, Jason Wang wrote:
> The double `that' is duplicated in line 171, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
