Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1A4C1B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244001AbiBWSjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiBWSjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:39:40 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F449CBA;
        Wed, 23 Feb 2022 10:39:11 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NIcp5C012312;
        Wed, 23 Feb 2022 12:38:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645641531;
        bh=VlmLvNgPCe5L7g2q46zh3SU4EKwQf3NcvwX8kmi+hUA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xKURzZxvW+WP32Fpl1fCWJ3EEqsRpzEMUb/t94kLSXojbDmZkQY40tDTRrLPsy3Ys
         px4LKDr3kAHZKAL36DRdY80IxrkvrMLIolj5woEvWL7Cn9bvGT8eaQGrwxL93v4Y8P
         wUeSKqdkX3cQHB33RXSXLTu4V/qcTuLjiFt5T+NE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NIcpQO112522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 12:38:51 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 12:38:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 12:38:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NIcoo4017359;
        Wed, 23 Feb 2022 12:38:50 -0600
Date:   Thu, 24 Feb 2022 00:08:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Message-ID: <20220223183849.xcwciv2ybnkdnauk@ti.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 22/02/22 02:43PM, Tudor.Ambarus@microchip.com wrote:
> On 2/22/22 16:27, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am 2022-02-22 15:23, schrieb Tudor.Ambarus@microchip.com:
> >> On 2/22/22 16:13, Michael Walle wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >>> the content is safe
> >>>
> >>> Am 2022-02-22 14:54, schrieb Tudor.Ambarus@microchip.com:
> >>>> On 2/21/22 09:44, Michael Walle wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >>>>> know
> >>>>> the content is safe
> >>>>>
> >>>>> Am 2022-02-18 15:58, schrieb Tudor Ambarus:
> >>>>>> Fortunately there are controllers
> >>>>>> that can swap back the bytes at runtime, fixing the endiannesses.
> >>>>>> Provide
> >>>>>> a way for the upper layers to specify the byte order in DTR mode.
> >>>>>
> >>>>> Are there any patches for the atmel-quadspi yet? What happens if
> >>>>
> >>>> not public, but will publish them these days.
> >>>>
> >>>>> the controller doesn't support it? Will there be a software
> >>>>> fallback?
> >>>>
> >>>> no need for a fallback, the controller can ignore
> >>>> op->data.dtr_bswap16
> >>>> if
> >>>> it can't swap bytes.
> >>>
> >>> I don't understand. If the controller doesn't swap the 16bit values,
> >>> you will read the wrong content, no?
> >>>
> >>
> >> In linux no, because macronix swaps bytes on a 2 byte boundary both on
> >> reads and on page program. The problem is when you mix 8D-8D-8D mode
> >> and
> >> 1-1-1 mode along the boot stages. Let's assume you write all boot
> >> binaries
> >> in 1-1-1 mode. When reaching u-boot if you enable 8D-8D-8D mode, when
> >> u-boot
> >> will try to get the kernel it will fail, as the flash swaps the bytes
> >> compared
> >> to what was written with 1-1-1 mode. You write D0 D1 D2 D3 in 1-1-1
> >> mode and
> >> when reaching u-boot you will read D1 D0 D3 D2 and it will mess the
> >> kernel image.
> > 
> > But you have to consider also 3rd parties, like an external programmer
> > or
> 
> Why? If you use the same mode when reading and writing, everything is fine.
> I'm not sure what's your suggestion here.

So our stance here is that we don't care about external programs?

If that is the case then why bother with all this anyway? Since the swap 
happens at both page program and read, what you write is what you read 
back. Who cares the order stored in the actual flash memory as long as 
the data read is correct?

If we do care about external programs, then what would happen if the
external program writes data in 8D-8D-8D mode _without_ swapping the 
bytes? This would also cause data corruption. You can't control what 
they mode they use, and you can't detect it later either.

I think there is no winning here. You just have to say that external 
programs should write in 8D-8D-8D mode or it won't boot.

> 
> > another OS. So, there has to be *one correct* way of writing/reading
> > these
> > bytes.
> > 
> 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
