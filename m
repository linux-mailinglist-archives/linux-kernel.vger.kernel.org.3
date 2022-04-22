Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4585750B5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446971AbiDVLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiDVLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:00:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD1E56200
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:57:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k12so4813672ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbSvuAVaub1Njn4yB+H94pUnlHVbGvezo9LPTAI5RA4=;
        b=NmGFtYWNzRFIpiPbdATS4YfHNW/FDJEqW4davWGJqdSwumU09/ZKihpNCL8Auygs+3
         C1io5SYYzVpY2BB9gAYdPEEhWEr2Vry06ba65A8D4lqjHP84KkpofPh+ZNlaHOTgLQEO
         Ba64QNXv+mBWtauqccmv5Qu2b+bC1aUNsKRqBEbvnayKObay7ike42nq8O0Qn4vMRVZl
         p+kQed6LDSZYsmOnmVHGmdKurrq+4tg2Ky58uYeXimNDja0gviWMAn6n4McmOC7lZ4Xw
         eeu3bhEDj5GhPOHZV3WcFtAPreFSPqnzqyIL7jIYFbr2EtF4Ud5RdzwRARCvOekTXXFN
         71KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbSvuAVaub1Njn4yB+H94pUnlHVbGvezo9LPTAI5RA4=;
        b=0S7Vqj4f9j14MxeCS1eW5sOwoIq/h+1JKVlXbkwjebmJHTrhab7g0WRRzewtTodUnK
         SBcL0cxlP25iKhxCjNVyXcmUiz4kEqhB3GjqQjL/+rnUsFgonxl94JJ9aFSlG4yyGBLg
         MXphuFIORE75v2fAtlmvT2Saa0jJJoqUc8OQYFZdl5ww4kcQxvpRVQIthJknQoX/YvJb
         ZB5fNYC5tRWtPVYbPLkOGUlMGmJsaURdhcm8CD3qRaLxT6T9oGPOp7pUgRCqqH9Pvcl6
         B4g1Trg5Tcg3RI53xnkmgcu7O8By4zusIHeNF9zAs4fAcNOw7e0taTsMPw8/iQGfliWX
         tMrw==
X-Gm-Message-State: AOAM531Bdmc0rEcvBb8HCtroEJXi9ZMzNle7N66CBkwozHkInLMNwsF6
        0aYy2Kp3/CEYi4LC6wLTHP+Z+fEABJABiBUdrI0=
X-Google-Smtp-Source: ABdhPJzG2SjA+b7gkJNdWx6L3nPzkez0bnSKvNLff8++Lz8Pw5sOKV1EoWBj3UwNOnWhB4Y+HOXY4GCej8ouf/Go6xw=
X-Received: by 2002:a92:c908:0:b0:2c1:a287:8868 with SMTP id
 t8-20020a92c908000000b002c1a2878868mr1630502ilp.321.1650625072350; Fri, 22
 Apr 2022 03:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
 <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
 <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
 <CANiq72=HdsTfQt5DWKf065pENN0xrOwvKq+T3JpHdyyRkPVx8w@mail.gmail.com>
 <CANiq72mmFn8KUjhcOHhTbWGCktK-HEvAQ+nz8HZhM598XqO2aw@mail.gmail.com> <YmHuZjmP9MxkgJ0R@google.com>
In-Reply-To: <YmHuZjmP9MxkgJ0R@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Apr 2022 12:57:41 +0200
Message-ID: <CANiq72kZmE8h=GVTS98rKWnxmmxuYK7xOeyvVXE2qjoXEmP+Tg@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Brian Norris <briannorris@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Brian,

On Fri, Apr 22, 2022 at 1:53 AM Brian Norris <briannorris@chromium.org> wrote:
>
> How's it going? Are you ready to apply this patch?

My intention is to do a wider review of the file (e.g. remove all the
"Unknown to"s, check if any option should be changed, etc.). Let me do
it this kernel cycle and apply your diff.

Cheers,
Miguel
