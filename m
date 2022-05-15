Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB165276B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiEOJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEOJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:48:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867D2EA0C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:48:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d15so21291919lfk.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qGxOq7T/f7Tns14YCD1lIIHt7LLOjEBdhYOlr/jBw+U=;
        b=KtCg9f7fR/qMyhPo5OBQsB9/whT++OXOEE9zGgmlzS+f1WinQef2U6sSxUU1i6cqwy
         bHXccEe4Ty03jlKADU6OobdJy00lYPZbw6AEd5ALGj/RTSN/eW/V4ElslxL+OkDSRzW2
         f/0LuCtS5AFxR2OlxDpeXdFzcITjB1qurdB2oV1SZHdek5SnSQzMfBk0mtfsQFzDTDqX
         YkxDSxYDXL02/0riRJ3/4nHZFhhWWPSUMKQyU2x+BIQD8TF7fbKH0lx3lZJX6vXk8gdd
         sY+N0l32y3Zl5mKAENPjeo9LyAOUSHe7oDqOob8SyqEj2WoeU8BZ4cYMukTmMtWIinyV
         FEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGxOq7T/f7Tns14YCD1lIIHt7LLOjEBdhYOlr/jBw+U=;
        b=1bJ+g4PHRWetenYkQ6IYh/uuq6kmrlK9baRbQ/AD/zI+xEppv93QzbT1PIZluHAcTY
         /xfpYewctOxjscNk5uLdVOvqUu1WnaCDdqe+lSjjItxxIQceShPXvS5osZiT9kKKdCcE
         CpLfc4XZ83hzu9A4VeRGf2fCx6wd0Rlvt1qO8wMeUWJAOTXw3VXz6Nvi84UDIIFp7Gfb
         NIIIDXTJhMXffEbfWaIoYwsXXscGTD05D9fa4a/zBamvUrSE6WwL63vR/nlcvIUu+7Ro
         WvAv0aIKinHAA8l8RQFrJhyPba1XalGfL7m6nmh0zQei7eAnCsbTkNiYhLjv0UzJWygm
         hmXA==
X-Gm-Message-State: AOAM532ObVEfLdxHdCUqIdvMtH9ohdsiAsk0PI7J++RxjjNSLEyVXwrU
        SCJgPkd+7CWxWRelv1HnOx7iyg==
X-Google-Smtp-Source: ABdhPJwW1jd2qXdskYkbYOHvbUfn+nRO9jCAQ7buWH00FXW+UQmBRXNOja7qQLjuaTJ/rZKYZYDiTQ==
X-Received: by 2002:ac2:4e15:0:b0:473:c4c2:dc0f with SMTP id e21-20020ac24e15000000b00473c4c2dc0fmr9344241lfr.13.1652608122067;
        Sun, 15 May 2022 02:48:42 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c13-20020a2ebf0d000000b0025052e35be2sm1134536ljr.130.2022.05.15.02.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:48:41 -0700 (PDT)
Message-ID: <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org>
Date:   Sun, 15 May 2022 11:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 6/6] thermal: exynos: Add runtime power management for
 tmu
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
 <20220515064126.1424-7-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-7-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Add runtime power management for exynos thermal driver.

First of all - why? Second, I do not see it being added. Where are the
runtime callbacks?


Best regards,
Krzysztof
