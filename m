Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23951593528
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbiHOSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbiHOSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:18:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A62AC52;
        Mon, 15 Aug 2022 11:16:17 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRCFw-1o2px33fJk-00NDs7; Mon, 15 Aug 2022 20:15:57 +0200
Message-ID: <2ecf22d4-3b46-4469-28af-e26f44cf2952@i2se.com>
Date:   Mon, 15 Aug 2022 20:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] clk: bcm: rpi: Fixes and improvement
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
 <20220725081838.nd2tsjcw4uiapl5k@suse>
 <c7fea2e5-eeb7-cd66-dc42-9fea98cfda9d@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <c7fea2e5-eeb7-cd66-dc42-9fea98cfda9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tYrByavhS5DN9ADGYh/BJj7BmbkVJN/qbkuasfPCAd6ke5CsPmI
 Nn6TbD2ij+Kd8F6HnOR7xKAq1W89cDEBR9mKH+GHp5lwoiL7ED24ahXshrvEq57ACwVmHX/
 VlVCYmlpZJ8b2P9vWtqiJOSTI6HgMKVIJbVOj3HbdLsgi+EfoLJg27JO08UZ9DylTn1m0YS
 bSr54wKHKgorefqEfhlUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HWcY4MT2eKM=:Jy7QyZ8oSsYX903pK4KB7f
 RLdCKmK9Fw7vhpthtqIXP/hrj6jgandfNQadD7GABv+6gbl1+uy5xJm7f8SgQQOekoZ4mS3L5
 DKCTRmiM2lakD96Jf03bP30SD6R2l8e7b9X3plOBe4ahmb23fXIw5XY7WE4VEMN2e1fQbqWHe
 tCVDX6jcdMTMWqBg/ZGXCzpjmfvzxbmZLpb5TDj8ILnYXca3HJCHpNV6rUvwGlpI6QWZX/agj
 LiG6K0IrQsfkUA3/DDGgssWFFAmo41bYYAFMvhU5evPkfgxQTxyXRnrB32HiP46AHm3ZRmsx4
 xhvotMkGq26WpBzcBRoqf7/Y+a/Lj5AB4p4DFszL1/KD94t2U5Mu2MRzbJoKruNAnl+Mck8PM
 zp8y0cjD4qYwp0Wm2CUxVK8T0itsk/mlof8q1cHPy2RpvLoESqESQBzqAg9wyIEqTU1OwS+dQ
 kS2H8FigIAStQzK1hAlq1EtwJGTSAV6IF8JCd1jhATiLAgGnmQEhjoqj+FpiQ7lpuI7VbFi6J
 +x0Ob7gyGUZ7xqjhSZhzpfq3VSTnILY77skqe/tKdF1Uso5OI2ebi3rbE/ha47VJIc96kPBt6
 ByDj/cP0Fj3wUYdyBzfNT1ofg+TUIf7OpvHjdVYxVLpIJsFtUbDF+802XRL+FEkcM9cbpWMNF
 GCxoJKSkG61wPSRIvlKaJcSmxpguVBtxPJh/068yuB3gLOBwYk+1R9CYJcp0MMWFdLxpZdq/a
 vZ5I2imy7U4jGOVFLMMRapbKW5z7MDfr+oVdab7CS4Cj9s0eUEsrvt8F9Is=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am 04.08.22 um 19:58 schrieb Florian Fainelli:
> On 7/25/22 01:18, Ivan T. Ivanov wrote:
>> Hi,
>>
>> On 07-13 17:49, Stefan Wahren wrote:
>>> This series tries to fix and improvement the Raspberry Pi firmware clock
>>> driver. This mostly focus on clock discovery mechanism.
>>>
>>> Just a note patch #3 depends on patch #2.
>>>
>>> Stefan Wahren (3):
>>>    clk: bcm: rpi: Prevent out-of-bounds access
>>>    clk: bcm: rpi: Add missing newline
>>>    clk: bcm: rpi: Show clock id limit in error case
>>>
>> Maybe is little bit late, but still :-)
>>
>> Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>
> Stephen, can you apply those patches? Thanks!

should i resend this series?

Best regards

