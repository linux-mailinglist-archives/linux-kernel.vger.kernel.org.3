Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7103757855E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiGRO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGRO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:29:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BC1018
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:29:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so19663702lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UIwsjHmYAy6o2H5gyVjjDnR9DnRkhIidIIqukB2u4HQ=;
        b=H3+Eqt2CRdrwE/sq8OI6YA2wMynd586WNKdp1IROTnh8y36dl7Q2XR42zZghiE1sQn
         IH1aMA042MVpuNymWxo+0mgQpEDkqxMBwVBAH/Z5hGsonRrJ5Vwg+LOpxrNJujKzXx+k
         3LjZpqnoFri7S5leF3OE+acWOEuDFwVRM2Lc4fNCs8FfIrltAFHD/Cc48Drj5QA+J98g
         4wsSJ4ag/BsRgFmdmygZIdcc0L0MsCDBvuxwIn2hYSWliBQnZlTx6BFVh23AIRBl72Kb
         8XNTPBZHIHDzo5LuKxCNSdhqfuvmpl4dmMuRHaHCR93Osm4yfi+az0Y1kbAf2hEl7c2J
         fALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UIwsjHmYAy6o2H5gyVjjDnR9DnRkhIidIIqukB2u4HQ=;
        b=ui6UuWCmGU+nzZR//TxjHORQy34u7y5HxEASo2qGj1TxTs1LH2427XM4QAfDfT6nRQ
         N0vCAeh5dYHwKHG3vlhDMWuOpVeSJMYfJBxV9DZQtz2WG5NfiH+J2rTU3/svIoyNSsFN
         lRHzDrYb/QeJDlRqf6ef0gqq+DzYrDeZneVOXgKSBJYiL96PQoG+qDdjCXz2j5iUM4cl
         i5AzMLl2oUaDpwKOl4kTY4229/QdrlH2WMIlpDMDvKxPPB+D7PClrgCfd8FlblXkjBJ4
         GIJzFje77D1nlmQU0AO3puCtNlwJHQjtsIoW25fk7D5jPZLFiqLXm8gbh8cJn2i4H3lj
         IbIw==
X-Gm-Message-State: AJIora8XtTiQRqJ7jfS93FtUJYcbUvIznfP5YcM65icPJWxg5cALX+T+
        iraQSn1ae7lfHZfK3VhsvDtA2g==
X-Google-Smtp-Source: AGRyM1uTGKtmJi7B5fs8B4ZC3MhuyFcqmc5Y4PNuXWmGM6TKkVvyNXmhUuSzybHpm6bkJJBusTC//g==
X-Received: by 2002:a05:6512:1191:b0:48a:2269:e87 with SMTP id g17-20020a056512119100b0048a22690e87mr8331779lfr.122.1658154568353;
        Mon, 18 Jul 2022 07:29:28 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b0047fae90bfb4sm2630755lfq.56.2022.07.18.07.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:29:27 -0700 (PDT)
Message-ID: <f992f2b4-9b75-c937-99e1-034987f71f4c@linaro.org>
Date:   Mon, 18 Jul 2022 16:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] dt-bindings: arm: cpus: Add Kryo 660 CPUs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Stephan Gerhold <stephan@gerhold.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220716193257.456023-1-konrad.dybcio@somainline.org>
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

On 16/07/2022 21:32, Konrad Dybcio wrote:
> Add a compatible for Kryo 660 CPUs found in at least Qualcomm SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
