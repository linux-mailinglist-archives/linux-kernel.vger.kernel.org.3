Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C144C5AD6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiB0MES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiB0MEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F004504C;
        Sun, 27 Feb 2022 04:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64EC4B80BA1;
        Sun, 27 Feb 2022 12:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D84C340E9;
        Sun, 27 Feb 2022 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645963413;
        bh=oCxNGVyXFBEgGugPHKW0CLS6eePMvEzboypl9TTvBb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQJ+GVQ2MclK/3FPcpwO2XsPb8IHnhgaAuWky53FX/YwRThuLwPkb1KPcfobmMj0d
         zz4pFiww2YBAHggtvie/WPeZZr9rWvPGBnnA5rFZHjQcXPS4ObQ931xSjCGBvpM6dZ
         ek1g07bmn7BjOCZJbUGxqrLisX46FZrhLcYTBRFfliwFVc8GxIQnarGBJYLuwZZtTU
         H/hsAeHHQEUMZSqX9C+G/2qCVYPGMI+3AI7x2/8C650pIaOZWx22WzWYq73fBZryzE
         PRQxVsZ9reUP/ElForUcxlvVZn72c46Nf11roqpMTuiTMJ7rucmRw5Ws6zGdimf/JS
         /AL71XeBKKUBw==
Date:   Sun, 27 Feb 2022 12:10:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: amplifiers: add ada4250 doc
Message-ID: <20220227121035.07a922a8@jic23-huawei>
In-Reply-To: <Yhey1QmZa4RU0p50@robh.at.kernel.org>
References: <20220223120112.8067-1-antoniu.miclaus@analog.com>
        <Yhey1QmZa4RU0p50@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 10:31:17 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 23 Feb 2022 14:01:10 +0200, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADA4250 driver.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> > changes in v6:
> >  - add space before `{` in the amplifier node example
> >  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a quick look before I go making a mess of linux-next.

One side comment though - when there are lots of revisions in a short timescale
and people haven't had time to get back to the intermediate ones, it is particularly
helpful to give a multi version change log.

i.e. tell us what happened in at least the last couple of revisions to save
on having to go find the earlier threads to find out what changed in v5 and v4!

Also, I always prefer a cover letter for a series even if brief. It give somewhere
to reply to if there are discussions covering multiple patches, or if someone wants
to give a tag for the whole series that I can trivially pick up with b4.
Obviously no point for single patch series though!
I don't normally moan about this, but I was moaning anyway so why not get
everything off my chest! :)

Thanks,

Jonathan

