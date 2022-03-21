Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069794E27F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbiCUNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348021AbiCUNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:43:30 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5150762B3;
        Mon, 21 Mar 2022 06:42:04 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id h16so8011600wmd.0;
        Mon, 21 Mar 2022 06:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1D8fCbd6M2RW3TQjcSstNbvj49/pj/ERzJ4WGueTQMM=;
        b=zy7gnPp6kRgYvdHKJ7GiG1CzpeLw814XN62JxLljQXEHgeCrceVtHy0LQRgSc7EkpX
         5Tq2lrRb3/WXb9gq3YGurBgBLocgB+WXyzPz8SyGTuVnCh7cBCLpm38zWN/ppYlVheGc
         Q1U1I3LEok1U5NEBzCHk5Qu1CUdEaGW0ueSawH1LUqObMkqrz50PVW6THd8rm2Q1IInD
         67p9nFcG5Ub2G9MEok5/R1tH9mGnodz6w9Ke4amiJbg2FtT4FJMD7zEaVvV2ylGui+Tq
         avp3/vtnUjcQ5lIWVySMcPFW3N6eLon7pOrCfG287zMDZIhnKWcwxu0BHrOi41zbAV1r
         JB0A==
X-Gm-Message-State: AOAM531248Zk5KAm0dZBgHbGfqju2GT08A3ImDP+qOSA9qT6uIGwZSnk
        lJV/GSK+Y4XCDJtX3uAmrz4=
X-Google-Smtp-Source: ABdhPJwKkkvUtLSdDDQnT1UyZu0lkFZ/o7qOqJ0X0Ghcmb7fM5+dc9Qw88Yf1Id0H4ErQQHl9dhFsw==
X-Received: by 2002:a05:600c:1f14:b0:38b:6ef5:1247 with SMTP id bd20-20020a05600c1f1400b0038b6ef51247mr19448817wmb.194.1647870123435;
        Mon, 21 Mar 2022 06:42:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm8887120wrq.55.2022.03.21.06.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 06:42:02 -0700 (PDT)
Message-ID: <04c0d6a7-190a-cdde-d953-3eae73282343@kernel.org>
Date:   Mon, 21 Mar 2022 14:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sm6350: Add UFS nodes
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-6-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321133318.99406-6-luca.weiss@fairphone.com>
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

On 21/03/2022 14:33, Luca Weiss wrote:
> Add the necessary nodes for UFS and its PHY.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - rename node to ufs@ -> this makes this patch now (soft-)depend on
>   https://lore.kernel.org/linux-arm-msm/20220320110616.18355-1-krzk@kernel.org/
> 
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 77 ++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
