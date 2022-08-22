Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B559C847
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiHVTN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiHVTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:13:32 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A4E0FB;
        Mon, 22 Aug 2022 12:13:28 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11c896b879bso14072173fac.3;
        Mon, 22 Aug 2022 12:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LMDQuJo0oA0Z9tEl0K4aG8X27m3X4p/D+o2EROlyl9c=;
        b=Ibms/jQqHBrp4SaXeUGxGck/wxmFC1ytBb/6CNnmRB72z0pijYoewC58wh59DEzQxk
         wWJMnzXsNwY+/91prLuGm9qKz3ZbgmiA7lgSCFkaotcbRgIlY0tivO4M546EINVmTsJ6
         /ZRwj7gcTCLKqaG0VOxnIZ3M7qnDB+bm8SlBkORvREllIY5iCo9ExCKPCgGn2mGXAWog
         LWYTgUTHKScBmDRfVZZv48AqSriNsTOQnSqb779o5OkXMHwO8ImV9loCdlPfsQbhwPFN
         a/+eJ38WLGZ5B9bWIl+9wlK9XFP4b9yMFSfrrHgjW7eFP2U/ePuLW4AtgK9kSZ0Stj8N
         AMRQ==
X-Gm-Message-State: ACgBeo2RcqsVb6Z/yuO2AKB3OqgT4WTAoK5c6XJcZvJK2G2f08F1sfFo
        5zubKoacJmg+t8EphxRdRg==
X-Google-Smtp-Source: AA6agR67XoVrfLE3mx+5Fw11ac0e2irOfcRNgY3xc6cGJL73PSJH/Bm1ic8ztm9iNBoc5wdWnk0njw==
X-Received: by 2002:a05:6870:a91d:b0:10c:55e:3f64 with SMTP id eq29-20020a056870a91d00b0010c055e3f64mr10201618oab.123.1661195607460;
        Mon, 22 Aug 2022 12:13:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t20-20020a9d5914000000b0061cbd18bd18sm3166198oth.45.2022.08.22.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:13:26 -0700 (PDT)
Received: (nullmailer pid 238867 invoked by uid 1000);
        Mon, 22 Aug 2022 19:13:25 -0000
Date:   Mon, 22 Aug 2022 14:13:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>, linux-kernel@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: ti: Add bindings for J784s4 SoC
Message-ID: <20220822191325.GA238497-robh@kernel.org>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190054.31348-2-a-nandan@ti.com>
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

On Sat, 20 Aug 2022 00:30:51 +0530, Apurva Nandan wrote:
> Add binding for J784S4 SoC
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
