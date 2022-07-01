Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB045637A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiGAQSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGAQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:18:42 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BD38BC1;
        Fri,  1 Jul 2022 09:18:42 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id o4so1704773ilm.9;
        Fri, 01 Jul 2022 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVq9FhmaSCUNqqcPRzai6+Yorwbl6Z9gJF6zzAz/I1o=;
        b=2Wv013GAZ8eC6FO1ZboevkTBQ0oMnIjvtVwbWcs032R2u1ZXIHVqGW8yKap0GRsx9k
         YDcAty+tLxMgIi0GP8xLuzPTSImM+kML9Co59i7XZsLvde4RThNp6jWrMlIKEqx3MDDA
         SAqYFiTKtsD5PB9AY5cRTBwdZniiN6koNxKl1/35U7OEZUB+KXE1P1C14fXkZFNl3hGo
         tL7bfeiD4A18nnAg79vjRUQevxu4rI66CU4n3qF9OF3Q/f3mzVWpwzsBoW4+O9lFPOk4
         BxVZgUEPaTNbqJWBufRA1U2w4QTikEgPiz3BZ9r95+vJuJwsiM4s6AXl4ioKSiMuyenk
         JOiQ==
X-Gm-Message-State: AJIora+z4P8cJ85B9nqDtes8EX3B1KA3dQ3yw9YRm4TXB0raXsqa/yRN
        rPZd+LHHBihaIxMXVcDUeA==
X-Google-Smtp-Source: AGRyM1uKu4ZHeXlBk47g/1Kn+xIxVsoVCeJJK86OxxIz1zMtHypyobrtFZSlf2w6duKGphDJrzQIhQ==
X-Received: by 2002:a05:6e02:194b:b0:2da:8568:99da with SMTP id x11-20020a056e02194b00b002da856899damr8933917ilu.80.1656692321453;
        Fri, 01 Jul 2022 09:18:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a3-20020a029403000000b0032e6358ccefsm9862984jai.77.2022.07.01.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:18:41 -0700 (PDT)
Received: (nullmailer pid 1065573 invoked by uid 1000);
        Fri, 01 Jul 2022 16:18:39 -0000
Date:   Fri, 1 Jul 2022 10:18:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     sjakhade@cadence.com, vigneshr@ti.com, kishon@ti.com,
        linux-phy@lists.infradead.org, s-vadapalli@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, t-patil@ti.com
Subject: Re: [PATCH 4/7] dt-bindings: phy: ti,phy-j721e-wiz: deprecate clock
 MUX nodes
Message-ID: <20220701161839.GA1065515-robh@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
 <20220628122255.24265-5-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628122255.24265-5-rogerq@kernel.org>
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

On Tue, 28 Jun 2022 15:22:52 +0300, Roger Quadros wrote:
> Mark "pll[0|1]-refclk", "refclk-dig" and "cmn-refclk1?-dig-div"
> as deprecated. The clock muxes are provided by the device driver
> so not required in device tree.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
