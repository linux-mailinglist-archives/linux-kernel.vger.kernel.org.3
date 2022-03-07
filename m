Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460C4CFC20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiCGK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiCGK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:58 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532290FC1;
        Mon,  7 Mar 2022 02:21:10 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id kt27so30897529ejb.0;
        Mon, 07 Mar 2022 02:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gklbw6NojNX9LElaFUzhIaJ+ODG7CHLZKWRF0mPmNTQ=;
        b=ARwHNGt+CKnqI0JDWmP17e7jIy0KtzPJKplI0/14T9QXwdH95CSDR6/JFIR/JydhgX
         8HetpsBLCIdcnKt7h7B6cBq4kqbNXiMNoufeWZWWizzA2B8RaLz0GCbVYGuDaqzQJKIB
         fuQ1cTNM4W8ZS5o+pq5YYizjXx59VEHhSlJLdZ4Um8Re/Kxt6CAPSsVN66UL+kY3c+Zt
         iu2voCdyx2piUvcWcte64FktIDfo8GJm5loC7KV+SS6LRrkVC+xOTfYvkw5qRRwWRMGR
         9i0MzQKBcV08zoTBIP0ZH1fHEnHlARBh6wYDLIfnt7JltQ0UFbcwt81VPwwnSQbKgDDd
         FrMg==
X-Gm-Message-State: AOAM533z2cIQIxb7+i/ZvhPm4zv0+i7PfZLj+QsOO7r7J1QVeNE5mEYq
        PMEsjEuLJuk6ji6SWMa3sk0Vjgvfit8=
X-Google-Smtp-Source: ABdhPJy21DbK07SCgek3zh0yMBqPZ8MlpeuXaq1JdFirxPsVEyr0x6vQ0zDAW41uHxvAu24AWYpx1g==
X-Received: by 2002:a17:906:5d11:b0:6da:68ed:270f with SMTP id g17-20020a1709065d1100b006da68ed270fmr8736100ejt.661.1646648468731;
        Mon, 07 Mar 2022 02:21:08 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id r14-20020a1709067fce00b006db0edb8a80sm1604632ejs.225.2022.03.07.02.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:21:08 -0800 (PST)
Message-ID: <81e8d2cb-c935-fb83-4a29-5ec9dfce16e8@kernel.org>
Date:   Mon, 7 Mar 2022 11:21:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add binding for MA35D1 clock
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-2-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220307091923.9909-2-ychuang3@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 10:19, Jacky Huang wrote:
> Add the dt-bindings header for Nuvoton MA35D1, that gets shared
> between the clock controller and clock references in the dts.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
>  1 file changed, 262 insertions(+)
>  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> 
> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> new file mode 100644
> index 000000000000..3634e5edcac5
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> @@ -0,0 +1,262 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
> +/*
> + * Copyright (c) 2022 Nuvoton Technology Corporation.
> + */
> +
> +#ifndef __DT_BINDINGS_MA35D1_CLK_H

Please use header guard matching more parts of path, so:
__DT_BINDINGS_CLOCK_ NUVOTON_MA35D1_CLK_H


> +#define __DT_BINDINGS_MA35D1_CLK_H
> +

(...)

> ________________________________
> ________________________________
>  The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

Since I was not intended recipient, I am going to NAK it and delete all
copies.

NAK. Cannot be included in Linux kernel.

Deleted from my computer, but I cannot delete it from network servers.
There are just too many of them...

Best regards,
Krzysztof
