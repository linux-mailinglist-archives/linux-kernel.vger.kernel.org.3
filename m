Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3364D73F9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiCMJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiCMJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:30:07 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660824BE6;
        Sun, 13 Mar 2022 01:29:00 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id gb39so27820565ejc.1;
        Sun, 13 Mar 2022 01:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NgQyfpQ5reEt2GXu9ddANeGGQrL1MxR6becPBkQwz1c=;
        b=2kI5xGiB9ijkpgnPkIxNXb2wbqUHOwFO/VR9km70GcqWCwWLg/k88dYqI5A10CHSEk
         rTAXU+0RMOPGA1cXXcehIUwgkJsf2ZHt7qE7aOQElcFfzl1s21TvbQ8dXpWnbjM1wVtq
         zxfrogmgMiR7jrG6x5EtMB5EcBlFMwHvTO1mdN6Sy6O9FXRpr0fhidsBOG7/9lo6ATrl
         FymS1CSZCyksxnmtnCqpR70aAl3k0M5E9S7rIxaO6ZRX9N8s80UtzKcyNKybO//mWrtT
         tKmtQIYRHDCXOVzzYlje6+ofD6kdhytKe7hkAz5pY1ltsoc28GBZ1xybaJlZ9LBJ2u3w
         5IZA==
X-Gm-Message-State: AOAM531/mqxEHcg5PHlXLuvAC8UYH8za2o49GtxGRJ+s9spCyzZPSaOF
        qiMWx2k3W/jc7AU9vHHiIUvVWsf2fbs=
X-Google-Smtp-Source: ABdhPJzstF34aanf7kupJgg+MdwPHQyeYPdgPIv3qy+90mIiDQwpnr0MnWfi2lkSfGRZc0OG3yb8kw==
X-Received: by 2002:a17:906:c10f:b0:6da:88aa:9d06 with SMTP id do15-20020a170906c10f00b006da88aa9d06mr15073786ejc.196.1647163738188;
        Sun, 13 Mar 2022 01:28:58 -0800 (PST)
Received: from [192.168.0.150] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm5305148eje.180.2022.03.13.01.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 01:28:57 -0800 (PST)
Message-ID: <78fc6b4d-ac26-43a5-8f45-6e9ea2c6eec8@kernel.org>
Date:   Sun, 13 Mar 2022 10:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: extcon: bindings for SM5703
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos-upstreaming@lists.sr.ht,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20220312184156.24912-1-markuss.broks@gmail.com>
 <20220312184156.24912-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220312184156.24912-2-markuss.broks@gmail.com>
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

On 12/03/2022 19:41, Markuss Broks wrote:
> This patch adds device-tree bindings for Silicon Mitus SM5703 MUIC.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
