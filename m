Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7B563B60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGAU6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:58:49 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F254168A05;
        Fri,  1 Jul 2022 13:58:47 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id h5so2141090ili.3;
        Fri, 01 Jul 2022 13:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTiysxQ1mDjbgrX1GIC1fvRl2VzOeJCuzL2T82Etx+k=;
        b=Xl20VnIOlXfFU9xIQ0XWjSoN32hL972s8LviKmM5y0X0l/yzATRtYESPUD8wwxDqMy
         fxZphJz73ZM7epvyfrGjAc6RrrP9GierrBTe1ipsH6scEFDns05CqfdkNnbFCslhu6Wb
         I4Vx9dCdRDoAA0G9Hvp6g+Myz/ylK9mLD1mQJ4mGP0Iu/2mt/nVgVjD7F4JUlUw1Vu48
         k2QNsM+WKt+0zuCMj0SIQL6QmJTigvPe97XYQhNIlS2FH2oxVBbzDbrwyVrTF6nCr6t2
         MajWU24cgU06MG5llOPW0JZEk6NYTuoPFOIa4aUt1jNEO/9f7Rk69vfekJhlPin7yOSa
         HX5A==
X-Gm-Message-State: AJIora+E2qZNKYDxbQhG1HdgRW1/5O9nAVNBdNq8VYmcwl51FCtLCY/+
        JnTxUZ4NyLoTPYwoFsfDtpCDuOODDg==
X-Google-Smtp-Source: AGRyM1t/0z1oa23PdELK4xIthVQ3oyP1jTCDv+F8M18YpRCBHLKAdXJzNvzSC4kT952g5L1ewpbuhA==
X-Received: by 2002:a05:6e02:1be5:b0:2d9:3419:742a with SMTP id y5-20020a056e021be500b002d93419742amr9391939ilv.289.1656709127296;
        Fri, 01 Jul 2022 13:58:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z19-20020a05663822b300b00331f1f828adsm10301591jas.16.2022.07.01.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:58:46 -0700 (PDT)
Received: (nullmailer pid 1518882 invoked by uid 1000);
        Fri, 01 Jul 2022 20:58:45 -0000
Date:   Fri, 1 Jul 2022 14:58:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Convert is31fl319x to dtschema
Message-ID: <20220701205845.GA1518826-robh@kernel.org>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
 <20220701134415.4017794-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701134415.4017794-2-vincent.knecht@mailoo.org>
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

On Fri, 01 Jul 2022 15:44:08 +0200, Vincent Knecht wrote:
> Convert leds-is31fl319x.txt to dtschema.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../bindings/leds/issi,is31fl319x.yaml        | 113 ++++++++++++++++++
>  .../bindings/leds/leds-is31fl319x.txt         |  61 ----------
>  2 files changed, 113 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
