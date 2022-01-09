Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978C8488A15
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiAIPHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jan 2022 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiAIPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:07:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D30C061748;
        Sun,  9 Jan 2022 07:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DC060EE2;
        Sun,  9 Jan 2022 15:07:37 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6AD8AC36AED;
        Sun,  9 Jan 2022 15:07:34 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:13:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property
 sizes
Message-ID: <20220109151329.6e4ef20f@jic23-huawei>
In-Reply-To: <PH0PR03MB67866DD9F266C44A8B4CA87D994D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220107032026.2408196-1-robh@kernel.org>
        <PH0PR03MB67866DD9F266C44A8B4CA87D994D9@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 15:01:29 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Rob Herring <robh@kernel.org>
> > Sent: Friday, January 7, 2022 4:20 AM
> > To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
> > 
> > [External]
> > 
> > The '/bits/ 64' notation applies the next <> list of values. Another <>
> > list
> > is encoded as 32-bits by default. IOW, each <> list needs to be
> > preceeded
> > with '/bits/ 64'.
> > 
> > While the dts format allows this, as a rule we don't mix sizes for DT
> > properties since all size information is lost in the dtb file.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>  
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Hi Rob,

Do you want me to pick these up, or as they are fixes would you rather take
them yourself to get them in quickly?

In case you want to pick this up.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Thanks!
> - Nuno Sá
> 

