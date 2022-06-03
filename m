Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904C053C87E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiFCKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiFCKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:18:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018013B2A5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:18:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so9506503edf.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5fbRPrTY/R6Jd76DmGbXt/CjZ+4hz6lnt00jcUmxXAg=;
        b=t8/f8rjrZGF+WUM+6ClElXVh805GH0n4iOYfEYgv0UzffNnoLxvP5LuMBW2jfAdKrf
         gcslWnwvf/Yok/o8IVDVLLHCUig0/wSTfW9iHJ0hAiHpPoT3SUQ0qKYRFFHll7iB3s95
         RAHPWXFg5HNs90h7W2Cry3Hzn9wPKox9h+f3xZfOHDtNYyoUuVxPbcGqd9PT0Z852jp7
         iMlrck5tMnoXk3abO+ukY3stmV/YxT6X34+2p4R/fRU1D/XgayYsPLMfjHy3YflVSPjc
         cz4W/gsm3gOZCHPCxRbRd4poVIahRf9imqTuQrtBtLjXnrRYiIBfAKgXO04ooa1vH+ir
         7TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5fbRPrTY/R6Jd76DmGbXt/CjZ+4hz6lnt00jcUmxXAg=;
        b=7v4EXYT0JUu1GDOkoUhlNsyXc31z48VJvawNffeIkMJcESPAeCwwO4W/IZsr0Dllcm
         xUgMtUngAKE4FPvsBdYkADkBGFdsY7+ct+WWwaF+uIF0Jc71GNe2+G66P6N84q2S8ZoC
         8n+WD7LMtpFCyoVBeAm35MIpLrbpaFGPpBKk7zxz3LifWftZUVNVU3BlkKX9BqdMMjIK
         CcelXHgmrlK7zqlFmwjC5F/En3mzzuTy0Yj6l4ovJdFemt76mu4QIGH2parbzd6C8Aty
         0YGwJXQE3K4kDPGVGkC8LePESjkfFSniqCWGceRqYvXyBlpwsZ61nuFiguwENvlvBtdm
         s0Lg==
X-Gm-Message-State: AOAM5303VGbl1po6JaR3No3bcH8Ttr3hnVQtaXn8QVRpBNW6GPdIQEHr
        zV2xQWVQOB8PQR9kDjbvaSyOAw==
X-Google-Smtp-Source: ABdhPJx+BS9VItYHy8INrRWA83fCNEHsjQqAdZbjlKF/tnOUZQe72ZC7n+Npd+Msqlk91EOjqNPTIg==
X-Received: by 2002:a05:6402:2926:b0:42e:1f3c:d041 with SMTP id ee38-20020a056402292600b0042e1f3cd041mr5757406edb.240.1654251485589;
        Fri, 03 Jun 2022 03:18:05 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm2619487ejq.181.2022.06.03.03.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 03:18:04 -0700 (PDT)
Message-ID: <281b5518-c1bd-e994-3ec2-7429dbd3702b@linaro.org>
Date:   Fri, 3 Jun 2022 12:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] dt-bindings: altera: Add Chameleon v3 board
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com
References: <20220603092354.141927-1-pan@semihalf.com>
 <20220603092354.141927-6-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603092354.141927-6-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 11:23, Paweł Anikiel wrote:
> Add Mercury+ AA1 boards category, together with the Chameleon v3 board.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
