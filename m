Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26351C287
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380630AbiEEO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353436AbiEEO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:29:20 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D5213D65;
        Thu,  5 May 2022 07:25:41 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id y22-20020a4acb96000000b0035eb01f5b65so746999ooq.5;
        Thu, 05 May 2022 07:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6D1plv7qfy/cJKu1iXxkRk8eZlvR6Mt/KnTOaxH5/k=;
        b=PuhK6pIP6hai6x1fyFSD7xZk6elZTwmnNnfpKiMv/MCP3y9yjO+iNVs6ozIavMIhVO
         UPxe+YZ+kPKextQjGEbeUsHjalE+wJCKqMQev/kpEHgLqkQFvuga4RH7fNN6q2hPGUQt
         afh6k6PVih5r/8XJzZLi6y4qxXOeN8EDZ5JQfL1D0O3DBbHcDSyZEC78f0yoUAsYibTV
         5B3M27zFReh0SMAaydujWbhi77rIe5bElAU2v+B/biMTKgsYoaOh5aPD7qA0/mhIlp9Y
         USkvrZEJrOlXcRviSq4ZOAOw/gyf78KYsm0/EKgyhg8LwNBGpGxpijWhziBDqvBq173h
         XG2w==
X-Gm-Message-State: AOAM530V0xgA6LB1Xsk1S5/dKGs034K8qpS2F1Vz08NAiU6H2/uVpxG9
        joSvjvzGiSpyScelds1sCw==
X-Google-Smtp-Source: ABdhPJyvL3Edq6MwGudS9eLrFjC4KG9919dpALhLQH5iF+EbqD3voYoBtYa8TcDugNLOoZCq33ZNeQ==
X-Received: by 2002:a4a:be8a:0:b0:35e:9d51:2359 with SMTP id o10-20020a4abe8a000000b0035e9d512359mr9334293oop.6.1651760740243;
        Thu, 05 May 2022 07:25:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 15-20020a54418f000000b00325cda1ff8dsm691889oiy.12.2022.05.05.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:25:39 -0700 (PDT)
Received: (nullmailer pid 3831239 invoked by uid 1000);
        Thu, 05 May 2022 14:25:39 -0000
Date:   Thu, 5 May 2022 09:25:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630
 compatibles
Message-ID: <YnPeY46mKSM4wbWq@robh.at.kernel.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022 13:37:57 +0200, Krzysztof Kozlowski wrote:
> Document compatibles for QFPROM used on IPQ8064 and SDM630.  They are
> compatible with generic QFPROM fallback.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
