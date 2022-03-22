Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE14E3C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiCVKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiCVKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:03:16 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6EC7C79D;
        Tue, 22 Mar 2022 03:01:48 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id r7so10152875wmq.2;
        Tue, 22 Mar 2022 03:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j/qgdjKwccf8EPOidmwJ3w5TF8yoynAyS/lxz3nLGS8=;
        b=5Xu6KACnQx7m4B9ZRYAccCJjbBKGrzAwrKwMZFqffPNDfaHysMUS/TGndXYSj/2jcx
         +OFPsxgwmdhPkR+Lx5IWggE6Xzz7Gr73p16BgikDz3gBhLw1LCDfoaPQ0WJOiDRWXzkM
         6oLUrSzCYoqAyEFLxYz4/E0ebSYoyWxDDNMks6zt6JEHYFMKZB6NSyhY540q1k/2OwF6
         24NMO3SCBwX7PyWfs/zOB3ZZYX2yGnJcQkQdVfFjHWbnX+4svnBCcZT9P0/D1LsdYW9K
         Ptdm6vVqPiBETC6jtlSilfg4d9sZNMR8C6UN0uFZ6KZ8XZn5riN880Yze4oIj6zXvS1/
         0Whg==
X-Gm-Message-State: AOAM533hgjf4fTGlBF859FQJutQ+sxPBn2vJyYBg06hLGx04nEzmZrHA
        pSdRze2S+49z8xc1oxb+lNs=
X-Google-Smtp-Source: ABdhPJy4XHyMtIM442pgEfYm42wdqDd8trn7iJ9ILqvcyqLt8QdybwbOUvTXfhm04dhJ/5udG8Tdxw==
X-Received: by 2002:a5d:5886:0:b0:204:85e:5a3a with SMTP id n6-20020a5d5886000000b00204085e5a3amr9701385wrf.434.1647943307366;
        Tue, 22 Mar 2022 03:01:47 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id r4-20020a1c2b04000000b0038a0e15ee13sm1568576wmr.8.2022.03.22.03.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:01:46 -0700 (PDT)
Message-ID: <9bcd0548-ff5b-78f2-9fb7-7b15755a049f@kernel.org>
Date:   Tue, 22 Mar 2022 11:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 18/18] ARM: dts: qcom: qcom-ipq8064: add missing
 krait-cc compatible and clocks
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-19-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321231548.14276-19-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 00:15, Ansuel Smith wrote:
> Add missing krait-cc clock-controller and define missing aux clock for
> CPUs. Also change phandle for l2cc node to point to pxo_board instead
> of gcc PXO_SRC. This should align ipq8064 dtsi to the new changes in
> the Documentation.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

It should not be the last patch in series because now it is impossible
to judge whether you actually fixed Rob's robot reports or not. You
still have warnings as answer to patch #17.


Best regards,
Krzysztof
