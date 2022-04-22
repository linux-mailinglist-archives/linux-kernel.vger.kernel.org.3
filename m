Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EF50B4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446483AbiDVKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbiDVKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:22:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844433A0C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:19:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so15496619ejd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kXcFFH5z+Qq976hXZFox/KSTDlgF6EIFrsS1pxqoR3E=;
        b=fzSho7fftnlfP6pm6gBKxMNmgczxN0xGRrvch89F48Ef5lSwiPZkoBlYcBQGYsd6yN
         uf5ZwrEPayELqr67sKmxMd7e7k7Bupu+uJyMB2V+NhxmNLVZfKrf+C/GSWj37YqMstOG
         SHzsIt6qgBXwEgHCPqKGaQhkxggpwOcCB5MGhXtbesTdsOiqtwVGZWPX+Wy4eVPHjyVD
         QPiiEucI5EKUignwPzeb3rFfeOZwgzijIq0c4CNo1THhrtLRczYOYswSCq/Z8Pz/Rq5K
         +PdEUm4lJr/AwVJ8kFIzogLe6pJOiuMJ/KAmCrnR6X/qrwqk7r3y6nLqxWbeoA501TJt
         +krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kXcFFH5z+Qq976hXZFox/KSTDlgF6EIFrsS1pxqoR3E=;
        b=dT9shmtgcxe8NLA5Re+vFQX8tg7Zjz9Uk6d4GuRQ2iKSvTPC1/ANXKF4bEe4INMU6K
         u0h10aaAuwkRsJFevFk9ITkLJ7AJyabruu6IZED/wafNcdMuhUhdk6v4+l3333rMswWZ
         DedN1pvv6OzOKfMM4/YmAmpxRAqvIhrqoSHP+I9y91PO9rvTrbIo8/5RCuMstkWpaCSu
         VZPbINswDKT5pMWv1n3R8dw1oCbLtr4qyY25T0nu0O3a29IUcdlshsghcti859hhi8QB
         khfA2HXw3WjtSs1zrSDV4Deha1QRTWNd1X3THxTmowN41NIxvwL/cf923V8Ze8J/0Rr+
         5tzg==
X-Gm-Message-State: AOAM533Ie9sy/UdAW6fJKRB3+4ZmxpjBEdHavsS2UG+yXtakqZBifmlM
        ojsTfi0wXBPPNcBwJMl6UVJetg==
X-Google-Smtp-Source: ABdhPJzpcfN9v+Xc/2V8AerRTWsfjkHFGJs3Y9L5m0NP00FcGjDpxBiE0tR98fplIEFcypQ2+HP4Fw==
X-Received: by 2002:a17:906:28cd:b0:6e8:98a4:4ccd with SMTP id p13-20020a17090628cd00b006e898a44ccdmr3461568ejd.390.1650622773400;
        Fri, 22 Apr 2022 03:19:33 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm603058ejc.161.2022.04.22.03.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 03:19:32 -0700 (PDT)
Message-ID: <29fc53bd-1016-fe6b-0c82-6f2fbd8171ee@linaro.org>
Date:   Fri, 22 Apr 2022 12:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
 <165044570803.75184.17759035800452933385.b4-ty@linaro.org>
 <38f29c29-e3c2-240a-23a0-509c4febf1ca@gmail.com>
 <f7c5c3f9-0083-c0b0-dc49-e66139268312@linaro.org>
 <234d411c-1386-d661-71e3-f1f30f5cbf36@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <234d411c-1386-d661-71e3-f1f30f5cbf36@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 11:13, Matthias Brugger wrote:
> 
> I pushed it to v5.18-next/dts64 [1]
> 
> Let me know if there are other patches that you want me to take.

Thanks! I dropped it from my tree.


Best regards,
Krzysztof
