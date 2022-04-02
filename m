Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F34F0119
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354668AbiDBLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiDBLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:33:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B14A3E4;
        Sat,  2 Apr 2022 04:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B974B8075A;
        Sat,  2 Apr 2022 11:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C65C340EC;
        Sat,  2 Apr 2022 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648899092;
        bh=hHiaN9oQ8ExvCLuAqHVX8GhGvr0JDcc8KoNUT7YzQeQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XKuIRDL43MpBpxr/RptIaKZKJR6EGeGWNkYtaNMCtIGwGXVqzA5i57XwxM54tVZ2N
         SjEfIUs8wDBMf81/FJiWI633TR1Bqh5IbwxY44eD1obDH5wSpDPvoGug1iLEbJ9zl9
         dF1SrQrFYf4IhpClRUs2MejERVXmb/nr9GW+YaBI2kfjIx6xNg5XE/DEuHkTwCKDZb
         O2itFS38dngcTS/XWun70RifGDQFMBuryMyU/DyVxwpJ040NeR7+L9eAfaXo8lFnrU
         4E+xDrArOnbh4T5cLQkNUSgcuoNZyvBWF1OM+aRt90V9CuznkyCNGqjf2JwyKD3IEg
         jiimG0s8JPYjw==
Message-ID: <ac0e3336-f9eb-def9-68ea-ab49e2c467a1@kernel.org>
Date:   Sat, 2 Apr 2022 13:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: devfreq: mediatek: add mtk cci devfreq
 dt-bindings
Content-Language: en-US
To:     Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-2-jia-wei.chang@mediatek.com>
 <bf418e08-2e32-5e61-abd8-abb0d8f5c080@canonical.com>
 <13482b1b4244df5c0c0a4d6a60cdb2a7ba88500a.camel@mediatek.com>
 <aa34eccf-ef08-4a8f-7a6c-7fbd05bd54b6@kernel.org>
 <126e0905c2eb9f22a0be46dd7aa8ac891622346d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <126e0905c2eb9f22a0be46dd7aa8ac891622346d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 15:39, Jia-Wei Chang wrote:
>>>>
>>>>> +
>>>>> +  operating-points-v2:
>>>>> +    description:
>>>>> +      For details, please refer to
>>>>> +      Documentation/devicetree/bindings/opp/opp-v2.yaml
>>>>> +
>>>>> +  opp-table: true
>>>>
>>>> Same comments as your CPU freq bindings apply.
>>>
>>> mtk-cci-devfreq is a new driver and its arch is same as mediatek-
>>> cpufreq so that the properties of mtk-cci are refer to mediatek-
>>> cpufreq 
>>> bindings.
>>> operating-point-v2 is used to determine the voltage and frequency
>>> of
>>> dvfs which is further utilized by mtk-cci-devfreq.
>>
>> "operating-point-v2" is understood, but the same as in cpufreq
>> bindings,
>> I am questioning why do you have "opp-table: true". It's a bit
>> confusing, so maybe I miss something?
> 
> Yes, you're correct.
> "opp-table: true" should be removed.
> I messed it up.

No, I think I was wrong. The opp-table pretty frequently is embedded in
the the device node itself. The operating-points-v2 references it.

You don't use it in the example, but it might be a valid usage, so it
can stay. Sorry for the confusion, it passed some time since I looked at
OPP bindings.


Best regards,
Krzysztof
