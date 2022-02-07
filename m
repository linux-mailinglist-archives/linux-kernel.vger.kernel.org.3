Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB14ACAB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiBGUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBGUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:45:14 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E9C0401E2;
        Mon,  7 Feb 2022 12:45:14 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r27so18396722oiw.4;
        Mon, 07 Feb 2022 12:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4CBvpKDtyyuhqMBdinQ0npnVmuvp9xQ/uV+Zs1POU3U=;
        b=J5jgkxYXSAWdCJVYGVKoZLFjbw/3gBSlCCIKID+5LbwrrKJbvnCmeeUizg88ZyJEPV
         Si0yHozg/m2e9n8qnYcrQPJltWPhLNvKNJtz0OHcnS6K0mdxDQezbq5S0Xie+YRahCjX
         JcfIq9Q4dBYuH1s7bjzytMj9ySD8a59w+mflZc/dFMCSu8/irU+n2dy8snQ9uQa95KOX
         JHZyskD9JggSFx3n1jTm17RHIV/osOUSnTBqoa9HSuZRK567mnCiUW/LW9UTob4jktzS
         afwWICe3huOYMP0PJknPEyeflIcACE3tuOh2fvcoz5OPYu9vmjDfKV1+okI95oraBfKZ
         w+0w==
X-Gm-Message-State: AOAM532ERKoAkgbnEWnZHNrTUA7SVJvRF8QAn4+oF1g7s0eB7EcEog9k
        6XqLrEssRd3iWKKyqa+MVw==
X-Google-Smtp-Source: ABdhPJzhRWneseWtM0NrmN8rIoAn1dnsDFmiVKztKKTCE9meH6v+AjXkpehgBpZvAR9+EeGDabR7Ug==
X-Received: by 2002:aca:59d4:: with SMTP id n203mr351770oib.293.1644266713798;
        Mon, 07 Feb 2022 12:45:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k10sm4434156oou.26.2022.02.07.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:45:12 -0800 (PST)
Received: (nullmailer pid 887046 invoked by uid 1000);
        Mon, 07 Feb 2022 20:45:11 -0000
Date:   Mon, 7 Feb 2022 14:45:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        robh+dt@kernel.org, srini@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        bkumar@qti.qualcomm.com
Subject: Re: [PATCH v3 07/12] dt-bindings: misc: add fastrpc domain vmid
 property
Message-ID: <YgGE1y+IbtvXD60w@robh.at.kernel.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
 <20220126135304.16340-8-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-8-srinivas.kandagatla@linaro.org>
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

On Wed, 26 Jan 2022 13:52:59 +0000, Srinivas Kandagatla wrote:
> From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
> 
> Add fastrpc domain virtual machine IDs property. This property is used to
> setup memory protection for remote processor.
> 
> Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
