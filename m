Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F97506FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353198AbiDSONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353114AbiDSOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:12:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273221E10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:10:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s25so20960894edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rpe1/2k9skZQZsZohQIAx7DCRl/7wi0AvEbx7ya00/A=;
        b=naS9LXHM/dVe9KSCU8+bDBdI+tqV4C8pnpXGkO391qmD55MpUH5CTe77QJdmJn5kqe
         ovOuvo6210Az0aNuV5UakzirqqJqS10/vkj4XxzhNHpgT2nQwXFaSRmXnc9nvsxMotpo
         qawDDTKlHCrapFe6C43P7OO19Pp6WfXhg1jhaK6ZIUvVOdqXE4VrzemPonLn2zlrWPgk
         Ruddwkax5/NfW5rHnSihreYu8SvyAQM7fJLyww6Qm4lvY62HArIqGn8DTDYbmNXCsKsm
         q57xKkGomiimkurvZ5CAtEuuARsFL0usQhJkUF99b02EnDbUkUVi2Ex8QljUUS69UdEc
         pOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rpe1/2k9skZQZsZohQIAx7DCRl/7wi0AvEbx7ya00/A=;
        b=gBWBbbKuVp5vYlynw3w2IO+3QhGDBV6srtL8Uda9eyfWPjirK1juyWYGeJLYj+Hm/o
         9T/r/xLBaUbwkcuDsDJ3KpGGnYsYBd7Cb/2zhltLYRkqggMTgZLOSYjB1DjaKLMz4YXN
         Eb1Dk9urwOZh2oPNhtnL46lVYYrFYL0R318LLi5cX+4DffOkLAgiAptj0NyPs0TWdNj/
         Xs1GPTRnVJPWpfvAPP34BpiNUMwUi/W5Y3hpgCHTOnXM13vZk9J9S+9JL/dSM1GZQgGv
         yF/A4/VE83zmKNde5iAbJLtHYba+SFaqvGs61jUz+7UIRVcn1vKWAYm8TsQVTz6+58bI
         +gjw==
X-Gm-Message-State: AOAM532xfqbzHiVNL1PmKrA9RCxMEi0hYVIw0ImcyRX33+4m9nrnQ7/z
        k8A2RvicKbfziCiOjLu8sN6xLFhSjEb+GA==
X-Google-Smtp-Source: ABdhPJwZnGxVLDm8zeQDBLITRAoaPGLSJ3R6Ng0tvRhs+d20obKSGJkS46owIQxcHIUhhy6PZ+Akrw==
X-Received: by 2002:aa7:ce05:0:b0:41d:6857:549e with SMTP id d5-20020aa7ce05000000b0041d6857549emr17992958edv.251.1650377403787;
        Tue, 19 Apr 2022 07:10:03 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7d65a000000b00424064b8ed2sm508617edr.33.2022.04.19.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:10:03 -0700 (PDT)
Message-ID: <b7ec781e-e56e-8376-7866-263e0209dfdb@linaro.org>
Date:   Tue, 19 Apr 2022 16:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memory: Make use of the helper function
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220418020147.2556925-1-lv.ruyi@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418020147.2556925-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 04:01, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

This is for public bug reports. Don't use it for regular code which is
not related to any bug.

Best regards,
Krzysztof
