Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C45223FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbiEJS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349045AbiEJS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:27:20 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F414CB68;
        Tue, 10 May 2022 11:23:21 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso14881fac.1;
        Tue, 10 May 2022 11:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6VUj9Lojhw3KHnOTn3bbGkCrGpPROOfMwN16uub3uA=;
        b=fYXOE74xEJwI3g61z2Z96/F8SG9Y4J9X3dAkF2y0Y8G7ccZd7ZjbiqCnvn46qo6Xen
         zUrQR/PAD5qBWdFuykJ9nVRie7cAJYRkJGCfdzmHSmA1Di6a0LEY/OrnMuwoys12+T0J
         s0/LNBfQ23+Z9nG01JZVk3oJ5jZBqAISzB8X/VID3sy8ZG59du6FuQAP+MIksz+bpqEQ
         TGv11iCEnokHLsjNuG0ygBo8oMRIAVUtyUe1OKF8rWI3BIQYK42s6FG/sCYdieVDJ5b1
         SwwZhgSEqCFQuDenpeN+fQ3zGFIHzyI0V6hGZbdycCoKaUQJbmaZ9BuqXhRyk1HR69jH
         43hw==
X-Gm-Message-State: AOAM530fvr0V8cjm9APgbtiZG7p45ox2jrAmMLJ94fL95qdpekDJS9sK
        GgBAZiSJi1TjAICSDdtttZPil76BpQ==
X-Google-Smtp-Source: ABdhPJwI6HZZicgtT7n4tnN+YTEXRTNNsEMQBJKkWbmNeJZz/g6ItcbzCpRTBS5ZEPqb8fgrNUKVSw==
X-Received: by 2002:a05:6871:887:b0:ed:4b3b:2bc4 with SMTP id r7-20020a056871088700b000ed4b3b2bc4mr790934oaq.278.1652207001018;
        Tue, 10 May 2022 11:23:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a9d400d000000b006060322126bsm5874079ote.59.2022.05.10.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:23:20 -0700 (PDT)
Received: (nullmailer pid 2333804 invoked by uid 1000);
        Tue, 10 May 2022 18:23:19 -0000
Date:   Tue, 10 May 2022 13:23:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: clock: stm32mp1: adapt example for
 "st,stm32mp1-rcc-secure"
Message-ID: <YnqtlwXwKgrvngGf@robh.at.kernel.org>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
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

On Mon, May 09, 2022 at 03:46:58PM +0200, Alexandre Torgue wrote:
> For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
> required properties.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

Assuming this works in arm-soc tree,

Acked-by: Rob Herring <robh@kernel.org>
