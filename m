Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B94538D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiEaJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiEaJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:17:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837462A03
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:17:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so25371481ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yiRJZcsK8/nOtrVqAQkM8gdI+HHI5A3xNn9CKo9QNn8=;
        b=U8u8oZFJb5MjAL4CVHJ0XH6H6VHERv5AKXW0csQS4cF0dlmO+NcS1uqX80UATzR1fF
         CmC0GuYup9bescyRqQiynV5JGC3xop8YrJ3e5H7bXagVFBRLoJ0QVCrYp0sn8ahFBbyR
         f+ZcwKl2ZZ+0Uq6GiLllGwaHomd/1gKSWYQq6KEIDILBMarV/IBil4FF6ypQRaaU+wzd
         uK6vX20fNLwl2P5QhF/7cmX7BCJZWGgpVM65ClnHVvS+y+u7kAdMqhvzD42XEFUJ5srG
         6l/y0MuLslXEVuXwlY0DiJQpNQyU+BWlljeb4EjQiErz3xI4BxBWHMQ3/GKmZ4LIwsOr
         JO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yiRJZcsK8/nOtrVqAQkM8gdI+HHI5A3xNn9CKo9QNn8=;
        b=3N3bOHAR6eU/8xCLN7tbALrJDOfyw17Aj04hwHd7ZeUP179UDwKHEhxV7kIXKCVIgv
         L41c4Upu2uewj7hMhy0ekNBW3uRM0bR/0LsrVexqCo8pd1GiqTiRihKXUuTr97HbR/t2
         xvYTxuaCTpsizXnsuLTodVRmbZBATGzgVMCjEn/tQLV1j+uplxj3VXHIrJ+a1Lc2Jtb5
         dEXBwRoxoGyAPZCTf5JVW56jEQLs/qwEnMnhhyeuFdSJVOwzBqz4tH5E7Z+BGZAirxgl
         9AJTG+iOj33qwezXVic1lj3/sQE+jtVGXBdBDJoSsQkMCFuwNCZYcspBiGO2xO6QxQ63
         5hgQ==
X-Gm-Message-State: AOAM532jFkkXMj8sRm2/4t/QmWJItP3JCBLv+HKNBcsUCaO4o4Jr3Lel
        nH2CWiWwKsliuhTlmy1GE1NR/g==
X-Google-Smtp-Source: ABdhPJzc1RUFRZ168BDePJCPLhMCHxR29p9KkUfaSl5CoTOvkdDU2r/8S/FdI4KzfVyR1qimbNJVjg==
X-Received: by 2002:a17:907:7247:b0:6ff:f00:c4c with SMTP id ds7-20020a170907724700b006ff0f000c4cmr26918873ejc.261.1653988641426;
        Tue, 31 May 2022 02:17:21 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906354400b006fe98c7c7a9sm4764288eja.85.2022.05.31.02.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 02:17:21 -0700 (PDT)
Message-ID: <cd71f427-8db5-e908-bf25-0154e3006568@linaro.org>
Date:   Tue, 31 May 2022 11:17:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/6] dt-bindings: phy: Add FSD UFS PHY bindings
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com,
        Bharat Uppal <bharat.uppal@samsung.com>
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
 <CGME20220531012336epcas5p2fcafe14c90ad3e3a0901fccd62d15437@epcas5p2.samsung.com>
 <20220531012220.80563-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531012220.80563-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:22, Alim Akhtar wrote:
> Adds tesla,fsd-ufs-phy compatible for Tesla FSD SoC

s/Adds/Add/
and a full stop at the end, please.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
