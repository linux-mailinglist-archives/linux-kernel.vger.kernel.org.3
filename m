Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2555D22B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiF1HIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiF1HIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:08:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB5CB1F7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:08:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so11064167wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ALeNXOGzGUNrc57c9ovBvFy+YP0nasZkB9E9FG0rsMk=;
        b=G2nj7FM6LHML/s/oUAs+KrIZs3qU5nxLSkiF9k/5Q1jOMBFyKkbBzANpbTsAXTxVaX
         a2afGpur/8hv8HhHzltP9I8u1DtlRkNF1rzezguWiWGpfh5B07XS37HAMpxi8pOAnd7o
         xSBCNxkrggnMlMv5YBmcq7cKLuTxpdcMaME/vIY5m7CH2BLmVvmv7pr8rVxiRxWHfPgh
         Nt5zsRDbtE+vpAczLT066zCr28FiYsjxb97EMhsj50jpy6wCtdNRd2M2+iJsQkKAer1L
         ovwhTWTen2Ot/CpYvWbSelTsW7nTsIVhhlufIkbUnA8kNcjVztt1wXtBP00yUiq5D0c2
         WT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ALeNXOGzGUNrc57c9ovBvFy+YP0nasZkB9E9FG0rsMk=;
        b=kfNne+gEJhNgPVShKEjF+P8K7RZLcg0aPLyguM5NuzbfgaEhNFefJ+Hyieyejl6mx6
         qxf4/UIXsQSuFAKT7T2hzopuxWrFidFxRdh1PUmod/NyG9SaDKwTIwQlcQgdqv9wnRA+
         iVsyMWyV1/tTQIfS0fJx5rJv/1dr8AHWlSImWRbxgUsceXGp7nBoVAfbh3o1t0fKvsGZ
         CcmeJxkAGy3H678mUkXPEt7++hg1mSC7ts6RcUtfCIwybc1XGjNSy1EqdERhMmbt627q
         KN2vSRXPwmHWaJDTFinbj5Bdst2Li+bG6rPhQPMO5GBgU8i/rJOtyUz+zPScGnpRoyV8
         dBgg==
X-Gm-Message-State: AJIora/jjn3uxof6h5MkfWSEMCbmV5wzdaUf3sfhBNuo1VGkU4/QvWCY
        2DUyhtKc+t9mrRHvZD8LHT/2sA==
X-Google-Smtp-Source: AGRyM1uS3DFOzrs9WsR+XDci0voUSNM0aDCcdqgOZ1YRXrZ3PiatQ5o+fsMAXjziWQ1YMEPfdEKqFw==
X-Received: by 2002:a5d:6d49:0:b0:21b:a3ba:30b5 with SMTP id k9-20020a5d6d49000000b0021ba3ba30b5mr16384784wri.513.1656400111677;
        Tue, 28 Jun 2022 00:08:31 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d4f8b000000b0020c7ec0fdf4sm14800387wru.117.2022.06.28.00.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:08:30 -0700 (PDT)
Message-ID: <a48d1286-7b22-8340-e906-969e73d1f7fd@linaro.org>
Date:   Tue, 28 Jun 2022 09:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm64: dts: qcom: align OPP table names with DT schema
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627093250.84391-1-krzysztof.kozlowski@linaro.org>
 <YroOxPn/mQjJiJtX@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YroOxPn/mQjJiJtX@builder.lan>
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

On 27/06/2022 22:10, Bjorn Andersson wrote:
> On Mon 27 Jun 04:32 CDT 2022, Krzysztof Kozlowski wrote:
> 
>> DT schema expects names of operating points tables to start with
>> "opp-table":
>>
>>   ipq6018-cp01-c1.dtb: cpu_opp_table: $nodename:0: 'cpu_opp_table' does not match '^opp-table(-[a-z0-9]+)?$'
>>
>> Use hyphens instead of underscores, fix the names to match DT schema or
>> remove the prefix entirely when it is not needed.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Hi Bjorn,

I was expecting you to take it... Does your review means I should push
it independently? I can do this, but it is not the preferred way as it
increases chances of conflicts. I am taking only cleanup stuff, usually
mine, which other maintainers miss.

Best regards,
Krzysztof
