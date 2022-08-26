Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC715A26C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiHZLW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiHZLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:22:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13DDAEE5;
        Fri, 26 Aug 2022 04:22:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27QBMXjO053966;
        Fri, 26 Aug 2022 06:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661512953;
        bh=ePfG0EpOr92S+PbFmQ5kcqb6z6CZ0FlDegmJSjIPXS4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=X1jqprEr5Ge3M5OAjXkoOT61Kl+0cQDUwmmHg9e8CfjE2SWtIZycC5Gz/trZ+j2BH
         PCjYT+LI5MupgxV300uEAbu06/UJM8RSb8+mxND9RsegQOWKDxZwUB75LBEVCFaJPT
         HlZik/MSp9FALpDmBb15ackyCrY8K5tbFyBWZgpI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27QBMXKf032353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Aug 2022 06:22:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 26
 Aug 2022 06:22:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 26 Aug 2022 06:22:32 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27QBMSws052231;
        Fri, 26 Aug 2022 06:22:29 -0500
Message-ID: <fd8bdb08-5ed3-8d97-c394-0cab5460df1c@ti.com>
Date:   Fri, 26 Aug 2022 16:52:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for J784s4
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-3-a-nandan@ti.com>
 <CACRpkdaktinAJveF_nH9NYYk7mAvnResRzoyuVDVWpwKKq6JOQ@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CACRpkdaktinAJveF_nH9NYYk7mAvnResRzoyuVDVWpwKKq6JOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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



On 26/08/22 13:59, Linus Walleij wrote:
> On Fri, Aug 19, 2022 at 9:01 PM Apurva Nandan <a-nandan@ti.com> wrote:
> 
>> Add pinctrl macros for J784s4 SoC. These macro definitions are
>> similar to that of J721s2, but adding new definitions to avoid
>> any naming confusions in the soc dts files.
>>
>> checkpatch insists the following error exists:
>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> However, we do not need parentheses enclosing the values for this
>> macro as we do intend it to generate two separate values as has been
>> done for other similar platforms.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> I guess you will merge these patches together?
> Tell me if you rather want that I apply this one patch to the pinctrl tree.
> 

I will the patch via TI K3 SoC tree once other patches are in good shape.
Thanks for the review!
-- 
Regards
Vignesh
