Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559251586B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381501AbiD2WeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiD2WeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:34:19 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA96193F3;
        Fri, 29 Apr 2022 15:30:59 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e67799d278so9470980fac.11;
        Fri, 29 Apr 2022 15:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWGWEWMSBsvg1zR3CFVWEX1ktHlqUPAgCr8cR4qa9sg=;
        b=ClT8cfqdGZ27i84XNhVv0eOE5GV0ayIOPeyOPjeH1IyW5I46VONaYbcMwpYl1Y/K12
         pXoFihTt7CSbQWh6V92BycoKrf1ORzD0cLb/87CRBZnQWsMiVyQQRhfQ4e6yc6Jc0E5F
         jbv/h1uqBTBEgjDkysitD3y/eM0eNuIq9LRhPVObesnKvmGQu8GMuQD1EAidnXGqPEaa
         HyNQpBLE81rP15JgjJCEcNRafYm5JJ5BpB4qiLzBVEjbL6qiWwqOUKoAvup9kJF5Ht3+
         WLTE8/B9nKgPRZtmm+mOY2O0Jkm4MSF043ud95svfcltlRLmL1oudzmkD82ZenXxSAhl
         FayQ==
X-Gm-Message-State: AOAM530UKfe6wK8F3k3ycO8SR+rukp4vB2kjvLs705zhZSygC52UO2Js
        SwUWLXwjv8IEQHkNwsQjF3sGvEC7xQ==
X-Google-Smtp-Source: ABdhPJzPZlVTjo9d1hX+LY+6OVsyDKuqA0BAspGFW5EUYGx/QcL8afxPewR1xgOXtWtpAl9NFHD4WQ==
X-Received: by 2002:a05:6870:6324:b0:e9:16de:4053 with SMTP id s36-20020a056870632400b000e916de4053mr2365756oao.164.1651271458562;
        Fri, 29 Apr 2022 15:30:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056830240500b006060322123bsm193391ots.11.2022.04.29.15.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:30:58 -0700 (PDT)
Received: (nullmailer pid 3018419 invoked by uid 1000);
        Fri, 29 Apr 2022 22:30:57 -0000
Date:   Fri, 29 Apr 2022 17:30:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     quic_collinsd@quicinc.com, tglx@linutronix.de,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, quic_subbaram@quicinc.com,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        David Collins <collinsd@codeaurora.org>, maz@kernel.org,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
Subject: Re: [RESEND PATCH V6 08/10] dt-bindings: spmi: spmi-pmic-arb: make
 interrupt properties as optional
Message-ID: <YmxnIQ9niVbyASfN@robh.at.kernel.org>
References: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
 <1651108369-11059-9-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651108369-11059-9-git-send-email-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 09:12:47 +0800, Fenglin Wu wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Make all interrupt related properties as optional instead of
> required.  Some boards do not required PMIC IRQ support and it
> isn't needed to handle SPMI bus transactions, so specify it as
> optional.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

I just applied the dependent patch, so I've applied, thanks!
