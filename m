Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2C528D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiEPSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiEPSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:50:02 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94B3EAB9;
        Mon, 16 May 2022 11:50:01 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id y63so19697358oia.7;
        Mon, 16 May 2022 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJd87yuD1pj9LvycAEhEJrAh+QDD24w77tyGNFmAUac=;
        b=W3bYZ7g8Ny6j6oB/REGsK3+MIgK+vorrbofovmGVOrfow/FqrThJES2MpfJeC82oeQ
         uAKNt35FLC7rCd0bwtxetfUTzAp0WC71ZMz/8rseihvQXLcHjx2ng6bUdTl1pAxEUruS
         0o+U1R0sFrTFOz6uxA7JPkYsRV7NHW7MTuuiRNduDjJFArXqCdCwo+DxG3/6Wuct8+9b
         GYcGTh2SMhdwOMXYQMgY6RbXsRTpEf4ePiPn7boq1r3uyGLZi02hlDRbFJ/H2DWjD8aS
         Y0e5cIg6jIzBwr1A/aGqVX5N2yR9nCnBc2W+UNoMVXXSw817HuSSld+Y6WvpUDaYlfWp
         ZJEA==
X-Gm-Message-State: AOAM533o757wiIVS8AWQgihkIUq+sCjdMKhziscoEqiZyTFDNhllXPep
        NK5XFNbooLF2FrvrIVfkMA==
X-Google-Smtp-Source: ABdhPJyCgwgytE1j1rmFgNxcFGnnP0JWCOTaEHZQvJ3m78nnVLvWvImK5sOPYKBVRyHSdLgb3+CiDw==
X-Received: by 2002:a05:6808:e8d:b0:322:4fbe:8c5f with SMTP id k13-20020a0568080e8d00b003224fbe8c5fmr14009563oil.284.1652727000791;
        Mon, 16 May 2022 11:50:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r9-20020a0568301ac900b0060603d8be2dsm4232444otc.67.2022.05.16.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:49:59 -0700 (PDT)
Received: (nullmailer pid 3069340 invoked by uid 1000);
        Mon, 16 May 2022 18:49:59 -0000
Date:   Mon, 16 May 2022 13:49:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Renesas versaclock7 device tree bindings
Message-ID: <20220516184959.GA3069296-robh@kernel.org>
References: <20220503194201.25714-1-alexander.helms.jy@renesas.com>
 <20220503194201.25714-2-alexander.helms.jy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503194201.25714-2-alexander.helms.jy@renesas.com>
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

On Tue, 03 May 2022 12:42:00 -0700, Alex Helms wrote:
> Renesas Versaclock7 is a family of configurable clock generator ICs
> with fractional and integer dividers. This driver has basic support
> for the RC21008A device, a clock synthesizer with a crystal input and
> 8 outputs. The supports changing the FOD and IOD rates, and each
> output can be gated.
> 
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  .../bindings/clock/renesas,versaclock7.yaml   | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
