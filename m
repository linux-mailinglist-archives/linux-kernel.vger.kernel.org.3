Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E83F50D151
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiDXKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiDXKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:52:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84B240A0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:49:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so24408895ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZeFfic7NkdYVY76qjghFYEa4bj1suXvfyxykTnL7iSU=;
        b=EQzrSr7IPIJEN2vBGd4rtciOiq7x+HzcyycDjE3DJxCACvRuhViJsJVxgtyGYh77h+
         bXh+U/bRcLGD5btOet6OMQS0+DcPPBQmkNKLpwqpCNUE/M7CWf6vmecux8Sx+g/Klret
         /jZs65AzmSB0w7b60opHRrvd9dKn0TWDKz9/rdlzpp8VB5QzmrzrgXjvwfABEwq5bQJj
         AhI1w3mx3C5pJbod0RjZibSlzG5KtixYP6rvxDcqTwDfIP0MbzPY2aeAjuSzGRv0oyyC
         /DNrWd4lGo8dVjhCQY4vrNz1RNpRBanlq35mLozoeTIB8R3cGuG4LZqglrzTfz7qzx7d
         skMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZeFfic7NkdYVY76qjghFYEa4bj1suXvfyxykTnL7iSU=;
        b=AcXwrkzrvkMdsVEoiApZKYcKjX2lMlEsKLnOdC9Fm2mOkTLpFUs36Q6MExGTVanfJF
         KrIF56BXRJqhaisRHqVdadbZskPBtcOGBko6xSOEZ6AzIlAU/982RY+9w/G13eBKqC0s
         0ZXGEQ/wX1wDTCYLQXmPq+YPF7PxKxomW0MM8BK7jj5MI1hun3UtBbv2eoexp3+9A5YI
         S9VnfOLzstEvqFNZTjxwhJOm7weGkIxh8wbhLUYxuVXV/qc3PYoviTuFhX8D9mlHzE1/
         dpbUxs3JzXr1cSeOpzyUTMp2o+CDiuWeBQuQD/ZAwLzo6pJ9tyI0Jb9YLZpDdrjemRVk
         cvdg==
X-Gm-Message-State: AOAM531/J4ezmKvVbofxFeIpO0/UeRT/NdTpRtOOSSE+fe1oX+rimrgF
        e3CeqgjGO6Lf4sHCgHuKAeOYSg==
X-Google-Smtp-Source: ABdhPJxu1SgZxDPFJ4hqAIpFqD034Z/96Fhc0oCnQnk01+fVNPLw3U0KEHFw/qjT9d5lLeTmJz/g7Q==
X-Received: by 2002:a17:907:7f0d:b0:6f3:85c0:7c6e with SMTP id qf13-20020a1709077f0d00b006f385c07c6emr3054591ejc.693.1650797341532;
        Sun, 24 Apr 2022 03:49:01 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h22-20020a056402281600b004206bd9d0c6sm3244860ede.8.2022.04.24.03.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 03:49:01 -0700 (PDT)
Message-ID: <5b41d217-a5d6-91f0-bae8-4086173bb5db@linaro.org>
Date:   Sun, 24 Apr 2022 12:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] mtd: onenand: samsung: Add support for device tree
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <CY4PR04MB0567451F82EEBED23A7559EFCBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CY4PR04MB0567451F82EEBED23A7559EFCBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 05:43, Jonathan Bakker wrote:
> This builds off a patchset submitted in 2019 [1] and adds support for DT
> initialization to the Samsung OneNAND driver.

Please rebase your patchset first on recent kernel, because it seems you
missed some addresses in Cc, so your get maintainers are from older tree.

Best regards,
Krzysztof
