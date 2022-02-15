Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A04B78D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiBOT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:28:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiBOT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:28:03 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC249AEF26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:27:53 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJRlSu061142;
        Tue, 15 Feb 2022 13:27:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644953267;
        bh=Qkwjf57xlH5V3afr/StOorltpiLph87zUCxTofDyKO8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PTtToDR6zc9xbtTIsyuhLQGYe6n+Usd8z7iYI0XPiGTTYmd1zVhtPPjBUVn7EhSwz
         9dcB1wogg/l5yxOXNQT09MpndqWen2T0JFky2ZNlKC9xLk9qAivtFYNngaIdYnDpdO
         JXB1M1nX1uQN2kzxJ43F7lYDHvumS/yA1XqKvRPc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJRlTK116144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:27:47 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:27:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:27:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJRIdr094655;
        Tue, 15 Feb 2022 13:27:18 -0600
Date:   Wed, 16 Feb 2022 00:57:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 14/14] mtd: spi-nor: renumber flags
Message-ID: <20220215192717.pxk33eyi3skg2lqz@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-15-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-15-michael@walle.cc>
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
> As we have deleted some flag, lets renumber them so there are no holes.

I was expecting you to forget about this and was about to comment this 
in a previous patch. Good thing I looked ahead to double check :-)

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> 
> Signed-off-by: Michael Walle <michael@walle.cc>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
