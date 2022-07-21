Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5558F57D247
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiGURPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGURPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:15:02 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655286C29;
        Thu, 21 Jul 2022 10:15:01 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id n13so1120411ilk.1;
        Thu, 21 Jul 2022 10:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJxhvKyCtA/e4QO3jHTio9jgVbrA3arFF7/VVpN4X2k=;
        b=zSf1B4aVu47dLju/fWwNX/wBGahXYHrOguRVEvunTgsALL0cZS22/IVW/t4iebuiYo
         R+4NUaMJVWFLC0IsEuF3a6iW55ZhYUdrmmdgFOE9eVAKepz/R8thIirAY6In+1lfzyy+
         wtiGP+sRivD1JJiBSMdCXRxeWVX9vije6Cbgai1Uiv8ah4aHuUvYNXtM9FWqk1Wma9Qx
         wehjFet+3CPuTvA/G/U/hy69bCHFRFqdLgX3TU48yg8n/UOCfHMdSx2Lt9nfYpx5oYvA
         KKW4ZWSbDZD00cgyoUIZbzCQjHpxHdFWvt8HtSQM55zF5lK0CwcBn+C6HtUiy2QUE5zn
         u+AA==
X-Gm-Message-State: AJIora98VYeEcUiMCPLu7Zx3zrJlkTNxPx3h9qrgPbFjQGmYeSsSPngy
        rcen01jyy57C1Tbg9uA6iw==
X-Google-Smtp-Source: AGRyM1tnnfG1TCsGYrv/PXcMBH0LzwSzc4qJXcCsniADuAUKDOQSk4uPOJUpcEkvooNO2vK2yKwpng==
X-Received: by 2002:a05:6e02:1a6f:b0:2dc:8875:617b with SMTP id w15-20020a056e021a6f00b002dc8875617bmr22474872ilv.303.1658423701048;
        Thu, 21 Jul 2022 10:15:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g188-20020a025bc5000000b00331c58086d8sm998799jab.147.2022.07.21.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:15:00 -0700 (PDT)
Received: (nullmailer pid 1584463 invoked by uid 1000);
        Thu, 21 Jul 2022 17:14:58 -0000
Date:   Thu, 21 Jul 2022 11:14:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, hns@goldelico.com,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/12] dt-bindings: leds: is31fl319x: Document
 variants specificities
Message-ID: <20220721171458.GA1584266-robh@kernel.org>
References: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
 <20220712100841.1538395-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712100841.1538395-3-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 12:08:28 +0200, Vincent Knecht wrote:
> Add si-en compatibles for all chip variants and add conditionals
> depending on compatibles to document variants specs:
> - possible reg addresses
> - whether audio-gain-db is supported or not
> - maximum number of leds
> - led-max-microamp values
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../bindings/leds/issi,is31fl319x.yaml        | 84 ++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
> 

Applied, thanks!
