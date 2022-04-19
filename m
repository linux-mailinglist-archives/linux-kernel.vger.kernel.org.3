Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7715076DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbiDSR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiDSR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:58:32 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E80AE40;
        Tue, 19 Apr 2022 10:55:49 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e4so18959504oif.2;
        Tue, 19 Apr 2022 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G53IGdSl4eKD/pKBUNFtH8S3ZJw3xBhGFrzG2Kwc3lo=;
        b=0tZlbuT/p3sJcbqRkmQHmMr5OqijfQXcII8oALu7NTFpt2dQKPqUY06QpcArfZWzqN
         c4S2xXiNWr8i/iPceQVkLPI2y+QvmFeC9Fg137WhaccyIpMyIbJgKBR0fCuGcQCt/cZ9
         vpdR0VJpdUZf8Dr1nIu7vxOHBH+PlNDHU3mWrFe7HZ1DdO/Edn2lU/CZmmwqMRWcBOj4
         nkiz5TXrcdf7vj5FuyNkYm8MBsLH+xsqOgje0iESjz6iFv4a4R3+wRYQo/m/m6xxUTJ0
         jU5+k95JkXN9vtQxUOaE8gRUDoTaTOQAEYpAmPdtf4GiWmCRMIqbxyI8STjxWI1I/z4T
         OTDg==
X-Gm-Message-State: AOAM530UVCJCT9tg04DC01S6csSc61XAAnLgoX54L1vjcFIPyUQm0/G+
        zQOFaLnd1/BsVuKPtqJKpw==
X-Google-Smtp-Source: ABdhPJxndRV5nmSseK/j2Lgy/q7El5d7cQm60BIp4GkP1mhx/Cvfniq4V1aBmaIujM+XiM8WMJ/UsA==
X-Received: by 2002:a05:6808:bd1:b0:322:3523:f30c with SMTP id o17-20020a0568080bd100b003223523f30cmr7819510oik.234.1650390948421;
        Tue, 19 Apr 2022 10:55:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m5-20020a056808024500b003222ff73171sm5274286oie.17.2022.04.19.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:55:47 -0700 (PDT)
Received: (nullmailer pid 3052225 invoked by uid 1000);
        Tue, 19 Apr 2022 17:55:46 -0000
Date:   Tue, 19 Apr 2022 12:55:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Message-ID: <Yl73orZuOaPG7KgV@robh.at.kernel.org>
References: <20220414103211.16202-1-a-govindraju@ti.com>
 <20220414103211.16202-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414103211.16202-2-a-govindraju@ti.com>
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

On Thu, 14 Apr 2022 16:02:08 +0530, Aswath Govindraju wrote:
> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> controller.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v3:
> - As VBUS_VALID interrupt is not being used, removed the interrupts
>   property from the bindings. As there is change in the properties
>   I did not pick the reviewed-by tags from the earlier version of
>   the series.
> 
>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
