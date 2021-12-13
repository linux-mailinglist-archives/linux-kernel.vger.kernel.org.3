Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61C472BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhLML4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:56:52 -0500
Received: from codesynthesis.com ([188.40.148.39]:50618 "EHLO
        codesynthesis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhLML4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:56:51 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 06:56:51 EST
Received: from brak.codesynthesis.com (197-255-152-207.static.adept.co.za [197.255.152.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id A3838604A8;
        Mon, 13 Dec 2021 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1639396040;
        bh=8ksUQKZPbAJbPZd97Ymotj1fb6XHPJWx686wGbZIbGM=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=gpODPLIRJGmHzeHmNOCIrHEeyY92gqa1wzv3WOe4p2rAkC7GwmcPFjIZK5uJzhuHq
         v3z6GE20sABK1/SZUVVcR8OoPS6Gfb3J8DAmuabbr4fhTTGcyzshUOULl6oCAPgu0P
         AM6xcFwKDZNJv+aEaZT9Bk5LN9ZrWDc7dlGbr114VJ+mVjyLn1CsOlo97B95qF9KVu
         Et+gE7aAvnnOaBMyeh9nzsAUhB67+crBa2vB+F/DMiYP68tClpacG6dc2Pr5X9ux/a
         f2eG1jZ24JbWyeLSAIdeP/tZgYz/FkQB8V0scOY+dC2rIymbdeUV98Q/GxR6HDixNk
         H/4t80DXkPrgQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 186311A800C4; Mon, 13 Dec 2021 13:47:16 +0200 (SAST)
Date:   Mon, 13 Dec 2021 13:47:16 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kconfig: Improve comment blocks in the .config file
Message-ID: <boris.20211213134416@codesynthesis.com>
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213100043.45645-1-arielmarcovitch@gmail.com>
Organization: Code Synthesis
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel Marcovitch <arielmarcovitch@gmail.com> writes:

> The format for comment blocks in the second patch is a suggestion. I
> realize some people will think the '###' prefix is distasteful. I'm open
> to other options as well, I just couldn't think of a better option that
> starts with '#', looks different from a menu and can't be confused with
> a disabled config.

Maybe instead of decorating the comment, it makes sense to decorate
(and improve, while at it) the menu? Something along these lines:

#-
# Foo
#

CONFIG_FOO=y

# Comment.

# CONFIG_BAR is not defined

#
# Foo
#-

I also don't think a command is likely to confused with disabled option.
