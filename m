Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887084C5AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiB0MPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0MPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:15:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7E5674D;
        Sun, 27 Feb 2022 04:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5402C60E65;
        Sun, 27 Feb 2022 12:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93733C340E9;
        Sun, 27 Feb 2022 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645964081;
        bh=sgzKryWvFEwRSTVgMV3XSDuN4d/DthubbeMrQ+5G468=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fS6uacjqnIu8yIEVHkUKb/dTR6yAx2Rd2wWS1qmAMDV8CHJp7WM62JXqOZxV2unzU
         ehqmf3LTdBxf8oaDoOHDDI26J39rS8hSodv2nkjawlHs5qP8g9n0eD1CCO7z4QDBvo
         R3ZUxZk7GM8NNpneJUdQODC9/d4F2Q9rvb/OSyYCk6ZR5MjNIpsCUBM2BFsrqopVmY
         SvQGnWxkSnJLuwfMcbvcvawKgsi4Mu1G1GlvclrAOsPEeVNhCxIa0CeUGqNZhbWDOB
         3ix9o1PyWynVdvmnXmrEo8ImxFjPtvTvzf8Cq60Wiek10VuAqZQgf5o5ZlUhAGYgM7
         8/bLD/aHylF0g==
Date:   Sun, 27 Feb 2022 12:21:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Message-ID: <20220227122145.6bc20b68@jic23-huawei>
In-Reply-To: <b591b26e-1a80-e17d-4525-989b357e97b1@canonical.com>
References: <20220223130808.13352-1-cristian.pop@analog.com>
        <b591b26e-1a80-e17d-4525-989b357e97b1@canonical.com>
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

On Wed, 23 Feb 2022 14:26:05 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 23/02/2022 14:08, Cristian Pop wrote:
> > Add device tree bindings for the ADMV4420 K band downconverter.
> > 
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> > Changes in v7:
> >  - Fix commit message  
> 
> Please include the tags accumulated in previous reviews.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> 
> Best regards,
> Krzysztof

Series applied to the togreg branch of iio.git and pushed out as testing
to let 0-day take a look before I go breaking linux-next (again :)

You get the same general feedback for future series as I just gave Antoniu:

1) Particularly when doing multiple revisions close together, please give
   a longer change log covering at least the last few versions as not
   everyone will have looked at v7 and it saves reviewers time otherwise
   spent checking back through earlier versions.
2) Cover letters are good for multipatch series because they both provide
   somewhere for general discussion that overlaps multiple patches and
   as somewhere for series wide tags to be given and that sometimes
   makes my life easier (complex cases where some tags are for individual
   patches and some are series wide which I have to go in an add by hand
   as no automated tool e.g. b4, could work it out!) 

Sometimes I like to complain about this trivial stuff that makes me
ever so slightly grumpy :)

Jonathan

