Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4FE4F86EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbiDGSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiDGSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:11:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F322477D;
        Thu,  7 Apr 2022 11:09:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 237I9HxA086717;
        Thu, 7 Apr 2022 13:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649354957;
        bh=ROjjpxK8BAdaQhzZKm7fS9sSF97YsYdJqBc7SXBiyXQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aG6bRaKBLjPYE8/aaIUpzqTnq47aQCUNoupStawPJB/AS5R6BlZU3rynoPt1Afzuf
         m0kgyP9KM9Tq079oVNRCjkjNA5mS5GKigobsLLOv1ADPcDbJS8J2TmvD3rkxJiT5Zi
         1hojg9At0W74tI6iEle50pIoHSaMoqDa+FYMMP3Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 237I9HKm104001
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Apr 2022 13:09:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Apr 2022 13:09:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Apr 2022 13:09:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 237I9Gxo087536;
        Thu, 7 Apr 2022 13:09:16 -0500
Date:   Thu, 7 Apr 2022 23:39:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: jedec,spi-nor: remove unneeded
 properties
Message-ID: <20220407180916.a6b2z7iqqoefsn7m@ti.com>
References: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 04:20PM, Krzysztof Kozlowski wrote:
> After conversion the jedec,spi-nor DT schema to reference other schemas
> (SPI and MTD) and use unevaluatedProperties, several properties are
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
