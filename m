Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E2573D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiGMT64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiGMT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:58:54 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD110FC2;
        Wed, 13 Jul 2022 12:58:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE2432B2;
        Wed, 13 Jul 2022 19:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE2432B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742332; bh=IpR5hlvA3X6EpAnWpcb8qaW0WD5H/zI6yHsfztl/DTM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DgnXAwHTuwK0AI6gMGeBTqnAKT0ySEhGkdJp3CJAPq8BCx740CXNa4vQBgL74LPu4
         gEgy3MJk19zwvm911nfQaalTofeL4rY5y7zX6YpBV/4ZizTRHiJtR03CJtQgRp+4iN
         EksFbgbQ057YaObvTrgAlouSKLqFvLgPlebb1XY0CkPETzWCh/q/dmLl4g+SUh0/6b
         gMbW9HCONv/1rX8plqkMFRkO1YXR3CyZ/o/SigciSWEzyeQGRShD1Xr7tGEwpxlstX
         8TDGUmFYdvDb95qdc6a+G6taEiyXTOkQ5mSHyxi/7y+lQhEu8EB7w0yVuLYW4C7xQM
         HaRv5fTUMNwjw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Update "If something goes wrong" in
 Documentation/admin-guide/README.rst
In-Reply-To: <1dc0ab09-2cfd-a310-d1da-ef7d3cc47a71@leemhuis.info>
References: <CAKXUXMy2WfsRj+nJuNCV4bPNYTvDySLOq3HgpK+gWJSpWS81Kg@mail.gmail.com>
 <1dc0ab09-2cfd-a310-d1da-ef7d3cc47a71@leemhuis.info>
Date:   Wed, 13 Jul 2022 13:58:51 -0600
Message-ID: <87o7xs4wec.fsf@meer.lwn.net>
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

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Maybe just copying the "short guide" from the top of
> reporting-issues.rst might be the most elegant solution for README.rst
> while adding the link your mentioned (maybe while adding a comment to
> reporting-issues.rst saying something like 'if you update this section,
> update the copy over there, too'). But I'm not sure myself right now if
> that's really the best way forward; maybe a few modifications might be
> good here. Let's see what Jonathan says.

Let's not duplicate the text; why not just link over to
reporting-issues.rst?

In general, README.rst has seen little attention for a long time and
could benefit from a major thrashing, methinks.

Thanks,

jon
