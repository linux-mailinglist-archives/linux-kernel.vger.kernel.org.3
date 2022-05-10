Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C37522495
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiEJTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiEJTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:17:34 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178262608F3;
        Tue, 10 May 2022 12:17:34 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id i66so118058oia.11;
        Tue, 10 May 2022 12:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5pt1nhkt3BTjyS+5a9vGL7dR1PanXMrncxkn2qYPM4Q=;
        b=GJLuYIGUdVkAp/PIGIKsCYtffCF6DWq/us0w1gmJEM0NXnaLiYNB+aoIlR0j1YjHgv
         3UAzeGUd72iiCJkzljjYl/YKWJjabzyRFGjA/JSyUJnjey1P++akECDZzp/IwCQaVzi2
         XC9p6dK1btasRtaUVDf0RFG4UaDQ7nf5BF02t9xMJS5LUt78QpiO5Orzv7PAv2rv83ka
         KvABWRcmUrUoxcN/0ftmH7/ZkmP7Qb5Y6tSQqWBqwsYuQlL7k8n031c4+Ff7AKPETAqF
         WYn/pgHMBP9qTjIrH1I8MueSwxwLxLrj0cLyYi2R8woFSVVh54g3y6deWij1e874XUeo
         YgCw==
X-Gm-Message-State: AOAM533rADNl0FTUcYi6HNTLZFRAoLo4vGZXvp1SZfCzF4QAx9hXo8er
        16oPKCVOoJPAnjdfirlF2A==
X-Google-Smtp-Source: ABdhPJyG4SPRDiSI4R0cRjgdp1eWBrkuuiQkzgMZcMTEKSaJA0JscKRXgIWGTH058Z5bR3BF0RDwWg==
X-Received: by 2002:a05:6808:f06:b0:326:fdf0:fd77 with SMTP id m6-20020a0568080f0600b00326fdf0fd77mr811761oiw.254.1652210253309;
        Tue, 10 May 2022 12:17:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o34-20020a056870912200b000ee2bb503d0sm4788848oae.50.2022.05.10.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:17:32 -0700 (PDT)
Received: (nullmailer pid 2429752 invoked by uid 1000);
        Tue, 10 May 2022 19:17:30 -0000
Date:   Tue, 10 May 2022 14:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
Message-ID: <20220510191730.GA2427587-robh@kernel.org>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
 <20220508142624.491045-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508142624.491045-2-matthew.gerlach@linux.intel.com>
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

On Sun, May 08, 2022 at 07:26:22AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add device tree bindings documentation for the Intel Hard
> Processor System (HPS) Copy Engine.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4:
>   - move from soc to soc/intel/
> 
> v3:
>   - remove unused label
>   - move from misc to soc
>   - remove 0x from #address-cells/#size-cells values
>   - change hps_cp_eng@0 to dma-controller@0
>   - remote inaccurate 'items:' tag
> ---
>  .../soc/intel/intel,hps-copy-engine.yaml      | 51 +++++++++++++++++++

Also, this should go under bindings/dma/

>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
