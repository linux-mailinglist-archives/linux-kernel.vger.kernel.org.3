Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339E51A331
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351896AbiEDPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351796AbiEDPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:11:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593CC222A3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:07:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z2so1889325ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SlBkoO1sK5p6C20wzTnNNu31b+DHcR3rosTKprOdHs4=;
        b=NG/g7+GoQkuRMr4Owok4yF0WlWRYzGFoO4aL/2lfoyecYNKbnXea3E5U1IerqsE0+d
         RzJK2AYlmvlObdC2gMvsC3ZIQuviWFYpdIKcgoAmAshyqvw77oj/6wDK7eb2NJibvRvA
         +itEyj2X5jjLjhGHaeqs+90rhCpCTlnyAteMh1Jn0dz45LYMOINi/XN87uwdL7i3KYPM
         aYkQb6d8WTwDwm0sJVa5r5sHcTB2JwqkEZ5aJgDrDWH+y97Zi7LE84Kj5tkEb6pP+jvf
         /lJThvZHZMz9gCv1EfiVpTkqHIOcUIpc6oH8eAK8v/1oMXNAzy90Qw4LPu1Mao2NZfgS
         BAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SlBkoO1sK5p6C20wzTnNNu31b+DHcR3rosTKprOdHs4=;
        b=2gNQD4NMhYxo0IAdwNIQBjQeAk2Q0tx1gZa6TGAea1fq6QBrRvrY88vsT6q99wbbjM
         E1HmlzB2EEXzWj0zuJx9aq8/c50AEbucKc53N8jorQUpUCA7kLWbL61uXmPCsr2lk72p
         lJ3Lsz1SO8xL62hPwPT9MDTBfVW/C/FBrYcG3ozjP0Rxk6j1oSCkubRftmuErRKNn4H2
         KuFjy1w1CjZuPp9LUmwInF26gHb0F+Rz3L4p8I+goScYvMqPW21wzEMx2jfbXwmeLtyR
         urblbmyoJ9/XY3F7VjroYFZs5Cp6cAdv4VlSB0pdePSfSC2wZo2nF9JowVmTtNB4WUZ0
         P+zw==
X-Gm-Message-State: AOAM532cuRfxl5UEVtlFBPR6RqMg4vCrUBJoH6vqvNVaHkIhv4zJjcJZ
        EeqdLquPg7pYK1D+Jr9lqjx4Hw==
X-Google-Smtp-Source: ABdhPJzNR3dty6xg+9nnvi7tgssQ0/Gt/9NPLgoDdq2XQDhe0Sr7Ik0M13Ay/4y+wuygaAnEDSwF5A==
X-Received: by 2002:a17:907:2cc2:b0:6f3:7657:7eb3 with SMTP id hg2-20020a1709072cc200b006f376577eb3mr21514299ejc.403.1651676840683;
        Wed, 04 May 2022 08:07:20 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv1-20020a1709072bc100b006f3ef214dd2sm5849972ejc.56.2022.05.04.08.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:07:20 -0700 (PDT)
Message-ID: <e9494c4b-55c9-b4a6-b836-fd47fa717290@linaro.org>
Date:   Wed, 4 May 2022 17:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] dt-bindings: Add Sercomm (Suzhou) Corporation
 vendor prefix
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
References: <20220503154254.2339744-1-csharper2005@gmail.com>
 <20220503154700.2339796-1-csharper2005@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503154700.2339796-1-csharper2005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 17:47, Mikhail Zhilkin wrote:
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml 

This is visible from the diff, so just "Add sercomm vendor prefix  for ...."

to include
> "sercomm" as a vendor prefix for "Sercomm (Suzhou) Corporation".
> Company website:
> Link: https://www.sercomm.com/
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)


Best regards,
Krzysztof
