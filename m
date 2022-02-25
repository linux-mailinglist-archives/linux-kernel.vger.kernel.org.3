Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272664C4ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiBYTdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBYTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:32:46 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA44B1D0365;
        Fri, 25 Feb 2022 11:32:13 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so7570999oos.10;
        Fri, 25 Feb 2022 11:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRILqCarovlsZz7thgDDibtWJZEbIzmqyc2ox6LuLpY=;
        b=Cm3D0xI4Yt+LUUrm5/sUCrpd33+npF9MlJLlZvbTR5xcFgxPB5Tjn2WkLQckkBPeLU
         P3+87Tg6iBbcH65XgBTXng58T8iO+POj6tj7fdb6Bl/r5TP11ogVXLX0I66fEB2fwvgs
         uh6a4six2iVyP1Syt6DTmgaluj2HP0tdkljkD3C1zs9WSstmrs/9Vi1KNq/zwzlhjgR+
         1FdytNb52tU6MyFdSK+h8giw+8/T8xFM2M8v++qAmbY4qfeGytakJWQrU0lfPBdoyh3K
         nRCfQ8CAYxoraPs554Aw6BIreffuBZNa4hTyxYsWpfC328+e/iHT6uJ8bd/7mw9axec7
         7Jaw==
X-Gm-Message-State: AOAM532z0u0el2JDZ1snmZswXjOLbgt/3k1JqeoAjaiTgi6te0BDCW/u
        /Spacpou5X3wS2DJxhvKJg==
X-Google-Smtp-Source: ABdhPJzwAL+432KfYz3I8h/Kv7X9CZCjqxcsRfm56jxdkR8gD0rIcbp3XoQRwtlfUGG0WF8u8xo2dg==
X-Received: by 2002:a05:6870:9a85:b0:d6:fb74:eef9 with SMTP id hp5-20020a0568709a8500b000d6fb74eef9mr685677oab.50.1645817533317;
        Fri, 25 Feb 2022 11:32:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a10-20020a05687073ca00b000d128dfeebfsm1652359oan.2.2022.02.25.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:32:12 -0800 (PST)
Received: (nullmailer pid 1296393 invoked by uid 1000);
        Fri, 25 Feb 2022 19:32:11 -0000
Date:   Fri, 25 Feb 2022 13:32:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Nishanth Menon <nm@ti.com>, Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Li Wei <liwei213@huawei.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-samsung-soc@vger.kernel.org, Jan Kotas <jank@cadence.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v2 04/15] dt-bindings: ufs: drop unused/old ufs-qcom PHY
 bindings
Message-ID: <Yhkuu/cMDl0fMx/8@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-5-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:43 +0100, Krzysztof Kozlowski wrote:
> The Qualcomm UFS PHY bindings are documented in
> bindings/phy/qcom,qmp-phy.yaml and the compatibles from separate file
> bindings/ufs/ufs-qcom.txt are not used at all.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/ufs-qcom.txt      | 63 -------------------
>  1 file changed, 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
