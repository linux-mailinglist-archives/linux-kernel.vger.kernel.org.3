Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F32543ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiFHVsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiFHVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:48:13 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426C13DCB;
        Wed,  8 Jun 2022 14:48:12 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id a15so17527032ilq.12;
        Wed, 08 Jun 2022 14:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Hcq2KlgFtmPr+0ri+N9W4VslZfw9d1fwhgipuxpRa8g=;
        b=gJAW0qukB7eLS2MdlaHtnz8RUVzHHubQnA+qSXm+vbYb0NTr9m7CE4MgCAnQQpSsFP
         aui54D/gaer2Fd+pzs4y1maOlo/4IjEc28wfv/BK7FEvj8Aj9BE+Sa4JmgvmDsDHBM0Y
         80gY+FZ8nMot+OvHZAbKCi7Llbc2QIxIkzK5uvx1FRPNh5ZOg9e9k4OAhl+QPaVBtN14
         WKoosOqKbJqv2MLNkeGg+sQDjxzMNEHBM4Cz96f0bnudZUBr3fX5ETc0fSdJHVn7of8Q
         fuH19EviRBBkT14Oogo4BfceRDJteaisQ0s5ERQcszKBBsbhLhWFBZK0WTZZsGv7GYIf
         j5QQ==
X-Gm-Message-State: AOAM53317qoHH+cgm8Q4TTQULx4cFo5gagfXqOY3IokarwNQRAml7JuM
        H5uXGaNbmmY9rFdsv4oN7w==
X-Google-Smtp-Source: ABdhPJz5VAScxIaNZL+1SzgG6SCE4nbpEE7g2Xea+n0RcGQcCPtEikJXSncaEErE55oZJBLSM87wnQ==
X-Received: by 2002:a05:6e02:2187:b0:2d3:cb8b:218c with SMTP id j7-20020a056e02218700b002d3cb8b218cmr20153917ila.28.1654724891475;
        Wed, 08 Jun 2022 14:48:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t14-20020a5e990e000000b006695b8bb8d3sm3691144ioj.12.2022.06.08.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:48:11 -0700 (PDT)
Received: (nullmailer pid 2134381 invoked by uid 1000);
        Wed, 08 Jun 2022 21:48:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com> <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Wed, 08 Jun 2022 15:48:06 -0600
Message-Id: <1654724886.799944.2134380.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 23:06:25 +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:369:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

