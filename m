Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02E55CAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiF0NTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiF0NTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:19:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575DE56
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:19:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so12966194edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X5ILPbtoG+kYe94QjcMQMKpsN9aa028wJTwAOUmgPAw=;
        b=JiKRcCWwMcvUtGrRKMwovuARV8vpyLDUNaPumhk3zuMHFwVu4JL2KtKzaL4W8XHPfb
         6DrJwa5q3oK3kz6ZZe0QCm/zROD0EXCBAXiXuHMRP+G8+UKsJ+fMY8r4qkc9G6yLTNEv
         4sfBgZSmT3PlTLnlq3tuFdBqwCIswq+fbH33dpOXhur9G9yY+bNhFknMtV1x215Utlqf
         59hFMkQ+8qD84hnCWZ/w8qlfkGzlz0HxSfbdaTdIyBpIpgjR+3ZbSxUaDjmwP9Eb5KQ8
         mtjDIlGxqoUEFD5/xpoMoLOuBKzsKGan440yLoRjOxFgNIg79NLGqOQhcg6YioSO/eb3
         3Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X5ILPbtoG+kYe94QjcMQMKpsN9aa028wJTwAOUmgPAw=;
        b=6XFQUKfi5aMgEZIto8FUyT0ixkNWywXDGMv+ichLGa+zVOpB0NbtZrHoI3fWPTk4pF
         9ljcg4yAeeG2kkfBCDNC30Drnx7r9ZLL6zVwuZXDCYSobwwiK15OGaiQBMdpzHnGO0ws
         fpQDgG29GxrhUhVKE5+r4aS4DWhdlhdNyiSRudLFMdXiEF49hUQnNSl+xGWefh/2RXnj
         Ul16Sk2fm+T4ke/ppAFyMLeZsBTnP7Il7j753jr8Lxl6xy7sGGZAKIbQCwV69p/xiC3D
         D5+NObv/vlrWJcN7tY3ZzrHC5YC3EoTHnAxBfPJKPiOo+e+RSvBnXkZDacJhpBhQ3MoF
         CtLA==
X-Gm-Message-State: AJIora8PjsSg3OocyQ6/nC85jFUfEHaZCXnk2zkI6zH0y0CjuUa8Esz+
        BOpQ30RH5xNPbFtXS5Bge/NA9g==
X-Google-Smtp-Source: AGRyM1uMPQCrYWpdYVnmgF8r5u7CnjVZ1RetLnJQkM7YTkXqMa8mjfcCmJtPs3hbXcwjtqe+CFEeqw==
X-Received: by 2002:a05:6402:1386:b0:431:6911:a151 with SMTP id b6-20020a056402138600b004316911a151mr16635361edv.105.1656335983369;
        Mon, 27 Jun 2022 06:19:43 -0700 (PDT)
Received: from [192.168.0.250] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b00722e52d043dsm5078286ejf.114.2022.06.27.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:19:42 -0700 (PDT)
Message-ID: <0912d41f-fadb-993d-c109-c13be35c1b01@linaro.org>
Date:   Mon, 27 Jun 2022 15:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, s.nawrocki@samsung.com,
        jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
 <20220627131627.GI38351@ediswmail.ad.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627131627.GI38351@ediswmail.ad.cirrus.com>
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

On 27/06/2022 15:16, Charles Keepax wrote:
> On Mon, Jun 27, 2022 at 02:11:13PM +0200, Krzysztof Kozlowski wrote:
>> On 27/06/2022 13:45, Mark Brown wrote:
>>> On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:
>>>> On 27/06/2022 11:43, Charles Keepax wrote:
>> My comment was not a requirement (procedural blocker) but a suggestion,
>> because maybe Charles was not aware that developer trees can be tested
>> for free.
>>
> 
> Would be awesome if I could run things through the build bot
> before sending them up. Are there any docs anywhere on how to get
> a tree added to that?

For LKP:
https://github.com/intel/lkp-tests/pull/139

Sometimes intermediate work is also included in linux-next:
https://lore.kernel.org/linux-next/?q=s%3Ainclude+s%3Atree

Best regards,
Krzysztof
