Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67C84E3529
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiCUXwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiCUXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:51:14 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002612759;
        Mon, 21 Mar 2022 16:49:26 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-d39f741ba0so347896fac.13;
        Mon, 21 Mar 2022 16:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXSlpIM6FRvgJ0QypXg95yHNdd4hJ4xWuIaTwpSweAM=;
        b=oZp6C0ismBGcRi9817n1tuH+Bk6dMLJF8pejvNEG/+DhzgXqHi6y0WLzmENT28S0gK
         tR9EJrwb9bEGoQda+oyQzGFcyBycLaku0xY9mkDUvrLHmt+MatNkfcYBlI21diIVTFcq
         Zc7FoTURMppilEF6Liu1HB1W5Fsg6tWeG5i5jaivkuzMSr8jMhKikTxPS85VKq7pwtFR
         2rW0UzELR/E+gMWVCCRN6b9/7DSPG6wrl7QtczUCkuM4NLESV9goNE1FAlvKBIhjmkl6
         43xVP4Ovms5yWBa7C7vTIBVYAPsgyriJsx/PkDWq6mwOb4ctTzYqPsgLtRn2uXOlCs5e
         nhnA==
X-Gm-Message-State: AOAM531xZtvxLniv3DLt/jD2x8FtKH/FpSggilk5nuYF+1S2N+1q/pWC
        hfpm/zGsbXz4ZG2d+iS1RR018zK+MQ==
X-Google-Smtp-Source: ABdhPJx7f8Nuoo5rx7nF1pTUtnL3h0meqbjLMbDfGaAj075Fr6irvbZI9AM7smQTpUp3YPMCUsjepg==
X-Received: by 2002:a05:6870:a40c:b0:dd:e555:2155 with SMTP id m12-20020a056870a40c00b000dde5552155mr466548oal.231.1647899139447;
        Mon, 21 Mar 2022 14:45:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c30-20020a056830349e00b005b272587f47sm8345680otu.38.2022.03.21.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:45:38 -0700 (PDT)
Received: (nullmailer pid 593217 invoked by uid 1000);
        Mon, 21 Mar 2022 21:45:37 -0000
Date:   Mon, 21 Mar 2022 16:45:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v2 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
 string
Message-ID: <YjjyAarvvcrGvKoH@robh.at.kernel.org>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 14:33:13 +0100, Luca Weiss wrote:
> Document the compatible for the UFS found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - add second hunk for clock validation
> 
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
