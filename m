Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406C4F97CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiDHOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiDHOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:19:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9B17A8D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:17:34 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAgIQ-1nns2P0Jiq-00B36t; Fri, 08 Apr 2022 16:17:33 +0200
Received: by mail-wr1-f45.google.com with SMTP id r13so13052825wrr.9;
        Fri, 08 Apr 2022 07:17:33 -0700 (PDT)
X-Gm-Message-State: AOAM533+S4NKupeNPBjsQTy9XVS2f1OXQU3w4uKgOkpJIcQvovvf5gSr
        wKepiB6SvggL4EmMLFDmiLUcR9Y7G9CwalQszUw=
X-Google-Smtp-Source: ABdhPJyRvLylYLoRuY6841KYpUytqXI11HqBYxQTS325hyru8pYNuf4xphTlAZhMdkzDaG6t0dxOMOlKEQOVIRLpsBk=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr14524137wrg.219.1649427452724; Fri, 08
 Apr 2022 07:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com> <20220408133246.fyw5554lgli4olvg@maple.lan>
In-Reply-To: <20220408133246.fyw5554lgli4olvg@maple.lan>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Apr 2022 16:17:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
Message-ID: <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fSUH//fRoVL1JVYdqkQNFLMppuXsqI6gVGhc2sXbbA+du6trdHy
 1HbyaM1VXF9d+cnpAL2SSV2ATjO1Rtm/sURdcEO1mMAwEACchy3ufqF+tkhVWFcsD0tLnG+
 StSV/nu3BbVNBvtV5TQBuzxlwCb76H/h7kOxH9WvYIWUoYF40CtqkYeJqtaCitVNzSBNf1f
 vvSb0SByiO2QNMztj7uSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9T3McJ1VMWo=:ThsIvDXVhe2tZ15HacdoUj
 TRggOyI+sqAtcDVd7EWccS8OBTtlQ7kI+slfvEDV533kxkC1Qjhk+ZRO/2NPtZvtVUkpUk82g
 jYAb1b5/lKRrCuYJNKP1sQi1ixwPwGINNCnX3wHROuQhz0fAXb8XsM5/2D9EWjuJEAJlEIiIK
 /cULvB3gDTXyvIQON6TrQt+BPTKSoxqYnVyF0nHd9TWsUjYbo3aGeyb64L0MrPHEtrbxnXlqs
 8pkB6obfuQN5/e4O7cpySChV4gc8hqi5H/5NPi6anX8CXKYAPI5y9uCXbrNOeVaHCIZZRG21g
 NGPlRXBzfYwyApsa2APsqBVlAGcSStBsmWdI30jZCnnAzzFSZuQ3898ap7t7YIODZndvIhPfn
 oDADe5377+7XOnTdwmJMuyuaoKZ2OBKkPvYJMlzcfE/Z/cxzpjmcKQMpmErhGC+A+QDmmCNd8
 I0XG/63tOqyeWxaGvP5th5XgCjY/jfs0QsGD6K6BmNwlqHHn0Rih2oq1KiANJmqAK62JmUs1J
 bnO6yBRwaoHkD3Xv0xY/E/deaFpEVRXdAgz5PZ9ZK9IgePLd3FP/TubzwzagdINC+24rHYF2L
 9qw4JBMvXZ6L191tn5Utyo275NxV8Fp2KiB5NEskY4PMpyXND49sxHgiSFRI3GrL6I7qduYws
 KyFPwxJqIFsUnbVA2R1GpVAItXpRytTnCAYM33UQMKdp7GbWXfcqt+JxvYQvgsOBuENE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:32 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
>
> There is some prior art for this sort of feature. AFAICT SGI UV has a
> similar mechanism that can send an NMI-with-no-side-channel to the
> kernel. The corresponding driver offers a range of actions using a
> module parameter:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180
>
> I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
> it is just obfuscation. However it is certainly seems attractive to be
> able to reuse handle_sysrq() to provide a more powerful set of actions.

How about a module parameter that allows picking a sysrq character then?

        Arnd
