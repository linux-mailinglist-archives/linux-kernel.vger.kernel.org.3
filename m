Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF552A9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351662AbiEQRzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351669AbiEQRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:55:11 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611B3FBD7;
        Tue, 17 May 2022 10:55:11 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e93bbb54f9so25091638fac.12;
        Tue, 17 May 2022 10:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Rz9xM6L/PdFLe2DC5teg7et/sWEkDBUDfsO7wKp1Ug=;
        b=RMe0pD7TVBbxFqs67A4mvZrrSoe30MLmbxGzBLaJUClOz5NmZYNsy1Us97HaIuTky9
         HrMssWQfGRmy+NolL25caeS9rS2A6B2INsqgZxkyRkzHMda/lNvbnrwstF7sYsglYL6R
         Z3MfYPARvw83bM7C1INL2oq37Jc5SgsJIb7AIyxVpNIIRYU5HCm9zrcaXIJXWJZglklQ
         1tPfRAoNZ71nclEQdiOk/Av6HBHBPSFroq/xVgg4u0zeJ24r7rt5dITq3oGndKmK3+Qs
         cv5T404h+xYSfPsudyAV0Y3axFcdFG0YiwQqA+OGgIXe+pxz+Udv0bW8QIx0IuxKPIQ+
         zETw==
X-Gm-Message-State: AOAM533Avqto1f5ZCs0P/ZXl3ZJWGADZAF0lwfrSAj3QjF+E/lFy44XQ
        Fo7YZgTLmxPEWWW98/W6cw==
X-Google-Smtp-Source: ABdhPJxzGypqSGPDF8mxExdHUPXY12D4MFsWIAtlDUUPD2mZXrrLhnXEbnsalAawIOkCIjlcxx5cHA==
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id cv18-20020a056870c69200b000e9536810dfmr13441575oab.182.1652810110382;
        Tue, 17 May 2022 10:55:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q15-20020a056870828f00b000e686d13887sm30911oae.33.2022.05.17.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:55:09 -0700 (PDT)
Received: (nullmailer pid 1318269 invoked by uid 1000);
        Tue, 17 May 2022 17:55:08 -0000
Date:   Tue, 17 May 2022 12:55:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, quic_subbaram@quicinc.com,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        quic_collinsd@quicinc.com, Mark Brown <broonie@kernel.org>,
        quic_jprakash@quicinc.com, swboyd@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 3/9] dt-bindings: mfd: pm8008: Add regulators for
 pm8008
Message-ID: <20220517175508.GA1318235-robh@kernel.org>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
 <1652275113-10277-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652275113-10277-4-git-send-email-quic_c_skakit@quicinc.com>
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

On Wed, 11 May 2022 18:48:27 +0530, Satya Priya wrote:
> Add regulators and their parent supplies along with example.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V12:
>  - None.
> 
> Changes in V11:
>  - Add ldos directly under pm8008@8 node, remove the intermediate "regulators"
>    node.
> 
> Changes in V10:
>  - Regulators are added as a part of pm8008@8 device. Change bindings doc
>    accordingly.
> 
> Changes in V9:
>  - Remove description for reg and drop unused phandle from example.
> 
> Changes in V8:
>  - This is split from pm8008.yaml binding.
> 
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
