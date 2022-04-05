Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1D4F4C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577906AbiDEXRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573654AbiDETdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:33:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A0245BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:31:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235JVDpB035657;
        Tue, 5 Apr 2022 14:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649187074;
        bh=6S4oBgr084pJY5AjWt0SE218ar7kVDqYu4XZa5mwyyo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Ae8KIXXmxWXu6l+Go3Ow0EnTuWC2CugQgQ/jRblMkKcYe5EyR5cRLo7T9ve2wHmYv
         Oxv5TSP/pMblriRFbArE5tBDInYMSRBzAiFxWVNTUtMdg4cqw0T2oYSEPtjPQNuhnv
         lfEnRKFQnRiGXoVi7CRNdgTjRgPRl1Pv2rMQOFqk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235JVDOl031228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 14:31:13 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 14:31:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 14:31:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235JVBE2105678;
        Tue, 5 Apr 2022 14:31:12 -0500
Date:   Wed, 6 Apr 2022 01:01:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
Message-ID: <20220405193111.pnekaivbsj7hronp@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-5-tudor.ambarus@microchip.com>
 <20220401200133.gyyvoe7xdbsww7cv@ti.com>
 <ed093fa5-b514-b0a6-166f-ecf117582b0b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed093fa5-b514-b0a6-166f-ecf117582b0b@microchip.com>
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

On 04/04/22 06:19AM, Tudor.Ambarus@microchip.com wrote:
> On 4/1/22 23:01, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 09/03/22 04:42PM, Tudor Ambarus wrote:
> >> Keep the SFDP definitions private and expose just the definitions that are
> >> required by the core and manufacturer drivers.
> > 
> > I am not so sure about this. Since the post_bfpt hook passes in the bfpt
> > table to flash drivers, they might end up wanting to use these for some
> > checks like issi.c does for DWORD 1. They would have to move them back
> > to sfdp.h for that, which just causes extra churn, and also puts some
> > BFPT related defines in sfdp.h and some in sfdp.c.
> > 
> 
> That's correct, but I think exposing just the public defines in sfdp.h is
> the path to follow. We should keep private all the definitions that we can
> private in sfdp.c and expose publicly in sfdp.h just the ones that are shared.
> Flash collisions, and implicitly the need of public SFDP definitions, should be
> an exception, so I expect sfdp.h to be short in size.

I disagree. I think we should keep everything in the same place. And 
since we need to expose this to manufacturer drivers, that place is 
sfdp.h. Who is going to cast the tiebreaking vote here? ;-)

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
