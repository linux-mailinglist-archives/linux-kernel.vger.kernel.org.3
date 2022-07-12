Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D893057133F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGLHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiGLHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:40:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0429A6B6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:40:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so8959172ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h0c5geLVWocG6dJd9I6DofduKK4MdprrAm8njZkwppU=;
        b=ZyZfJZDfVPTxueqJvp6UDGsZkc3+ip0zh5zBAm46wrDkY/RIu8ba22imfR6IWZC0sY
         W/35QmTk82O51fi2PavrbOnTn3R0UjsTLit54R89lUgElSjTc4nkNSZQstekXJyiEDIS
         PR/9BVJiFSTw+1vMLGgTcW3lqrjemRHr3T26/AwEWoFnvkiVFV7F1uu/QILRQErK929i
         xnFgzdKQ9Pbsv+VfFkykY4PgfcKegymC+W1pzgVFsgltSY5+48d3S5RN0MXeyEHZfmO9
         DtZ4rBLtn622TS4In0oNpQrNQckSYRDwAxSFjA7L1rofT6F67x4lNHs1IP5IzCrOFzHI
         ZCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h0c5geLVWocG6dJd9I6DofduKK4MdprrAm8njZkwppU=;
        b=yN+U779rcZ3lvGAv4DQyMkmknG9est6JvG1GBPCh9V1KWvo2Hz6uO/1iUX+lDRKgle
         g6lIRIudfagKP294vvDa1r1rmI2MujtUxRlFAzqVuC/gpY88g3/mOq10S8OvRKCOAx/y
         g+dQFa5X0GAOo3OxhXJMdKh1iyHFAg1Jz7+4TCEYuRk5gyNEu9eTJ8AqguuNRR8MKOcd
         SPDJIQDUjn2YeGRxc/SSsCNQGboU2s4bi5gLeKsMS88pdniLXImKWbcdIPWoOBrqPlSS
         UIjXzVepzFQ7ijHJ6BWiTlnttFpaedf1ngL2mhMPRQYO44JGO/ChDuvDBlo9boG7TJSt
         msiw==
X-Gm-Message-State: AJIora9QdzmSHkwkXpwOijfsKl7ObB3oEF+7XXU0N8+rVhQnS6Mea21I
        Fb/liaXZ9u2rdMf98pBqDMhbs+m8dq+Bl3Vo
X-Google-Smtp-Source: AGRyM1t2IGlxja70WHNr/sLe94dwPbwyghFqMypmR6uOPku7mxXFKq9ewDMz2y/A9NgJWBViMD9zbw==
X-Received: by 2002:a2e:a36a:0:b0:25d:8089:80b6 with SMTP id i10-20020a2ea36a000000b0025d808980b6mr323186ljn.122.1657611645442;
        Tue, 12 Jul 2022 00:40:45 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25616000000b00484d82e8a09sm2017789lfd.211.2022.07.12.00.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:40:44 -0700 (PDT)
Message-ID: <842e3fdb-817d-6e15-8dc1-d8a82da0e962@linaro.org>
Date:   Tue, 12 Jul 2022 09:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] Remove an entry for MOXA platform board
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712045505.4500-1-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712045505.4500-1-jimmy.chen@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 06:55, Jimmy Chen wrote:
> use Freescale instead of create new MOXA entry
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  .../devicetree/bindings/arm/moxa.yaml         | 21 -------------------

There is no such file... What do you try to remove? On what tree this is
based?

Best regards,
Krzysztof
