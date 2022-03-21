Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7544E345B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiCUXb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiCUXbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:31:25 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95495357B60;
        Mon, 21 Mar 2022 16:29:53 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id s207so17879646oie.11;
        Mon, 21 Mar 2022 16:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3dOmL4Lu1fRiJ594ANhJlR56D28l0ED00gYien2ND8=;
        b=grchtgxu3OGNNqxdqQI1hHRIEvrOrF1lTefUt8qQsXWsjQFe+Z8Nk3GsrKmmXWKiSq
         ms2v/TdHCQnx0W0qzjOkaZ1sJLuqswcgW9awmNXg4M5LCo+Cu+2u6Xs6SrdoUzbBB0JR
         w2MzvYr2mypAhlR9Ik/BiVQEAM2rq61anUK0M95TVzIckQcPfnl8CvF8eEv8RDjK9IoD
         hvEdf/ZgZKg9+MS/Z4ZF3uXhdqUDpP/4syuHN2LmEsVin7zninmQzAfSQB8Ide77QXqc
         smlUA2JiQVgENbMtOPoi9BSZgiQOB8CEQsJOq6wMEDGjWxW8SaXZ/C3zXwU3zWPF88sb
         5h0A==
X-Gm-Message-State: AOAM533WYMmla3QTD5gGbgJ4teGnVd9oaveESixrSiJuEBHd7cM/fWRc
        q1zE5mSmkYfGgdAFPIbTBQ==
X-Google-Smtp-Source: ABdhPJwmXMgPhnzMv1j3RzkiRGU/aCFAw8rg4efntETm5W+agBydMWcOHUXiHPK8mFuJfm6cNcXT2w==
X-Received: by 2002:a05:6808:8c4:b0:2da:575e:3402 with SMTP id k4-20020a05680808c400b002da575e3402mr771261oij.8.1647905392875;
        Mon, 21 Mar 2022 16:29:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm7380250oou.6.2022.03.21.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:29:52 -0700 (PDT)
Received: (nullmailer pid 745601 invoked by uid 1000);
        Mon, 21 Mar 2022 23:29:51 -0000
Date:   Mon, 21 Mar 2022 18:29:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     devicetree@vger.kernel.org, collinsd@codeaurora.org,
        subbaram@codeaurora.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        maz@kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        tglx@linutronix.de
Subject: Re: [PATCH v6 08/10] dt-bindings: spmi: spmi-pmic-arb: make
 interrupt properties as optional
Message-ID: <YjkKb+o7KNJL4UOQ@robh.at.kernel.org>
References: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
 <1647497535-32151-9-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647497535-32151-9-git-send-email-quic_fenglinw@quicinc.com>
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

On Thu, 17 Mar 2022 14:12:13 +0800, Fenglin Wu wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
