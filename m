Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC754F62CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiDFPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiDFPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:17:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9A4027AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:18:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 236CHNtS107207;
        Wed, 6 Apr 2022 07:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649247443;
        bh=xusxtaIjNVje7kIAPhVOZ5p+5hisSYWMbwUvNtg+Rs4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BOM0ZDDkKKGjAqOP2Mqp13aY5ZF5LUN6kSdO3CNXayceuP1ldCdlBLK4anw9Yqs7w
         vXLMyPUOodcPQsGrfYfG3KR9N8DSlf+nuI5kITXL4xR/u4fCtlqLdFHBo/3/Tydqp2
         zkyak3B5LbIFWxkKD/TA7yv6EMGMKRH49Mjz095A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 236CHMMG100974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Apr 2022 07:17:23 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Apr 2022 07:17:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Apr 2022 07:17:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 236CHLBE113571;
        Wed, 6 Apr 2022 07:17:22 -0500
Date:   Wed, 6 Apr 2022 17:47:21 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
Message-ID: <20220406121721.j6wlbzxher4xhtba@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-5-tudor.ambarus@microchip.com>
 <20220401200133.gyyvoe7xdbsww7cv@ti.com>
 <ed093fa5-b514-b0a6-166f-ecf117582b0b@microchip.com>
 <20220405193111.pnekaivbsj7hronp@ti.com>
 <1fa079c4a0341ffe6ad7bdebd3cb8958@walle.cc>
 <16af88ad-52ea-4ed7-782b-eba28325bf0c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16af88ad-52ea-4ed7-782b-eba28325bf0c@microchip.com>
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

On 06/04/22 11:10AM, Tudor.Ambarus@microchip.com wrote:
> On 4/6/22 13:31, Michael Walle wrote:
> > 
> >>> That's correct, but I think exposing just the public defines in sfdp.h
> >>> is
> >>> the path to follow. We should keep private all the definitions that we
> >>> can
> >>> private in sfdp.c and expose publicly in sfdp.h just the ones that are
> >>> shared.
> >>> Flash collisions, and implicitly the need of public SFDP definitions,
> >>> should be
> >>> an exception, so I expect sfdp.h to be short in size.
> >>
> >> I disagree. I think we should keep everything in the same place. And
> >> since we need to expose this to manufacturer drivers, that place is
> >> sfdp.h. Who is going to cast the tiebreaking vote here? ;-)
> > 
> > I'm leaning towards Pratyush opinion unless there is a clear advantage
> > to move the defines.
> 
> Okay. Then we should move all the table definitions to sfdp.h, right?

We don't pass any other table to manufacturer drivers. Only BFPT. So 
those can stay private. But I don't mind either in this case.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
