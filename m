Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7058080E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiGYXQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiGYXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:16:13 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE810FE4;
        Mon, 25 Jul 2022 16:16:12 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id i4so5231197oif.2;
        Mon, 25 Jul 2022 16:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g49NRMyXpF3Ukz1Chp1eaP/CKtK/FAlLJyk9rQSO96k=;
        b=nAp8GR+7+cjm/z8Yl5C7lDpc4CNIxsxr/ZYyhzdzFHGvNiQVr9QX4JQyKQMmUPsIRB
         xUEowTkuoDEQTOCDMDkosPtVtRK6Eu/7YggSwD7ZYa3QWq14Scr9kaQcZzr/4UfbrZPi
         bcUHHEWdGwo6PHz4Hl84Fcl1R5AN4CkYAYo5sx3oAWHPG47dMRPhYJ0k6hgtcqDnapov
         5C3NGsLgE0i3+2xU8rMmQI9t4UfGofnl7n5bd4/bRVISCXcke0oeoDL6MvtSyoMWaY5G
         bb3U3fqBKRJJ4LL+t7MQ2j0rUPLx+cOoJ21OWiBxtMNpQnjhyXg22CK5j2nww5r0Mhb1
         O+fQ==
X-Gm-Message-State: AJIora+y4h9SHgLGYedZpvWOQ4wCTUiiyM6AtzHKI0q2eBg321Amq4L1
        ji2OKskILW4Shjj/pdU24Swh4xFtNw==
X-Google-Smtp-Source: AGRyM1u56k9Wer1FDd+BkIDjfxwPl929B5pswvCBQlRHjQCxoxz9IHoo6rqZWSCrgWwgYITubxRwow==
X-Received: by 2002:aca:90c:0:b0:33a:768b:50d5 with SMTP id 12-20020aca090c000000b0033a768b50d5mr13493374oij.294.1658790971099;
        Mon, 25 Jul 2022 16:16:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d18-20020a0568301b7200b0061c9bbac1f9sm5583106ote.16.2022.07.25.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:16:10 -0700 (PDT)
Received: (nullmailer pid 2935442 invoked by uid 1000);
        Mon, 25 Jul 2022 23:16:09 -0000
Date:   Mon, 25 Jul 2022 17:16:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: memory-controller: Document Broadcom
 STB MEMC
Message-ID: <20220725231609.GA2935380-robh@kernel.org>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
 <20220722201043.2731570-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722201043.2731570-2-f.fainelli@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 13:10:41 -0700, Florian Fainelli wrote:
> Document the Broadcom STB memory controller which is a trivial binding
> for now with a set of compatible strings and single register.
> 
> Since we introduce this binding, the section in
> Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt is removed
> and this binding is referenced instead.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,brcmstb.txt         | 11 +---
>  .../brcm,brcmstb-memc-ddr.yaml                | 53 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
