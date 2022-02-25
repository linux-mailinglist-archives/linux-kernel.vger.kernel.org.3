Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269A74C4EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiBYTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiBYTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:35:25 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725331DB3D5;
        Fri, 25 Feb 2022 11:34:52 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id x193so8454448oix.0;
        Fri, 25 Feb 2022 11:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9v5qtATzrOvXz3YN1ZWcwAzzG9N2l4CYH652u8TC4g=;
        b=feiQGO7G1m+TgTd2hh4SFmnTNyRDsuNxV+F+yYKz0tIM4z0s7Q3shJge/LkbbyoRsT
         3rDlhEFplD0c2OKJX/EaufG0PGlIDDNxQhGIJZTHAyttkj5T1gMoD1tNAhvI38Vrw3eX
         Y0W8M9fepIc4rYmRhL4Uu8P9nFHKId1x7VPsDP3S/1UAQoGGPsgRQJiUVTWN4zjBqCMU
         n6uOnNYolTGcXJwRqMiatpZXv/TeS5n5K3kzwkleWvL3mfHx0JPmvSD35eHmYF2EdBi9
         NksCuZks44tHab4jAXu6zq3tsOTuZHkCbkoITtDHmIY+6bYAi9gMcWxsK569AS80iOV0
         E6eA==
X-Gm-Message-State: AOAM533gkdQL+p5NMHLaUFKzKia1U1MU2m7qT2KHzMHw1ODx4Q/qwTqX
        ndinndQUGmdQK0lON+fMkQ==
X-Google-Smtp-Source: ABdhPJybpWDzjQJF9jGKPuCSK7Y0n1/VK66YoKWH8RCWHvU/F08Ob/+b5HLss7dQ80Wqhgfq0p9WxA==
X-Received: by 2002:a05:6808:1983:b0:2d7:7fc:9e9b with SMTP id bj3-20020a056808198300b002d707fc9e9bmr630387oib.133.1645817691671;
        Fri, 25 Feb 2022 11:34:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm1862982oao.3.2022.02.25.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:34:51 -0800 (PST)
Received: (nullmailer pid 1300868 invoked by uid 1000);
        Fri, 25 Feb 2022 19:34:49 -0000
Date:   Fri, 25 Feb 2022 13:34:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mediatek@lists.infradead.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Li Wei <liwei213@huawei.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        Jan Kotas <jank@cadence.com>, Wei Xu <xuwei5@hisilicon.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 07/15] dt-bindings: ufs: mediatek,ufs: convert to
 dtschema
Message-ID: <YhkvWWMq5X3/gqzF@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-8-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:46 +0100, Krzysztof Kozlowski wrote:
> Convert the Mediatek Universal Flash Storage (UFS) Controller to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml | 67 +++++++++++++++++++
>  .../devicetree/bindings/ufs/ufs-mediatek.txt  | 45 -------------
>  2 files changed, 67 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-mediatek.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
