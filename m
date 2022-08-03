Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1734C58878B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiHCGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:44:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A239BB8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:44:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e11so17926689ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6wCmqftL2YTJwRl3uJo2czdhPZEtp4fKlSDbfT0Ewd4=;
        b=S8AR7bEDgG1TRfKJbCDVv5Q3tJj6UuB0l62JQgl61dfaQ2IfMXCzzbiYMIt3cQQgXc
         wX0QRZXawZXgX4Z7IKoSjE0jCNzRplDDUEa4D5adMdvWwoGcgCGS7z4WBh8RqQouDP07
         IEzzNAv6bD/VXMZZULSeI3KZ6zI++uWfpyR1iXqUgfTUw+gGCJlo1fhWIbEKlBXIS35z
         v7DBBDohOCJ2VBhoMLNA5XwNYaSpYiTWrPkDfnNbOhqtSl0IDIwrimONgp4szk5qwK78
         nZVSStgWoyI9flFyLbDjGMXrXkMihmAPHFGJNpOJsrdaTQVk8ah9mNYawe4FZsJVLTWv
         Tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6wCmqftL2YTJwRl3uJo2czdhPZEtp4fKlSDbfT0Ewd4=;
        b=eaX+iTHk3UqzAhrjpAu1o12RkRT9W6gfszItZR6nM3EfPpJz2F9abQTGCxCK4dED7k
         Pu0/cLp4Kt/KnOGEoLiZgMcFjDBTZ99+Le8pDzQ4BrlqI274RL0OobEMJg1zWMj7Q8h9
         EqSeZFUAH46aPgAENJ4eAQjTTAQikxUxGmrWDFWPpu1WK8nKUaKA0FR1+MH3nsHEj/vN
         LLJYsqLM20qnZ9pQK9bUtatQo8xWo8sZs6UQWW6JqAkmDM5j8BRku7zyr9mkI7j3UhRE
         07KKAxMJXefh8oIZHWlsCWb8PUU6r9P8bbHow7PNCcJ4P6bA+kELVSzYOk2frWZa7ixp
         YPVg==
X-Gm-Message-State: AJIora8h9EqPLUQf5bx5Id+ijIQvLnC7ZoXZ1bHh7Iz3IC53pG/+l5CM
        34sGYJPNwknWTVpqucAL4AKj9w==
X-Google-Smtp-Source: AGRyM1s44i0wbnt6DAfjwwwQh9ZAYD+9dDBin5vOqQvN7GRthJFgT71RyENzL2QFCogHHWjE748DUA==
X-Received: by 2002:a2e:bf14:0:b0:255:b789:576b with SMTP id c20-20020a2ebf14000000b00255b789576bmr7850928ljr.47.1659509054089;
        Tue, 02 Aug 2022 23:44:14 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c14-20020a2e9d8e000000b0025e5b5474a4sm546137ljj.85.2022.08.02.23.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:44:13 -0700 (PDT)
Message-ID: <5c14e959-10cc-5520-e88f-b47a195b99e9@linaro.org>
Date:   Wed, 3 Aug 2022 08:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
References: <20220802120624.19258-1-jianjun.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802120624.19258-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 14:06, Jianjun Wang wrote:
> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
> 
> Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
> "peri_mem" instead of "top_133m".
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
> Changes in v4:
> Remove "items" for "mediatek,mt8192-pcie" since it only have one item.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
