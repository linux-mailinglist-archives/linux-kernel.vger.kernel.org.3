Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7A4C1155
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiBWLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiBWLdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:33:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371F90FD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:33:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBX5HP049950;
        Wed, 23 Feb 2022 05:33:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645615985;
        bh=Aezzoo6pZ5NzmYT+D2UloYyGtir9OeBkPwDbVKZR2gM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bPIYOmtXlAjdUSfWXHypD5xo4CiqRGsWSgbQBVD9JrQOT7nJjRHWS1OcKX1vh1dyS
         uWqilF3ExfZA/2JW2oZICU8ex1f5FoFQQEeiDKZilrN1NaFlKoicn1+vbUwoK+xzSC
         ei6rA02anR8swldB2AQQW1TZSnfO848fMNlBShRM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBX5Un015318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:33:05 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:33:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:33:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBX4lI046878;
        Wed, 23 Feb 2022 05:33:04 -0600
Date:   Wed, 23 Feb 2022 17:03:03 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 01/32] mtd: spi-nor: atmel: unify function names
Message-ID: <20220223113303.4cashhkp624yo5sg@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-2-michael@walle.cc>
 <20220222072314.tk4bw5sngwnk6zwr@ti.com>
 <338bfd692a372450d1210a333994c31e@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <338bfd692a372450d1210a333994c31e@walle.cc>
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

On 22/02/22 08:26AM, Michael Walle wrote:
> Am 2022-02-22 08:23, schrieb Pratyush Yadav:
> > On 21/02/22 01:07PM, Michael Walle wrote:
> > > To avoid name clashes unify all the function and static object names
> > > and
> > > use one of the following prefixes which should be sufficiently unique:
> > >  - <vendor>_nor_
> > >  - <flash_family>_nor_
> > >  - <flash_part>_
> > 
> > Shouldn't this be "<flash_part>_nor_"?
> 
> No, a part name is already unique and its the same "style" as spi nand
> is doing it.

Okay. Fine by me.

I have not went and checked every single function changed. I trust you 
to get them right.

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
