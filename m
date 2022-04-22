Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327F50B47F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446317AbiDVKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379948AbiDVKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:00:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECC53E2B;
        Fri, 22 Apr 2022 02:57:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M9vmvL061406;
        Fri, 22 Apr 2022 04:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650621468;
        bh=6Wwr2Xv2WPiZwqXROFSGphAFgO9Z5a8jZSXkMWXZLgA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gxZCmim2tpk9ye9x5ykxDZ1QH+jwaU3KoMrFp3C2AYp5Vk6s+NPkI/lh4hpEpybGy
         nDK4VzwaanNctVIfybZXwqlEOSVuKUtEekYpf30PRBaqgnwNUgLBI4IkV/7I4iCcnQ
         v1K+fr/fA25L3kM/EOVkkzQ4Jvz3WXJPHZA1dAOs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M9vmKZ038954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 04:57:48 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 04:57:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 04:57:48 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M9vipw009319;
        Fri, 22 Apr 2022 04:57:45 -0500
Message-ID: <9c37471b-37e3-d47d-79d8-05a62fb9b520@ti.com>
Date:   Fri, 22 Apr 2022 15:27:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND] arm64: dts: ti: k3-am642-sk: Add DT entry for
 onboard LEDs
Content-Language: en-US
To:     Aparna M <a-m1@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <grygorii.strashko@ti.com>, <nikhil.nd@ti.com>
References: <20220420072952.3509-1-a-m1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220420072952.3509-1-a-m1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/04/22 12:59 pm, Aparna M wrote:
> AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
> gpio leds.
> 
> Signed-off-by: Aparna M <a-m1@ti.com>
> ---
> 
> This patch is dependent on:
> https://lore.kernel.org/all/20220223174215.17838-1-a-m1@ti.com/ 
> 
> RESEND patch has been rebased on top of v5.18-rc2.
> 

This will have to wait till dependencies hit mainline. Cannot take it
for v5.19 merge window


Regards
Vignesh

[...]
