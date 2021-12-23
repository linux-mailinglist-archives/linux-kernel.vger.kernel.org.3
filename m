Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257047E1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbhLWKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:51:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47012 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347737AbhLWKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:51:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNApbXx041847;
        Thu, 23 Dec 2021 04:51:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640256697;
        bh=Zq03om+WgTyTM3mOlXkoW2vhdZRGGOFXUFgr+p1Bnhc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u8dmrcuMBc3rf/B7jal6ENoqkae2iQF5l+gtcHeAxEPSqOzSTeNBw/ZVZXMPWcxoG
         NnNwHEIM97FsKhff5e4DnVYvbn7n/rBhIG8euMGTVqU0EzIYVaoL+WKmNMxCvw2UcX
         K42iKv0+J1YTHGzLPI0O/MB1nIbkeOjquIjt4BDM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNApb7e105056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 04:51:37 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 04:51:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 04:51:37 -0600
Received: from [10.250.235.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNApXSr086780;
        Thu, 23 Dec 2021 04:51:34 -0600
Message-ID: <60e9a3ef-f717-bd2a-b722-01942e184fd0@ti.com>
Date:   Thu, 23 Dec 2021 16:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL v2 2/2] arm64: dts: TI K3 updates for v5.17
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Olof Johansson <olof@lixom.net>, SoC <soc@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>, arm-soc <arm@kernel.org>
References: <20211223094040.15349-1-vigneshr@ti.com>
 <20211223094040.15349-2-vigneshr@ti.com>
 <CAK8P3a1s7Ekhvwvt0DtndxwkzMwCD-2Y7Va58T_8gDdL0vZNVg@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAK8P3a1s7Ekhvwvt0DtndxwkzMwCD-2Y7Va58T_8gDdL0vZNVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/21 3:20 pm, Arnd Bergmann wrote:
> On Thu, Dec 23, 2021 at 10:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Hi,
>>
>> Please pull the device tree changes for TI K3 platforms for v5.17.
>>
>> Please note:
>> This adds a dtbs_check warning due to missing YAML binding for pinctrl-single compatible.
>> There also a checkpatch error for complex macro usage in dt-bindings
>> header defining pinmux marco which is harmless.
>>
>> v2:
>> Moved aliases from k3-j721s2.dtsi file and trimmed the list
>> as per Arnd's suggestion
> 
> Sorry, I should have been clearer about what I asked from you. I have already
> pulled the first version of this branch, and a lot of stuff on top of
> it, so I can't
> easily replace the contents with a new version.
> 

Oops, I did not realize that v1 was pulled.

> Can you send just patches for the difference between the two versions so we
> can apply that on top?
> 

Sure, will send delta patches in a follow up PR. Thanks!


Regards
Vignesh
