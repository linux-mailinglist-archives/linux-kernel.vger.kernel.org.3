Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC669572F30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiGMH1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:27:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21AE2A17;
        Wed, 13 Jul 2022 00:27:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e69so17897724ybh.2;
        Wed, 13 Jul 2022 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IaCuAnDuqRoO8/jU22pSfTKWD6iflCkcJh14rWsQ/1M=;
        b=WoZDRQ+q4tjCB5Ct3FiO0sSoF6JBXWibfr32sk3pnnhFL0UsxcjrBDxiPnXoofMeyM
         iQUHVpnRYtWrOpwNnBdndogbJvjd6dX2YoV9W+f9cWgVY5dEAw8Izu2ZQIMLkeGMF23t
         w5uBm9CjTLC+tIoF8eO4pLfOPAxXk8dWSWMB9y7HUNC4rRDR/1d5f9JvG15NvFCLxfqP
         HaJVHLVBWQ8rMEkrXabHa6KZm2qx5aA2qJMmnk9GJetQ/v3qfwH6Zga6xkQgNwtcEi4r
         8k5I5dOZE2GSKp7rOqEUqHtPg06L49BvmoR71i+6sE3iAMHHZinocvvyUH8sJDi0vIrX
         tFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IaCuAnDuqRoO8/jU22pSfTKWD6iflCkcJh14rWsQ/1M=;
        b=3YHURmshsnDHOBSqgmf/Jz4+6bsMHZi0+6YFOCiB+EVZEX3Q7b+4y4y+licy+43G4C
         yADW0XXzniCkSmb8Bsw4TUwyZnY5ONtAjN69THGKE+KXqmvCZbjayn7admSOMT6ztOVd
         k5OX5oLvP9Inkxk5ub56FW/u2sYDZzb5ygbz+N7d7Zu4Vf+6F9kXSVOmrhaG4S6rEaMQ
         rRnYkF+8WLXmwGMwm1xZZ+iODdZizEw708Txa4woP7xe6VXgjZ7FeaPK3CNoImHFYb09
         CwDp5/bcSC3WUCkXxZc62YiLjpfc52ZOLAxYagGp8J7+2qQ0Z0t/2W00zoTw8vuRG6Ed
         5WhQ==
X-Gm-Message-State: AJIora8Zq6Urmh/6FpeGuHTjaPIaUJLd8gPDQtESJ8+U0wbEpMlSAE1S
        AO7jiCpKhXGJYyDQspxnHTESmh7T7hlnqY4aQWU=
X-Google-Smtp-Source: AGRyM1uLOl/Q7U4qmzQ49L6oSYRgW/l+cioK2zfHPb+jrHSM6prJh+ENQEK85RthI87HZllq440HCfZhjEqDovYWgtM=
X-Received: by 2002:a25:1457:0:b0:66e:cb5a:5dae with SMTP id
 84-20020a251457000000b0066ecb5a5daemr2193434ybu.27.1657697220942; Wed, 13 Jul
 2022 00:27:00 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 13 Jul 2022 09:26:50 +0200
Message-ID: <CAKXUXMy2WfsRj+nJuNCV4bPNYTvDySLOq3HgpK+gWJSpWS81Kg@mail.gmail.com>
Subject: Update "If something goes wrong" in Documentation/admin-guide/README.rst
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thorsten, dear Jonathan,


During some other unrelated clean-up work, I stumbled upon the section
'If something goes wrong' in Documentation/admin-guide/README.rst
(https://www.kernel.org/doc/html/latest/admin-guide/README.html).
README.rst is---as it seems---the intended first summary page of the
documentation for any user of the kernel (the kernel's release notes
document).

The section 'If something goes wrong' describes what to do when
encountering a bug and how to report it. The second sentence in that
section is especially historic and probably just discouraging for most
bug reporters ( ..."the second best thing is to mail them to me
(torvalds@linux-foundation.org)"...). Some random user (potentially
even unknown to the community) sending an email to Linus is most
probably the last best thing to do and is most likely just ignored,
right?

Probably this section in README.rst needs a rewrite (summarizing
Thorsten's reporting-issues.rst, or just copying the summary from
there) and should then refer to reporting-issues.rst for more details.

Thorsten, do you have time to prepare a change to that document that
gives a short summary on how to report potential issues and
regressions? Otherwise, I will happily put that on my todo list and
probably can suggest some RFC patch in a week or two.


Best regards,

Lukas
