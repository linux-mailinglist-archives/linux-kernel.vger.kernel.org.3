Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5D4EE2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiCaUqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiCaUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:46:47 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992A522D2;
        Thu, 31 Mar 2022 13:44:58 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id b188so734734oia.13;
        Thu, 31 Mar 2022 13:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGtAk0+XCya2tuDgY9VrbuZe8tnyjhnFimlASLoNPI8=;
        b=F5vPyLcPsYpRO6ShpLxMM3JMYtw3qcnLZWjzcPfPZFwv1NHjTvVPXUj/2qYZpjsFzD
         Ge+XdX2tgBY+Jk63wxobt2QNbGFGjZtjzOHB0WLrLXti5bb7l2lJHzUZw0TFSUeGNmDL
         2ZAbAzJEPTmjXIMyZ/EiSKr9K0/A4OQRdNQURdsWMlFiYfzNQNOVRBuftqPFY6bW/p+m
         O36XFTTOWbScvdoV3Jb0o9j1c7HTX5KED1AGWEkmiAQHlxOcwJoj7W+xBXQc46LLt9hS
         Qsqb9dfxxwea1x7vNvjLdrxAhofoighovRl3CyCaVzsJ1jcCWGwfYWoO8J/yaW2CmcJ2
         lcgg==
X-Gm-Message-State: AOAM5313llfqmBal46IfRi3rcefeELILnxZvZwjXLo+RdSqYkxO+5ovP
        Xx+s+cJ+ocNObN4zVYfyUesT98W+AA==
X-Google-Smtp-Source: ABdhPJw3anR6siPHibQz2MGfN4iffr/8wQurbIagIlKD/2cmHXZ0tfwA8JUognsm1JUZEWJ+Xerd6A==
X-Received: by 2002:a05:6808:1402:b0:2da:b72:74f2 with SMTP id w2-20020a056808140200b002da0b7274f2mr3333790oiv.113.1648759497901;
        Thu, 31 Mar 2022 13:44:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d7986000000b005ce0d5433cdsm275155otm.15.2022.03.31.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:44:57 -0700 (PDT)
Received: (nullmailer pid 1462775 invoked by uid 1000);
        Thu, 31 Mar 2022 20:44:56 -0000
Date:   Thu, 31 Mar 2022 15:44:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     arnd@arndb.de, linux-clk@vger.kernel.org, p.zabel@pengutronix.de,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        tglx@linutronix.de
Subject: Re: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Message-ID: <YkYSyHVGsXkGs0uf@robh.at.kernel.org>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
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

On Thu, 31 Mar 2022 16:29:53 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Move 'reg' after 'compatible'
> ---
>  .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

