Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8122513EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbiD1Wto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiD1Wtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:49:41 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383649278;
        Thu, 28 Apr 2022 15:46:25 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id k25-20020a056830169900b00605f215e55dso727677otr.13;
        Thu, 28 Apr 2022 15:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfLClO0c3m5ysOvoYs15acVm9FGrl4E52LtituaKB/c=;
        b=1wkRm/S33yGS4iQzb6QVWGU2RWtXKFMoc6lid64yXANfjjyE3NglZu0khPLAGtlmO/
         YI1m8g3LENfeL8x1IBUFQ2t7PXdbXujs8SwVRKqMiIk8UiGKVwYkzz6Pqyj0zEEmoczR
         nKCwcfGI34n80MBXFP00NZFno3XDuzCCzAqrBd5Xcg45StvxyXJsorzg6S8K8dOb4REh
         fyeeTRxw7jNlWg1vnQpUBjGwwayBL3w/tgYxYaU11r9fJUOm5e9keK0PsSKOrIZSuxO2
         CNMBBvbDmq+rMqnqthgDs4a4bYen7GK6ZrOgGCxqm4yhFst0jGqwpkKjxZDSUn/Mjlg5
         LChw==
X-Gm-Message-State: AOAM532L3KSKG8E/22kImGUAM0fPT+1LZvDs+g4N4B1/EhuCPbcL0Z1G
        +KI8ZN9vZ96fNLJUa9xOzg==
X-Google-Smtp-Source: ABdhPJxlsAp0UyeRenAWEeWlFhn6JRT0WWSoTOr8ogVulmNOLZlOLjQYwvcFF6qzcEDtDrXI6maGPg==
X-Received: by 2002:a05:6830:4104:b0:605:b481:610e with SMTP id w4-20020a056830410400b00605b481610emr7799417ott.268.1651185984606;
        Thu, 28 Apr 2022 15:46:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a8-20020a4ad5c8000000b0035eb4e5a6c6sm112724oot.28.2022.04.28.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 15:46:23 -0700 (PDT)
Received: (nullmailer pid 486861 invoked by uid 1000);
        Thu, 28 Apr 2022 22:46:23 -0000
Date:   Thu, 28 Apr 2022 17:46:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/4] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
Message-ID: <YmsZP41lvje+pBna@robh.at.kernel.org>
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427075338.1156449-4-michael@walle.cc>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 09:53:37 +0200, Michael Walle wrote:
> Convert the fsl,ls-extirq binding to the new YAML format.
> 
> In contrast to the original binding documentation, there are three
> compatibles which are used in their corresponding device trees which
> have a specific compatible and the (already documented) fallback
> compatible:
>  - "fsl,ls1046a-extirq", "fsl,ls1043a-extirq"
>  - "fsl,ls2080a-extirq", "fsl,ls1088a-extirq"
>  - "fsl,lx2160a-extirq", "fsl,ls1088a-extirq"
> 
> Depending on the number of the number of the external IRQs which is
> usually 12 except for the LS1021A where there are only 6, the
> interrupt-map-mask was reduced from 0xffffffff to 0xf and 0x7
> respectively and the number of interrupt-map entries have to
> match.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v2:
>  - drop $ref to interrupt-controller.yaml
>  - use a more strict interrupt-map-mask and make it conditional on SoC
> 
> changes since v1:
>  - new patch
> 
>  .../interrupt-controller/fsl,ls-extirq.txt    |  53 --------
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 118 ++++++++++++++++++
>  2 files changed, 118 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> 

Applied, thanks!
