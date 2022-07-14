Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF7575097
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiGNORR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGNORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:17:15 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AB63905
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:17:14 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id v185so1480788ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFGlUqxb7cc+5gWDCoJrXqS9wTvSC/PjQSRqProZaOw=;
        b=4efXs9vVW/HaB/zRGA8btwmAmyGBMvL8owjdc6o0wWyNJKUojLGlb7w2iJOtiuDkgy
         qaWdSPamfqtxJPQIaeeqe5/iaeHh8cH9owPVPoItRwD8xAVJZoGkfWVRA9K0ZKMA5UDt
         dp4WomcUmUbpCt/VZKhvDip0nHXi54QiXnPPxD5uTOzc7jKLSotswFc2t5Ln9vtiBXBZ
         SpZfDZgTbmr40O/ACyk0akyCOlPZba61scIdGWMSXVfpRR5v3JxTNzKQIGyqr93ISO3X
         r2DrfepSR6A24Q8QvAp83eDG2yTQfPKh/Fet/VARL40XyuXjeph5Ja5WbGeZd4OmjU0H
         EfIg==
X-Gm-Message-State: AJIora9BiIcAX1v+ocgrRRYR/UpnSvC79vxHle/OfhoMPx1g1xXFK4G2
        3BqG9NDCNhQfd8YxlcM0rg==
X-Google-Smtp-Source: AGRyM1ssrbSinGZBrix/SHFMuWMfClpfn4fy+Qr7EU6nKH9Tg0tC5DxxD1Z4pjX7E7BrAruoXRex1w==
X-Received: by 2002:a6b:c30c:0:b0:67b:963a:c6ef with SMTP id t12-20020a6bc30c000000b0067b963ac6efmr4684788iof.137.1657808233649;
        Thu, 14 Jul 2022 07:17:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cd8-20020a0566381a0800b0033e72ec9d93sm757191jab.145.2022.07.14.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:17:13 -0700 (PDT)
Received: (nullmailer pid 2258307 invoked by uid 1000);
        Thu, 14 Jul 2022 14:17:12 -0000
Date:   Thu, 14 Jul 2022 08:17:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     naresh.solanki@9elements.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] regulator: output-supply DT support
Message-ID: <20220714141712.GC2229197-robh@kernel.org>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <165756666221.1166849.17586001373716391631.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165756666221.1166849.17586001373716391631.b4-ty@kernel.org>
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

On Mon, Jul 11, 2022 at 08:11:02PM +0100, Mark Brown wrote:
> On Thu, 7 Jul 2022 10:18:22 +0200, Naresh Solanki wrote:
> > v4:
> >  - Add 9elements as vendor.
> >  - Update dt binding.
> > 
> > Add devicetree support of the output-supply driver.
> > The supply names for this driver is provided through DT
> > regulator-names & regulator handle can be acquired.
> > Driver events can be received from sysfs.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/4] dt-bindings: vendor-prefixes: add 9elements
>       commit: bd9b7998b4816b3d604253a774d83b6736474283
> [2/4] dt-bindings: regulator: add bindings for output-supply
>       commit: df9c96b69a1d2629519a5d8a9dc4b39f775ebe2d
> [3/4] regulator: output-supply: Add devicetree support
>       commit: 34e5700e1e64077ede50eb60d04e7604dc4f508a
> [4/4] regulator: output-supply: Add Notification support
>       commit: 490a15324ce6d55b950fce0eb9e95c793fac0dff

Please revert this. The vendor prefix is not even appropriate here and 
the binding has lots of issues. The first being whether it should even 
be in DT. It's not been reviewed as none of it has gone to the DT list 
and the only thing I got was '[PATCH v4 1/4] dt-bindings: 
vendor-prefixes: add 9elements'.

Rob
