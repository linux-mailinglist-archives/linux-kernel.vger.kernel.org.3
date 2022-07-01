Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B855637D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiGAQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiGAQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:26:20 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F3403FB;
        Fri,  1 Jul 2022 09:26:19 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id p14so1738004ile.1;
        Fri, 01 Jul 2022 09:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNjwLM4nY3RlnA3G1YrPKfMdACXR293N5X+lQYEKiLg=;
        b=2JCHVnJvD73AKzk88e/UcSfjx5V7TsL++n73ET2B7tR1MlNwTFRA8WfypN4OGc4z2+
         kfuXVUPG5k7PxgqbRzwFyA0ohAAO+K0O2GylskFMSIMoEAfwNM1BgIv0pUgD1ACQFF0X
         VFg+uloKSy3hdePH2tUi9/93EeJnSXGDl7T58MX8pafIRki+oOU/6JzqwrP8ddfOcuGh
         ahxfyiuXz6kD7Si0R5kmgjwXWiKfakBKRa80uP7As7AmlPOqteiQBbw6te6iCSptBOim
         sFXnZTfSI475Aa4ozoN7O1/+RiFLbpbPFf+C31wAFimwmiNmS+PKWJfKuyWSpClXdQ1c
         Ezlw==
X-Gm-Message-State: AJIora95OL3U2910OkONasCFvPKqNyXVaJvOwXGXLPYtzWCUOxRLishm
        toLYiereWUovJZvtyhj/kA==
X-Google-Smtp-Source: AGRyM1vX11SyB3WVVPrsXxu0jFZuKEwzpOVgT10BsXJj708I4V1PoZPQFKLuPVicYWaAdX2s9KDcPw==
X-Received: by 2002:a05:6e02:18c6:b0:2da:e186:d51c with SMTP id s6-20020a056e0218c600b002dae186d51cmr3900671ilu.188.1656692778702;
        Fri, 01 Jul 2022 09:26:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f17-20020a02a111000000b00339bae1dab9sm9919628jag.40.2022.07.01.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:26:18 -0700 (PDT)
Received: (nullmailer pid 1078180 invoked by uid 1000);
        Fri, 01 Jul 2022 16:26:17 -0000
Date:   Fri, 1 Jul 2022 10:26:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     rtanwar@maxlinear.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-phy@lists.infradead.org,
        kishon@ti.com
Subject: Re: [PATCH v1 2/9] dt-bindings: reset: intel,rcu-gw: Allow up to
 three global reset items
Message-ID: <20220701162617.GA1078123-robh@kernel.org>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628124441.2385023-3-martin.blumenstingl@googlemail.com>
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

On Tue, 28 Jun 2022 14:44:34 +0200, Martin Blumenstingl wrote:
> Legacy SoCs use three elements for the global reset:
> - offset
> - reset bit
> - status bit
> 
> Allow this in the dt-bindings as well.
> 
> Fixes: b7ab0cb00d086b ("dt-bindings: reset: Add YAML schemas for the Intel Reset controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
