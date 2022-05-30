Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DD537818
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiE3JrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiE3JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:47:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1FE6593;
        Mon, 30 May 2022 02:47:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 330FE1F42772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653904023;
        bh=TscsrSniRUbTF2lS5EjYkm9gJZ0Gk4By33O4vJgUvvk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=il99dXitmCOx0A/VyZZgaOg/pMyn3K9JWvwUiQJ80FitEn4Totge5VEgd5QM6PiHm
         Ofum2lXAOT6ZkGd8iTUrvCUA8L0eYcWD+A4NF858gkt72XXcf0KeBLqKqmAohKMTgz
         kVHoGOiLJtHCsCn1jKLT4amWAGjjrTxYSO54cl/We8FeI+ww8NEiyoe25wUsUPwQKm
         6NZY9VVIyvwU3belzrLQZAJM+WMC+7zV5XLJx+Yg18rGaKj8NFhDy8t7q+mhwefEto
         4MUajxomeppisUKDJkcu6uN14/o5ESv5DiKBTFWm5LRQ9WJPPZNixL60ms9FW98n5k
         A6aOhdL1o/b7Q==
Message-ID: <e9cf5b0c-cb11-f68b-3130-4fa6243468da@collabora.com>
Date:   Mon, 30 May 2022 11:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/3] MediaTek Helio X10 MT6795 - MT6331 PMIC Keys
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     dmitry.torokhov@gmail.com, matthias.bgg@gmail.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
 <20220526110827.GC5138@localhost>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220526110827.GC5138@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/22 13:08, Pavel Machek ha scritto:
> Hi!
> 
>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>> I am upstreaming more components that are necessary to support platforms
>> powered by this one apart from a simple boot to serial console.
>>
>> This series performs some cleanups in mtk-pmic-keys and adds support for
>> the MT6331 PMIC's keys.
>>
>> Adding support to each driver in each subsystem is done in different
>> patch series as to avoid spamming uninteresting patches to maintainers.
>>
>> This series depends on another two series series [1], [2] named
>> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper" and
>> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration"
>>
>> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> Please cc phone-devel with phone stuff...
> 
> ...and thanks for all the work. I guess we still don't have an android
> phone with basic phone functionality working on mainline...?
> 
> Best regards,
> 							Pavel


Hello Pavel,

I'm sorry, I've been sending a lot of things lately and I forgot to add
that list to the Cc on some series...

Btw, we don't have any MediaTek android phone working at all on mainline:
the one that I'm in the process of upstreaming would be the first one ever,
the hope is that doing this will encourage other developers to do the same
with other platforms.

Speaking of them all... I don't think that there's any retail smartphone
that comes with Android having any phone call ability... I'm aware of some
Qualcomm smartphones being able to use mobile data and SMS, but no calling.

Unless anything changed and unless I'm unaware of recent developments.

Aside from that, MediaTek chips should be a little simpler in this regard,
so I think that we can (and I would love to) get that working, so that
smartphones can still be smart -- phones -- on mainline as well... but I
have a hunch that this will require quite some time.

Regards,
Angelo
