Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B344AA387
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353397AbiBDWtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:49:46 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36393 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiBDWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:49:45 -0500
Received: by mail-ot1-f53.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so6206573oth.3;
        Fri, 04 Feb 2022 14:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gS2wDAPjLtZITuBJhr7hO9ow+BOwN9m6+rIuCnFNKA=;
        b=SxAXXZvTAGiNkmsWvPLRzukcNhNQyk9LpYPIJekhZsm/shRUOoWMF4W7ipYB6PhuCh
         wUDncm14eJlDzbEBI5hqVcumlONdbWla4ZNJkrXWR4kFUd5Y3Z1f6ifh/WEgBJ5CWRXO
         LrQyKYu+zhJhbZHxYvDj0mYfBZGptXDjMpllNCSYY8MsSj1ZJBYaaeEBwFCQ2CRz/zBh
         OJ0Hlm505NY9t3OjbyeRaVamfeBwdQbIGxH3WumYGKburgiCekN9nuDauEWjU8mkwDrp
         a2QD0X8x9Ko3LDIb5Z9glOc/on/3SJGrZR7KV1Rmu57N9ocoX7Nceli30CR7M4kLHxCF
         VMMg==
X-Gm-Message-State: AOAM533w5dJTQ/3fw9ewr2An1ExxWv6vCqSmZGZlpC/1qr5O7h57AEo7
        0AYCRNgwq4a1XEkJf1TfWA==
X-Google-Smtp-Source: ABdhPJzTbrAh6HQGaq/XCfqp1RmL2y2VWzJIIFJQMkAYA0l24yN+lY9N+kY+ksOxkD8s0BjGnpx5Ew==
X-Received: by 2002:a05:6830:450:: with SMTP id d16mr449846otc.151.1644014984721;
        Fri, 04 Feb 2022 14:49:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m15sm1248873otr.37.2022.02.04.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:49:44 -0800 (PST)
Received: (nullmailer pid 3328432 invoked by uid 1000);
        Fri, 04 Feb 2022 22:49:43 -0000
Date:   Fri, 4 Feb 2022 16:49:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     quic_sibis@quicinc.com, quic_satyap@quicinc.com,
        pure.logic@nexus-software.ie, quic_saipraka@quicinc.com,
        greg@kroah.com, quic_psodagud@quicinc.com,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org, quic_pheragu@quicinc.com
Subject: Re: [PATCH V5 1/6] dt-bindings: Add the yaml bindings for EUD
Message-ID: <Yf2th6cIGfsGhHCT@robh.at.kernel.org>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
 <09ebfb6c3efcd3084ba2eae65820a6d4187785c7.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ebfb6c3efcd3084ba2eae65820a6d4187785c7.1643880577.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 16:04:30 +0530, Souradeep Chowdhury wrote:
> Documentation for Embedded USB Debugger(EUD) device tree
> bindings in yaml format.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml     | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
