Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220BB58A034
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiHDSGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiHDSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:06:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16F6BD5E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:06:42 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g5so273454ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W5vtOsGoRNFUeWobww4WWm+woSsVgSrVSuurs+lnPco=;
        b=Q4OVg/NCWfPBpO0ZwT+yZpjwRI5Ie989Hve6f+OWo+s3Asy9HPU46cI5AIaTJdwuNj
         NjmBa5dIdzN0o/iUiosBRTX85lzcOmurw8yGwJzgJkPQYVw10FbxjXSrGeKDmqs0BXYf
         n6ePRZze6YOK4/F60l5ES0L2Wro7NL1X+FOQnKyjwlB+EivnOGXcPo2dSwVzqjG7lgve
         Duwd+X0N+MA4+cwin9Ls9y894QMToWhZ5iz6qpEv0WfnHjVAkUdXPUZKMTwIQvZEa1Qj
         5/AL2iZPzqcNSvCTmTlpPAZ0uSVVrU/53dFvYKzwaEVDbsjhh9RPBE1UGMJuMEFgCcSG
         vYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W5vtOsGoRNFUeWobww4WWm+woSsVgSrVSuurs+lnPco=;
        b=X8lhYf3lf51mbF4A586RTCtJ/kT8jiyLqNa/qYW6K4lOMqOOLO2sJIQ+hsBbejrH+U
         KKnJvuTovwHTQc6n5ePzPRFdFgjWbyHgJ/W4SL5PWJUQGlgtyjzL+4HDzhGdvx72r2F7
         /wuyfP6YwMo10qsn9uJIjOhrAuf7gSupkk1KJFdwSqgB89ZuBafqeXndKALsU2j+jvIX
         dS+Ja4Sp9EttTJBG1bSmNRtq9aYWEoooVhphziuRKdZGUnEvFgZD5Kak7v3G38OVE3Dt
         6mGaLEIo6FHROpe0dzab/+GOQFTquuPxAuNHY1gv6SzXT1dYNrN/+1vMww2AryKr60L0
         PiAg==
X-Gm-Message-State: ACgBeo1OdKRH0tPFjHpRRjyKBe1S567tsTnQfRq/6DIZznI9Ay6X1tAt
        Mnily/O+Jow73SuZiLBSPv8ksrayQk32iDjUMpw=
X-Google-Smtp-Source: AA6agR57/OeeTbYU5ZkJThBEpdOtwXIQZvZCIqiQ04Q1TZ4ctcZEEhntZH9Yy6UT9m1c3NZp2bWN9S5OdB1CpEm2Tx4=
X-Received: by 2002:a25:508b:0:b0:672:e8af:3bfe with SMTP id
 e133-20020a25508b000000b00672e8af3bfemr2283126ybb.106.1659636401974; Thu, 04
 Aug 2022 11:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <Yut2otE1h2xtC79o@debian> <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
In-Reply-To: <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 4 Aug 2022 19:06:05 +0100
Message-ID: <CADVatmOTkf1LfC0teDe8OLm6+Ctm28TWvefRM=frf+aB_seSKw@mail.gmail.com>
Subject: Re: mainline build failure due to 6fdd2077ec03 ("drm/amd/amdgpu: add
 memory training support for PSP_V13")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chengming Gui <Jack.Gui@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 6:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 4, 2022 at 12:35 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> It sounds like that file just needs to get a
>
>     #include <linux/vmalloc.h>
>
> there, and for some reason architectures other than alpha and mips end
> up getting it accidentally through other headers.
>
> Mind testing just adding that header file, and perhaps even sending a
> patch if (when) that works for you?

Tested on alpha allmodconfig, that worked.
And also sent the patch.


--
Regards
Sudip
