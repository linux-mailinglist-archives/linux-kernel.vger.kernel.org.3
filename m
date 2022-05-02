Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1736851791A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387650AbiEBVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiEBVaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:30:23 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DBDE92;
        Mon,  2 May 2022 14:26:53 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e9027efe6aso15485351fac.10;
        Mon, 02 May 2022 14:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUXadxcBM2wGghQUZGspLXPv1H+K2sEgrmrW9LXrYH4=;
        b=USZYw8k/HXF1/4NmsLjukmn7Hr6xtDRkcwoyZ3XfIuHT1Oe8SHJYgyaoyNlCw3qZpz
         G2ENRNtS+wIHarmbjjzZaz8HrMKBgCPLaw2iB9uWNMnWzW9S/m/OgfCAzdYIr/N/pvjw
         OjIgGmQhIF41y+ULBCSE2KwL1cGPrW9ZXX6uKmH6RAUpiy0b6GdloHcIzR+4BLkWC/n1
         ml7Vhf8tmYVtNu2tMCdyc9QQFFNyIDfloJXtmKlpWMA+/JPiqAOW8u/1z025MuoBNiUa
         bbyLKLCjGTiNX06ePXCaa67yze3asCQOisvWpngx4EtQQXwXX/uCXX5fzO/80WdOAuo1
         x2HA==
X-Gm-Message-State: AOAM532/SzN3Yw6GAjsFiL491SVOLxYb+fyi4s0r4ZL2Wf6O0z2TgmsE
        aWk1AADWurtbSATuS/ZLig==
X-Google-Smtp-Source: ABdhPJy5aexT9fpRtVRW+BykQHq+euRFdmPRG6US0k26rcVqaqzGKoPFTWQt8OnGoRceqsXjqE4Vzg==
X-Received: by 2002:a05:6870:969e:b0:ed:9e77:8eba with SMTP id o30-20020a056870969e00b000ed9e778ebamr516885oaq.269.1651526813128;
        Mon, 02 May 2022 14:26:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n44-20020a056870822c00b000e686d13894sm6244497oae.46.2022.05.02.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:26:52 -0700 (PDT)
Received: (nullmailer pid 1784491 invoked by uid 1000);
        Mon, 02 May 2022 21:26:51 -0000
Date:   Mon, 2 May 2022 16:26:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        soc@kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, etienne.carriere@st.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: clock: stm32mp15: rename CK_SCMI define
Message-ID: <YnBMm7wE5/Jz6N3l@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-4-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422150952.20587-4-alexandre.torgue@foss.st.com>
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

On Fri, 22 Apr 2022 17:09:47 +0200, Alexandre Torgue wrote:
> As we only have one SCMI instance, it's not necessary to add an index to
> the name.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
