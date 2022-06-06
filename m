Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9953EB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiFFJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiFFJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:17:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DA3524A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:16:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v25so17934212eda.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=cmfLbqhoQiFLa5E1pfLk7y/mThg1wpsTvl0u1dgvBk0=;
        b=DfsN10T9CbmLe9U9m96Z1IaxmGbZ0TDZVgsUyWOX5qThqhfWdoOyHYVl5PbE4BENdX
         bAShDJrsPNXAA6j9S856T8kCzwUZ3d5jjkzumK2hrI7z0x/hireWPz3uQ0xMF1cLdAhm
         rOHZvrTxYtfeA/QD8+MKY4wM6/ax2EIJF+I7WSZjOtFsB4on29anw/lTywjujrxhwS/7
         e0o8/gLd2EC5aCcP5e8MJrqPgvNnmZzZrTO4TwI/YUqx/t4/YuNkHCWfPnzpeGcM2zmv
         XJ46EUMQgHG7MXU7O40xAHZEH5EcpB4lg7nCx0XZe6c45pQar8yYxyqY8DnuMg+O8cG6
         u+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cmfLbqhoQiFLa5E1pfLk7y/mThg1wpsTvl0u1dgvBk0=;
        b=T59GaKVd8lIOhOtU/DgztHJ15rMfL61CmmwtjVHQ8rvrWM8mI2J7Ijh37I+f72/fF4
         qtjXCl9WycGpFw7D3RTPKCJTKyCIwi2Ea8/vMHZYBIogN9lvGqJ3QmSB16VZlwCSf2Oy
         zcTUHrFJgPMKOjBti10KJuzXI5rewhI2cxiB5eW4yZvQ8nAHyGHuw2bVzSt3pfly4XL0
         /FegRfvwHgXLv0bhQBXRcdUtpvPOuoO68AOwV+od6v0sfK1PB2nd2N3dVFKrvx9SQyA9
         MrhjVj3MZWPvdYrnUjTmfWZwD69anHou38MC3/jrW+MMsoR/XtxFueNPlFyDx9U1Ur8D
         uj0w==
X-Gm-Message-State: AOAM530L2tfd4j0iORBV4lhdtStZoqvfiBDD2G1BQhPAnSQh54qXeZQV
        gKjkKjljko0kLIRoy7LCqD/Utg==
X-Google-Smtp-Source: ABdhPJxjQO0yREoFPWIXHNb12VVyOH3vwlE+zaXsSP1AND8vy6C1Ufxo5Yw3+8L82h6QG+A8RMCxSw==
X-Received: by 2002:aa7:c444:0:b0:42d:d1d9:e4d8 with SMTP id n4-20020aa7c444000000b0042dd1d9e4d8mr25824860edr.145.1654507007953;
        Mon, 06 Jun 2022 02:16:47 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906590f00b007081c5ce04dsm5846061ejq.58.2022.06.06.02.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 02:16:47 -0700 (PDT)
Message-ID: <b6cc31fe-1d71-376b-31ad-a149d2224d53@linaro.org>
Date:   Mon, 6 Jun 2022 11:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] memory: mtk-smi: add missing put_device() call in
 mtk_smi_device_link_common
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220601120118.60225-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601120118.60225-1-linmq006@gmail.com>
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

On 01/06/2022 14:01, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling paths.
> 
> Fixes: 4740475 ("memory: mtk-smi: Add device link for smi-sub-common")

This is not correct SHA. Read:
Documentation/process/submitting-patches.rst


Best regards,
Krzysztof
