Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A459FB42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiHXNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiHXNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:25:35 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102953022
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:25:33 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QqNuo0vdXtUbyQqNuoT03y; Wed, 24 Aug 2022 15:25:32 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 15:25:32 +0200
X-ME-IP: 90.11.190.129
Message-ID: <c14607d5-337c-3e75-2b95-720553f40282@wanadoo.fr>
Date:   Wed, 24 Aug 2022 15:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Conor.Dooley@microchip.com, Daire.McNamara@microchip.com,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rtc@vger.kernel.org
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
 <c74a42f7-7d9a-6b52-85b2-d87dacd91be6@wanadoo.fr>
 <YwYZZWu3gOBIPJeI@mail.local>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YwYZZWu3gOBIPJeI@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2022 à 14:28, Alexandre Belloni a écrit :
> 
> BTW, I thought you actually tested your changes on the other patch I
> took, not that you were doing a blanket conversion of the subsystem.
> This is the kind of info that must appear in the commit log. I would
> definitively not have taken the patch.
> 

Ok, noted for future contribution.


In fact I first sent only one patch to see if it got some interest for 
such transformation.
I only sent some other after your Ack.


Nothing is never trivial, but such patches looks fine to me.
It saves some LoC, reduce the size of the .o and slightly saves some 
runtime memory.

And unless, I missed something, the order of operation remains the same, 
both when resources are allocated and freed.


Why wouldn't you have taken such a patch?
(just for my understanding and in order to avoid spamming others with 
useless/risky stuff)

CJ
