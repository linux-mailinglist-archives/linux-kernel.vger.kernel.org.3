Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1953AA29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355608AbiFAPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbiFAPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:34:42 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DC6A3090;
        Wed,  1 Jun 2022 08:34:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E98C4723;
        Wed,  1 Jun 2022 15:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E98C4723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654097681; bh=AMNnxu+yFDxeOhiDrKZjLH3xOBEGLJL3HDWk2TyQV8w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iLnHdmITIUmdrHQkV3R9TVwF4RLXbY6OE/G4kOBO10emFIMPGwYGoPet/nbR8SuSQ
         mUZOa7vEynqCS/tuKtXIRL1XRPoqnOiIuqESVJhrGuNXnkrCKLWb8A1ycmmBdjm2cF
         CkvKeDn1I9Er7LpodUphZ4EW6RCMMzyuvd1VLGfVJOHnY+YMXjT/1vvgLHGNSk5K/g
         p5VqklZ0Nx7Bt5pOK9zZ6k5S1C7b7TYfBghhOwingSmOQwDYr8xw8HCQVWEmx67lxh
         ALI6U/7WNh3R3yGE2W6KKWi9x77tkuvWsmzXDXAvfjQJhTJ0wkIMeIYr/z2UZ6Ebdl
         hovbNSXXztpWQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nelson Penn <nelsonapenn@protonmail.com>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nelson Penn <nelsonapenn@protonmail.com>
Subject: Re: [PATCH] documentation: Format button_dev as a pointer.
In-Reply-To: <20220522194953.12097-1-nelsonapenn@protonmail.com>
References: <20220522194953.12097-1-nelsonapenn@protonmail.com>
Date:   Wed, 01 Jun 2022 09:34:50 -0600
Message-ID: <87wne04cth.fsf@meer.lwn.net>
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

Nelson Penn <nelsonapenn@protonmail.com> writes:

> The docs on creating an input device driver have an example in which
> button_dev is a pointer to an input_dev struct. However, in two code
> snippets below, button_dev is used as if it is not a pointer. Make these
> occurrences of button_dev reflect that it is a pointer.
>
> Signed-off-by: Nelson Penn <nelsonapenn@protonmail.com>
> ---
>  Documentation/input/input-programming.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
