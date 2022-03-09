Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439344D2E68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiCILtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiCILtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:49:11 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879E171EEF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:48:09 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfqCF-1o3RL42ODZ-00gGuL for <linux-kernel@vger.kernel.org>; Wed, 09 Mar
 2022 12:48:07 +0100
Received: by mail-wr1-f44.google.com with SMTP id h15so2592525wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:48:07 -0800 (PST)
X-Gm-Message-State: AOAM530sDQ4h1UpFt+fZR3OEV1C3XLKKa0c1c3VpB/ic/DKKCHSxhft8
        Yy7bGpF9wcJCZtSN/+Vc/gYRSv4QCa+cfNRRoD0=
X-Google-Smtp-Source: ABdhPJx8CmrEkP9lIy7Z5de0qkV2NmzIOzmwBGL9JST+3PaDpmd2sG65KYvqwn/RglW3lLU3PwBwOhS6PRPEiVwkkUI=
X-Received: by 2002:adf:e181:0:b0:1f7:7d5e:c3bb with SMTP id
 az1-20020adfe181000000b001f77d5ec3bbmr8821463wrb.12.1646826487258; Wed, 09
 Mar 2022 03:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20220309052842.247031-1-michael@michaelkloos.com>
 <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com> <e936de26-95b7-1eed-008e-8d025b638265@michaelkloos.com>
In-Reply-To: <e936de26-95b7-1eed-008e-8d025b638265@michaelkloos.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Mar 2022 12:47:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33g1D2mE2Z_ZsukMCBZ3gCGdDbH+2osHZe0Y8GoO_5UA@mail.gmail.com>
Message-ID: <CAK8P3a33g1D2mE2Z_ZsukMCBZ3gCGdDbH+2osHZe0Y8GoO_5UA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
To:     "Michael T. Kloos" <michael@michaelkloos.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DfQbHoCGD30olWfmn00WWrwJm36gsGzi2gl8xkAxfg4UF5SUWZP
 xxjdnkOXHaEs6B5MoIE8y/8QJM3XpNIOcob5RVq9B2+Sv0HGsJZb9iquo394Rz1NjVKPeUU
 B/6z64IlrJznToOC+kG7lx3fRKgjGe1/6m0uJ2U/dc/REDKPCxm/4LpJuKhPZzICLB3SZrd
 sksTPmu1BA5IJzuEa7OtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKYYSIcRy1Y=:rdOHeu3gLfOEag6BgUa6Zw
 inEWJLEnjgi5NI8vpjVe5HHLRpTL/cSSiaDwqr4XgWOSXgErhWVluJmiNRe8mBBqldRCdRTVN
 nXMVfFD/grANRZnGMCXWZ08Tek1DfneFJ/QmSoAIKRXOk9W0IHHNpsaONRNw616a0ymPq1fRY
 ldDz9q5Ak4Nr9o7qgt+cMfVJ84Ne5nKsOvELSEJbF13/g0gSJa0nHGqSAdq8vKNeOTY5x5SOU
 mO7s+67ZMDJhUbmo2KKcB+Lt48HWjlGmJhUO2ZJWMmxKAsbpPimI90oa9agTuyWiNTji2lPwr
 Ar7AEld7mYjDa2Be3bzYQVjgaTpVevYDBqM8QBcoKUYlCDPeu1GOHRxA5mK+KSBo4FgcdJf3a
 TOXIcM3lDtydS8wSPG1PmmVLKJ4J6OlnrjcCmtu2p4z7f5l0JghlC5YUsC2BUbwAVpbLGPp/2
 76HNSL9rcriKQR0Nt7vbqv1dqEpTbW2LPSjXrqv7aM/H88Zuy5NXIzfHt+HXvQoV5cpU8WQYz
 scFJvIzJqYaUkTI1QutFuB3L1K6k1GGZFh9XqMgLpY1YkZzpw3pKoyetRLncpuWftmjv/JGNZ
 PzIZU7qvsBK5sBkEl0FL6KHgKPpCKRTHb9qSmUHiDY7M87bNOrVwTM6KbOrhlPvPFz1WW/ojZ
 MlRtqdztVO7xlYyj32CVjSN86PGqpW22jZQWJu2SwmhLh6SEzzCuP3E09zIL08GtV3mY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 12:43 PM Michael T. Kloos
<michael@michaelkloos.com> wrote:
>
> Thank you for your feedback.  I don't really have much of an
> opinion about that right now aside from that I know where things
> are in the current structure and am comfortable.  My goal with this
> contribution was to keep it in-line with the current config
> structure.  Hence, I put it right next to the menuconfig option
> to control CONFIG_RISCV_ISA_C under Platform Type.
>
> I wouldn't necessarily be opposed to rethinking the way platform
> feature selection is presented in menuconfig.  If people feel that
> most users will be looking for an rv64gc config and that it should
> be made for clear, perhaps it could be done.  I would need to do
> more thinking about how exactly that would look.
>
> I do think that it is outside the scope of this patch.  Were you
> working on something like that and worried about a merge conflict?

As I said, I think your patch is ok, and I have no objections to it
being merged. It's just one more option among others that
can cause problems if users get it wrong.

       Arnd
