Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C94E2FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiCUSPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbiCUSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:15:51 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95256C13;
        Mon, 21 Mar 2022 11:14:25 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id b188so17074197oia.13;
        Mon, 21 Mar 2022 11:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X18l5ZgCy7Io/W3nugZZbOoUaFggmyKgVds/Y3paIIE=;
        b=mSTgM10NgNOwMAJQAQ9rNgNITyQZ3s5hbz2IkuIFX0KnZR2mSlH65H8ucS+WzPX+eG
         bq4jeiXaCnVF3Jg8EXFDjNIeSCwnCN7H2pmTbFukdCrNoTjU8y4Wp1q7TihFaaFH66AK
         81Y9AyX3jz5WjmsI8WrK7RsDrw9DpLjNYlFUlB6bZiCCcT+9NQgEGJ5yonlvfJxWQvSo
         aWMNBE2cQcq1Xpqh6b6Kc/f4ibV7Rj3Rb+8BQAvVqVRSOXlcuJFRQaSV8r+LoB/7dhJy
         1JwaUaL7vEmI58JNc5s4GMcvxm3aZJ0GthBNk0v79u9eQyeJ8T5Zj+42XQdLXYhc2tFs
         52FQ==
X-Gm-Message-State: AOAM532fj9vzj4t+IFFLOmq2iG+fVPMbZVChvC8GXLniUICWic8kGlSV
        cBk5O1xhD2ucpgP3cFaWHg==
X-Google-Smtp-Source: ABdhPJzM2OCjvOW1TW1oV8roXo73goKmx759fni9Dwt32oL6loDEsvcF1us2W0ldM+xfPJ5nyn2B3Q==
X-Received: by 2002:a05:6808:8ef:b0:2ec:aa80:4b90 with SMTP id d15-20020a05680808ef00b002ecaa804b90mr190621oic.201.1647886464844;
        Mon, 21 Mar 2022 11:14:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l13-20020a056830054d00b005a3cce351a1sm7881084otb.28.2022.03.21.11.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:14:23 -0700 (PDT)
Received: (nullmailer pid 306587 invoked by uid 1000);
        Mon, 21 Mar 2022 18:14:22 -0000
Date:   Mon, 21 Mar 2022 13:14:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: usb: samsung,exynos-usb2: include
 usb-hcd schema
Message-ID: <YjjAfkMRf5eCMtqF@robh.at.kernel.org>
References: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
 <20220314181948.246434-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314181948.246434-5-krzysztof.kozlowski@canonical.com>
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

On Mon, 14 Mar 2022 19:19:48 +0100, Krzysztof Kozlowski wrote:
> Remove parts duplicated with usb-hcd.yaml DT schema and include it
> directly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/usb/samsung,exynos-usb2.yaml         | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
