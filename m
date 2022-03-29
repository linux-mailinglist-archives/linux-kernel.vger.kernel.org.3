Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9224EB287
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiC2RQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiC2RQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:16:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691DF606C6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:15:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa43so36453461ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u4/Xoq8QX2+BSN1akZ5eJ0B56WB/4G+OnIBGzph+8D8=;
        b=Uqle8LLPZRhi7EFrBAFaa3v0GJirU8cirdL4/0+sEr4luHTyY44LMh/eNY2bjY14q4
         aYAHCvphytwYlzNtmOVjY5J4zofpkdMkXDH27OhFhaSXwqoLQmnrckfUaxTK7keEbL9a
         vFfm5O4zrJEMHp+P3J/Lab5BUDEWoYXhs/oswOmVGtVQwyE15ol0UN/UR3+qI/Nht4dH
         yHJ1loyFFR4NMMEhc5VaHdSzS+uoWlngIPdGKGZ3MBO6Tz8dcC7tnhnZ/bPvLUERAe7W
         lIpZ9vj6gg93r/xmvrzO9tKZG2p3ZtLRRwodCX8rEUemAUhC+DOftKx/q/jL1LABxcW6
         g5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u4/Xoq8QX2+BSN1akZ5eJ0B56WB/4G+OnIBGzph+8D8=;
        b=wP40IkZ3Gg9b1GRxNe7mr/ck0o+ECsZS7MLiexIV/pylf8lANLY+3ga6mqENd1E5sA
         dGqSjx05Y4RZMyzLEya1smcMprcpP3NaMBIoqP2sgYHPOyPYxEWoMt+CrRBLErni5nl2
         +boizaFiIzWXYNUgsiC6aJuygz5RnavWSyt6di7m1EtUSDFNOe+ps6xPNs2/Ef26I3N3
         s+IpJjJ7GOphEgQ8pISuttvzTP6sf2J0mXzHq5iH7YpNIHGL4UPaX8Zh/ymv/sHik32i
         sJddRvrha411e+06zGcykJN08lpNs2GdBdLjJActOD7kbL4Ow3tV/xs2vR4XhbLpI/12
         6GwQ==
X-Gm-Message-State: AOAM533N4lcefywTrXKrNELz2dXeNfBI1dOsXvXwsBCFOOooKI5eGf2m
        UQxcBbwIuJrWrwPTT6dzW5jxug==
X-Google-Smtp-Source: ABdhPJyO+8+whle+3kOlbJHCsgtYjuqBeH8vGylEvAwP94rgXmdsghv9CEj0b2o9qYXnTEPXWCihvg==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr20867752ejc.424.1648574100077;
        Tue, 29 Mar 2022 10:15:00 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b004193fe50151sm8782747edr.9.2022.03.29.10.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:14:59 -0700 (PDT)
Message-ID: <a1c70fd7-efe5-aacc-bb4f-74d7a21a310e@linaro.org>
Date:   Tue, 29 Mar 2022 19:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] dt-bindings: PCI: mediatek-gen3: Remove clock-names
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "allen-kh . cheng" <allen-kh.cheng@mediatek.com>
References: <20220329071526.10298-1-jianjun.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329071526.10298-1-jianjun.wang@mediatek.com>
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

On 29/03/2022 09:15, Jianjun Wang wrote:
> Some SoC may have different clocks (e.g. MT8192 uses clock 'top_133m',
> but MT8195 use clock 'peri_mem' instead), since these clocks do not have
> any timing dependencies and the PCIe controller driver uses
> 'devm_clk_bulk_get_all' to gets all of them, remove 'clock-names' in
> dt-bindings file for compatible with different SoCs.

One driver behaves like this, other different. Driver implementation
might not be a reliable source. :)

The clock entries are expected to be ordered and fixed, so clock-names
should stay.

Best regards,
Krzysztof
