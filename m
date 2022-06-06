Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0286153EC6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiFFJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiFFJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:14:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A42CE02
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:14:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg6so7841427ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o2BIvs2CiHbnftIF9GXeEXyWaa8d8VLM4+ON27yArK8=;
        b=PLSEwqlS9lPKnhGdi/Rhw5WSk0u4NZhXNzBm/E9qHDDD56GPXzmJgR4n5VrVSUaMPo
         w8babsv7+xcmdqxWOz5VDBshuwnwwzt8thyjcF2c/Rlrd/8nK3IuAiJx7sEC4BRaA5gD
         nWpVEwg5PPL9N7JzjWzHFfY6muFiuBPJO8+EpyYlwAURFyM2TLx8JOZULfYhj5TVejDL
         uqWFvvwiijMj+Pbn1idzUBvnNd+FqbOuiDwhyZ+s1ZL0mB0GNZ3sXTfUBnI/vnYuHjiy
         XkkEGD0nvUlDROkibAGrZmG3pJxyaSV1UDfK81bPL+eZ7OUNwHVlpEZuICQCIRGPohnd
         iJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o2BIvs2CiHbnftIF9GXeEXyWaa8d8VLM4+ON27yArK8=;
        b=1dV0SUph420/QJrxymeHrmBG/y+A+O+ytGIK1Ug5HtVyuWDO4ZS+Qq7Y2cmdEyElRe
         BioC9rrQuJT/SlL+bl+lTz1ZEvNMKYW+64zNLI+CZ5ErtU2BxY/glBeHDXefn5ueRzTb
         yOmHudgzp1n1gmViJQxZSVHMKQLPSPVdV+xhXwlRpkoE11CdVROYUHSs7Xes/Ccx9OuN
         rBchnvVtNaMYGXppamYWwT1VMtrZCjXiT9bdCanmMEimQ6f3kV+rFJ1WoiwzKon69Us/
         idAkjBItOdm6UjjojIpo2zyTe2HZfVilXfOZBkmoPg4xWMYIpWimbTeBQ0p0KuIATRA5
         xFSg==
X-Gm-Message-State: AOAM533Jhel2IzvIlQsH4rU7s89UFsUisPzwfCSNMOmjfq8N6p+ADSQ9
        gDsEX9fwDTcQ1D6P5Qs+DwMsIg==
X-Google-Smtp-Source: ABdhPJwzItmtpxqMK7mq8lOPKWTf5GlFbaJo+qj5njAy2pX6EQrpgNOZXO8Pwj7O8VeqjUNo1B0OtA==
X-Received: by 2002:a17:907:6e90:b0:711:cb3c:8c1a with SMTP id sh16-20020a1709076e9000b00711cb3c8c1amr4818413ejc.516.1654506869295;
        Mon, 06 Jun 2022 02:14:29 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zo11-20020a170906ff4b00b00709343c0017sm5407317ejb.98.2022.06.06.02.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 02:14:28 -0700 (PDT)
Message-ID: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
Date:   Mon, 6 Jun 2022 11:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] ARM: s3c: Kconfig: Style cleanups
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux@armlinux.org.uk, alim.akhtar@samsung.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
References: <20220523064252.11938-1-juergh@canonical.com>
 <165450679893.60702.4773704114108524411.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <165450679893.60702.4773704114108524411.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 11:13, Krzysztof Kozlowski wrote:
> On Mon, 23 May 2022 08:42:49 +0200, Juerg Haefliger wrote:
>> The majority of the Kconfig files use a single tab for basic indentation
>> and a single tab followed by two whitespaces for help text indentation.
>> Fix the lines that don't follow this convention.
>>
>> While at it, add missing trailing comments to endif statements and replace
>> tabs before comments with whitespaces (which seems to be more common).
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] ARM: s3c: Kconfig: Fix indentation
>       https://git.kernel.org/krzk/linux/c/076702da7e8a2472f8ac86f1179ddcc5e90febae
> [3/3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
>       (no commit info)

...And dropped. This does not pass checkpatch. Please be sure you run
scripts/checkpatch on your contributions.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Juerg
Haefliger <juerg.haefliger@canonical.com>' != 'Signed-off-by: Juerg
Haefliger <juergh@canonical.com>'


Best regards,
Krzysztof
