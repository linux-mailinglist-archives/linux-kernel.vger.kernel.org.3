Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B011501830
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiDNQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiDNPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:53:42 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE9FC113;
        Thu, 14 Apr 2022 08:34:07 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-df22f50e0cso5624157fac.3;
        Thu, 14 Apr 2022 08:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgRBiTVC/FFWfC6f7VFIlxavcDc/C7IkOvLYm4Mfzvs=;
        b=QQ2vRYRmlckrTL2uohmikWroCLGEKLv0jKTlcPyESt926PPnpwMcTeFzlpWehuNSTA
         tflGx73ggnfWtCf6c07p7TFZ1CVVxqQcZhqcEhCZ55OCx4Mp3eLY0X+mW5bWx11g8RQE
         jm//i5g41NtucMGPNs2z2rjn4QxE0Y4ZrWp6pVGNcHsmg5AWMECHdD+0ggFQTOsmPiHR
         bQU2cvhqzbLzle/L9M7aOVB3Y/7KrukGrBCJxB/FFvg/iDnhH93ZGN2vnnVx5mxz3d/f
         uVtG2LtyzFoxQjlK0WNUxzmO9nugzThEUg4HQx6GEy/OVnLlVs1ggHm/kjHm8CEHJeS+
         6QjA==
X-Gm-Message-State: AOAM532mhJzNiOj+41uxL2P01P3UkUGOxiY96GmtfB0szSeanPpnGO/c
        /FxYjxmCzhDIIf5MNheDEA==
X-Google-Smtp-Source: ABdhPJxO41UyWKPRLV35Yj+ApQ4PFF6XoQyq8uSctU7sQmGIJXL6DxUImc9X9hOqKaDbOcuZF4s6Kw==
X-Received: by 2002:a05:6870:434f:b0:bf:9f2a:26f0 with SMTP id x15-20020a056870434f00b000bf9f2a26f0mr1521011oah.40.1649950446230;
        Thu, 14 Apr 2022 08:34:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h8-20020a056830400800b005cdceb42261sm120283ots.66.2022.04.14.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:34:05 -0700 (PDT)
Received: (nullmailer pid 2095983 invoked by uid 1000);
        Thu, 14 Apr 2022 15:34:04 -0000
Date:   Thu, 14 Apr 2022 10:34:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     dmitry.torokhov@gmail.com, corbet@lwn.net, sre@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        skakit@codeaurora.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Message-ID: <Ylg+7MVRS4sKbOFb@robh.at.kernel.org>
References: <20220411200506.22891-1-quic_amelende@quicinc.com>
 <20220411200506.22891-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411200506.22891-2-quic_amelende@quicinc.com>
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

On Mon, Apr 11, 2022 at 01:05:03PM -0700, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
> 
> Update the description of "reg" property to add the PON_PBS base
> address along with PON_HLOS base address.  Also add "reg-names"
> property description.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 353f155d..542200b2 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/bindings/power/reset/qcom,pon.yaml
> @@ -26,7 +26,25 @@ properties:
>        - qcom,pm8998-pon
>  
>    reg:
> -    maxItems: 1
> +    description: |
> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
> +      peripherals.  In that case, the PON_PBS address needs to be specified to
> +      facilitate software debouncing on some PMICs.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    description: |
> +      For PON GEN1 and GEN2, it should be "pon".  For PON GEN3 it should include
> +      "pon_hlos" and optionally "pon_pbs".
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: pon_hlos
> +      - const: pon_pbs
> +      - const: pon

This says there are 3 entries, but you limited to 2. The schema also 
doesn't match what the description says. Entries should be extended by 
adding new entries to the end and keeping optional entries last. So like 
this:

minItems: 1
items:
  - const: pon
  - const: pon_hlos
  - const: pon_pbs

Rob
