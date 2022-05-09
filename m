Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F2520759
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiEIWMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiEIWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:12:37 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA02B4CB7;
        Mon,  9 May 2022 15:08:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E64D7750;
        Mon,  9 May 2022 22:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E64D7750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652134122; bh=dO8AHAFq0RjSV9IS8lCspN2KpGKOcY8CrMNFYhJkC90=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ylbt5j/GDLnz8wIIDsRwGD8/7ph6aKtCOUgO6yRToRVEb3NTWPC6LlRpm0fAnmzTL
         oEu6J8fVzOhp9rDGTkqx4UVMwZ1QcgwCjEgAfFHTMCXDCvIqNe1AqS2JIiKyYMaSjW
         8kcvD8aVGckY5+0f2dPo+rw/7FLk5sibTiOTJ+9GUoq3TZL4jOioPbhmH98rXAXAGV
         iv0jPuSm/jitdBh0kqsrn13DwdB5EODXO8Jxpn9JO5FsASQ9RvpJL3WwA++jiWVMqK
         jI/SHWpDzOKvJG8jrG0t6r/xpywt5+eJFadw+sinNsHULpgr/J1/qpKdpYlkxbSzkF
         XPCyAxAa0mRcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for DOCUMENTATION/JAPANESE
In-Reply-To: <7689b502-8c34-85b1-54e0-7a3b5e3c2bd1@gmail.com>
References: <7689b502-8c34-85b1-54e0-7a3b5e3c2bd1@gmail.com>
Date:   Mon, 09 May 2022 16:08:41 -0600
Message-ID: <87h75ycqae.fsf@meer.lwn.net>
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

> Due to the lack of an entry for the Japanese translation of
> documentation, Kosuke Fujimoto needed to ask the status of
> its maintenance [1].
>
> Add an entry for DOCUMENTATION/JAPANESE as a sub-subsystem
> under the DOCUMENTATION subsystem to make it easier for
> another prospective contributor to know there is someone
> who takes care of Japanese translation.
>
> As a first step, install myself as a designated reviewer.
> Hopefully, other interested members get accustomed to the
> kernel-dev workflow and would get ready to be
> (co-)maintainers/reviewers shortly.
>
I've applied this, thanks.

> If there exists such a rule that every entry in MAINTAINERS is
> required to have at least one member listed in the "M:" field,
> I'm OK with filling the role.  Thoughts?

No, reviewer-only entries are fine.

Thanks,

jon
