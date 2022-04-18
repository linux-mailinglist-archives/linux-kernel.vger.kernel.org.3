Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26A7504F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiDRLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiDRLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B61A076;
        Mon, 18 Apr 2022 04:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00669B80E6D;
        Mon, 18 Apr 2022 11:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA83C385A8;
        Mon, 18 Apr 2022 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650280391;
        bh=wwE2D7Hcj5fftw+S9d3Tubx9RVx84/kTA+8TdD2y+QQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BzsRy9QHW20BPD2GJc81aJi3R2/go2onQvbzoPWGcEcF9WaVazkwFFRYfd5dzxgf6
         JNHDDxdjDMuXxYnJzFPaHVxeRVlySOr7AbZXW0kILvm5zoS2KYnL9s1ZeE+LsZEkqn
         5eORYfsQ8HXS2m3ZbJFiHN33QyPk42cMQh3ETaJfLUmIgttdE4au83CwoelXTF/LTx
         DAYMluTVHB6wZ0G6Ac2MF1QmkTQX8TfQEpFVcZIyabO+MjdYaSbnGo4Jl9n+/Od5bb
         ymTpWooG4/9oFbmzFAzifW5/RS7VbY+EjMN4wfaOipVFtyJDF8KK/3VJVWyotdMAcn
         dJFuo+3kCkSVw==
Message-ID: <de9b0114-23b5-04b4-86b3-0d393441a267@kernel.org>
Date:   Mon, 18 Apr 2022 13:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220319204628.1759635-1-michael@walle.cc>
 <20220319204628.1759635-7-michael@walle.cc>
 <CACRpkdbrw7Hjt9mB9pr_iNsGi71g_d8BGhpT_ih1RVgKJ5U0qQ@mail.gmail.com>
 <e02e22920ffe23b49237c0c1379e888b@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e02e22920ffe23b49237c0c1379e888b@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 10:19, Michael Walle wrote:
> [resend, use Krysztof's new email address]
> 
> Am 2022-04-18 01:41, schrieb Linus Walleij:
>> On Sat, Mar 19, 2022 at 9:47 PM Michael Walle <michael@walle.cc> wrote:
>>
>>> Convert the ocelot-pinctrl device tree binding to the new YAML format.
>>>
>>> Additionally to the original binding documentation, add interrupt
>>> properties which are optional and already used on several SoCs like
>>> SparX-5, Luton, Ocelot and LAN966x but were not documented before.
>>>
>>> Also, on the sparx5 and the lan966x SoCs there are two items for the
>>> reg property.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>
>> So is this single patch something I should apply to the pin control 
>> tree?
> 
> The first five patches will fix the validation errrors once the
> binding is converted to the YAML format. So, do they need to go
> through the same tree?
> 
> Also as mentioned, there is this pending series [1] which is the
> reason I've converted the binding to YAML in the first place. So
> at least the first patch of this series will have to go through
> the same tree as the YAML conversion patch.
> 
> How can we move forward here? Krzysztof, maybe all of the dt
> bindings patches can go through your tree and I'll reposting
> the second patch of [1] afterwards?

I think you got all necessary acks for this pinctrl bindings change and
the dependency ("add reset property"), so both can go via Linus' tree.
That's preferred.

DTS patches goes through your SoC maintainer tree.

At least this is the usual scenario, but maybe I missed here something.

Best regards,
Krzysztof
