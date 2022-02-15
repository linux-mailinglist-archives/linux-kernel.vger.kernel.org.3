Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6814B781B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiBOTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiBOTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:17:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923610F9B5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:17:08 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJH11m054157;
        Tue, 15 Feb 2022 13:17:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644952621;
        bh=6+4pNjB4kGYhVNFqBm0KwJ30sZDsMp6NZjQKle6vH58=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=s8lu9Cogqf4+4irS1uoqqLkePMbgism4OjNJJoYBycwZqR4D8apaJ4BX7/JW0nTep
         TIuy90ARiQFaPdzzhbXx9CCg9mFaJ1FSuenTSy4ogx/5WuYgMon8WYLqiLqPS15i6s
         4w7wXVLm7RCHb6Wd1Y+zSydcuF+blf1rcwCEjit0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJH0UW024912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:17:01 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:17:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:17:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJGxwV023879;
        Tue, 15 Feb 2022 13:17:00 -0600
Date:   Wed, 16 Feb 2022 00:46:59 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 09/14] mtd: spi-nor: micron-st: fix micron_st prefix
Message-ID: <20220215191659.cjcmoitewpcu3avk@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-10-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-10-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 03:58PM, Michael Walle wrote:
> The usual prefix is micron_st, so use that instead of st_micron.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
