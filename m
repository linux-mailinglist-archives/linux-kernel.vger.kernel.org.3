Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837055CDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiF0XsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiF0Xre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:47:34 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83316585;
        Mon, 27 Jun 2022 16:47:34 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id z191so11262105iof.6;
        Mon, 27 Jun 2022 16:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRvWZ9TeKvYoId4Is7bsf/P3csJZYeH6unVDw+FoBLU=;
        b=DqGL5rQAznhpykG45QQmWkBJJ+kum7QXo7ndJNibCk03g5AykLFcHP5z2f16At5LTx
         h5CBS0YfD25NEv5fqWowdPQi0pttPk6hAuJBiEFDhp96xE7sFSeXjaTXjH3F2/9MlGoP
         x61Mkx/76Y7aZS9pruuPfZSAFWN9YU6f7eqt+rWBcLQZEl69L8ZbxE0LoXFx2JrGN75o
         w43jmI5jtwQkFIA6FfJaj9nj6tWhxO01XpZd70CiF2lPxvaaXrPcz3r9MfEDyLPGnHCn
         X7W+e1wC6KeUNJiUghw6xn4JzrG0PQsCfeXS0215lnVb4MET35BWbf079akN4ZYlZo6J
         EU9Q==
X-Gm-Message-State: AJIora8thM5q6XjZ44OxBYVwae09kS4EqjL1Mci4YZEc4oKT/z7DHpm0
        zj3Ui9KkYyPpjQhflYJZrw==
X-Google-Smtp-Source: AGRyM1sfviI8ea8JVeUGZ7ysyjsRGHtyP3Kc3Y6dB0rkpSKEubWLB6skv7nEn5awW3d9L+56SWnBOg==
X-Received: by 2002:a05:6638:1344:b0:331:f546:69e with SMTP id u4-20020a056638134400b00331f546069emr9894555jad.131.1656373653305;
        Mon, 27 Jun 2022 16:47:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b201-20020a6bb2d2000000b00674c8448c3csm5993564iof.6.2022.06.27.16.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:47:32 -0700 (PDT)
Received: (nullmailer pid 3193779 invoked by uid 1000);
        Mon, 27 Jun 2022 23:47:29 -0000
Date:   Mon, 27 Jun 2022 17:47:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] dt-bindings: phy: make phy-cells description a text
Message-ID: <20220627234729.GA3169775-robh@kernel.org>
References: <20220619113325.21396-1-krzysztof.kozlowski@linaro.org>
 <Yq8LHN+WGVpXDwiM@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq8LHN+WGVpXDwiM@pendragon.ideasonboard.com>
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

On Sun, Jun 19, 2022 at 02:40:12PM +0300, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Sun, Jun 19, 2022 at 01:33:25PM +0200, Krzysztof Kozlowski wrote:
> > The description field is a string, so using YAML inside phy-cells
> > description is not actually helpful.
> 
> Does it hurt though ? 

Unfortunately, I see this a bit. It's convenient because the schema 
passes all the checks. Doh! And I usually stare at it wondering how it 
passed.

Though I probably did review this, so IDK...

> For xlnx,zynqmp-psgtr.yaml I wrote it that way to
> prepare for a future where it could be described using a YAML schema
> (but such future may never come).

There's 2 parts. There's the resolving the defines and then applying the 
schema to the cells. I actually think the latter would be easier. At 
least from a documenting standpoint, we just need to define our own 
keyword to stick the schema under. With the tools doing dtb based 
validation now, the tools already get the phandle node and get the cell 
size from the DT. It's just another step to extract the 
node's compatible, find it's schema, and get its cell format schema. Any 
volunteers?

Rob
