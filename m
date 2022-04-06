Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8F4F69C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiDFT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiDFTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:25:36 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B01E7A55;
        Wed,  6 Apr 2022 11:12:09 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w127so3212752oig.10;
        Wed, 06 Apr 2022 11:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rHx8DYluJ4kaShg551QjzvikhQaz62YjftzoTLZUGD0=;
        b=ss1HUOv3FQCNYuLeoGDSm+cYFZi3eaZi18k8lx77Di00BQk2oQ/pjq6+U3Jo6A0snD
         /GPv5Sn2iZcNDjmuCRciAfZQi3SnuTBOS8ONa1zCaYJTJASwzAsgWiGOYByG4N133Vlb
         TV5YD3QuRFJ0Et6gtk3FsmTkAFMI+v1sPdjj9ZrJx39lJGMC/Qu7qQC0igYOc1SxZ6Zi
         7+gslVHh9JwR4dCVWwtpsC3OPpMH3ept8icr+IuCSiw2/796r072mlZK0nbEKfRqXS7D
         TubNmU/WMtjlvm/RV7LSeQx9u75tjUtFDEvQNIJds4hvLuxASpCLIMNDVNCsz1pdTM/e
         nntA==
X-Gm-Message-State: AOAM5327W6l8hrV+SF3BJ6kQNXQovnWbKboaHHhsPjlJrtwVTDC/FSP7
        u99vnII8xEH7tE7GDsHKAQ==
X-Google-Smtp-Source: ABdhPJyCevYeLyks6ifd963x0nEqiyqH12/VPQziDsd5gYIHmumRkZTptSxNrcMu3cJOGWA9Hsg7pQ==
X-Received: by 2002:a05:6808:191a:b0:2ec:baa1:7b86 with SMTP id bf26-20020a056808191a00b002ecbaa17b86mr4105599oib.103.1649268728142;
        Wed, 06 Apr 2022 11:12:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bc35-20020a05682016a300b00324e9bf46adsm380406oob.41.2022.04.06.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:12:07 -0700 (PDT)
Received: (nullmailer pid 2520269 invoked by uid 1000);
        Wed, 06 Apr 2022 18:12:07 -0000
Date:   Wed, 6 Apr 2022 13:12:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <Yk3X94DwNR4AcPP4@robh.at.kernel.org>
References: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 05 Apr 2022 08:37:24 +0200, Krzysztof Kozlowski wrote:
> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> address rejected: User unknown in virtual alias table), so switch
> maintainer to Bjorn (as active Qualcomm platform maintainer).
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add only Bjorn.
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml  | 3 +--
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Let me know if you'd rather me pick this up (and the pile of other QCom 
bindings).
