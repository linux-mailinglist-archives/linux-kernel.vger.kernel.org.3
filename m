Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F86578572
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiGROaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiGROaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:30:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C31D30A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:30:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w17so13824346ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fCWbk7LXs7gBYt1/QRxzJLDVGWo4gV+Xc5RCVN4dXug=;
        b=V9FXuh4flWQbIcWdAZjs0NXVxOD9ShwrP9+bNDXIbn6Gn2wyFo3fthlXT7lKrc23GB
         P2rkjGggCvm8AIVNLLCqSXpTg6bYI80nsU7GmjdVAPIwD14vkqhPc9QUYHQFVLOgf3EM
         xtWjm6b2k4tAImwYqnOq24x44C4uCzjm4KkW56N7KUI1o6XoTF7e3naUVEYwD1an9RpC
         syzZ9y+544EljzrhkGA2DNocdyuFNSl3pH0ZoiL8oSnI9/cBdttWMoFYHD00B1yO0rQ7
         YebyiB28/TPlyyU+6BOoR4PTC7sAPhQ6nPNsFDLtmbREMrTarSqoKyg+0bqE+pH0F0PS
         3DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fCWbk7LXs7gBYt1/QRxzJLDVGWo4gV+Xc5RCVN4dXug=;
        b=xCU6JvceD7w5YbgJEncyvIwJp0lrYm54xdR4rhqsX+8wtsdHPnZEEjBLb5REUUxy4p
         rxbdKKKSzJhVYi4cPkRHMIOCZbQGqlTrwfgnMucFFL4iLi6CqNvck2EAmwg+abK69KPv
         ujGGTOPqPuulbzf3022CcnrpDxizjqqVjg9GmG0WbrKzXfBxmW9Ceo91z3VDsauOenoR
         ePUb60hR7Ojvfvnow+mwnkz777lHfmmbdbMy+RCwazxFC0bZlxX+JOdjsWpdbrHgsxdp
         1D0uVOM6QfwZAioABc1CarA13vlSR18CN6AoqOXn62lLxfNkTiSeXdqu6KBy3PK3nc0E
         NgqA==
X-Gm-Message-State: AJIora+fvEuPCODxShf+936yrS/PCg7oxZGxqbYXOIICip/kkLCOJGdB
        5iJPJJ2nVABNIA1rrWdOlxGvow==
X-Google-Smtp-Source: AGRyM1sQTBij+2JX2UuhzfYvywjeiO0gHch17OAwTKq9Dk0A6d2udsQska5VIU9dcK0rTrUeVeLw3Q==
X-Received: by 2002:a2e:7311:0:b0:25d:6967:c85c with SMTP id o17-20020a2e7311000000b0025d6967c85cmr12828613ljc.1.1658154613216;
        Mon, 18 Jul 2022 07:30:13 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b0047f987cc158sm2651344lfo.45.2022.07.18.07.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:30:12 -0700 (PDT)
Message-ID: <cd7787fe-8f5f-2278-5695-a07ec0acbf5e@linaro.org>
Date:   Mon, 18 Jul 2022 16:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] dt-bindings: usb: qcom,dwc3: Add SM6375 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-4-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220716193257.456023-4-konrad.dybcio@somainline.org>
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
> Add a compatible for DWC3 found on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
