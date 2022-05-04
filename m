Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18651A30D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351839AbiEDPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbiEDPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:07:38 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00D42EF0;
        Wed,  4 May 2022 08:04:00 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-edf9ddb312so497947fac.8;
        Wed, 04 May 2022 08:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sn1FprFMfZ401oZdnKMfgZTW8Bn5vjqnty4V/SEXSyw=;
        b=Hg1/WkAlXtJEmCEIw35b9V2UDFPMGEtmMJ2IYWIfmuKHDMzjftnZlHV+o427dpuVbh
         jS1d4W+HiALzQS5QCBOEF/K2ufVaAUI4Q6jYJCuicQOtr8FaWHx9fvc86oyqfR+/wfLc
         019LCPKPtfzJ4xbZcyEVl+m1mFqbv4z6yD3r8sGwpwMsZFTfFvC6mq9EbiJdYXB86DFv
         TzS51aJGbFcAFkXJESC7beEaWtuX8Sa+rB7T2/Z7yCyEOND2Iq/l50Ovw6Y64BU4Ojlq
         6LYFIZM8+35I3SWUFi4Ahn1rN7NpkWFLnM6aJgYZzTErBq+076TyUZ7kkWo0Do8xYuFr
         HDJw==
X-Gm-Message-State: AOAM531dqxJdXcrFz3dvN7ZBPre+/UaK8R+oM8vnQMEu4+JYRAKhmitg
        oYa3B+pscrzCn6P1AToK6Q==
X-Google-Smtp-Source: ABdhPJyeqN7a3WcUXtGg2ql4GhTZFEERXuwzOgpadB9FFz4RoHjJ2DvW2NTpiEz1s2KkYbL9qDwYhA==
X-Received: by 2002:a05:6870:6324:b0:e9:16de:4053 with SMTP id s36-20020a056870632400b000e916de4053mr4070223oao.164.1651676640211;
        Wed, 04 May 2022 08:04:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a15-20020a056808128f00b003264a325ecdsm897053oiw.5.2022.05.04.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:03:59 -0700 (PDT)
Received: (nullmailer pid 1708315 invoked by uid 1000);
        Wed, 04 May 2022 15:03:59 -0000
Date:   Wed, 4 May 2022 10:03:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Message-ID: <YnKV32XmMLW6bJAT@robh.at.kernel.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
 <20220503193937.3794477-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503193937.3794477-2-swboyd@chromium.org>
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

On Tue, 03 May 2022 12:39:36 -0700, Stephen Boyd wrote:
> We need to configure the sleep and idle mode of the CS pins for this
> device. Add a DT property to do this so pins are in a proper state
> during sleep (either hi-z, grounded, or pulled up to vdd).
> 
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
