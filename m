Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891BD568E85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiGFQAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGFQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:00:49 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00F22B0D;
        Wed,  6 Jul 2022 09:00:47 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id p69so14389721iod.10;
        Wed, 06 Jul 2022 09:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eapa/ltQqCjpwdBfwKCsw90fAUtdsJkoZHS0nADe7Iw=;
        b=a+fTCf2j7eV/BFWxkkEtBy+kOyVfVWJiuUZBZPxcpbPc7/qj/1Ibn79/N83Z1zi1ZI
         1utRmUZzRPB0nZvv9VYkRArqBhUrcXHtfn+Jp1+AP/soz6y94XlLMzGm+jNMzMjzYpxT
         uwjWB+UxWJTzLAu3SXRQnugjXDw6Mz/hUya9Fw9bBRzkJEQ0QJKowE+ilshffuHQnhSj
         801yfyYaYaFhUHtbATaiUbTyNBy6UxSLgKrrMVweRpecDiHvj2u0q/Qtj5VThv1sAR+S
         uXWSxRp4BPATLQx0mrUq2363UlyyYVNOiB1STBuRDFw0buenq+Kf9gkJwcPyYksRvwtF
         vrpQ==
X-Gm-Message-State: AJIora8Gy0JRcsrDIRHgsDDFCTcnJ3ik6+wzZHDAogJ10dfM4hJ78MhW
        nfNOvBA8lMrSPnuyWL8wfb2t4F6Sww==
X-Google-Smtp-Source: AGRyM1tdiGrB5Ucg2D1u/brE0h7PErQZk7g0g4hKTr463CkrTRnXebaIjgUy203Zg6eB3Em4ssvPjw==
X-Received: by 2002:a6b:8f44:0:b0:675:1e6d:938e with SMTP id r65-20020a6b8f44000000b006751e6d938emr21749173iod.189.1657123246482;
        Wed, 06 Jul 2022 09:00:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d11-20020a056e020c0b00b002dae42fa5f2sm6366095ile.56.2022.07.06.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:00:46 -0700 (PDT)
Received: (nullmailer pid 122249 invoked by uid 1000);
        Wed, 06 Jul 2022 16:00:44 -0000
Date:   Wed, 6 Jul 2022 10:00:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: samsung: document preferred compatible
 naming
Message-ID: <20220706160044.GA122192-robh@kernel.org>
References: <20220705161340.493474-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705161340.493474-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022 18:13:40 +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Add a DT schema documenting preferred policy and
> enforcing it for all new compatibles, except few existing patterns.  The
> schema also disallows wild-cards used in SoC compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Update comment.
> ---
>  .../bindings/arm/samsung/samsung-soc.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
