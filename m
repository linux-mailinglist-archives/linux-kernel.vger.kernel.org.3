Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C55A4288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiH2FsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2FsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:48:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB145F79
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=56hXlcs3L8noEZaq0D++JGyo405eyS4B1rqngFXbi0g=; b=atQiZ3KZOL7dDxpdSxCfEh34aw
        KmadyXf5X0BqZiF1E7+KL/jBcT0FGj3ljMr5oM+bV3yxcw4CIdAXnVvJMH7KT+ZTdjq/nO+dslf2H
        UeBn8ZLOW1bl929fB4GGgZmJvBAEPGBODEc+BwFdA2ZeMsd/PHYbzXgUW1T4c6ALTWLzHs2Vxd59c
        wo/CJ8oUvIR5LHSgryRd0yZSyhGR71zuotypxXEcwuvoOn0Xjgl2+fjtMoLyCKReLgiVafzLfsTXf
        js37+4NFvs3OousBFv6c4Wanonb3Elwg67zoOHPWgmXlfA3QzSC+tXp28ptPCA7nqhONW2Lj4sI3L
        Jj4edYww==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSXct-004zow-L3; Mon, 29 Aug 2022 05:47:59 +0000
Message-ID: <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
Date:   Sun, 28 Aug 2022 22:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: thermal driver patch
Content-Language: en-US
To:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <DL9RGR.8W3XFSCFFYXI2@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/17/22 03:39, Steven J Abner wrote:
> Didn't actually create patch, for you to do and review:
> 
> for drivers/thermal/thermal_core.c:397 :
> 
> static void update_temperature(struct thermal_zone_device *tz)
> {
>  (void)tz;
> }
> 
> stops kernel dmesg of unused function,
> from include/linux/thermal.h:429 :
> 
> static inline int thermal_zone_get_temp(
>  struct thermal_zone_device *tz, int *temp)
> { return -ENODEV; }
> 
> If this is a bother, sorry I troubled you.
> Per 'Do I have to be subscribed to post to the list?':
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to your posting, please.
> Steve

I haven't seen any such messages, but if this is still a problem,
please post:

a. the exact message(s) [copy-paste]
b. how to reproduce the problem
c. what kernel version is causing the problem

Thanks.
-- 
~Randy
