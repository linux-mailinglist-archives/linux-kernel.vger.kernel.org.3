Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3907570106
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGKLqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiGKLpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:45:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B87C4D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:43:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w17so4304315ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uc6ms35+AbS4/EQS4J9akUPVqTSo3UlLl9wiMGTG74c=;
        b=t0/2f7Cx6OYbmjZLZpPfeui0kebCveUEtF71oGksFUZRJf28pqpqI0s1EK8/+K/KGd
         8ZbXrYuZsqMzvuMGZiECOkjxVVZx5owZK9AEjxRJfwQ6DbdzITovMeq8et3NOe4z2n8O
         bKgQ0lf8fl1QDmwf+hucVodMt7aVJ1XPKS6oP3L9mfhi0dx8VDKhQtvnWBpanUQOI4bB
         SysQYbhNp9gY4+KJIaggXj9zUribB0WyYuMasDL9SSaeq2573aadhxI0joTr+C/IKPuD
         yHMbplIT/NMkyWMU9fXEBZm0F2/KtztUSIqWzrxyIvSU/UOP1kqMuYz1VkOlLrGdHRzn
         kNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uc6ms35+AbS4/EQS4J9akUPVqTSo3UlLl9wiMGTG74c=;
        b=UMGEsNCyQsZcWKTuJP5F9WJqal47RMh/18SnQmQnSCJNffsfgG8f2djGE/ivZ0HgHH
         4yFEHlV3NqFRVPU9lia25YxJE4drsvNswRXOa5r5VyOQ/N666SM7mWOVDh/saSMHMUhy
         Z03Qh3t26DGON0AI441HN3xjbjBmNS9yKFfLTUdfIMrjWTueicwblOc+kG7FKlqRqVvL
         Pk6QvOHJqCEG7zd6JGKh+U9TZ/3Hdop1EZAs5HdkuWMjcNK++AbLMj7Co8FRlZ5cmkNR
         zw6FJckkEu9NH8IBfrliLvGZ/4WrdgYZT4OP/6EiNyNEEmMYDqrybgYeBHP6DzC+FAPB
         Fa1w==
X-Gm-Message-State: AJIora94SXl/Hej6nrSjRLQKAPmlVmKCty43zZ/5NcMx7YA1zgP9jUk+
        no0dOm702Zy/ZhWo37yvdKgwzQ==
X-Google-Smtp-Source: AGRyM1tt6JCOi3gSxG34My3+LkkbHF7JRyEJKa5BpwH4EAwGZx3mZMH1e0MgbAGT5TnczKzOM7nDfg==
X-Received: by 2002:a05:651c:204e:b0:25d:4798:9776 with SMTP id t14-20020a05651c204e00b0025d47989776mr9974145ljo.86.1657539779744;
        Mon, 11 Jul 2022 04:42:59 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id 190-20020a2e05c7000000b0025d65d4e178sm1295325ljf.120.2022.07.11.04.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:42:59 -0700 (PDT)
Message-ID: <7cac726a-542e-777b-99a6-7b3b9b529bcd@linaro.org>
Date:   Mon, 11 Jul 2022 13:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] media: dt-bindings: ak7375: Add supplies
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
 <20220711042838.213351-3-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711042838.213351-3-y.oudjana@protonmail.com>
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

On 11/07/2022 06:28, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add supply properties to describe regulators needed to power
> the AK7375 VCM.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
