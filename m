Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1A51586F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381503AbiD2WfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiD2WfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:35:04 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE63FBDA;
        Fri, 29 Apr 2022 15:31:44 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id v65so9951129oig.10;
        Fri, 29 Apr 2022 15:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8ShUMCXwevSM+KZHgclp3XqLzSAI00vI1y7sVAiRZk=;
        b=Z8vw3g+9MYhIf9zLqjoKH1MjKgAFOTPgx8Kks6uiNQiI/99rZMYrhNP31Xht11qEla
         RVjVJSEyO9eXl6QPr6nNV4ErQdyZZ+cIIl76gcEOHMYkLZA2OiVX4Y/Osh5TQuE8WHgJ
         018uMFc0GJBicho6pfySkmw4mm9c+uvlcmhUZY8tGTtvM2rpwKFUUqckBI9R5RL2gsyZ
         VBcXMzgqoS3HvXBl2pTIpkxcom/i+GE40gOenElSCQ5SKY2uOP718hfLZjqQfmp0Nsm6
         ELeS/B+Vmtfveh4JC7NIle6Uf8ITubrCS8SIQ6L2+z7sRB6S8D6hmZXST1n0zI5HxzmQ
         y2Cg==
X-Gm-Message-State: AOAM5328WyDoAPsD7wNAJaHQge+jY9lH4UYaqdFmZC/ptjvLp59ZMBhY
        ciscYea/c7jB1u0M73004Q==
X-Google-Smtp-Source: ABdhPJwDqejqhWuRQiFknX+EWaZwHivSuDpGwtm8Z46JIaGZ16DdkjJ1BxROqroZgrqC3YcKAlmfFw==
X-Received: by 2002:a54:4e04:0:b0:325:644:3374 with SMTP id a4-20020a544e04000000b0032506443374mr2614428oiy.198.1651271503950;
        Fri, 29 Apr 2022 15:31:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b21-20020a056870b25500b000eba4901e57sm977104oam.17.2022.04.29.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:31:43 -0700 (PDT)
Received: (nullmailer pid 3019653 invoked by uid 1000);
        Fri, 29 Apr 2022 22:31:42 -0000
Date:   Fri, 29 Apr 2022 17:31:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add compatible for MediaTek
 MT8186
Message-ID: <YmxnTqCCtF7bchxW@robh.at.kernel.org>
References: <20220428061717.11197-1-allen-kh.cheng@mediatek.com>
 <20220428061717.11197-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428061717.11197-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 14:17:16 +0800, Allen-KH Cheng wrote:
> This commit adds dt-binding documentation for the MediaTek MT8186
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
