Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FE4F1FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiDDXKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbiDDXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:09:55 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618401262B;
        Mon,  4 Apr 2022 15:43:56 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-dacc470e03so12494960fac.5;
        Mon, 04 Apr 2022 15:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MZNmrOPOsOL2UrSRa9LdE+XzxijYmU0GespTjTlx7M=;
        b=hCy28eNtQuE2H1UIgO/JQ5BiCFibikmGn8mQTgfT4UjtoX4Q13rVulzKhyHl3am0Bc
         TlYp/shP1VxTS0vdYar1m7lrBvSmHJCBnm7Yv0FXbZL11p9bIfW/Fuz5PtVdELtyAYR3
         AeEPB4ANg0n6UIJIEJklfLQnevGUCr/CBrjhW15//E3HaZ7KDRx/LtX8dlbiDe2Mh+NC
         lAVOH9DTwn9MAYr9dZcdKYCcppIcTmsYAeaVaJAZaE9TEjKzbi4vEvVzP8nV5GDn7qVU
         FEOHkpMseZKXnw4RNcZSl1cJjMQgVA5Gw6/tOlg8engyWV3zowRYeCw3ZBXEZ7ZU4/7T
         XfPw==
X-Gm-Message-State: AOAM531IFB3Y6I+ojauPJyN2Drj7OwmlW9XBQUap9NifFRhpsCQZ0Ocu
        vnfEw+Yk+M4V25RZx5955vAVya1F7Q==
X-Google-Smtp-Source: ABdhPJxI2qYP8FTA84VhMS4ZS8EQWBheTKYOfNK4sGVlhVe6Nl3N6j/Mje0RQ4wJ3TR97W4CIYp1sg==
X-Received: by 2002:a05:6870:80d1:b0:e2:1c70:782f with SMTP id r17-20020a05687080d100b000e21c70782fmr201375oab.69.1649112235557;
        Mon, 04 Apr 2022 15:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm4997932otr.72.2022.04.04.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:43:55 -0700 (PDT)
Received: (nullmailer pid 2140401 invoked by uid 1000);
        Mon, 04 Apr 2022 22:43:54 -0000
Date:   Mon, 4 Apr 2022 17:43:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: soc: qcom,wcnss: convert to dtschema
Message-ID: <Ykt0qgHpmr7BLPGN@robh.at.kernel.org>
References: <20220402093919.50084-1-krzysztof.kozlowski@linaro.org>
 <20220402093919.50084-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402093919.50084-3-krzysztof.kozlowski@linaro.org>
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

On Sat, 02 Apr 2022 11:39:19 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm WCNSS bindings to DT Schema.
> 
> Changes against original bindings: fix qcom,smd-channels and
> qcom,smem-states names (how they are used in DTS and driver), enforce
> child node naming of bluetooth and wifi.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,wcnss.txt          | 131 -----------------
>  .../bindings/soc/qcom/qcom,wcnss.yaml         | 139 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 131 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
