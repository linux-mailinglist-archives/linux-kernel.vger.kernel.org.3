Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6C562261
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiF3Sz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiF3Szz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:55:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF335240
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:55:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so40684217ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zveEp55sahmOs7bahXZONZH6/4SsivXk5eL+rEQbYbs=;
        b=fbbVeGhnNXqvwnGb487/KlxjDBU4umDgh2JzIyHL7CO86gpu4Q1lEOrOBaHEoG7xTV
         /ES2QD+nehT+Tg2QYsW2Jv+2qaz9YWE5dzXeuETQb+Wss3q6EvALlrkTI2El5DAtzvCZ
         QEmcfhNtvQ9AWo9nw7/HEirxmx1k6KN3gjej6zLKavWXVZWp7YMPeMay/sk6eOfOHJVv
         pq0+SRzULn/m8z7rR87TXPXXW1Gm/+l3/+bpLfLhm8H+9+pOrLw/ojKsaGOXahehuNIo
         m5OPaC/z038hOZRJYTjQevIbVTNE4/dIqib5ACZRvQzqsheqUoEfdasT6fawEqN70K1t
         1b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zveEp55sahmOs7bahXZONZH6/4SsivXk5eL+rEQbYbs=;
        b=WCLMM+OGwFkuz4aZvvHhxLdRY4+tQERJ1cl0oXQxLD71oXKjXOgBetAKzcPR037piT
         lcs0yPq0s2aYawMETWV4Bm8YPm2Qm+KDBRPoQZFj/dad8cr8LoYahLUiTos8s1PdZev7
         CkoICyPkif/Gjj/Tk3zmxY35Kk9OUZM2UiHchhOJe1jnNLr73nV1gvR/u7G3Ytolx6vm
         cuGnL/4lVGeguuGaow5wREplk8P4Sr18KshTu9ztxD7gew0ERlhKnv5pSJFAb2M0tn9l
         HzBkl4R1vdg5gzWQvS6JLIlAopCmcqi8vptsKojbqcoI2af40oTi+B7td4NaRKLkPcuA
         gYcw==
X-Gm-Message-State: AJIora/4QSM38jn1Yuf91l0wm1OV0LdNUEOKJhmRReQAuCUixRl3dd21
        em5RM29ILChKnWagihAkN+TfZw==
X-Google-Smtp-Source: AGRyM1sSG7LPNbx+O3QX/U8EPf9wPHDJE6QJSdhqjAJZWBwB70LYl89mpiDhkHvZS4kLeJBaKPZwtw==
X-Received: by 2002:a17:906:d54f:b0:726:2c7c:c0f9 with SMTP id cr15-20020a170906d54f00b007262c7cc0f9mr10357394ejc.441.1656615351848;
        Thu, 30 Jun 2022 11:55:51 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id by27-20020a0564021b1b00b004356112a8a2sm13582941edb.15.2022.06.30.11.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:55:50 -0700 (PDT)
Message-ID: <3b1339d1-515d-20d2-074d-25d555f5e6d9@linaro.org>
Date:   Thu, 30 Jun 2022 20:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
Content-Language: en-US
To:     Kris Bahnsen <kris@embeddedTS.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>
References: <20220630182746.3813-1-kris@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630182746.3813-1-kris@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 20:27, Kris Bahnsen wrote:
> Device-tree incorrectly used "ngpio" which caused the driver to
> fallback to 32 ngpios.
> 
> This platform has 62 GPIO registers.
> 
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

You should add here Fixes tag.

Best regards,
Krzysztof
