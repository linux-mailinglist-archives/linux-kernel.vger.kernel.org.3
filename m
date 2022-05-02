Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385AE517922
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387670AbiEBVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387663AbiEBVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:32:06 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D03DFFB;
        Mon,  2 May 2022 14:28:36 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id l16so9225654oil.6;
        Mon, 02 May 2022 14:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWRyyqTX1zgpUL0i+w8d1Ou1tFF0ewiHqxv686F2LGk=;
        b=eTmoFK2p0quSY7JR/hmdFGsqqif3DTACF8uhUHPl0vHdW+H/wyvlnJdTWoO/WZo3qZ
         WK+yywAvFg8UlYKAkheWPRUcY0JnHwrqxA3zGZSBWDN7BvAx8YGFKJf4twFNO1GQoiZZ
         FI7oQgEeh0rrnqjXlHRAdX1YuS+QO9x3lQym9vBrHF1CgZcEZ/BJiWEKAo1rLbagReu7
         IT4I42m03CZf25T9SilblIfFtWwWxOjLXFFy/ustnAkbnEl6Pl2aRQjGXkAqu0AZlcYc
         Ju9OvvqCUS20WcgDA76iwqcXz1PSybVINaYZs4VpBaSCmfUawufHfr9C1xQKIxUpV7o8
         7lgQ==
X-Gm-Message-State: AOAM530uW1GQ42h7Mi/CX8zZytnZQav/aW/DrjAcYiWe73yvyuCfshLI
        QVtD9O9ILkmBMJM+UZNYyg==
X-Google-Smtp-Source: ABdhPJzuZVJjvpvlPD9utsP/MMvXGt+bpD1i+qtjarMTrHxsWFFkdFazKHKJ+54WhwWRfMXuHv14FQ==
X-Received: by 2002:a05:6808:1526:b0:323:1194:d3bf with SMTP id u38-20020a056808152600b003231194d3bfmr535917oiw.120.1651526916142;
        Mon, 02 May 2022 14:28:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k3-20020a9d7dc3000000b0060603221261sm3416202otn.49.2022.05.02.14.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:28:35 -0700 (PDT)
Received: (nullmailer pid 1787413 invoked by uid 1000);
        Mon, 02 May 2022 21:28:34 -0000
Date:   Mon, 2 May 2022 16:28:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     arnd@arndb.de, etienne.carriere@st.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marek Vasut <marex@denx.de>, robh+dt@kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 7/8] dt-bindings: arm: stm32: Add SCMI version of STM32
 boards (DK1/DK2/ED1/EV1)
Message-ID: <YnBNAnlIvF6ujYWg@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-8-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422150952.20587-8-alexandre.torgue@foss.st.com>
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

On Fri, 22 Apr 2022 17:09:51 +0200, Alexandre Torgue wrote:
> Add a "secure" version based on SCMI of STM32 boards. Only boards
> provided by STMicroelectronics are concerned:
> 
> -STM32MP157A-DK1
> -STM32MP157C-DK2
> -STM32MP157C-ED1
> -STM32MP157C-EV1
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
