Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4D517899
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387505AbiEBUzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387526AbiEBUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:55:15 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0D6572;
        Mon,  2 May 2022 13:51:38 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id y63so16397400oia.7;
        Mon, 02 May 2022 13:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VWOZBbGOn80V6+f0/v6r7Ed2zi/W6IJwHO0n/X/0CM=;
        b=rgXahsAaBExjtA30aCQjSOxAL1rsFb8bFxaqvv1RSlJnarXVwuYsPlJTlhW/2fJZmo
         4vPbvqZOG14Zr7w7KUJ61gRy5OG56scSw1wRomPWgyc5BArVEW1OW3+cBq1sUqc8sS1p
         58yp3UCaTDF9g8/C0VQcPPdNyAMJKJXFIGgvVziMHss3ajI36+GX1jm1FyqQt58rU9oe
         YVz3cP2E/2ln+7UutZvkg6S+SV2L9DsU1T/vaezWl6uKNDYLCAHw2djOSSRyQDvoSLtA
         iKDCN3k+B/xjOGY/cjjdZD+YrEFDMsm1rWFuIk8dJbZvzhbTLyltksvLcShQ7AEaaijm
         Q1hw==
X-Gm-Message-State: AOAM533kpqcADHdlp+ut+YSXXs1OrVIs6MAiAGNJybdjhYMB51gCyEKq
        b/+LejO8v6AnkKZ+owyj/6laIr8GnQ==
X-Google-Smtp-Source: ABdhPJyXVR6zBCbrp43TECq40H17+JMBGJm+PLHpua414oDvr57OG2kHM5NGu2sfxfcCyvq1GpTuuQ==
X-Received: by 2002:a05:6808:1a04:b0:325:9646:43b0 with SMTP id bk4-20020a0568081a0400b00325964643b0mr455345oib.175.1651524698003;
        Mon, 02 May 2022 13:51:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a4ae541000000b0035eb4e5a6c8sm4276006oot.30.2022.05.02.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:51:37 -0700 (PDT)
Received: (nullmailer pid 1725493 invoked by uid 1000);
        Mon, 02 May 2022 20:51:36 -0000
Date:   Mon, 2 May 2022 15:51:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: mailbox: mtk,adsp-mbox: add mt8186
 compatible name
Message-ID: <YnBEWI3aVryi06pH@robh.at.kernel.org>
References: <20220422023909.6584-1-tinghan.shen@mediatek.com>
 <20220422023909.6584-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422023909.6584-2-tinghan.shen@mediatek.com>
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

On Fri, 22 Apr 2022 10:39:08 +0800, Tinghan Shen wrote:
> Add compatible name for MediaTek MT8186 SoC ADSP mailbox.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml         | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
