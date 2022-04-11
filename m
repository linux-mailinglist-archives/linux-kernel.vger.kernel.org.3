Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA634FB63E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbiDKInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbiDKInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:43:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D283EAA8;
        Mon, 11 Apr 2022 01:41:30 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 632D11EC04EC;
        Mon, 11 Apr 2022 10:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649666484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Uydja6762aIWVkJDPSqqmoMYUdAdYWYNE0eIPcI3tdo=;
        b=AnyDoQLUOh7lqvEBynB/S/f6bAZARR5KZQlhFJLbiV4zd6hZYAAsZdOxJVxvTrOig1ReJ9
        0syTlQ6UIQyIYEV/ytHYrwbxy9dvSE+CfTc92XE1vLC3caomXkMPO58pe9xk4NApKwY8FH
        B1mo+JOuxKQguYKQlesNjIfQ2SPpJeA=
Date:   Mon, 11 Apr 2022 10:41:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Documentation/index.rst
Message-ID: <YlPps05WaHH2ghmp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jon,

so this has been irking me for some time now:

I'd build html documentation and open Documentation/output/index.html in
the browser to see how the added piece looks.

And yes, there's the search box ontop but for the life of me, it is
really hard to find the section which was added from the wild naming and
sorting of the different documentation sections in the left table of
contents. I always have to go map it from the source.

For example:

On the page right it says "Licensing documentation" but that's not in
the left TOC.

Then

"Licensing documentation, ... User-oriented documentation" ... the word
"documentation" is unnecessary. "Linux" in all those section names etc
"is superfluous too.

And then the title format of the sections is kinda different.

And the structure should be probably organized better and not have

"The Linux kernel user’s and administrator’s guide"

on the same level as

"MHI"

for example, whatever that last thing is.

And so on.

So I was thinking that maybe there should be a small set of rules -
don't want to overload submitters :) - about structure and formatting
of each documentation section/file/etc so that the final product can be
more useful and I can actually find something in there. :-)

Thoughts?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
