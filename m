Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4151398A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbiD1QTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiD1QTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:19:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AE29C8B;
        Thu, 28 Apr 2022 09:16:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23SGG7Zx098167;
        Thu, 28 Apr 2022 11:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651162567;
        bh=Ag61T7joQzV4UlYN1HBLzYfjn+vFXY6sr4UJyEQXhyg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=c1G4Kq/jNnrKULsMA5o1XRJPXnIqQ2DfFYQaRIr7fcbrg9ESXeziGEUU1pPRDQ/mL
         i/SZvgFH6B96g1YxQgbzzt4GJRotj2FHJ3U3eDUSDDgG0OdYPR2b5QozEsWpyQAPis
         CERs9GdqE5ALpGEzwlQdJQirNZ54iBoEFSMOshdQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23SGG7T1017811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Apr 2022 11:16:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Apr 2022 11:16:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Apr 2022 11:16:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23SGG6Uf017876;
        Thu, 28 Apr 2022 11:16:06 -0500
Date:   Thu, 28 Apr 2022 11:16:06 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62: Add SA3UL ranges in cbass_main
Message-ID: <20220428161606.tyewwckfkipv6lte@bryanbrattlof.com>
References: <20220412075008.10553-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220412075008.10553-1-j-choudhary@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 12, 2022 thus sayeth Jayesh Choudhary:
> Add the address space for SA3UL to the ranges property of the
> cbass_main node.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Looks good to me Jayesh!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
