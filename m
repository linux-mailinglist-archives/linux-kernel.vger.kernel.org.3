Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20C563B55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGAVAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGAVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:00:15 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2B6B264;
        Fri,  1 Jul 2022 14:00:15 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id r133so3398321iod.3;
        Fri, 01 Jul 2022 14:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ctqlzZw2MhrIChLMCIeBt07CM3EXBC75S3zsan61x4=;
        b=PNJfMKpf2EoNoHmTLgzDgIfcx+ALNuzWit5OccgrNsDyBjqFnMMYwe7sPdGdGbCYJF
         7VKeLEcLV1RHEP4QMvJKeSaFKA8AmMuFrKpRpQTXG9ZLMcIZoTpviHL6Ij5TJjTDgeVv
         4s32hcusSu8hr1qbhtZoueecqn/1iMeEJeNsGIsJMX+vrjEqcurmtPH0nHucFm+hPYbf
         1dbInNyfZ8UOgdS+5U/PfYAcCkX76nXhARX/SwAEar52sEory5hCuWcmk2S0c+T42gUU
         BO6CDmIjSr5pXMraCcmNAiyffCQnw6Z2NmFqvOppGK/S5I/6lq2Ul8utpmGjvDiH5u0c
         E8aw==
X-Gm-Message-State: AJIora/jFStUxbJElffsU+Xmrbh6hgDSj5uAc36nj81CK5CqaOQGvJ0e
        YyCOsc9op8RhBu1byODWcg==
X-Google-Smtp-Source: AGRyM1u3Ud6uF31yf1r/fk8j5de8jaxoaKm0vsqfcLRGAZN/JpWcNvqwol7Cr/srtDFd8aco4c1wjA==
X-Received: by 2002:a5d:8b96:0:b0:674:f65c:a12d with SMTP id p22-20020a5d8b96000000b00674f65ca12dmr8558377iol.180.1656709214372;
        Fri, 01 Jul 2022 14:00:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s12-20020a92d90c000000b002d92c91da91sm9412776iln.77.2022.07.01.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:00:14 -0700 (PDT)
Received: (nullmailer pid 1521297 invoked by uid 1000);
        Fri, 01 Jul 2022 21:00:12 -0000
Date:   Fri, 1 Jul 2022 15:00:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: leds: is31fl319x: Document variants
 specificities
Message-ID: <20220701210012.GA1521242-robh@kernel.org>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
 <20220701134415.4017794-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701134415.4017794-3-vincent.knecht@mailoo.org>
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

On Fri, 01 Jul 2022 15:44:09 +0200, Vincent Knecht wrote:
> Add si-en compatibles for all chip variants and add conditionals
> depending on compatibles to document variants specs:
> - possible reg addresses
> - whether audio-gain-db is supported or not
> - maximum number of leds
> - led-max-microamp values
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../bindings/leds/issi,is31fl319x.yaml        | 84 ++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
