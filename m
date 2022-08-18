Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9C5989F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbiHRRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbiHRRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:10:41 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107B62D7;
        Thu, 18 Aug 2022 10:03:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B39AF4E5;
        Thu, 18 Aug 2022 17:02:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B39AF4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660842161; bh=WtV58fiAYtLq7YvpGt/exWtkMhHyCYENvRvhrjkGd44=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jhYV4WhF2EtYNfrE5MVGt5ZxUtgfXaAnONedHRbpff058+i5nqMQQGp6Wx0OV+rbW
         fGc+VYahWFnb/FATPeRDz8ns7TM2VcTnponXoC0UCqGDBhtNmDBcG5VEUp4j/xWDJj
         +4KHfDXBtqP/35TJPiUXTnb1CJCLFJWT2ihXM+kwSp9rQzeTPFfcOrqyPujlnKvTdr
         h6sVrkp3qmIQbNgI7svk7XTI/t5b7jI76ur5i30GffELjUdjdPMEamFcGbqSAd7tI+
         /L/TFXlex1fNJ/EweBj13w5q1xz/5MK8QrEQW2E5SSKANsVFpkGgKV7Z6bVoyExZTU
         1div+d8zVzdyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/ja_JP/SubmittingPatches: Remove reference to
 submitting-drivers.rst
In-Reply-To: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
References: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
Date:   Thu, 18 Aug 2022 11:02:40 -0600
Message-ID: <87edxdcwnj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Reflect changes made in commit 9db370de2780 ("docs: process: remove
> outdated submitting-drivers.rst")
>
> Reported-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 9db370de2780 ("docs: process: remove outdated submitting-drivers.rst")
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>

So I can't get this patch to apply; I'm not really sure what the problem
is.  Does it apply on your side?

Thanks,

jon
