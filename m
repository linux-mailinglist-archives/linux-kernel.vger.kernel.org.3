Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E2F4684F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385008AbhLDNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhLDNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:16:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8EDC061751;
        Sat,  4 Dec 2021 05:13:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v11so11774219wrw.10;
        Sat, 04 Dec 2021 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Tsd1rE26zaiSJkO/71hza3dNv3C8IY+YEVzWQKSlv74=;
        b=cF2QdOFhWmuloOtISN2U4eqYZq4v7OZZLqHN6yGnXuUzrGf8LDCcIatJZnbj4TqXgQ
         odL4HBncm3UtgUolGcMaNvAq+Lm+wPmaWKR9hRAxQJA/nzqSb/4sjEVl+3I6jCY4Gxhx
         7b+K8GbKi2RPNcDgCY7cDOkFXzjJsoBhEn0v99uy8rdkMt3vJ+E94MeGJisZIzrJl60W
         F78ZM9hjRMt6j2niHM0LNTe/6hXOiNLl9F8WzOohsbJXT/sfHwcR9cf6xHKgomNLK5om
         PHZlYBf6t0uF1P7z/xYq+LGgzTXejqx76BYxxczjvYxaVS9d9K99wLkw5qRip62yKQ8c
         Pwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Tsd1rE26zaiSJkO/71hza3dNv3C8IY+YEVzWQKSlv74=;
        b=DBlwCw9cyL9qUd9vfivZY0H6Eqqzi/zuPyRU/1JwAZcuwl2I1B3QT38+QX+tN1GOTs
         khHs1dCNLPVnjOxTB39t6YuHIO0Gn53TOLpCR+Y51VQqRj0de1tZHwELODuhxYBDvv9D
         HQ/fI9FuMeyGKXrQ3wpG8jL7WehWbONmrhGZB78ccY6zeEb9M+q/jYnPGzHkbiIBely/
         w07Fh3f6Yp7ocY5xLIxxxFsypjA3XmmCYm+OewC48ZVNC8BXDbVL18/fUCbB06Rz6srK
         dYggWdHyvsUy5CWZxBDFmkBjA/r1XBztS1Gra6pKXlPhPH7d31R0oZTGnHUl6iCj5OST
         6FLg==
X-Gm-Message-State: AOAM532eiH1h6VD24+osl5wORBsHSU+vjqdnryqyup+tze7sDl9h6Nbw
        wUPXaOE6TML3hhPv81fxqq/ejli8nJQulg==
X-Google-Smtp-Source: ABdhPJwexm3vBI0A446S2gqJvn7oE41xBxIDGyAnF9mp9lh5FdNC3L9Ul4eVSHAImDy+u7AuyAU8QA==
X-Received: by 2002:adf:f6cf:: with SMTP id y15mr28197130wrp.56.1638623611122;
        Sat, 04 Dec 2021 05:13:31 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id x13sm5748925wrr.47.2021.12.04.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 05:13:30 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 4 Dec 2021 14:13:29 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to gcc
Message-ID: <YatpectAYsWnmPy2@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Since dee2b702bcf0 ("kconfig: Add support for -Wimplicit-fallthrough")
CONFIG_CC_IMPLICIT_FALLTHROUGH value is passed quoted to the gcc
invocation.

This appears to cause issues for (external) module builds. It was
reported in Debian for the nvidia module, cf.
https://bugs.debian.org/1001083 but might happen as well in other
cases.

Andreas suggested to replace the

KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)

with

KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))

Is this something you would consider doing or should the issue be
handled exclusively in the particular OOT module build case?

Regards,
Salvatore
