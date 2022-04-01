Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570234EE53E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiDAAWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiDAAWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:22:47 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA811CF53;
        Thu, 31 Mar 2022 17:20:59 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso1042351otj.7;
        Thu, 31 Mar 2022 17:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMr0vmhCCi1+boKrcsJRNJNXvbkGry96BandV3tYE90=;
        b=Ayn5v9m434EUMX20m7MgZfosy5/zU5q0rd4U08fgiVp1D8ZAtUfWk0ac9YZ0GOxhU5
         g/paewQKbq8nB+jZJqjK5cpjKipMcr4XK9IeuvW1na8taI3NdRcAEpKJvaJ7JnozNomV
         y0f5bcj9RZrh6TXHp7EWU0GtPKeSXziCYP9+YUe8+v5YXLPkLYDwiz87rL6hlyyr8aHC
         7jstXBuaXH3IgOdBf3xa5b1Wwp0S/vwaOdWkSCbqA+wV2a/XsO/jUvSqTAgFeSklzETp
         JuRbF4vbld3TdnY1bzsFR3F1SZdJEJFB33EdoEDCCYNwZH9mrqHypJMjYxh5FVerDCuR
         xNSA==
X-Gm-Message-State: AOAM5308sX66Pa0TyxoOAfQbwKJcEW/gRzlUhX11rzll1tjIzbsIgoN+
        kg+m965QpDWy5C2fuXQyNA==
X-Google-Smtp-Source: ABdhPJzaMqViLjIPniizWGBgNLH2NK32f/pBjLLDbJlKFKiAk6a338Fi8mCtQC8M/7+D4C6XvV85BQ==
X-Received: by 2002:a9d:7c90:0:b0:5b2:2ae8:43ec with SMTP id q16-20020a9d7c90000000b005b22ae843ecmr6728577otn.379.1648772458493;
        Thu, 31 Mar 2022 17:20:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm388649oif.38.2022.03.31.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:20:58 -0700 (PDT)
Received: (nullmailer pid 1770056 invoked by uid 1000);
        Fri, 01 Apr 2022 00:20:57 -0000
Date:   Thu, 31 Mar 2022 19:20:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     romain.perier@gmail.com, robh+dt@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: serial: snps-dw-apb-uart: Add MStar
 MSC313 uarts
Message-ID: <YkZFaZChWJoTDqB/@robh.at.kernel.org>
References: <20220324124402.3631379-1-daniel@0x0f.com>
 <20220324124402.3631379-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324124402.3631379-2-daniel@0x0f.com>
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

On Thu, 24 Mar 2022 21:43:59 +0900, Daniel Palmer wrote:
> Add compatible for the MStar MSC313 uarts.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
