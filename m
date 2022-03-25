Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F362C4E72F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358951AbiCYMXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiCYMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:23:36 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E4CC527;
        Fri, 25 Mar 2022 05:22:02 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id y10so9021239edv.7;
        Fri, 25 Mar 2022 05:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g0xq/qIctoWJV1cqa570U55ncjhwmhr6DMeMU/vi/PU=;
        b=oTdAEuPGVVpTWWRKYM1BmfhyJOC6pIVWRhfe4G6Ss8ZLzMhIhwsWqV5qENNca/LKlg
         5pO0U3RvTr5/JHUHl72B6E0bTbEum3u3Pbrk/oIXCJRP/lxhvlmpFfDpEDO95a7qZxBJ
         L1sAZ8mTSeDwZnEfY6ilhrLGVmrpckkWWLS6J9WTLztRWAp2uTN+/PkMvtkrEllOMh2i
         isM7K9+hp4ixQ0uvDR+KrEV0vgxZUNBIlZOkTmxFsCOJ8XbE/LQYH8mDiqbcF7OiA5pG
         6ucTK3KrZl15IHt/fotpAo6TsqaYFU2daytAqvRDCmGzvTGPChrpR3SBI+njhsM5tvjJ
         sLCw==
X-Gm-Message-State: AOAM531W0Q1eiRFTcOOoM+CMahCSE7ZeZNh/pZbkV1AQlP/zC+PPzrpD
        fudWiQa6XvNyeltHEDHCxkc=
X-Google-Smtp-Source: ABdhPJzT/M5gSCP4XsxnObX+t7Mq4oYpOHOsEMA9QCn3JeRHgGitUw0un91B9TDcrXTVlrw1quPHyA==
X-Received: by 2002:a50:ec16:0:b0:40f:28a0:d0d6 with SMTP id g22-20020a50ec16000000b0040f28a0d0d6mr12882210edr.368.1648210921181;
        Fri, 25 Mar 2022 05:22:01 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id sd7-20020a1709076e0700b006e015549bdfsm2182955ejc.53.2022.03.25.05.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:22:00 -0700 (PDT)
Message-ID: <b4cda0c2-bfb1-bdea-2511-e2952fa5fdf8@kernel.org>
Date:   Fri, 25 Mar 2022 13:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as deprecated
 vendor prefix
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
 <20220325103014.6597-2-shreeya.patel@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325103014.6597-2-shreeya.patel@collabora.com>
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

On 25/03/2022 11:30, Shreeya Patel wrote:
> 'liteon' is the correct vendor prefix for devices released by
> LITE-ON Technology Corp. But one of the released device which uses
> ltr216a light sensor exposes the vendor prefix name as 'ltr' through
> ACPI.
> 
> Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
> following warning in case the compatible string used in ltrf216a driver
> is "ltr,ltrf216a"
> 
> WARNING: DT compatible string vendor "ltr" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> 364: FILE: drivers/iio/light/ltrf216a.c:313:
> +    { .compatible = "ltr,ltrf216a" },
> 
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index baed2b007d0e..e78091d51443 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -691,6 +691,9 @@ patternProperties:
>      description: Linx Technologies
>    "^liteon,.*":
>      description: LITE-ON Technology Corp.
> +  "^ltr,.*":
> +    description: LITE-ON Technology Corp.
> +    deprecated: true

Keep in alphabetical order. With the change:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
