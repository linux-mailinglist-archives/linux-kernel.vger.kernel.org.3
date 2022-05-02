Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9945178F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387596AbiEBVRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiEBVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:17:22 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED092193;
        Mon,  2 May 2022 14:13:52 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id e7-20020a4aaac7000000b00330e3ddfd4bso2788103oon.8;
        Mon, 02 May 2022 14:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3q+qtdP+luQ33LzicXlYLTVCEnsuA+2H8mH4UxrS+O4=;
        b=wJfQW5CapC3feMuRnr7bjiOZvNAPFzK1bgAdQptjB1PRIKengWCm8zzTpZcVx6RDLF
         +LxFt3usfXm7GDTUoAq5YEDcqdmcodSzvdpVVdgVhnPcsYYZz0cQ8FPrFYaLpiZnlXVG
         yaHDwSVMuVdhHCYiG4R5Zno9bBdFisrV7JXX9im6BolDjUymTpNclj1xrMwzpKq4kDAA
         eJ4SpSmaKS2tjg2BqYf0GjYjIwITNXBZS6Uf8PASlfaivEed+Oa9cyr8sRgYL6ivu5be
         MNdo8ZZ8LpbBLWca86B85dIKczf1uRxpbgyblTecgK8SOcgYK1fetlXb7SUxGSYGHiha
         iJtg==
X-Gm-Message-State: AOAM53391vpaPtLg9lWa7zj/iiNtnPQGVCk0ex/D07MPI5Pa9iTf44En
        RWab3zeCdszZRa36CayDlA==
X-Google-Smtp-Source: ABdhPJzdddq7QjHdq1Gyqkm9hnLQMotisgl4Ju8ztMqS+jbqac/2Etf+2iATS8SO6UwVwY2Ix6AJGQ==
X-Received: by 2002:a4a:d40d:0:b0:33a:33be:9c1e with SMTP id n13-20020a4ad40d000000b0033a33be9c1emr4627230oos.96.1651526031874;
        Mon, 02 May 2022 14:13:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o11-20020a54478b000000b00325cda1ff93sm2771256oic.18.2022.05.02.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:13:51 -0700 (PDT)
Received: (nullmailer pid 1763244 invoked by uid 1000);
        Mon, 02 May 2022 21:13:50 -0000
Date:   Mon, 2 May 2022 16:13:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     etienne.carriere@st.com, arnd@arndb.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marek Vasut <marex@denx.de>, soc@kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if
 "st,stm32mp1-rcc-secure"
Message-ID: <YnBJjhv6uu2USIUs@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-3-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422150952.20587-3-alexandre.torgue@foss.st.com>
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

On Fri, 22 Apr 2022 17:09:46 +0200, Alexandre Torgue wrote:
> In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
> security support hardened), "clocks" and "clock-names" describe oscillators
> and are required.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
