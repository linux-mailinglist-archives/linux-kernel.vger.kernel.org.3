Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972FA53BB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiFBOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiFBOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:43:14 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B17255A1;
        Thu,  2 Jun 2022 07:43:13 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id p129so2123701oig.3;
        Thu, 02 Jun 2022 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ARHoM5LHWT9TByTd9RguxGGMAsE/6ISibQgr6i7ICU=;
        b=3y8kPGjEjOtvm4XrogPqr+InlNByySuOMBafi+Lt6MAjrlE6/nKhOTeN9aPpXMhuCr
         x3tcq3L6jLeWZFYMDoUpeQwoyEl8oUmwy3sLigPdf91c6Zo8oPhhqBm3jBOoNwZHCr33
         eXimUm0HnT+oBQ9xz3YmCx+zAhHCA/Xqev489Kjfw3b+8oFid6il9fSB0j81ODIOcUTK
         QdtWLfdBKaHKLdhgSMfRWkH+dF8IT2092klWccUjcZFcuXd1ysAAQZriQ3wwqfXQnTn2
         OigUGwdYxaSJsYd5/P6YV9TD3GNFBsr/UZtYPDTmPd2XaRJdzj4mVS8yrR10CSRV/rfe
         juFw==
X-Gm-Message-State: AOAM530zJkS2MzHeHX959Xb6mUlFLFzOtfwmJlgMpDzsgwonEiat59P+
        B56nqFDamFJWZrfArFCndQ==
X-Google-Smtp-Source: ABdhPJysiNjG99QgKgCjncBPlVVdav9tlJP2F5lRbb9jnwiLuIn1hoWcc91mSkX8MrmN+cktC9jNwg==
X-Received: by 2002:a05:6808:1686:b0:2f7:2f03:9792 with SMTP id bb6-20020a056808168600b002f72f039792mr17778848oib.278.1654180992727;
        Thu, 02 Jun 2022 07:43:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c16-20020a544e90000000b0032b1b84f4e3sm2348061oiy.22.2022.06.02.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:43:12 -0700 (PDT)
Received: (nullmailer pid 2283162 invoked by uid 1000);
        Thu, 02 Jun 2022 14:43:11 -0000
Date:   Thu, 2 Jun 2022 09:43:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, djakov@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Update email address
Message-ID: <20220602144311.GA2278169-robh@kernel.org>
References: <1654130923-18722-1-git-send-email-quic_sibis@quicinc.com>
 <cb8c7e28-dfef-78e2-c97c-11b9dee02fed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8c7e28-dfef-78e2-c97c-11b9dee02fed@linaro.org>
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

On Thu, Jun 02, 2022 at 01:48:21PM +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 02:48, Sibi Sankar wrote:
> > Update email address to the quicinc.com domain.
> > 
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 +-
> 
> Thanks for updating the email addresses. All three patches should be
> rather squashed to one (and taken by Rob for example), it's quite a
> churn. Anyway:

I've applied the series and did this.

Rob

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof
> 
