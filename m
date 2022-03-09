Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179034D31EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiCIPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiCIPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:39:55 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59568117C89;
        Wed,  9 Mar 2022 07:38:56 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B70EE2CD;
        Wed,  9 Mar 2022 15:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B70EE2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646840335; bh=IRq50+la5AYtWifQd3OVie2+CJwU5PKGsaB20TQ7P/c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qddCE+8tPhXjkgzkNDgQfRPPvj5282FzQ/o87NGf6qsXnihyiBRGKMPj4NWf1juM1
         hPl/+oebWRrHGAY93H+sHWxstBqQeNMwp8byOWQymKw7OIEc6c1y4Ro3YZ6Gp9txCV
         0ZnBHmAbzQO6tBsmZHNzvNTVXI0e2gS0mddLgiTMYTsXpNHW0KzTkAoixrAVrxOA2h
         OymxXJQgTynW3FCRga01XSpKFKo62wmFrIevwUaeX2rx0MbmqkgQNTU7d0901MC/rp
         O8t9u27P4by+MmCZL2W9fGQLbYrQnUqN2+/sPMvq8+0RsdMFnAACLiZ/8YKqV4pdtu
         4780fHpfcqVGA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jui-Tse Huang <juitse.huang@gmail.com>, peterz@infradead.org,
        valentin.schneider@arm.com, daniel.m.jordan@oracle.com,
        siyanteng01@gmail.com, song.bao.hua@hisilicon.com,
        henrybear327@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jserv@ccns.ncku.edu.tw, Jui-Tse Huang <juitse.huang@gmail.com>
Subject: Re: [PATCH 1/1] Rewrite mathematical expressions
In-Reply-To: <20220309122206.37497-1-juitse.huang@gmail.com>
References: <20220309122206.37497-1-juitse.huang@gmail.com>
Date:   Wed, 09 Mar 2022 08:38:55 -0700
Message-ID: <87r17b9lv4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jui-Tse Huang <juitse.huang@gmail.com> writes:

>   There are lots of mathematical expressions in the documentation
> which are written in plain text format, which costs reader more time to
> recognize the expressions. If those expressions are written in LaTeX
> format which is supported as an extension of Sphinx, the expressions
> might become prettier as well as more straight forward to reader.

I'm sorry, but I'm not going to be able to apply this.  We have to think
about the readability of the plain-text documentation *first*, and LeTeX
source scores poorly on that metric.

So, just for example:

> -  capacity(cpu) = work_per_hz(cpu) * max_freq(cpu)
> +.. math::
> +  \text{capacity(cpu)} = \text{work\_per\_hz(cpu)} \times \text{max\_freq(cpu)}

The document is not improved by this kind of change, even if the
rendered version is prettier.

I do appreciate your effort to make the documentation better, but please
focus on the readability of the original docs and not just the rendered
version.

Thanks,

jon
