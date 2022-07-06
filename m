Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2B568C66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiGFPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiGFPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:10:40 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455CBC22;
        Wed,  6 Jul 2022 08:10:39 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id h16so1391085ila.2;
        Wed, 06 Jul 2022 08:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdjs07DYAhmei3cQmKh7rMmTcQmZl8SHjo2pXmSEwmE=;
        b=jQluPyyvgk392D6V29Imo3jnlqPJxoRz6ubrTTn09eWLCKL11s7ylccyjzuvDWuYF+
         w1jZ7slDcFsnq7ybs2q3xv/wZThejMWk94QKuY+a+JdfQoBoNiTbEZSFFiz9wyZ1Na1f
         U3VaikdiHshHFdWyOQWpiT8/exS/EIsiq1SBuDDZ0ZtPjPLZdL0C20XpN559q81i79wO
         n8L9EZuj8w9R7Kfpw3azCX1DbQvVJ9F9ok3ouguS17XMCqXVb2GZTw4gwKtJdO6jE7DW
         pI49SDRSWcJpxW7P9CH4WTE4Q6pMbcL60bMuH63gTZKCzGwZM2RnjTOiNmxeumI/+4rT
         Y36A==
X-Gm-Message-State: AJIora8/wtE5KCoqAsmANKmPvDu8Y2hNaj6+1DebpC8XSsblFQW28dZj
        SziEx6L7cf5aSd3Zx29n8Q==
X-Google-Smtp-Source: AGRyM1ukR/q19o2G5RRh5INK5veEH8Jp0n9LvRhhRZ5m/iy7CTOt7IJCw4YpeHMhXstT1Zh2H3yAmg==
X-Received: by 2002:a92:d190:0:b0:2d9:4461:f2a1 with SMTP id z16-20020a92d190000000b002d94461f2a1mr24104284ilz.143.1657120239050;
        Wed, 06 Jul 2022 08:10:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c1-20020a92d3c1000000b002dc1d6652cesm2587203ilh.13.2022.07.06.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:10:38 -0700 (PDT)
Received: (nullmailer pid 53287 invoked by uid 1000);
        Wed, 06 Jul 2022 15:10:36 -0000
Date:   Wed, 6 Jul 2022 09:10:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: hwinfo: samsung,s5pv210-chipid: add
 S5PV210 ChipID
Message-ID: <20220706151036.GA53233-robh@kernel.org>
References: <20220705154613.453096-1-krzysztof.kozlowski@linaro.org>
 <20220705154613.453096-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705154613.453096-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 05 Jul 2022 17:46:13 +0200, Krzysztof Kozlowski wrote:
> Document already used S5PV210 ChipID block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. None.
> 
> Changes since v1:
> 1. Move to hwinfo and rename.
> 2. Mention that device is already used.
> ---
>  .../hwinfo/samsung,s5pv210-chipid.yaml        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml
> 

Applied, thanks!
