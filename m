Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29FF4B03F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiBJDbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:31:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiBJDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:31:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443123BDB;
        Wed,  9 Feb 2022 19:31:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so7168047pja.3;
        Wed, 09 Feb 2022 19:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nvvlCC3Ik+A9UvhOEE+RahzQMEHLT3ALXE7RPHq6bo0=;
        b=goUXqtpB5Sj1L6N906G/7vqkEFlKjCFgjbyFkZqaeLmU4hCHLxXnQlfoGeh3X/JwyG
         TG4G8dTLwSXfHTJG9HtikIr2NPkIAOaGbdMdyI+wTSwjiJzaWu3+5cRjHfHrr5lzsTNg
         W3MGGYOeCNOwhU+fCafboT+ke37bPLjmvwVDna3kxRER0t0XdABmOMtqrUhALE5S48hv
         6QbkFAsGeum6AbwKcFw1SNNjew9kXNbfL1JRRXraZwAe4B7NyeDs+pBciYQVCZioCqUf
         kZVEE2X2Gn+7MvInWt9GZj+L7xpmByspbX61GMthQbMTi1pEJ2c20bta7I3mxuyNFf3E
         RiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nvvlCC3Ik+A9UvhOEE+RahzQMEHLT3ALXE7RPHq6bo0=;
        b=V7gyxsrOYJNWyjBBIid/s9qdiDoMWTcicRxOCqRKo/8rlz5H4AU3vcwEZr4/n1zpec
         JwxNujboVckNqGLrObJDRMcIKE9I/iqIuU1+IT9s/asUnFQMQ78PJz42eaYGGKSDfAoR
         R4DP2c47UpbO2/Y3eVvQildOxWgLRmnYlzOGcSKevZtkgVggaZLgESruY+AP7CJJJdw9
         yb+pcVUv5lX53kRZhz4QQPdf/Gr2gBJ5+pUqaalxy/Ybt8nXWbqSnHLtZ4Z9rjEb01RZ
         MwI6Tz0lEAPl0mGonYWIbrD4xdLK0BbPuEYwL/HoPqGF7PuOnDIZQybEwNRg0XV9mDzN
         H2mw==
X-Gm-Message-State: AOAM532nujInk72l7R2gt6FXkg3zIGngrPsfsSgJoJOesmXQ+iQItv/7
        UVOclVBC3l64vnAKUy1o9u8=
X-Google-Smtp-Source: ABdhPJwTpk8bCXpASIyFuhcm3zEkisDZSfKcaGYV7LB7Ohjg4RnU5/jP6CwddnjyMQebLVzHOPLPNg==
X-Received: by 2002:a17:902:7fc9:: with SMTP id t9mr5614339plb.53.1644463867386;
        Wed, 09 Feb 2022 19:31:07 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id mu18sm252537pjb.18.2022.02.09.19.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 19:31:06 -0800 (PST)
Message-ID: <21f1016c-d725-2c98-5aef-14e94e02364e@gmail.com>
Date:   Wed, 9 Feb 2022 19:31:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] pinctl: doc: Fix spelling mistake "resisitors" ->
 "resistors"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202091551.580372-1-colin.i.king@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220202091551.580372-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2022 1:15 AM, Colin Ian King wrote:
> There is a spelling mistake in the documentation. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
