Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288914C4EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiBYTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiBYTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:35:00 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A851AAFEE;
        Fri, 25 Feb 2022 11:34:27 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so7679597ooq.6;
        Fri, 25 Feb 2022 11:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UICPO9Om+OjZbYZvV1eE9LFKzgVcG+7qGH6VjnvkKI8=;
        b=TwECzR39CpWOcLOArvNermww7VdjSz/BYxL0VpRUmSUOCCWAKd3Zer7ez6qil+65vF
         3XWzWzM4iiaMEvMWJ1s6tLcxrxUXxYCHSsDwtZiotr9L0QOE53qBPwyNnU9xOgel+yaD
         zEpv7wgRLTmBj6qS02had8PYe7v5UVLRCt0QSWfRy12z8r5NC/hw+cWxPtaYxJgRE+td
         wJUk5E3Jpi8o9PzIOlQY+dZ8qyg+WMRIzJ3mVcu9Q12OGtlsjPPcjYVOOW2DlTecs5oU
         V/sELnzlg1GWcqZS4krzU4qht+unOoNyxmYq6HQNX8K+rKh2c2a6cXdVxPIZYjR+jPeO
         3qzg==
X-Gm-Message-State: AOAM5335u/np/7m7f/YVu2cIwKGxiXYtK9ugo3R4mP2voV72E8yvJeMZ
        9E5XwpCn1K1FvCnVNvN0ug==
X-Google-Smtp-Source: ABdhPJyOmdG3rl+cOnFKAoGP1Z8WrEkO0FitJjYvk9EWfzGhRJ2baL6iZ1iEjArJAHpRjo6HZhDxAg==
X-Received: by 2002:a05:6870:9a03:b0:d6:f261:4d04 with SMTP id fo3-20020a0568709a0300b000d6f2614d04mr1194467oab.161.1645817666852;
        Fri, 25 Feb 2022 11:34:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l12-20020a056830154c00b005af943e7a4asm1515000otp.71.2022.02.25.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:34:26 -0800 (PST)
Received: (nullmailer pid 1300164 invoked by uid 1000);
        Fri, 25 Feb 2022 19:34:25 -0000
Date:   Fri, 25 Feb 2022 13:34:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Jan Kotas <jank@cadence.com>, Nishanth Menon <nm@ti.com>,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Wei <liwei213@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 06/15] dt-bindings: ufs: hisilicon,ufs: convert to
 dtschema
Message-ID: <YhkvQXomgBnyYF0g@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-7-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:45 +0100, Krzysztof Kozlowski wrote:
> Convert the HiSilicon Universal Flash Storage (UFS) Controller to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/ufs/hisilicon,ufs.yaml           | 90 +++++++++++++++++++
>  .../devicetree/bindings/ufs/ufs-hisi.txt      | 42 ---------
>  2 files changed, 90 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/hisilicon,ufs.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
