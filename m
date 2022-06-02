Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87953B94B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiFBNDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFBNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:03:11 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E47183;
        Thu,  2 Jun 2022 06:03:11 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f2e0a41009so6631703fac.6;
        Thu, 02 Jun 2022 06:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1uE//vdrX6s2dLhOkjOsdaFXRjoT93w83zDJuSLa4Y=;
        b=1bWwr2L+MaeocUh3gIHz+FN5n29+oBl9OqUR83iGV09iBFlY6VWlGo8DSB5mMijtXe
         EQFgz+Vdwpo+M2B7On1Whng23n1FlYobVbkJWpswMAO6Y8p1CLISyaLj910gxmudZL4Y
         DYgabIp2MExlS5faNDksQ686DW7rD2zFMiKKkKXCCxCsVqS9yBK+IHaKoisWvI2hLB6x
         +M9JqSJD3y7IUWL2EWGiDllpYT0ll1BEl1sDyWpY7hwgj2JrdndwzsWdvyMa6bZ/+Q8s
         pV6nBwA2KCq44Z28/l2EBoDQrjFI4o2SNCs5iZsaU6Hj/wQb0UOH99/kdbgHv9WYvPCv
         5vSg==
X-Gm-Message-State: AOAM533aOr5TySBQztTDA8izBqz9BmmDtW0t0oV4UuYI2NQFXnOkSbeC
        YRlSjdisOcC2mN0ObSH3sg==
X-Google-Smtp-Source: ABdhPJyIWIOLK9U0zon4nsw0OCR3PsPbtWPI0k2j16u0gJTLEwMmde0nSJsxSsPjniOpBoE501JLHg==
X-Received: by 2002:a05:6870:339a:b0:f2:d065:be1f with SMTP id w26-20020a056870339a00b000f2d065be1fmr2654071oae.69.1654174990510;
        Thu, 02 Jun 2022 06:03:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b13-20020a056830310d00b0060b2f042b67sm2193889ots.43.2022.06.02.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:03:10 -0700 (PDT)
Received: (nullmailer pid 2103224 invoked by uid 1000);
        Thu, 02 Jun 2022 13:03:09 -0000
Date:   Thu, 2 Jun 2022 08:03:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_psodagud@quicinc.com, bjorn.andersson@linaro.org,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        eberman@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: firmware: qcom-scm: Add interconnects
 property
Message-ID: <20220602130309.GA2103167-robh@kernel.org>
References: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
 <1653289258-17699-2-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653289258-17699-2-git-send-email-quic_sibis@quicinc.com>
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

On Mon, 23 May 2022 12:30:56 +0530, Sibi Sankar wrote:
> Add interconnects as an optional property for SM8450 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> Since the interconnect requirements could either be specified in the
> individual remoteprocs or directly in the scm interface, will perform
> the yaml conversion in the next re-spin based on the consensus.
> 
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
