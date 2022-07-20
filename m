Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9E57B475
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiGTKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiGTKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:25:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FF2C66B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:25:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv24so1601163wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z3jJrPCyTzgDwtpGSTySZxdrcJyisqv97waetDyPkCQ=;
        b=sCjSMvoF3N/YhfKOZGtrMzIcX8cxlimIX+SK+xYqEKXCgqRBkY6lqsBsABZeIzh+yO
         fs7bpLWl5dF11SXyxp2l2ky/YDoitDwkLXSzsJXTdFeDqwELcxATYktrzyTS/C4/T4IY
         JgsT1ntJ1QXffjy2ODz6SR4YXqq7KNb8YHpj+he7lVSwm4iLYPRECN5eeo7ro1o3nPP/
         PZbXUiLkskZo57ZubzaNZXg7QXwDE0omfYBWo9GiMjC6t317K8u0L34/Sc72s53X8OIQ
         e6UI8uTxSO1TjumE2XjVAOID5Hi/NA/DOlLZ9zNnpqDsRvdwG23Di8YOItQGQp4620NZ
         wLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z3jJrPCyTzgDwtpGSTySZxdrcJyisqv97waetDyPkCQ=;
        b=XMGniOROCZzD3z27FrJ9z5hvNXTUUDRRnY9BM7VPPllG1EXB4lmEDdydYewu3L1C0x
         xf6j/hP8LjE9z8dx/LfSKgPF2zXRI0ZarKGDP8AhMQHzdNbTAcIbbZ25jY2FzQMjnQL5
         LQGzBrExXfgF3clVdwQ/b6mMdy26GAKhvs2r7KqvMi8MqdXemFAwQ5keVtNKIHJcCkSG
         nOpYyiHwo63aC6ODbpAy7+l9OMgYFtZgWJTbKAESwhVHwtdlvk0cqbzl5ocpM6K9D3p0
         F+/5TnN853A5SUmX7ZD8pEs5IIpbq6FOJ6wry4BjDDzgs0VyOwCTVOtu+Y3Z/HJYvcvD
         fTPg==
X-Gm-Message-State: AJIora+uVq3nv/V83Suk7nco31Skk2Y8N+IjeHEAPwtcvxyy7oyg3JD8
        w/+18R/jQ5Br8bHP5Hv9TXxodA==
X-Google-Smtp-Source: AGRyM1uyrwWzo5MmrGdZYIEhYMnIovU4xFppY+X/ePoCuDLQGMqHhKKIOZHt43U5jzpCtuBuuiuoBA==
X-Received: by 2002:a5d:598e:0:b0:21d:869c:f6b5 with SMTP id n14-20020a5d598e000000b0021d869cf6b5mr31135914wri.399.1658312743177;
        Wed, 20 Jul 2022 03:25:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b579:e7b5:219d:267c? ([2a05:6e02:1041:c10:b579:e7b5:219d:267c])
        by smtp.googlemail.com with ESMTPSA id o24-20020a05600c379800b003a327f19bf9sm1890514wmr.14.2022.07.20.03.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 03:25:42 -0700 (PDT)
Message-ID: <e35a741e-0d90-9aaf-5563-9721648dfc11@linaro.org>
Date:   Wed, 20 Jul 2022 12:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clocksource/drivers/tegra186: Put Kconfig option
 'tristate' to 'bool'
Content-Language: en-US
To:     tglx@linutronix.de
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, kkartik@nvidia.com
References: <20220718213657.1303538-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220718213657.1303538-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 23:36, Daniel Lezcano wrote:
> The clocksource are built-in, not as module. We don't know if the core
> time framework is ready for that.
> 
> Revert back this option to 'bool'.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
