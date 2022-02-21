Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873924BE7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380712AbiBUQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:36:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380689AbiBUQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:36:09 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD45220C6;
        Mon, 21 Feb 2022 08:35:46 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id z22so30551253edd.1;
        Mon, 21 Feb 2022 08:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YFk+sl4M7Srs5DbyN1lMmhvfVbrNyGzC2wMufF8/rDI=;
        b=a3nP+7a2WMjKLb+A+/p0mXULvk3eOmZE7OQNybxwWA+KTBhiEBn/YKCi2A9xgZFaVy
         qnqITPv0RoaSbtukQ7BVl88pQnVAokUdYpVVb5uukUKYUzASu92iUAwdYcaQD1MfWEEz
         YbWVUuHcQwKweHgvW1VfZTLiYQpcUKKT8iLcYWnEojMX/mTzmQewO2LuEjFAM22se/xm
         XLhFAMXeglhve9r6T7V9JFII2d2K84yaRu/KumZb9wNKrpz/XfJMl4v6irrBFrLIdGnb
         qUzC23AtR/kr26ZKSXX6QtnHDCi16qADorsYCU2OW1Qvm/YDlQOvyZADJTRNjweK6T5R
         3S9g==
X-Gm-Message-State: AOAM532vxTjN/aVWvA/UowGUz121bmoUKMOqyfSSngCX1oClRXrFji65
        r7KpDCfl4bnfiUDVN9XT4bI=
X-Google-Smtp-Source: ABdhPJyoawrcgww37p4WIuGhhpNJtlKE54lAC3oY6WyEM4tYYSDFB2khdaABAB+WyF0xZpbWP+d/XQ==
X-Received: by 2002:a50:fc81:0:b0:408:4c2d:bf69 with SMTP id f1-20020a50fc81000000b004084c2dbf69mr22229360edq.229.1645461344712;
        Mon, 21 Feb 2022 08:35:44 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id e27sm5482626ejm.18.2022.02.21.08.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:35:43 -0800 (PST)
Message-ID: <61e964b4-a406-7721-f3d4-26754c7f865c@kernel.org>
Date:   Mon, 21 Feb 2022 17:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220221092740.25511-1-antoniu.miclaus@analog.com>
 <20220221092740.25511-2-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220221092740.25511-2-antoniu.miclaus@analog.com>
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

On 21/02/2022 10:27, Antoniu Miclaus wrote:
> Add device tree bindings for the ADA4250 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - add `spi-max-frequency` property
>  - use generic node naming
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 

Please do not resend without fixing pointed out issues. It just looks
you ignore comments.

Please fix or respond to previous comments. Please also fix all common
issues recently pointed out for all Analog devices - folks from Analog
are making the same mistakes. Reviewing the same mistake is a bit a
waste of time. Much more appreciated is when team applies one feedback
to all its submissions. IOW, do not repeat the same mistake second time.


Best regards,
Krzysztof
