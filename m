Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC34FC823
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiDKXhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiDKXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A8A1DA6D;
        Mon, 11 Apr 2022 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sLkhFTcI2YBtwvymDDK5bdvpkZAX+JWfooBVe6r6vOg=; b=aJRkhFTIG1Cn1/NMU4icHNCgIs
        8xvcWtWSzVYl2gS8PtHZxvI6KmLSoDbHlcRL5GRzxc5xl86MN/0Jv+jQV63mRhWe6fGA2ITbfDjIO
        cGWlxtOWGTwFgeyj0X7vd75Hchfxc3j+mBdqG5G74Zcj0ZhZxbq/tbPpeQ/uZGvVNQXnLR/xA4Wa6
        /n+emQiYiCmWmIouR12mWuIxkD8IKZHvkjDcnmg3Ita5V/t8yzZtaGnAe7p8ZEKjsNU8AIHySoRGu
        KnD7wiz6dTwWLx4uCXWEHyUpUWFXwosL51cn8dthh8+yIee/NBZOpbJSRdYYMu+/iha+Vyuw+h6Zq
        f5h2vPpQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne3Z3-00Ckot-Ts; Mon, 11 Apr 2022 23:35:22 +0000
Message-ID: <0ee86fd8-5e07-3260-4600-48d7522eb00f@infradead.org>
Date:   Mon, 11 Apr 2022 16:35:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Build regressions/improvements in v5.18-rc2
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, sparclinux@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
 <20220411103528.2187797-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 03:42, Geert Uytterhoeven wrote:
> On Mon, 11 Apr 2022, Geert Uytterhoeven wrote:
>> JFYI, when comparing v5.18-rc2[1] to v5.18-rc1[3], the summaries are:
>>  - build warnings: +23/-0
> 
>   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: 'struct page' declared inside parameter list [-Werror]:  => 38:37
>   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]:  => 38:37

Fix here:
https://lore.kernel.org/lkml/20220409151609.3715-1-rdunlap@infradead.org/

-- 
~Randy
