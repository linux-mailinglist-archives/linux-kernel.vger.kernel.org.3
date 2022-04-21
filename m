Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93150AC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442869AbiDUX4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382034AbiDUX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:56:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C4434A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:53:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bg9so5949250pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j6Fy6hHkZQxGgTlL3xckKZgzFBUzdD/IAkyE5C20c1s=;
        b=EePhR+I9hORt8Rkq64I8Jpga00uK6YeWg9eQaJJCC09gApDG50VhY/P9/yG8EMD2Qq
         6Fh0RCJw2RnxwUCNKYCAhQd6oLmwHoUcSCDwMA28zLncb0lCMErzvJUcM+chra8VEMJj
         szGelmLNtZGvW6m9yPvNOWwEmUPPF0G8c3xIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6Fy6hHkZQxGgTlL3xckKZgzFBUzdD/IAkyE5C20c1s=;
        b=clhes1iw6En0ExXSmlJXOMeSw2OhOs5/Flm870ZeZKKkR3TJirQk0x1xoI26+v+aMG
         b0R+Xpfm6f7junbtWY7ypm2qbtWUDtXkHXiDre11loP7HCmcAtFyjtw1l6BIaPplc0MP
         H1RMo16PVggT7sVRlnS6Gbvb4xvRtUiTIxPpnY82hh/gh9p4Yg5JNKcuaVTedzZTEiC2
         GviPxtFgiSRpKJEWe1XYhGtKPuv0FGzxXhiJqWv8InbtoGH3+QJCmVx1oPRFN41uYTx+
         GEkHQL+AuAH0v9sBGDA/5hEtanx1SQeYTxF1bS0RV3C5veZyGUDhB7QUJhSgcosubKJL
         Nn+g==
X-Gm-Message-State: AOAM531MrqW3/IXgohqRdWMV/YkRQqSYd5vWm6GK+HspBaVRRiwHSF7c
        5crprp3btiU+F3r5ioAqlrYcy8IDywqMXA==
X-Google-Smtp-Source: ABdhPJw/bXD4k6M8ME7pqPbMOIas5AJXZAyJav8bxwJ4ROzLFva3UR+U6MBHPMZ4WLC7ZGGqQ2qv+g==
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id b11-20020a056a000a8b00b004cd60304df3mr2114326pfl.40.1650585193224;
        Thu, 21 Apr 2022 16:53:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a030c00b001d5793b6f71sm3990629pje.13.2022.04.21.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:53:12 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:53:10 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: list iterator spacing: clang-format vs checkpatch
Message-ID: <YmHuZjmP9MxkgJ0R@google.com>
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
 <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
 <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
 <CANiq72=HdsTfQt5DWKf065pENN0xrOwvKq+T3JpHdyyRkPVx8w@mail.gmail.com>
 <CANiq72mmFn8KUjhcOHhTbWGCktK-HEvAQ+nz8HZhM598XqO2aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mmFn8KUjhcOHhTbWGCktK-HEvAQ+nz8HZhM598XqO2aw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sat, Jan 22, 2022 at 02:16:14PM +0100, Miguel Ojeda wrote:
> On Mon, Jan 17, 2022 at 10:41 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > So it is coming -- the question is whether we wait a bit until LLVM 11
> > is the minimum supported version (nowadays LLVM 10) or we are willing
> > to require LLVM 11.
> 
> LLVM 11 is now the minimum with commit df05c0e9496c ("Documentation:
> Raise the minimum supported version of LLVM to 11.0.0"), so I will
> give this a go.

How's it going? Are you ready to apply this patch?

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 .clang-format | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.clang-format b/.clang-format
index fa959436bcfd..63f0127a409d 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# clang-format configuration file. Intended for clang-format >= 4.
+# clang-format configuration file. Intended for clang-format >= 11.
 #
 # For more information, see:
 #
@@ -545,7 +545,7 @@ SpaceAfterTemplateKeyword: true
 SpaceBeforeAssignmentOperators: true
 #SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
 #SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
-SpaceBeforeParens: ControlStatements
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
 #SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
 SpaceInEmptyParentheses: false
 SpacesBeforeTrailingComments: 1
-- 
2.36.0

