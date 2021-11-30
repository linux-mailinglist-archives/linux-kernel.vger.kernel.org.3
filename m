Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4E462FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhK3JkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:40:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37424 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbhK3JkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:40:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AU9aSvb088095;
        Tue, 30 Nov 2021 03:36:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638264988;
        bh=N+Gbrxz85CPm2g1QNSdZgtR2Dpod+ABYilbEGbZO5Vk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=f11y++twHtndHk25Su6Mv+3/Lu8qRYpj0fY7iIWSNqli/sTizzbV0az831WGznz0L
         nPWDgwDhcVJo4iNGWwn8TrkREBTubVLhaCJq+9K+knxRNIPE+NJktul9fE9L2m5vd+
         HyikD39b08tkzACMfG4bVnEBwjc4EXEzhUFZN/vA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AU9aS62050668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 03:36:28 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 03:36:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 03:36:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AU9aRFI051313;
        Tue, 30 Nov 2021 03:36:28 -0600
Date:   Tue, 30 Nov 2021 15:06:26 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Add bindings for peripheral-specific SPI
 controller properties
Message-ID: <20211130093624.kc5ivrhzjwfo7rke@ti.com>
References: <20211109181911.2251-1-p.yadav@ti.com>
 <20211129180935.nmymboy336hllly7@ti.com>
 <YaUY1gKnyoOEvo/M@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YaUY1gKnyoOEvo/M@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/21 06:15PM, Mark Brown wrote:
> On Mon, Nov 29, 2021 at 11:39:35PM +0530, Pratyush Yadav wrote:
> > On 09/11/21 11:49PM, Pratyush Yadav wrote:
> 
> > > This is the best approach that I came up with with my limited knowledge
> > > of JSON schema. It has some limitations that are mentioned in patch 1. I
> > > don't know of any better ways to model this. Suggestions are welcome!
> 
> > Do you plan to take this series through your tree or should I poke Mark 
> > about it?
> 
> I'd expect to take it through my tree but please allow a reasonable time
> for reviews...

Sure, thanks. I just wanted to make sure this series didn't fall through 
the cracks if there was some confusion on who is supposed to pick it up.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
