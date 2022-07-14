Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFF574B05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiGNKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiGNKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:45:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972F53D16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:44:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so2148937lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ezbe8/Zmzgiu435vISrNzCsTE1vc6aAMrCgNByBnrJY=;
        b=yZJvspVMk3P3j/yDNQ0iYlU59yGOE1g0aXmm/O1hkZJTVFUzYET5BjWM1zGWaYkVsk
         8EcC64WJuZyhNe1YeQEXDhKHAJTyRNNrzmmHJPdl1Yvf//71GkfwuTLQJIQFSi8N6556
         qjbtNEiyJQF0XUWv+3uoY6X8TgWC5gIrzxi2qn83H0x+HMVz9SN6Dz9wQEemaEn6Yv1k
         +toRwleEjwWbTe70EY3qnSKKIM3s9rMi2Xh9g8HC2lauvoGnhHkU27ucTku4d68D3vwq
         edD68N95RnhDPANJ+rEGkpp5BSPnqUjGqtLqzosIN9/MAySciSXRC6EMB2LDc1jlEMJV
         oPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ezbe8/Zmzgiu435vISrNzCsTE1vc6aAMrCgNByBnrJY=;
        b=3ajyTpWOmNNj2GrRubE8Lw20uu7fGk6MFm0j5g9A6d1gHGLR/HHvwoo1fDulTG0n4Z
         cAS/IW5fvAepg8oQivBDjl6ILoveF4ycsfLoevH93XlWLWohd8eFAS8KRuP4vypAer/I
         1t+Dm1Sg4ruiU6Aq0ysmpVqq+Qj+cOdqaXPiQEH0ha3c8thx5F8S1QSvGLqw8WN/pXVY
         Eo90ZK8LluzBwLijpruKiI3O1GSeL+7239Iu9clWWJ+H6XA7niFzzyo5AoChn1o5lvbo
         cAGKUCFi3d1VF1/5BSI+5jVYP/2DXbhxy/c/kU8wctoWffTWZpaG9DatRlKdy37tGJIQ
         kGGA==
X-Gm-Message-State: AJIora9fCLSPe/30VQzzBKGxHRe2qGEIiWDBBohC3eNpqCuoWvuVNEA9
        XXzXjhsVATjetlpJXPG3jbVp1w==
X-Google-Smtp-Source: AGRyM1sMmH8VDImlt5yq7+wGRaj/ajBXJ+zYg6N9rK+le9CWMVJcwr3CotqWEaZ8cKLgsKJEBoeliA==
X-Received: by 2002:ac2:4d43:0:b0:489:cb6e:b293 with SMTP id 3-20020ac24d43000000b00489cb6eb293mr5135859lfp.376.1657795496788;
        Thu, 14 Jul 2022 03:44:56 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id t24-20020a195f18000000b00478a8b7ab1csm291638lfb.150.2022.07.14.03.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:44:56 -0700 (PDT)
Message-ID: <b50abf48-8aee-8d68-2800-f53fc612781b@linaro.org>
Date:   Thu, 14 Jul 2022 12:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: qcom: Enumerate platforms with
 single msi interrupt
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714071348.6792-2-johan+linaro@kernel.org>
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

On 14/07/2022 09:13, Johan Hovold wrote:
> Explicitly enumerate the older platforms that have a single msi host
> interrupt. This allows for adding further platforms with, for example,
> four msi interrupts without resorting to nested conditionals.
> 
> Drop the redundant comment about older chipsets instead of moving it.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
