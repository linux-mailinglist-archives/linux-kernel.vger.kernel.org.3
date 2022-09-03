Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772E5AC0E2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiICSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiICSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:42:14 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229731DF6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:42:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y18so3762705qtv.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=J6XE1O2ZWCpY/clzvoN88TJg9PZ0eb26xbhiVvKP4lo=;
        b=ZLRqn/c0+rzTsE0ll2clObgAAimBVEPP9MBpfugRmWtY5mYL5FNjYMzFbDhaVOvk4T
         ee4RwcJLQ0DN4yFn7iFLl+BZZyGL0FQizewfH+HGkeRu7msjQCNQ98DgC4h8tNwX1em/
         KQw6LehBXLAFtmcDQUNJ+iX0dD2D3QBGbzpgbjXmmiJxZbhh+2GsXq2aYwIN3/UZQvIX
         y0Nl8CMK1TEXvQ/QsnQgPP6Iw3XZW1clbatqKuGfdHIQUEznNwz+JGDcMlqKOCxNgxbm
         jH6k1U6aRneVWVKg3nLs7TJlwG7WAv3PtJUdRA/KGJmmHvoBtFmitCqAZv4KkJjjD/DB
         prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=J6XE1O2ZWCpY/clzvoN88TJg9PZ0eb26xbhiVvKP4lo=;
        b=1W2DYTF/2lKtlo/ETFNYWm84g5Fi1KYfPeUngvr3CIULI4tXsANWsT7GAkA6iZPAwv
         Yn56QFcEnk5NczGS/NgFwZ13Yp0KVjbRqLus/EHJZmT1xfZD8LlLkfixCmYLteci178L
         5V0lLAUz2+E5bEYRHdnulYpXmYGpWqx+dJ6KHmu/kxCNIDKhjVPMn7suUvPyGD4MKjEH
         mESdVFwqRQxIn+II/BgYluypxvvkSmTxsBMIuUJOfykc8DWm7aEfzoqKDGDWDVBB0roS
         g4Z9b6DOUdrkovkTFRv5WPyXviOFXcb+VUltRFjxH8Db7R0ZRhmqDTCf/FkLe8bjMvqV
         5I3A==
X-Gm-Message-State: ACgBeo3YjIJ1pitX6KWkT3MXGko+p05gz6Tvfwxaha7zr5Yfzn0zeHuz
        AExHIq53i57weCoSaxX5EyM=
X-Google-Smtp-Source: AA6agR7HxzIwTJ9RWwG3gXmLje2tPCj6V0jw/52dT39Mb7QmN934e3u3R0eV3Zbu5KvY9JGCDDU+hQ==
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id f1-20020a05622a1a0100b00343310dfedfmr34464267qtb.622.1662230531251;
        Sat, 03 Sep 2022 11:42:11 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o12-20020ac841cc000000b003430589dd34sm3390388qtm.57.2022.09.03.11.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 11:42:10 -0700 (PDT)
Message-ID: <cdde4e0a-dfd7-51d7-0800-7ac124c34ff7@gmail.com>
Date:   Sat, 3 Sep 2022 11:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/2] mtd: rawnand: brcmnand: Glue driver Kconfig entries
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        William Zhang <william.zhang@broadcom.com>
References: <20220711222323.4048197-1-f.fainelli@gmail.com>
 <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2022 10:55 AM, Florian Fainelli wrote:
> On 7/11/22 15:23, Florian Fainelli wrote:
>> Hi all,
>>
>> This patch series allows for a finer control over the BRCMNAND driver
>> glue driver selection such that it defaults to the various platforms
>> enabled in the configuration file.
> 
> Miquel are you able to review and apply those patches if satisfactory? Thanks!

Ping?
-- 
Florian
