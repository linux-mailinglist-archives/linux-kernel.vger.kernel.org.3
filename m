Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF09578578
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiGROat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiGROab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:30:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290C1E3F5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:30:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bf9so19595635lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yGzBcnIR8gnhNP8TbCXArntI6WydijgCYOQATQgi/hg=;
        b=a4y+HT/Qw6BSHRoP9vACpK1VlKGnPtYNOpiWlQ3SkNlxhupWBeDKQ6fjMiZYzzJItI
         sa6Gg0cCAC4k0bp5o5w2iVTRw//E5CkhKbu79i78oO4b72tfHwHwsJvxZ1V1v5AwGYnZ
         Ms/Xkh1Wd5AIIGOdKuiAwYrxrCV88X4EO2SG8HvrqoAmxpvS7x+N3OzT8wdHx/6iPzTd
         Nv8E11tUMU1TTIaA4JK8Ze3o+d569B2PmNOyvd5VusJ/M22EUHaL2Sl/RXLwHTWcuHyT
         4kALWpCgDQnZXLRgvbYvHwArr5zxmZFiHCcOXFG0VefL7i6JlI+V8ql+HhxIrBiDRWKn
         QlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yGzBcnIR8gnhNP8TbCXArntI6WydijgCYOQATQgi/hg=;
        b=YeTtScxYIBfFFZdVj4yH7EIKaU2yWI+E3+PqENbfh0oJDWWqRc2byGNjhYly2uZGDR
         dN/g0A9Nx6VbbVXA1C6mo4fBn7mW2WAo7vysVvArb0IIpsYSFBpHlFoGQKWdKXrNATLD
         9KaH2s8XYE6AvUqQGmnOQNKN2t4A4zLPu+IPKS17U0fx+ZLfrFIJsYn0G/tdH9TLEi5s
         hfxF7CQ3UvNwtGEU1zVG3oN8NyYEPEMp2n9T0hXVfOvP7+DfsJySH9q4TwL7STVcKdKO
         NsUPY8ZXcuQXDNri+wl6m0ZKz66yPfzZcvO3Z54zSrBg3SdyywEbOsTOQz50vnzGhQGG
         O16g==
X-Gm-Message-State: AJIora/HzP+6of0MAESebVDcW0ZQ42oGdaZ6nNhoyEDm5tV2ESvOg4xt
        lPYabujzuTFkHczMkKWT4Mfquw==
X-Google-Smtp-Source: AGRyM1uiEmPF8T4kOGGXhvsc8apPta0lzgE4syolmluzy1g2FHmEL0UNC5fW4nmtwQDT3G4NfB2auA==
X-Received: by 2002:a05:6512:3c86:b0:489:cef9:18bd with SMTP id h6-20020a0565123c8600b00489cef918bdmr14690203lfv.386.1658154628261;
        Mon, 18 Jul 2022 07:30:28 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e8e2a000000b0025d53cbba2bsm2137642ljk.45.2022.07.18.07.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:30:27 -0700 (PDT)
Message-ID: <e898be38-dd0d-04c4-7152-ab16cc027c7d@linaro.org>
Date:   Mon, 18 Jul 2022 16:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] dt-bindings: mailbox: qcom-ipcc: Add SM6375
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-6-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220716193257.456023-6-konrad.dybcio@somainline.org>
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
> Add a compatible for SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
