Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D154FD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiFQTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiFQTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:14:44 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF5C51E4F;
        Fri, 17 Jun 2022 12:14:43 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id 19so5442059iou.12;
        Fri, 17 Jun 2022 12:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROxQNWepyxFvZiTq2FGYSmXKdfg/hoZVhK9wn73gCSo=;
        b=D8JQLfBwCO/L9w3xJ0yZhq+tC2BZTiqtt30zHM53yHzzrA8vxQlZppR0JSEE/u5fB+
         h1+iF1b0qIuAsFUozwJxeNUTU3rLsgB2t34Yy+D8yH8njYEVR8RFt3cH3iEKYz+4g94G
         04G/avWuIJq/prHa+aL9Q+4/PcdWKP8rR5Or4cc/t6tCyho21ZjxGFN2qru/MS5TMEhe
         iQtodc+TD/QE7OtsGZenRrqfAsIlfsF/DQUQ8p+2W7WRvsg5R8uag7N97DSb2wLivgvz
         QGIak9gkR8U5M+3Olm2R3eiF+aXxo126YGKrxY2DkxRO8SnmP1Me0wuaDW1cf9xvaSSb
         gozQ==
X-Gm-Message-State: AJIora+Kf63WEvMYYjKNNiWecYM2Lp8QVlRg5q3kw8UKiDWJ9Yg+CPdz
        gHTEJqob2udOyUWGhXCDWw==
X-Google-Smtp-Source: AGRyM1skQCk3jEKpjp4gVCWhPxydb4ykJSdlOAuI8I8ko+C0oG9aNCxdFG6N74+nn1vHN5XJjZJ+cA==
X-Received: by 2002:a05:6638:1306:b0:331:7d9a:6f8 with SMTP id r6-20020a056638130600b003317d9a06f8mr6264999jad.195.1655493282438;
        Fri, 17 Jun 2022 12:14:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a3-20020a056602148300b0065e246fdf94sm2964951iow.45.2022.06.17.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:14:42 -0700 (PDT)
Received: (nullmailer pid 2125743 invoked by uid 1000);
        Fri, 17 Jun 2022 19:14:40 -0000
Date:   Fri, 17 Jun 2022 13:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: vexpress-sysreg: Add deprecated GPIO
 provider properties
Message-ID: <20220617191440.GA2125674-robh@kernel.org>
References: <20220613171809.3928949-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613171809.3928949-1-robh@kernel.org>
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

On Mon, 13 Jun 2022 11:18:07 -0600, Rob Herring wrote:
> While the current binding expects a child GPIO node, the old style binding
> with GPIO provider properties in the parent vexpress-sysreg node is
> still in use. Add the GPIO provider properties as deprecated.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!
