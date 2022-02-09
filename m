Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F84AF299
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiBINYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBINYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:24:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A6C0613CA;
        Wed,  9 Feb 2022 05:24:22 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219DOE9a021345;
        Wed, 9 Feb 2022 07:24:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644413054;
        bh=IPZn5s6h06YQJiWN8ESgTEq+LTBA3K3eNtW4abfS4ZU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=liRLtWTqQF/0tBWIiJjrukiVL9oylZBM8U//c9DpGlWmYUWpn1ha6pCCVOcqCo6LQ
         5JiUAZGLop/WEVzvljDynBEGovN3voVVr70pVAqXHxmL4MroktVBFhp3o0rbdUIZ4m
         EJE+snAUZ1D3Hp98dafdJDo5nfuShar/f9VqUefA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219DOEUh078755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 07:24:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 07:24:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 07:24:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219DODAY100226;
        Wed, 9 Feb 2022 07:24:13 -0600
Date:   Wed, 9 Feb 2022 07:24:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
Message-ID: <20220209132413.u5staibdmxegrxul@outfit>
References: <20220208182119.24707-1-hnagalla@ti.com>
 <20220209003519.clokfvln7m2deewi@buddhism>
 <c29de523-021a-d139-17ca-3ba8884e50ce@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c29de523-021a-d139-17ca-3ba8884e50ce@ti.com>
User-Agent: NeoMutt/20171215
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

On 19:18-20220208, Hari Nagalla wrote:
> On 2/8/22 18:35, Nishanth Menon wrote:
> > > AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
> > > other in MCU voltage domain. The error output from Main ESM module can
> > > be routed to the MCU ESM module. The error output of MCU ESM can be
> > > configured to reset the device.
> > So what happens to the window for MCU ESM - Is that already open?
> > 
> Yes, the cbass mcu window already opens MCU ESM address space.

Please add that in the comments to making sure there is no confusion.

> 
> I will loop in LAKML as well..

Thanks.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
