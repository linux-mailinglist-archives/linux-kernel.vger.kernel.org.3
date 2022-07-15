Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168C45769EE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiGOWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiGOWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:34:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC758B7E4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:34:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so8523913wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wOP2A2FeSpHI1WPKlFbVK/7JXB5FOqAuroR4HnQVIN8=;
        b=yU9E9Wg5JswBO9l8eJlendpb+vPlcQCfr4Y5vU+yHGP3wDLUgKEGxGWipU0CuHSSzZ
         5QKHvpmDNEq9bU/xfGJ+UwJXQT469Plvf2uL9Zm6VDXbbrXjx+cQQjvqxEuUYUkq01qh
         OwwgXhE/YJ1RnarjTa0CQ056VFpGpq/ADeoQeTU2+c5bTgLrvtUDMC/aEL4UoLgW6hwj
         S4+S2PYLtE9ld6VXyNFmIMibuL1v/MC6kY3iSNPX+HdmuXCVG4dvSFiZaTNw2/4YnUKQ
         510GDbFsryCi08oVM816gquWyJLJ1oJbCl+ywjPxCCemAmwx5uYLsiD4Sxdh/mvczme7
         toog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wOP2A2FeSpHI1WPKlFbVK/7JXB5FOqAuroR4HnQVIN8=;
        b=oC0CX8DQppyuWH9/qoymDczPFjRjWRC9+hCA2FAWq2oXDr+lZwqPLpHFAAUTnRSric
         pc7QfswMQNWlVck4JC+NxcewSEQ+OD5JDJR99IlTe2O9dAoKaoMXm2m2Igw6eUnlJQIQ
         i02qA8fJTbm3875AtAQu0AstXlEhSsYpWL9ZSq3HIA/Vg2M72lwXRenp8K+g9jufRxqm
         08+AdjZrejGfr6KQSIxa1i6bg5hKowrgdsZ8hc0ZuGHHLiq8FonkbpTNqMyZaCmquzUn
         kVBvrLumjrxpOXx3/DDgqjzbgM2eFPH5ORETXDyFyk+MWOYr0/LekMxD9pbkr41UvqQG
         T8jQ==
X-Gm-Message-State: AJIora+eJaZf/Rl1wZ2H76IFyptX5s1b+JBWBeQZhYXgpRsNTqBlsExl
        ChyBgHPtZ3eReqteILlUKR7ujuyTNWZwQQ==
X-Google-Smtp-Source: AGRyM1tbT9XekkCh3jRlzFprRNajmItl/jpNcqdWw/6Y7rtttT4qARHLc7X74MPURYIChJNKmgjbmQ==
X-Received: by 2002:a5d:64cc:0:b0:21d:a4bd:fdbe with SMTP id f12-20020a5d64cc000000b0021da4bdfdbemr14234254wri.580.1657924445455;
        Fri, 15 Jul 2022 15:34:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id r16-20020a5d52d0000000b0021dabdc381fsm4719388wrv.22.2022.07.15.15.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:34:04 -0700 (PDT)
Message-ID: <b00b14a5-0e8d-bf64-de02-2551eb5df6df@linaro.org>
Date:   Sat, 16 Jul 2022 00:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clocksource: arm_global_timer: fix Kconfig "its" grammar
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20220715015852.12523-1-rdunlap@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220715015852.12523-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 03:58, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
