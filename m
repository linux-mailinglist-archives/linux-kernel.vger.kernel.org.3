Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F534C4EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiBYTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiBYTgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:36:11 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754A1AAFF5;
        Fri, 25 Feb 2022 11:35:36 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so7684853ooq.6;
        Fri, 25 Feb 2022 11:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=89L85cYit20bkFsWPwAmB3tmEEHx1GMuglloEs9LbG8=;
        b=yYrSuKQFhTq3AyIAhqJ0wynxlBnInRHpwKUeQsekn57J//VpEbHE8zJPpYjx+vB/PZ
         YWC8iDO3Sf98ZK2A1Tc3M9Y0UPqoBM4dvw6DBgwxGznCNaTKJuQfPp1Pin9RgJuJXNGI
         lBusokBpyjGzVThxKh2GHm/LGRe5TJ5JyVZ8z1GALZ/t1NKbLl3Pzsz5v4FSqkG6hXM7
         E3fWDtVpBu24E6fhIhKHYAqefvp0qkK2/+HEWz6Pgo5ZyxcWQJL3h0M8i6Qmv5+0f0Gy
         yrq+3oMGrqTQJpQOKDABlzG3rRbKCSfrIi4BTZYJ9tCBxB0ZmzPDnXJ0ZwzZMWlyZWyp
         1Dxw==
X-Gm-Message-State: AOAM532vdivS6I884S2mN/eBseBJQTa8lMoYKoXoX4VxPUGU9YNeYorF
        hiqWCI2Q0IuxNJA5h+FmgQ==
X-Google-Smtp-Source: ABdhPJwTB3dMTBlwo5pHLDzpohHjFzoCrMqR0lPTutQ46f+OsP6T04QO8IFX4yubZI0OTunbKa3GwQ==
X-Received: by 2002:a05:6870:ee0d:b0:ce:c0c9:64a with SMTP id ga13-20020a056870ee0d00b000cec0c9064amr2072910oab.156.1645817735262;
        Fri, 25 Feb 2022 11:35:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j25-20020a4ad199000000b003171dfeb5bfsm1458351oor.15.2022.02.25.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:35:34 -0800 (PST)
Received: (nullmailer pid 1301936 invoked by uid 1000);
        Fri, 25 Feb 2022 19:35:33 -0000
Date:   Fri, 25 Feb 2022 13:35:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Jan Kotas <jank@cadence.com>,
        Avri Altman <avri.altman@wdc.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Wei Xu <xuwei5@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Li Wei <liwei213@huawei.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 08/15] dt-bindings: ufs: snps,tc-dwc-g210: convert to
 dtschema
Message-ID: <YhkvhdFZXkVsteeq@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-9-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-9-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:47 +0100, Krzysztof Kozlowski wrote:
> Convert the Synopsys Universal Flash Storage (UFS) Controller to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/ufs/snps,tc-dwc-g210.yaml        | 51 +++++++++++++++++++
>  .../bindings/ufs/tc-dwc-g210-pltfrm.txt       | 26 ----------
>  2 files changed, 51 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
