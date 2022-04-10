Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800564FAC77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiDJG44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDJG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 02:56:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774362BD5;
        Sat,  9 Apr 2022 23:54:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so24924410ejb.4;
        Sat, 09 Apr 2022 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zauW37hZKPQj0zCz4NalU8xu3JjPbiaaA2uRWNB22gE=;
        b=nnWkbWS3dszmsDv7aXEZLc+24lt3NcTuvsPM/VpE2pM2pyfGu8FkcqIEh1zz9poYcF
         uzce3Z0ZNf6mTXqlplma1Mvtz8l/NPnStp4q+xp8qBoHl2UF/3bzCgAkPANrnnZk2LNY
         URKv30tl+MhDqlGerhGd8ur5NBLIcd/E0qwM7wojZoqbyfVXQSwv+3pq6p3vQCrJ8npI
         q7Hj5hcZjvzBKwdkqFI5fwRBCsc2reuoukyFOAMN30/ugvfB+KsHkPP+0f1VXyHRXzUS
         RsOn3+scY6uukVR2vpMjhz7m6s0vXU16CK0gpc2frM/R4tfEgEVRDuhNdO/K+bWdnIc4
         A6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zauW37hZKPQj0zCz4NalU8xu3JjPbiaaA2uRWNB22gE=;
        b=Tol9DVOgsLATg+srj+6e9zwxTb8sM/+WH738aSWbsj24jglrLbnGRDPpFKdhKbBc34
         N4PDzB4PV7dnJ362ULt/jf4G9ucwB+JIFiW3oF4QC/vvtqBKKTfuMgoaqgKuFJk7q+nE
         eHkVq3D8xriTQOswT9QI+gRA0ckEPd2V2yw2p8ysmCFumLe+A+e5ADk/0ncUzdXiwpo8
         oQuVqucFUfKzSsdan6+cWAM583EDaiPyPkRiHLpNdvKp/WTelfRQqXpKZMRr/BIWdMvV
         r6Li06jqK0RU3TTG6Z2eK5d+DmtzCjZMI3/Bj3fNPmggrxAC0nRUtSDlSDFvnuvm5TTo
         rXbg==
X-Gm-Message-State: AOAM5316uBViMoIVyRtp6FO6Moo3De3v0T9fp5yYM4eoqGk5LABVXfG0
        t6WDvPIgJxlI/DrgQXw6d0c=
X-Google-Smtp-Source: ABdhPJxnfdwJZ3HNLq21mnJgLRl21Pfs9epyk6/tcAjFMY+XD3RqknXCvsqQoBcWr6Zt8N8r9XsuGQ==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr25255567ejc.730.1649573681824;
        Sat, 09 Apr 2022 23:54:41 -0700 (PDT)
Received: from ?IPV6:2001:470:9898:9eac:f1cb:6e16:4fc0:c830? ([2a09:bac0:87::815:6e3d])
        by smtp.gmail.com with ESMTPSA id m13-20020a50cc0d000000b0041d7329eaa2sm1229803edi.48.2022.04.09.23.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 23:54:41 -0700 (PDT)
Message-ID: <6738687b-eeb2-c4e3-90c8-ee3aaa73f576@gmail.com>
Date:   Sun, 10 Apr 2022 09:54:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm
 parser
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Karim <Karimdplay@gmail.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <1649339427.653492.795407.nullmailer@robh.at.kernel.org>
 <9cf4e596-83d7-00cc-afcc-585309cb4852@gmail.com>
 <aea5e032-5cd0-7480-13c1-2af924237532@linaro.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <aea5e032-5cd0-7480-13c1-2af924237532@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2022 3:49 PM, Krzysztof Kozlowski wrote:

> One? Apart of broken compilation, there were other mistakes. When you
> run the tests, you will see all of them.

I checked the first version again. It was:
- One "FATAL ERROR" (missing '{' in dts example)
- 5 warning / errors (severity not specified) "From schema"

Fixed version is here (not a single warning):
https://lore.kernel.org/linux-mtd/20220406195557.1956-1-csharper2005@gmail.com/T/#ma43afb59fd1f0fab8899951005ae9ce011fbb0cc

Is it ok if I send it in PATCH v3?


> This is not related to dt_binding_check. if you ask about checkpatch,
> then no, this does not require fixing.


Yeah, it's about checkpatch. Thanks.

> Best regards,
> Krzysztof

 
Best regards,
Mikhail

