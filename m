Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA885A704E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiH3WCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiH3WC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:02:26 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66D91D20;
        Tue, 30 Aug 2022 14:59:04 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so9043250otd.12;
        Tue, 30 Aug 2022 14:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=c/mrE4x9g0huZBo1ugVDt1ad905oGNnLQIQ5LBb4CBI=;
        b=NcIY6NkzNR74thJGbz+oCMiBavT+cCKGawax5DpLKQxtN7H3xhFv07setxTnm401ll
         1oWy0MSoQIurLcr+K9RTlz5zIaaI6npQ3SBRr4uImwLC0sMUiLRkC0jiSN9h4jpKP1oX
         LVSx0kAiskotCG53EUfAv1tTanE6DCsP6EYOc/ehbPgNCJp4wwvIBTheMzN6jm2E56eA
         itLLAzYquzxDukbY+NC33F72CyvUPSkahV2EvyLTgFryZo32rlwY0RQzo7VCX8njstzI
         4x+3gkfUpsD7fJsI1U09RkNyrxWaZXqpAGDsR14b8zPC3Zg73sbMH9RfrXVIjO0I3xhY
         fn/Q==
X-Gm-Message-State: ACgBeo0dLTfoQW3ZjJawrmN/UztJUH7iNN89bjDPumdDp0oaZhynXXpm
        Rlz9JRYbqDXqVp1oOkCUFCE/GWvFNw==
X-Google-Smtp-Source: AA6agR71tq++21E81nS1qjOGVLtVmMpvSKqybPuf6VKvptEt5YSJ3AZQMb63n+WeA2kCVWWehZ1y8w==
X-Received: by 2002:a05:6830:929:b0:63b:25ba:dfe4 with SMTP id v41-20020a056830092900b0063b25badfe4mr6463836ott.311.1661896743283;
        Tue, 30 Aug 2022 14:59:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a056870e30700b0011e4893127bsm8804950oad.38.2022.08.30.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:59:02 -0700 (PDT)
Received: (nullmailer pid 2162196 invoked by uid 1000);
        Tue, 30 Aug 2022 21:59:00 -0000
Date:   Tue, 30 Aug 2022 16:59:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC
 compatible
Message-ID: <20220830215900.GA2162133-robh@kernel.org>
References: <20220825180417.1259360-1-mail@conchuod.ie>
 <20220825180417.1259360-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825180417.1259360-2-mail@conchuod.ie>
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

On Thu, 25 Aug 2022 19:04:17 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The l2 cache on PolarFire SoC is cross between that of the fu540 and
> the fu740. It has the extra interrupt from the fu740 but the lower
> number of cache-sets. Add a specific compatible to avoid the likes
> of:
> 
> mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
> 
> Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
>  1 file changed, 49 insertions(+), 30 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
