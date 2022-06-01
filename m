Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551453AA20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354690AbiFAPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiFAPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:32:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DFA3085;
        Wed,  1 Jun 2022 08:32:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 216D92C3;
        Wed,  1 Jun 2022 15:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 216D92C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654097576; bh=1LkC4KBB+n4gWoH4zaqMyei5vIAn42/01o1vUxBV35A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rHE+zeqQrlMmd5TLzW9fUVRP9wdV9+rQ0uq2kHMSWXsrZrA/LZJBLv6dUyCmLze9q
         BwTx0AeXkaK76i9hvS4fjtU8y8oU1TYlU508z2LJsS6pur/XkR5g7L65SCjHNH7ssa
         OKuHewEsmGlUQnLfJfmlaihEdscU7bmIkNk/llzDMbCQFQ+j2xJRhwbr0KHYaxowa5
         hkbWkNd+D4siI1GJ7FwlxzNp5olRJBRB/ssYunXGAK+KGLpKzt9dS5dK7EqzxPyN3K
         UsdM8KWMPMK/5lLtMoHOF/xEisjc2i4+nQzVSmWnYE+Xzse/Gff959kHs1oMQgiO8r
         ZT5OByurcOJAQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2 1/2] docs: move Linux logo into a new `images` folder
In-Reply-To: <20220528153132.8636-1-ojeda@kernel.org>
References: <20220528153132.8636-1-ojeda@kernel.org>
Date:   Wed, 01 Jun 2022 09:33:06 -0600
Message-ID: <871qw85rgt.fsf@meer.lwn.net>
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

Miguel Ojeda <ojeda@kernel.org> writes:

> Having assets in the top-level `Documentation` directory can make
> it harder to find the documents one needs, especially if we want
> to add more of them later on.
>
> Instead, create a new `images` folder inside it that is used
> to hold assets such as logos.

Both patches applied, thanks.

jon
