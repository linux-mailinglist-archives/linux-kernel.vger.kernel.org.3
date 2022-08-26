Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED605A30CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiHZVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:07:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37ADD76C;
        Fri, 26 Aug 2022 14:06:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 997A87C0;
        Fri, 26 Aug 2022 21:06:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 997A87C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661548018; bh=G7fZxG3wR/mWq0VmrJmHPyenRxqdQCZ6CdJ0WO+15eM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k5yVMbCJeUyPl4YqTiJm7nxEBoZ9IEg2JBldgK5NlRbz8wrKbjdt/f0paAHxCsjQR
         q+rLPHZYa/RAP7Yr4U//QM7e3mxbmecsYRZ4CMqoGpMCGkKN65OW40yOuFUYi3ZGqV
         mz8ESuGhsQBow247mvMXSxdMUPzIL64QfdUnQ502PA5z0OHGM+IWuQU88+bpvVaIJK
         RidppQCuIxT2yv4EMfd88md0EgERLP59VCDCeokkfXTozQRi3LvFaCWx/+XNjdKpyZ
         w39q3p/672+pRpZkusDbYtNq3iveuV2hC2u1wm0Et4SR6UTca1hqiAf6+wt2tthdLS
         vjCcfAy0LcthA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>, menglong8.dong@gmail.com
Cc:     sfr@canb.auug.org.au, bagasdotme@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
In-Reply-To: <20220826135839.39c7711f@kernel.org>
References: <20220826160150.834639-1-imagedong@tencent.com>
 <20220826135839.39c7711f@kernel.org>
Date:   Fri, 26 Aug 2022 15:06:57 -0600
Message-ID: <874jxyu32m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Sat, 27 Aug 2022 00:01:50 +0800 menglong8.dong@gmail.com wrote:
>> From: Menglong Dong <imagedong@tencent.com>
>> 
>> Stephen Rothwell reported htmldocs warning when merging net-next:
>> 
>> Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
>> Invalid C declaration: Expecting "(" in parameters. [error at 19]
>>   void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
>>   -------------------^
>> 
>> Add __fix_address keyword to c_id_attributes array in conf.py to fix
>> the warning.
>
> You'll need to CC netdev@ for the patch to get into the net-next tree.
> Since this is a pure Documentation/ patch get_maintainer.pl did not
> produce netdev@ in the recommended addresses.
>
> Please wait for a review/ack from Jon before reposting, we need his
> permission to apply this patch.

I could also just carry it through docs; I'm about to send a set of
fixes Linusward in any case.  I wanted to run a couple of tests to be
sure, but I don't expect any problems with it...

Thanks,

jon
