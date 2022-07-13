Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60765573DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiGMUk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiGMUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:40:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8E3121C;
        Wed, 13 Jul 2022 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Sr2i2yEX+/2BwsId6Bcn2NLnCYiWYr2wbDbG9kllWJk=; b=I7GAMX/0/EYmFaWn8RIAkn1nbD
        Sdi5LA+dQ5nfhcXFXc6V/2qSX50sKnh9z7XQPhaRLYbcW+ndFo5Fkm8zOrGiBqpV4kzZhTeCE9KWA
        j7JWICYGQmNKqT419+FwrCCbM23lxYEDDRgY0O9fvlFDgsmsXRsY+ERVju/VAUU/lBGY806A7NHep
        UcoyrKA7ipVsXfKuRfFyu5q9jCrkwv86wljlPN1+Ia9VeeE8TJhehj0ualm1TKJ64ahqVGRwQIsR/
        L/X4xTHW57KH9th3N9v6hMv1yBxyNbZKnpWTy1IKRM33u/BonP9xnjl3xUV+gakw3aV6F7Ev7s94k
        1BvnDRBw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBjA9-007kUy-7H; Wed, 13 Jul 2022 20:40:49 +0000
Message-ID: <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
Date:   Wed, 13 Jul 2022 13:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 13 (UML, apply_returns)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-um <linux-um@lists.infradead.org>
References: <20220713223328.07016b70@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220713223328.07016b70@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/22 05:33, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220712:
> 

UML for x86_64 defconfig:

/usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
module.c:(.text+0x416): undefined reference to `apply_returns'

arch/x86/kernel/alternative.o is not being built for UML.

-- 
~Randy
