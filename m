Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10B513C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiD1Tmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbiD1Tmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23763B6477;
        Thu, 28 Apr 2022 12:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9218B82F9E;
        Thu, 28 Apr 2022 19:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A19BC385A9;
        Thu, 28 Apr 2022 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651174761;
        bh=UgDPG16EQ1o8xT5G2Ea0j8kDFXnr+CSGOT2RWoE8VOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7y6YjCSsmAN3yTZNCKeLD0pnnoxkXOqAzNcIsAG+ykcNkY7wO1D7sNxd1WhOX/9U
         VkNwwUqyt0A51yyjIiOUaGMgHbp40DaRmW3+suRBO0XtcmyfnlVuHrrYwSa1Q78w2m
         W6TkGQZAns9tM0dYAzafTiJwQo0Xadw/6RYSWiiUGHYOfwg7uyelm2qaQiXiJO+fU/
         i78gaInD3AbaWjdSJOx7nCBKgKSXcEmnxGSAUKiqEbhszG4pLklSwnDQil8G13Xk5M
         1x9h2J6vCkuMygB9lC4B7YW87ONYW3+n18bcq5v2MvPMMbyMgXJH2czp3z+bWIllJe
         xZ/sUh7ZWqPDw==
Date:   Thu, 28 Apr 2022 20:47:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in
 examples
Message-ID: <20220428204733.6af91db6@jic23-huawei>
In-Reply-To: <Ymb6TfADJKd+a6Ys@robh.at.kernel.org>
References: <20220422192039.2590548-1-robh@kernel.org>
        <20220424171212.6d247854@jic23-huawei>
        <Ymb6TfADJKd+a6Ys@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 14:45:17 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Apr 24, 2022 at 05:12:12PM +0100, Jonathan Cameron wrote:
> > On Fri, 22 Apr 2022 14:20:39 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > Fix a couple of examples using incorrect compatible strings.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>  
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > or I can pick these up through IIO if preferred.  
> 
> Yes, please apply.

Done,

Thanks,

Jonathan

> 
> Rob

