Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822159C879
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiHVTRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiHVTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:16:53 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DEF4BD16;
        Mon, 22 Aug 2022 12:16:44 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso8349285otb.6;
        Mon, 22 Aug 2022 12:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4Oa/UMWYkVYWBruwLqUl1catmvheetRkDDVHMlQt8JM=;
        b=PgMdZZFDyx3PXp6lthMUGXsP2x39lLRhwYPXs5SRSV60kGo6D0i5cIZyjlXyF58oA3
         iB8kDLuONUzE+ocUonkRwviYWDib+xNE2XCxyNH/yE/qNyrBbVVEfmGcf3jmhdssb4kr
         smPaxvwHt7r09ech9k2Eweva4VLUfXWTsztCGUIckxL3u8DPVDQsBhQhgaZYHdPLb/Xk
         CPqBMwyikLLqW625CcKKyCCsgm/ojJa3uirkSJm0VEFjPTGlQyhddOEMr0Psr73ehUwL
         PJ9d0ejsBI4yAcEhBt8DyZezUBZssNoqeEUB2NQkZ9jyd11MK/fk5Ij5GIR0b6gkqL4R
         BmLQ==
X-Gm-Message-State: ACgBeo0BUJFHg/aE+BSfk7n7CCtcDG415niBmA07tU9hur8zNJEhO0YR
        QjKiwyUUjastVvxZaOV94RBP1P73Dg==
X-Google-Smtp-Source: AA6agR6ysS5OEqWcPt4oYYbtHtpUsEkrszbDwDzYSWv6EaU9kt1STyzXD3ZeTVZu+8EwJYE8qMYxLw==
X-Received: by 2002:a05:6830:d81:b0:616:abfa:796f with SMTP id bv1-20020a0568300d8100b00616abfa796fmr8212916otb.18.1661195803382;
        Mon, 22 Aug 2022 12:16:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x19-20020a4a6213000000b004320b0cc5acsm2595504ooc.48.2022.08.22.12.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:16:43 -0700 (PDT)
Received: (nullmailer pid 262091 invoked by uid 1000);
        Mon, 22 Aug 2022 19:16:42 -0000
Date:   Mon, 22 Aug 2022 14:16:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] dt-bindings: interrupt-controller: Fix 'reg' was
 unexpected
Message-ID: <20220822191642.GA262042-robh@kernel.org>
References: <20220819190729.32358-1-a-nandan@ti.com>
 <20220819190729.32358-4-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190729.32358-4-a-nandan@ti.com>
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

On Sat, 20 Aug 2022 00:37:29 +0530, Apurva Nandan wrote:
> Fix the following warning in dtbs_check
> interrupt-controller@a00000: Unevaluated properties are not allowed ('reg' was unexpected)
> 
> Add the reg property in the schema.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/interrupt-controller/ti,sci-intr.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
