Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D205570E05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGKXNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGKXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:13:21 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0830509EB;
        Mon, 11 Jul 2022 16:13:20 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id n68so6372897iod.3;
        Mon, 11 Jul 2022 16:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+xsXrHKbwgwRMOBC5ueCPd6m6uJqEs8A2pHdJgDMG0=;
        b=Ou78mne9/ZXnw7A7sdH8KFsgtz2KpZKR5AohaLJRS0JYYu3PCiyt1e5TdJ7TpN8Go2
         S46bT9htu3xANMrVzxPdO69UV0JORnKerFr1GwoYKfmuw77ItHCSpHeCwZP9AgKtaqWy
         E8sOv0bTmrKEq/a27pmRUQuMD9ytch/WeXapK3HmF/eLlMBhPvgvygAzt3N/I1+FpIZp
         ZlrtRNNRm6HCYKowYpags/U/QTtUOLlM8VinZEueJ0pGp8EDBiPKc6r1IHiX1g96tq4N
         Zc+qQKnW+tvUUz49xusjVobnaToo6yF/MJ0tUhMDQjcOMQG66qBOkWfbuI6qdopLD/al
         8F9Q==
X-Gm-Message-State: AJIora+riZ49mGas9fHpO6Jx/Rdnlt1aGd7JSjPHGA/KNKx+FOTMHFBk
        6skZnvOMHU1I0qVlsP3ocw==
X-Google-Smtp-Source: AGRyM1smXQuLdxE0NR8tRcT+paGMEY5ZJBKF79o1+ztxVmzVmSeS4W5jT4PHCTvnuAeWHdotl+T2LQ==
X-Received: by 2002:a05:6638:4511:b0:33f:4ccb:3139 with SMTP id bs17-20020a056638451100b0033f4ccb3139mr5647828jab.20.1657581199999;
        Mon, 11 Jul 2022 16:13:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a26-20020a029f9a000000b00331a3909e46sm3504613jam.68.2022.07.11.16.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:13:19 -0700 (PDT)
Received: (nullmailer pid 448337 invoked by uid 1000);
        Mon, 11 Jul 2022 23:13:18 -0000
Date:   Mon, 11 Jul 2022 17:13:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     MollySophia <mollysophia379@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s
 bindings
Message-ID: <20220711231318.GA442599-robh@kernel.org>
References: <20220709131935.50708-1-mollysophia379@gmail.com>
 <20220709131935.50708-2-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709131935.50708-2-mollysophia379@gmail.com>
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

On Sat, Jul 09, 2022 at 09:19:35PM +0800, MollySophia wrote:
> Add documentation for "xiaomi,polaris" device.
> 
> Signed-off-by: MollySophia <mollysophia379@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 129cdd246223..80dff09bdc83 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -235,6 +235,11 @@ properties:
>                - xiaomi,lavender
>            - const: qcom,sdm660
>  
> +      - items:
> +          - enum:
> +              - xiaomi,polaris
> +          - const: qcom,sdm845

I think there is now an entry for this as a bunch of missing 
compatibles have been added, so you will need to rebase on the qcom 
tree.

Rob
