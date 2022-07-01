Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC45637FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiGAQeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGAQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:34:20 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93C13F8D;
        Fri,  1 Jul 2022 09:34:20 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id f15so1723850ilj.11;
        Fri, 01 Jul 2022 09:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAjn3M/xOLc0u5cG3jG7mYhlyDge8bkXUKr4zNyCXGE=;
        b=aphcpCkjnZWn2AwA6EM0MDqOxYXfUZo260qp7gPa2IGAEoqZTGrXJm/ZT+l0MYnSBh
         h1T/eFOZnJqpJ1PorRrd+wGgtC6Z6LE9VqbSjQQLxgeJe13Jo4mzhKHGZbhEttd8CUeJ
         cw+e/QUt0fPPCNaNoKA1c9UGIUYcJwlRoXt0uiULom6jlhyiNIoPpsZrbH5LDCObc6Wx
         kMQ40NleuHvmeCbCIAP8Iw7c99N2ww0a4bdBHDUj2elQbSwq1Fd/l1CjD9FkpTJ+aPzp
         LG+exD856GI6XM2t3ZMj0eudVaVEITEiFmLvkUs0MB7Xuya+HWCbYqBmf+O7CeDgbCGm
         +QPw==
X-Gm-Message-State: AJIora8m67tbSvBAXbayssyepWEz+D32yOsdaZi1LOLWHPkPjvaA2j/K
        suojTo6Wv5DB9fMZzqkIWbF8bjHadA==
X-Google-Smtp-Source: AGRyM1tblTI7F8CSwI8+nerSLn77nVtswznZ0l98jaldGav40dF2BAF9sWzUeH8C1+Q3My94gw11+g==
X-Received: by 2002:a05:6e02:934:b0:2da:93ee:1645 with SMTP id o20-20020a056e02093400b002da93ee1645mr8860741ilt.132.1656693259354;
        Fri, 01 Jul 2022 09:34:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z25-20020a027a59000000b00339ecd53618sm9886175jad.156.2022.07.01.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:34:19 -0700 (PDT)
Received: (nullmailer pid 1091036 invoked by uid 1000);
        Fri, 01 Jul 2022 16:34:17 -0000
Date:   Fri, 1 Jul 2022 10:34:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mips@vger.kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 4/9] dt-bindings: mips: lantiq: rcu: Remove binding
 documentation
Message-ID: <20220701163417.GA1090981-robh@kernel.org>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-5-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628124441.2385023-5-martin.blumenstingl@googlemail.com>
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

On Tue, 28 Jun 2022 14:44:36 +0200, Martin Blumenstingl wrote:
> This is now part of:
> Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> 
> The PHYs are still using sub-nodes while the reset-controller is moved
> to the main RCU node. Also the system reboot is now described directly
> in intel,rcu-gw.yaml which makes the syscon-reboot node obsolete.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt   | 69 -------------------
>  1 file changed, 69 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
