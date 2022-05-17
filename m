Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85652A9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351660AbiEQRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiEQRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:54:40 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E6E3F8B5;
        Tue, 17 May 2022 10:54:39 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id m15-20020a9d608f000000b00606a788887aso12683192otj.0;
        Tue, 17 May 2022 10:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3pXBmwavwziD8SwUU4NEpFWGeOwbylEbVMwnOPkG00=;
        b=KJheONebQKrxhJwaIhV+NBtIsawpnp8OFbqB8e1mEtvHoSrRnIev8ZtlRI7lzOPnid
         ckiIQli/zya3BYJnnP12WLiAUpzqVtI8HkYp1nog3C2nRSVW71eIPZeQ6tr6RInJd35W
         acAKSEhiSd4hxkFm4A16GcOuMnfrB+QV2HunNoar6XHbn4YKrAco0IjP4hX4cmMB2Cc6
         O9bmzBWbzIJloKKSKlkjT0YqXy7uXrjybk68VDqpOzDRMlGzdXpXXN7Py/fmvW+YF+hi
         CESKkhVBTz3LZOj13P2SKJ1qSkyMkA6/T3CJcVj+U54sg2L6BQuYxZ425+DZpWdsNnBy
         kPGA==
X-Gm-Message-State: AOAM530Jly+RDiUUMfKGqIUOxVvil5JrFaCzMhljOg6FKGrMRD0lfpyA
        JfO/dGQozA62Cqyn3qwyWQ==
X-Google-Smtp-Source: ABdhPJzPT/Z9T9o6YXQNBXdn09c12aoEqcJ6YvwdDe5qqWANHdCAxOkoaMdxcgH4/Qg+M+hzeOhecg==
X-Received: by 2002:a05:6830:4187:b0:605:4e15:de30 with SMTP id r7-20020a056830418700b006054e15de30mr8560872otu.182.1652810078881;
        Tue, 17 May 2022 10:54:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l188-20020aca3ec5000000b00325cda1ff9dsm69525oia.28.2022.05.17.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:54:38 -0700 (PDT)
Received: (nullmailer pid 1317335 invoked by uid 1000);
        Tue, 17 May 2022 17:54:37 -0000
Date:   Tue, 17 May 2022 12:54:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_subbaram@quicinc.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, quic_jprakash@quicinc.com,
        quic_collinsd@quicinc.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        swboyd@chromium.org
Subject: Re: [PATCH V12 2/9] dt-bindings: mfd: pm8008: Change the address
 cells
Message-ID: <20220517175437.GA1317302-robh@kernel.org>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
 <1652275113-10277-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652275113-10277-3-git-send-email-quic_c_skakit@quicinc.com>
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

On Wed, 11 May 2022 18:48:26 +0530, Satya Priya wrote:
> Change the address cells as '2' so that the first cell
> describes the i2c address offset of the clients.
> This helps us to define the child nodes of all
> clients under the same parent mfd node, instead of
> adding separate mfd DT nodes.
> 
> Change the gpios reg value accordingly.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V12:
>  - None.
> 
> Changes in V11:
>  - New patch added from V11.
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
