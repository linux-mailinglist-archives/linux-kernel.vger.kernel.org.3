Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57652504F56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiDRLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiDRLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:25:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810D1A385
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:22:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so26314762ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n8ODM6QauSWha5CpL28QgVES44fOHVlh77QAdolNXCc=;
        b=VUr1+h4Rh6JUE9tUUv1jiAyb8HwLW8T/maCljHHPs8wxvty/6W0pDgU/QWpBJbjlRp
         Udo+dnWDBhRqoD3wthqKIE4iscLGlt0+6webUBD6IamknW0NYdkbN5jYZJEIv1sxkJWv
         +VbpbENOAlqE9Z2ZIIa3D51mErcxPd94m5YQMjujSkyuvCmjvtWLTa5QmGsGQq7mwi58
         oos2jXTzigTkJAQ8M8+rMcdmjYO2vVR3wCoyxKMxXD5y+JbEMr+qFwe5eldglsQh4JXm
         ++TAhEHP/qcwmhQSN3TReRhoNmMW9+fLN5AeLenZYPDiDDC5gZXR82PnpT4iQetlFgaS
         kD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n8ODM6QauSWha5CpL28QgVES44fOHVlh77QAdolNXCc=;
        b=wLWiaER0uvMlwUITbS8Viep4V9dxWnVt2sNIRB3PO0q9NmpqjK8Va0Yb1JUwcwkA0d
         /5bi1cposowaPWkGiqvXGEsIQXAy+5YAt22BQQ9thugdlzW3hxQV9AFpfivwn7OlSBsi
         BQQr8su1yaLozlLzbzoKhAFP+8nBidja/Cyx4+vBE9vdOPHzV+1w8M9VHTcSVHC4/Nd1
         QNEPf2UIfM/kKzv3w11K4XzuvX227TiBrmE2TUrfjoSTfLlsbAoMxjCHRwc9TiWMcx5E
         TcGyyuwQZMI3YiYyPlMLD5M3mWwX+vDBV62W3jlBI5xo8KcBLsjXIJsgdD3Isd+wa/PX
         Q0Nw==
X-Gm-Message-State: AOAM532Gu3hvnt5dwr2pId80gvR93+GnPZbIXsB5dhtV2ycs/ffmJOt2
        ctZPPo1o3kJRlQtP2qZg8SmTiA==
X-Google-Smtp-Source: ABdhPJw3Fw9ysgPIMFoqefOQnAfFWqMLuoi+0st9zt/DVDZReWN/RZJ6jrS3ckOy66/Ygzt+Z/R2DA==
X-Received: by 2002:a17:906:28cd:b0:6e8:98a4:4ccd with SMTP id p13-20020a17090628cd00b006e898a44ccdmr8655956ejd.390.1650280942250;
        Mon, 18 Apr 2022 04:22:22 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cy5-20020a0564021c8500b0041fec3310desm7040679edb.68.2022.04.18.04.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:22:19 -0700 (PDT)
Message-ID: <8ab1c730-eca4-fc42-dd56-822aa779a2fb@linaro.org>
Date:   Mon, 18 Apr 2022 13:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add i.MX8M Plus Gateworks GW74xx
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220414161505.15524-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220414161505.15524-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 18:15, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Plus based Gateworks GW74xx board.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
