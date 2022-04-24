Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEF50CFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiDXF1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiDXF1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:27:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564643D48D;
        Sat, 23 Apr 2022 22:24:38 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F12AF2E0;
        Sun, 24 Apr 2022 05:24:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F12AF2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650777877; bh=p5g4Z92wQCYGxCeq5CwcxXEKG+AMLCDOpRhsKSHHywo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YLonQ2be8vtB/aKwFYhvqzS1Nv3KbstyHD+BXXPbzsT9mMLNLgp448FTWUJXfUVVy
         ZjIFFv5keavTgPxnPKQhT+JF0Q9haQOjTN32PEznCxHnDsQ3YUfj7DMbkhN83IiKXd
         vSIPP0QBgCt0stIO4LCiW7PrmRSD3I8pnCc+BvxSbldC4YJGA79WS0GJUQkt/MvTU0
         6daYWaDsuh/awfcwF6KvBGL8i/kM4mLWZirMVKWrMzTEjOGfg64cwWE2zquZaPHZej
         zUhDvkFasa4sLrGA7TjP/R2vL6Jct/7q1cwRreegb3HhNOJtGr2fD6tFLxFZd2SrsJ
         cHKA0i6zdsHsQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>, baihaowen@meizu.com
Cc:     alexs@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, seakeel@gmail.com,
        siyanteng01@gmail.com, siyanteng@loongson.cn
Subject: Re: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
In-Reply-To: <3ce4feb9-5477-e7fb-e98c-3d6342ddc7b5@gmail.com>
References: <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
 <3ce4feb9-5477-e7fb-e98c-3d6342ddc7b5@gmail.com>
Date:   Sat, 23 Apr 2022 23:24:34 -0600
Message-ID: <878rrvyrxp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> This patch looks like against akpm's tree (or linux-next).
> So it is not applicable to docs-next of Jonathan's tree at the
> moment.
>
> You need to wait until docs-next catches up akpm's tree.

The alternative is to send the fix to the same maintainer who accepted
the work being changed; that will usually lead to better (and quicker)
results.

Thanks,

jon
