Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52E538EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbiEaKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiEaKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:23:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87A8723F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:23:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so8902717edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+n2Ea3CNe0GRwcA3oeCqsmQAwdtV3q8V7/DuYtbQNiE=;
        b=Oos7ieqFgJKfv7Js//H3YYd3aIqIsFMpJ+MK76phUcljulzqcssRWbaML5b5Vf9X3G
         3rt9q41/Z/i7oyfb186BRWmmlVLcY3n9XqTZ4tL0tQ2PQHTqJnwSP7ajPlhIvvisO5AB
         Q9h50U3SpuO+UF9tPLzJyYsFLncVWvdveZdiiZiQXNaN6NejJuqTB7e61KYlMLl9nqOe
         Jq6udZ/Umzv965qXuRSYo2+IHM4zVGWfxQ2gofrDx18fPxNVHvsddIj2bqbvG3w31KgJ
         Xe3OeKUsnATJ3VEx7RBh5C/5hNrA0iMpMAT24uMUDmer5r6j1stZnmOiPi0NYLyvGJRD
         WJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+n2Ea3CNe0GRwcA3oeCqsmQAwdtV3q8V7/DuYtbQNiE=;
        b=5Yr8fXZZBGCu+emJy2cmCKZ2yCQT2UAOLsVhivmwOlW6hVTy8uzuK+W7NTw4R2xqkp
         FQnPlkr2cyTleJZfSGIp/VFBqhjsPqKsgq1nF75AW9DppGhBY8dg/KhcMDx/PrmlnUtz
         +ReaxLksZX55rjDVhpbvHIAQp8RcvYTc3n8gaQzb3WAlWZ5NOhcls73269iBA/VOa2Jo
         rqbsjq9oCROjPteErYCfY9ydjp5aGl1aja48LiQzDsg0t3tV2QRENKVK9O0ZxSFSCk65
         kawdGqExtr+TjmhR7w7KOICh40RgFxINB3U6NQGjnqsZIzSoN3FgVOut5R3wM2C4glER
         ZAsQ==
X-Gm-Message-State: AOAM5331EEZX/8mSDH/ptmq0AsPt6AplXvNML+gIjKnQyCNtRjjkpgA+
        AhSXpkQdchYtF0FP6eTNZEzhdw==
X-Google-Smtp-Source: ABdhPJygcunafiNc9FQCcU4I+V+zNxcqbiUIoIgNCIdchys9kDJNzbDpzQlGawXotJaah8yfW9riSQ==
X-Received: by 2002:a05:6402:2892:b0:42d:c871:78f4 with SMTP id eg18-20020a056402289200b0042dc87178f4mr14403307edb.192.1653992634887;
        Tue, 31 May 2022 03:23:54 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709061dcc00b006f3ef214e3bsm4815796ejh.161.2022.05.31.03.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 03:23:54 -0700 (PDT)
Message-ID: <f13be998-52ff-5742-2a0a-728a292261e2@linaro.org>
Date:   Tue, 31 May 2022 12:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] dt-bindings: arm: aspeed: document board
 compatibles
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
 <20220531011100.882643-2-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531011100.882643-2-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:10, David Wang wrote:
> Document jabil board compatible.
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---

Thanks, this looks good. You however need cover letter explaining the
dependencies (on top of my patchset).


Best regards,
Krzysztof
