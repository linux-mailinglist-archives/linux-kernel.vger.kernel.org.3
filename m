Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7376F599D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiHSNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiHSNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:55:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CDEAE211;
        Fri, 19 Aug 2022 06:55:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 36BCC2D7;
        Fri, 19 Aug 2022 13:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36BCC2D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660917353; bh=xxoEfJJqE8JslHY5gkAIae7dMgC9uE88hH40n9nxHi8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SCJpO8D9cRS7XwxlWlkwMl08EuEddMkZ1DZ/f0QOlcxLLVIt4cxcjasZ4bL/IzfRC
         dk7vcxYT5jVs76iOckX47JcILK9yiMoB4HZmCdefP+oPZd5BETXubDC0/qDfflTzWv
         NGcenoQGz3tlv51NGl2qy4zvhhZ1lTo800G+vI1EZ308EZ9z3UMMXwksFvpZ63fdOA
         EbsYL7iqQkW58h1K3GBVcvKaLGGPETzBMPwXvEN7yG/HPzWu7GmJTawfdbWwLHWThv
         cszT1+1YMvt6O0LsQU0AHaR+XjXDDj5L98DIslF+HGb9onywRXOyuZIJ1CnnXrR4Of
         719AWnSNVszxg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: Re: [PATCH] docs/ja_JP/SubmittingPatches: Remove reference to
 submitting-drivers.rst
In-Reply-To: <83347b74-5075-90ad-1f8e-575bf4cdaf50@gmail.com>
References: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
 <87edxdcwnj.fsf@meer.lwn.net>
 <83347b74-5075-90ad-1f8e-575bf4cdaf50@gmail.com>
Date:   Fri, 19 Aug 2022 07:55:52 -0600
Message-ID: <878rnkbamv.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> On Thu, 18 Aug 2022 11:02:40 -0600, Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>> 
>>> Reflect changes made in commit 9db370de2780 ("docs: process: remove
>>> outdated submitting-drivers.rst")
>>>
>>> Reported-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>>> Fixes: 9db370de2780 ("docs: process: remove outdated submitting-drivers.rst")
>>> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
>> 
>> So I can't get this patch to apply; I'm not really sure what the problem
>> is.  Does it apply on your side?
>
> Looks like thunderbird used "Content-Transfer-Encoding: base64".
> Resent using "git send-email" with "Content-Transfer-Encoding: 8bit"
> Hopefully it works for you.

I'd noticed that, but "git am" can handle the decoding - it was able to
show me the patch it couldn't apply.  Dunno...in any case, the new patch
applied just fine, thanks.

jon
