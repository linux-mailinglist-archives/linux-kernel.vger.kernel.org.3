Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4844AE738
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiBICmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiBIBY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:24:28 -0500
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 17:24:27 PST
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24131C061576;
        Tue,  8 Feb 2022 17:24:27 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2191Isei020915;
        Tue, 8 Feb 2022 19:18:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644369534;
        bh=3a+B7JP/4/Q6C2TXtYThs/GEgNbQaog5TxPJvRV1wDM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DbB07awvfxbuEhk6cEYEtMNwgfE6l127Lkbduj1rZnJyXpIDDwA+8AwXI7LVjlh6q
         obijIGeTfJeMzDnqKYLgw4aI0mNCBQrai2ou1HYZHa+4VBKdOSHa+nD8Dg4wbmyJId
         A5oFEKFbPtFVCqHSSpv1AhHdG61+aaCGFN1LFg5A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2191IssU051397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 19:18:54 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 19:18:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 19:18:54 -0600
Received: from [10.249.39.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2191IsDS106713;
        Tue, 8 Feb 2022 19:18:54 -0600
Message-ID: <c29de523-021a-d139-17ca-3ba8884e50ce@ti.com>
Date:   Tue, 8 Feb 2022 19:18:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>
References: <20220208182119.24707-1-hnagalla@ti.com>
 <20220209003519.clokfvln7m2deewi@buddhism>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20220209003519.clokfvln7m2deewi@buddhism>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 18:35, Nishanth Menon wrote:
>> AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
>> other in MCU voltage domain. The error output from Main ESM module can
>> be routed to the MCU ESM module. The error output of MCU ESM can be
>> configured to reset the device.
> So what happens to the window for MCU ESM - Is that already open?
> 
Yes, the cbass mcu window already opens MCU ESM address space.

I will loop in LAKML as well..

Thanks
