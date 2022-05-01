Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2451634E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiEAJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbiEAJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:03:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D09C1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 02:00:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so13559411edk.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6PJYh3sqWCa2tY+xYmHfq4tYwHtME+g6YPSvwa+jv18=;
        b=iYnEeSkcA8rwx9awPjZp4TwwrB9ShZpaik4sjxmebuZm3eYl9jJwYfh/oU+Olt3R5v
         ZWRtvxXkKsgDPNb+tl1CohYbxWwxADiSrsbTr8Y3yGBb1rU7Hyy6y/9zf2H5iyeKHa3E
         Y4glAe6N96lOOxJg49nS/hxtAKHv6kwsdsHc24VLud5RSLhOmH2c4e2mAliIuBqHC+7q
         8p5NSHOPetKtEmG0eMJV0+ZtJ1oXhiNSwEilHZTsUxN+xokeZF4yZ2wvPfSL3Ai4HoO+
         pUCz9zgAy+6YgpUrFNY4e6NMIrts98JwLfdcTZ9mXvxYZaY5/2EHoeVDrksoEqxdVJyH
         aKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6PJYh3sqWCa2tY+xYmHfq4tYwHtME+g6YPSvwa+jv18=;
        b=19nh7vzYLg9T9/f4Cb5s3BYLwzg7eKzUmbGRxuG2S9flAI/PP/rOmt8Y1Q9za7fJOM
         CVI0akM79WlpsVqBtxSxdCDv/zi4ZB/IeVV6CrwfmovzRwLqTQtO9y9IwlhPLAGuAcwr
         67C8MPdimMcLIgJ6J4t3YXLVaVJJcn9FzEXMddwjUQY/t3Y0O+ZifNpva8968c9vbLFP
         8Vn/2mQBAuVMWxaDmEyHhK0H+bPXtb21H6KaPXb40W0fKnRW6OLe1n2MLcbtBO6LFY2Q
         1kriKLoMpIcr3ExQ1iZL4s5UbsOjc8qBbr/IG7l8eil1QPrYGMgzaPohKQDMq/fKU9LS
         mj3A==
X-Gm-Message-State: AOAM530Y+wLd5AlwXb0wv1YY0jZ40Qy1Px4GmFTCfXG0Mwn5NHSeSCsf
        ARjpRB1ioIK9PGQ4ZCopnYb7YA==
X-Google-Smtp-Source: ABdhPJxYiFTtEL0B6CFg5y01ly+P2Zt5fKvhJ4uNpRacgPB2/Ls81VKRj5S1Po2G/xoB8RyNM+DVNA==
X-Received: by 2002:aa7:d549:0:b0:425:fc06:60d4 with SMTP id u9-20020aa7d549000000b00425fc0660d4mr8058735edr.300.1651395621804;
        Sun, 01 May 2022 02:00:21 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ig11-20020a1709072e0b00b006f3ef214e2csm2504094ejc.146.2022.05.01.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 02:00:21 -0700 (PDT)
Message-ID: <884d9546-4e5a-df04-bf03-eba2fe0188ba@linaro.org>
Date:   Sun, 1 May 2022 11:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 7/8] dt-bindings: riscv: microchip: add polarberry
 compatible string
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, krzk+dt@kernel.org,
        palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220430130922.3504268-1-mail@conchuod.ie>
 <20220430130922.3504268-8-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430130922.3504268-8-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 15:09, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a binding for the Sundance Polarberry board.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <mail@conchuod.ie>

With stripped SoB:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
