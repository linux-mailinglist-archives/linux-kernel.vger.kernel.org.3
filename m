Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17C55EB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiF1SB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiF1SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:01:21 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21113CDF;
        Tue, 28 Jun 2022 11:01:20 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id w10so8693704ilj.4;
        Tue, 28 Jun 2022 11:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyEzwvPI3BGxNhyGTBd05qTTzI+KUnXsrXGykLBGpWI=;
        b=wScY8X+R3OFPKDMQSTnt1c8KopyPDckwZuWHsHCnlVqGpq1uUxnMEGX198bOHPtU2k
         aQOQg1QpKVd8ZzdlgZL/z8wXAj/kE0onJvUu4xYFSzDZXSUqhxDqSkeDiPXTjHvhqaPB
         BPbg7Ot8c+FEDrcaDTAjImyL+9MRaGQ5Ymwml0A7hz73QXRkO4PaK/xXENVM5EV6roxl
         m8dSgxurVtER0SoxT8NwzaNiCcEY6PuBeX7DrVc4Oxq4mhNVqIIzX+lHPBUgwFdV8ZIx
         pZFToHU/aRtX+Qpn16uXFHK0UPYzTyW/3Ip5uev3LCc3Ly+V/piHMhO8YmiKL5FVPvqP
         yhMg==
X-Gm-Message-State: AJIora8K5l0/dRQd2WuJHfZtieWjfVVQNTgW+i2VcYxvurG+EX1IL+x5
        xKysJ0ZQrwxrBFJygeiaJQ==
X-Google-Smtp-Source: AGRyM1sKk9gL4yQV/igOvLwe9uL1GmQw+zbPQ4Eb34tAfm5CB2E0YhZpPgDOmZvs3Bol0j9fAT7xow==
X-Received: by 2002:a05:6e02:188a:b0:2d4:7fd:dbf with SMTP id o10-20020a056e02188a00b002d407fd0dbfmr10668739ilu.217.1656439279592;
        Tue, 28 Jun 2022 11:01:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e39-20020a022127000000b0032e49fcc241sm6317306jaa.176.2022.06.28.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:01:19 -0700 (PDT)
Received: (nullmailer pid 710546 invoked by uid 1000);
        Tue, 28 Jun 2022 18:01:18 -0000
Date:   Tue, 28 Jun 2022 12:01:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] dt-bindings: Arm CoreSight binding schema
 conversions
Message-ID: <20220628180118.GA703354-robh@kernel.org>
References: <20220603011933.3277315-1-robh@kernel.org>
 <20220620165541.GA1458883@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620165541.GA1458883@p14s>
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

On Mon, Jun 20, 2022 at 10:55:41AM -0600, Mathieu Poirier wrote:
> Hi Rob,
> 
> On Thu, Jun 02, 2022 at 08:19:30PM -0500, Rob Herring wrote:
> > This series converts all the CoreSight debug bindings to DT schema
> > format. These bindings are at the top of the list of occurrences of
> > bindings without a schema. For arm64 dts files:
> > 
> >     702 ['arm,coresight-etm4x', 'arm,primecell']
> >     536 ['arm,coresight-cpu-debug', 'arm,primecell']
> >     509 ['arm,coresight-dynamic-funnel', 'arm,primecell']
> >     213 ['arm,coresight-tmc', 'arm,primecell']
> >     143 ['arm,coresight-dynamic-replicator', 'arm,primecell']
> >      97 ['arm,coresight-stm', 'arm,primecell']
> > 
> > I'll send a reply to these with the errors in dts files that this
> > causes. I've reviewed them and they all look legit. Xilinx Zynq though
> > has 3 clocks instead of 2.
> > 
> > v2:
> >  - Rename other Coresight bindings to use compatible string for filename
> >  - Add missing arm,coresight-dynamic-replicator.yaml and
> >    arm,coresight-static-funnel.yaml
> >  - Update MAINTAINERS
> >  - Fix coresight.txt references
> 
> What a massive undertaking... I have looked scrupulously and everything adds up.
> Let me know if you were looking for me to pick this up.  Otherwise:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Can you apply. I think there was another series from QCom touching 
the MAINTAINERS entry that will conflict. 

There's a couple of indentation fixups. Can you fix when applying or do 
you want me to resend?

Rob
