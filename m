Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4DF4E7C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiCYTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiCYTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:52:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED86720095D;
        Fri, 25 Mar 2022 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u6K+7R1pK5zP+BGmPEHsLn6FbAvQwD9eSfF4itZFiuo=; b=EWFFJDi/JWX0UQZymV8VNrBzaU
        /S4VJYVDGFd0nX8ADN0WGBOQd83IFpHQ6R1erZ05Oqkef1QmDedMCtvhpx0hvOCHF3tX9mYFuH95C
        qNp1atu20cyUcuWwUSk798riaQFGErs+xqdvO1zYFiHEaFy9kZELwcC3XI8vk6JQgeRlreV3Grebb
        hWq1rySXL3L8zVnwMyLO7fW536DzEr+bIY01OUg2/cZVcAN+aZ3bc5OMYRHvsMCy4vCjT1C+dPphh
        CFWqwvRB3MyfDPyhWdqLz+XZFTSxh6J6FruWR1eBCeeIxUm31qj4NJ+KqrTqL5JxRqBRql4s894Dc
        P6PPNtSQ==;
Received: from [179.225.152.33] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nXplq-000589-A9; Fri, 25 Mar 2022 20:38:50 +0100
Message-ID: <34e5d700-7ff4-666f-9404-1fe3fe1abc7f@igalia.com>
Date:   Fri, 25 Mar 2022 16:38:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation: Fix duplicate statement about
 raw_spinlock_t type
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@gpiccoli.net,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220321144133.49804-1-gpiccoli@igalia.com>
 <87r16peslf.fsf@meer.lwn.net>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87r16peslf.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 16:32, Jonathan Corbet wrote:
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> [...]
> For future reference, a far better changelog would have been something
> like:
> 
> 	Remove the duplicated sentence from locktypes.rst
> 
> Thanks,
> 
> jon

Thanks Jon, and feel free to change that when applying in case you
prefer, it's a good choice of words, better than mine.
Cheers,


Guilherme
