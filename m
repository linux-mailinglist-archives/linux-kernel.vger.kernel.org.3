Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2B4C1145
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbiBWLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiBWLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:30:52 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A48F99A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:30:24 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBU6l0119499;
        Wed, 23 Feb 2022 05:30:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645615806;
        bh=8iJFbuoO/1UTlyrGebm94tvMfHSgMwxLXJIsLPvUJOU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bKYjk+cDLv/VzLu5Yd4T/ISZYnkQhp/ZMu38B4s9ls486So0h9Rl+zpz76Kq4CoGo
         rewbWvoqnKbYED/Z0mGGbIp8yYI1SO09oa4bJVD9Vg7FFdXQSWwxvNzFd+FUB82zoa
         BZ7cn4Us6AQvC/I2vX+gFf5MNWngy22rJdUYyPLE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBU5XS115414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:30:06 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:30:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:30:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBU4CM050742;
        Wed, 23 Feb 2022 05:30:04 -0600
Date:   Wed, 23 Feb 2022 17:00:03 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 00/32] mtd: spi-nor: move vendor specific code into
 vendor modules
Message-ID: <20220223113003.cuf7e6kgvjwsukzy@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <d45daacc-8372-9b2d-019e-5d383db4fa57@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d45daacc-8372-9b2d-019e-5d383db4fa57@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/22 08:59AM, Tudor.Ambarus@microchip.com wrote:
> I would like some tested-by tags if possible. At least with a micron and a spansion flash.
> I think I have a micron and a spansion somewhere, I'll try to do a short test too.

I still have some patches left to review in this series. But in the 
meantime, I have tested it on a Micron and Spansion flash. Ran through a 
few Erase/Program/Read cycles.

Tested-by: Pratyush Yadav <p.yadav@ti.com> # on mt35xu512aba, s28hs512t

> 
> Cheers,
> ta

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
