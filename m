Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7856D307
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGKCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:40:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28AB165A4;
        Sun, 10 Jul 2022 19:40:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so3608600pgs.3;
        Sun, 10 Jul 2022 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cVE7wOlVeNoq1ySfCQ4BILmyFDppX/c2EN1/2ktSi7E=;
        b=lAZn5fjqQJxtVCnpPOB8/uAa8Cvj+PbSrcMGX9JC84aSbNGEFj7CJorONn1amlml8l
         a76pMzVRoDatox9mAR5C0N7SbVHuXruMIm1JxYTYVECEGHlGq+496H1Se/vY48GITr6N
         LbX/W8ErNjIhf23aTLPPxr1AXPiS42F3H0ubTysYneFxpBPU6eGtFTNMuzjc+YBUjRmB
         /Ht5md1BNgwGUMMaZ4f0JLjN64D43dFjSYElz6Zr86T2pcUlh1WW8o8/QHuCF1lI8snh
         GelhZ4kvPFy/RMcUVVfRnBSu1Kj3thyhhD1Mm/uv8MEocOyfVA335OWK86AC93e51P/0
         auBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cVE7wOlVeNoq1ySfCQ4BILmyFDppX/c2EN1/2ktSi7E=;
        b=IuE+qcUjyx9bZkqoVFwhrqgYfYhAE5V477p20dEbS8LldxS6KhyLdtzxNnUpvorgzh
         8QsC0qfgg3OScsJENxpg6V5SuB+6NXI6p2LSO3eNCLVHjLxfQZ6Rq/5Rld8nQKTV1Sd8
         gPxeEnai1gmjzY+cERKvjWUi0dfBbrfarVZrqQ4j7jab1HzIaGRbZVT7KIR5/zwz1CHs
         ZYqVfSj2DDsod/H1AT4kskk0x/P1gqNvQFT0dK/Cih0uVbd1NC7UFEP8K77SqMK0DOL6
         r1ef13aV5zbUfPfd46S5z+rkRR5JomzcwREJe8dctsyBqvIGrP8Gz0h22iTEmqAKXNZe
         LePg==
X-Gm-Message-State: AJIora+SSaHpAmUg0RVeIw0UwF88G3afXHgjmSD0nNqaR/6FTudtBLwD
        7kMRs/JN1PYScQ0SkINqPiY=
X-Google-Smtp-Source: AGRyM1uLsbArbBufRT4sZY/RJ0B6O7H9L+XcFPJl4cjIAj1KyHZzkJhMnE452gVQxC4+c7t7ikwXJA==
X-Received: by 2002:a62:e817:0:b0:52a:b9fa:9a54 with SMTP id c23-20020a62e817000000b0052ab9fa9a54mr10507357pfi.61.1657507219377;
        Sun, 10 Jul 2022 19:40:19 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016c433f7c12sm1319528plg.271.2022.07.10.19.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 19:40:18 -0700 (PDT)
Message-ID: <aab5ce68-fd50-7be2-1ffd-1652564d59a0@gmail.com>
Date:   Sun, 10 Jul 2022 19:40:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v1 30/33] thermal/drivers/bcm2835: Switch to new of
 thermal API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-31-daniel.lezcano@linexp.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220710212423.681301-31-daniel.lezcano@linexp.org>
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



On 7/10/2022 2:24 PM, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
