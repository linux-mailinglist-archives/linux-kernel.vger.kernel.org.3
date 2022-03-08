Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631CB4D1D90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbiCHQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbiCHQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:40:54 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95A517DD;
        Tue,  8 Mar 2022 08:39:57 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so22765140ooa.10;
        Tue, 08 Mar 2022 08:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LqsblcX3MtbRMMm9B3Z+AqAZ1YQp8Xi0MtRM0YAPQak=;
        b=dPG4myIAKGpsOBZZJU0tUcMv8+ECBFzINH7oWbaejoFWJo2sz+W7TK00VFrXkGQS6X
         0zSyq4ySEGfl7tJsjermiFyaFXVSU62egkJwjPQ7GX+Z5OHujOai54nunVJIy/ZR2e4A
         zw9pHN5e8VSQJORM0o4EMkaHtm7khwA/Rf1Zl3ihePL/yjXWCa8InObYgVdkS7FNdS6v
         uXGonslmZXUCeGeqMDFF0ECubHrwCz10opFk21gZVebHzOPCXuqr4RmV18Saslk76TWM
         2XJqhqS/JsEjXJxlOt5cY3Smluj8EG4Lk4GfJIr0OjmMkP+clEHUIoXpgkF0CwSk+Ilq
         BA2g==
X-Gm-Message-State: AOAM533t1uyiyiVJ0rsY8atP9LHmLSZQbCGQuhHUbD2hHzltt8lZ83Qv
        A81D3CJrWkNXjOpMlJxqug==
X-Google-Smtp-Source: ABdhPJx8LX7mJBIVppVai6vgrJ7wctTztsVswtwWgW7rpKjxqFl4p4gEhzFq17Vl8bc/ghG4DRyyNg==
X-Received: by 2002:a05:6870:d69e:b0:d9:ad7e:f0e9 with SMTP id z30-20020a056870d69e00b000d9ad7ef0e9mr2872881oap.138.1646757596928;
        Tue, 08 Mar 2022 08:39:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm2220577otk.52.2022.03.08.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:39:56 -0800 (PST)
Received: (nullmailer pid 919426 invoked by uid 1000);
        Tue, 08 Mar 2022 16:39:55 -0000
Date:   Tue, 8 Mar 2022 10:39:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: ti, tcan104x-can: Document
 mux-states property
Message-ID: <YieG22mgIzsL7TMn@robh.at.kernel.org>
References: <20211216041012.16892-1-a-govindraju@ti.com>
 <20211216041012.16892-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216041012.16892-2-a-govindraju@ti.com>
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

On Thu, Dec 16, 2021 at 09:40:11AM +0530, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceivers,
> muxes might need to be set. This can be implemented using mux-states
> property. Therefore, document the same in the respective bindings.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

As the warning without this is still there and it hasn't been resent, 
I've applied it.

Rob
