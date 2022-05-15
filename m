Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25375276B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiEOJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEOJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:47:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD612CDFF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:47:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s27so14979535ljd.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=upa/6mpRaWNXap42b9Fhlm8p2m3O0ZkowJnqV9qxhSQ=;
        b=HGkdTfyNZ9z/VGOlOGeZ9tAiAMmwoFj7ayxLFWg3rtt8qaITsMQK34okgbeZU1LChw
         C48Ec3/SYgwKMVa46Vch+2vEBW1+BEJjNW+ve3Xbi3tNwDS+ulL5kkRAP6Y5P2niF9Bc
         /job2hmJckfc3OomT2QCZFoq27ZJCUYQKhbb5Pkyk5z5RCbAAEb80i8LfvWbjyW3Ltzb
         5k+N4kJqalYM1tRGnVG/v4OoC9WmBXO/MaRcZ9rgF1dwdPDBlC8Sa/iDhvY1gQw1gA9I
         fC7SMXROJHGhw/C/gXFajxD8xPQ+nxTB4jgH4QFAlSQ1vgTl0+I4SWbQfTDPOKg7OXvK
         28mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=upa/6mpRaWNXap42b9Fhlm8p2m3O0ZkowJnqV9qxhSQ=;
        b=j/9/b7qQEmYoi34YmyOIr5rZDqtajlllJ/ES6pxl93HoAWrkSSqKtDGyRRiQxcOv2F
         jEPzkNP0fdsOmeHVskrfzNBkysecFhTBbUVCcjVIJ+alRKF6axZrc7NjkiRQfkh9pt03
         dya9F/zDDD5WL8KVrK7z179p7Bs1TWLRmIb5RsrO9C0iCMPfQxNfOYFIJNWjCJz89NLp
         IrWw56YV6iS755bxKPnTSlWmfR+lWEvRD2WdjGi+xom78O5IwGXhoiJj0Z+1RfFw4aC/
         +6xUTpter8u+/ds8QosP0rgRF/eS2Oc6NkZfmpCmHmdL1er7I/jz8LXaQLAex7wOui7t
         /7qg==
X-Gm-Message-State: AOAM533kGFGaxWkU6+w8/1uddd27/v5KrdMsoLPGsPteDPIwha8aoL4s
        R15jABN5H9btP7vc4PTtfR0Jgg==
X-Google-Smtp-Source: ABdhPJwAVzbhaRncsmXG2PPgEj1lsAU7Zv6JTkPGQs3geo7EWnhPD3WsyxPVyrP0b45i3KZuWQ27+Q==
X-Received: by 2002:a2e:a7cd:0:b0:24f:505f:737d with SMTP id x13-20020a2ea7cd000000b0024f505f737dmr8170269ljp.168.1652608036714;
        Sun, 15 May 2022 02:47:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g16-20020a2e9e50000000b002539cd7b05dsm864178ljk.46.2022.05.15.02.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:47:16 -0700 (PDT)
Message-ID: <2a8e9301-5da6-46b0-850f-f3f12447d400@linaro.org>
Date:   Sun, 15 May 2022 11:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 5/6] thermal: exynos: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-6-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Use the newlly introduced pm_sleep_ptr() macro, and mark the

s/newlly/newly/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
