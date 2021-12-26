Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797AE47F8CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhLZUbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:31:39 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:35451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhLZUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:31:38 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZCOl-1mxPC50TnV-00VB4J; Sun, 26 Dec 2021 21:31:36 +0100
Received: by mail-wr1-f50.google.com with SMTP id q16so28697721wrg.7;
        Sun, 26 Dec 2021 12:31:36 -0800 (PST)
X-Gm-Message-State: AOAM531BoaGmI++Ao7CjWurlgs86nFMh/2A+pUEkPjQAJdY3FegQIyWx
        LD19x3rfcObS5sUNtrBtTHBfA1fveyO8JWMhj8Q=
X-Google-Smtp-Source: ABdhPJyO2w1XFqKG2mUoY/v29qgBpPCjDgTH702P8VhFGtr45r1AvPY74wUaZF5xCNebcMFHkX5hYE/0kqidQVo995I=
X-Received: by 2002:adf:f051:: with SMTP id t17mr10579480wro.192.1640550695572;
 Sun, 26 Dec 2021 12:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
 <20211226162223.795f9417@xhacker> <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
In-Reply-To: <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 26 Dec 2021 15:31:22 -0500
X-Gmail-Original-Message-ID: <CAK8P3a08kawHpz6RsLZsvNNn0_WKaFWRU-7M4fJ3e7i7J+GQcA@mail.gmail.com>
Message-ID: <CAK8P3a08kawHpz6RsLZsvNNn0_WKaFWRU-7M4fJ3e7i7J+GQcA@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
To:     Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:U5TYZUP3AoDHaRxJ+orOw2LY2aie5+KJbQTGqGSWwP0mhJp5WPQ
 HhpLReEcCIuyqKFMJhHtIAWCKPRC6HbYz2gi6kzu7Exy+LFHMe9UOc+1iGMXokMljaaCTwR
 Rv0KHJBflbIa5bA0zEDxf3J2PDCf+i3oo+MzpOpZHxYnJXBSFP37dPOF3WG/5fbLby4OjFS
 aVF7hietpEXMq0JapApcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9wkK1Vxpd28=:UYe69fZMID4s0xX/eqTmDq
 owqn8/B+9T8MFJox2vBO55tpYDv42+Cgu/TJfTiFp+bA6x07lzRwUpUp+jSjpce7znZhUMpzd
 6MEdcobviDrfrhBSjPG/5Axfa2kv4HNBciRur1fea7UwJSpoJ6lZW9/4r/22dmWg65bCNBjDK
 uEO0yx1j9ijoeoXN9AeYYBRIQFcrxuodLWL0Kvp1RO3NYhxplNyiTpLqwH+U7OI1R2N3nnJxh
 U9KXf+KRdo6fDJf+aH1+00/dlJ/Wbpvu9I5ycg48nB3eFHxI27VIl9+omHBuYRwGYru2tX05V
 C4kf0lyeBr4eFNYK+ZBHoeLxnTi8Nko5vG1S9Gu3F7dIW3qua3iE5uNdaqniZSJjqn7DOgRtM
 y13aqKXdcWm6ytCdSSuP7HzWtujL4byACXL/GNBh9SOw24Lo0AF7SvJ4/fFJoSl51lXeFzt5l
 rs/CkcWzBb6Y8huO8kD/CyN5BolqK+UdLz8W0RsSMSYYVvC0RTxq3K94RiE3I2Ecy0lZ/wkos
 iqKR3uMk9TgNcBOTJWkORnfMiwAoQPqdLNw3nY/wUI/1cBJSSlr8Gi2v2j+bJmPkypBmLlFu2
 p8R4lQ8pn36R8CUEG6SPqzfbySGgx5KoqDPvx5QfT9lsdAgPmOlVhsvGZd/L2tKwGXlmrn2cr
 O2Z6WD04A1huVp86XnVWtfIxKxqSCoHuOnWp0BYcLylNH/ikAUv7i4+rCFKMYKrFVM5dl4Mkf
 owJHPjjY2TGQUiYjz1XJtjduJeOWjZKLYwXbDu27yFAFS6tlLC5suufo4Id2c31necT3ZeAc1
 o4H2qRRvL0ceIOTdkisFL/m8Mv8OhkXW2+w5eKWwMT3WkLkka0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 7:38 AM Guo Ren <guoren@kernel.org> wrote:
> On Sun, Dec 26, 2021 at 4:36 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> > On Wed, 22 Dec 2021 20:59:30 +0800 Guo Ren <guoren@kernel.org> wrote:
> > > On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > What about adding RV64 ILP32 support instead? This don't need HW side
> > modifications so can benefit all RV64.
>
> ILP32 is another topic in C Language Data Type Models and it couldn't
> replace the standard rv32 ecosystem.
> COMPAT is a common framework in Linux (7 arches have been supported),
> so let rv64 support COMPAT mode is considerable.
>
> Customers would choose ILP32 / RV32-compat by themself and that
> depends on which one has a better ecosystem.

From a kernel perspective, supporting both is not much more work than
supporting either of them. We had the same debate for Arm64, and ended
up never merging the ILP32 patches despite them being well written
and maintainable, to limit the number of supported user space ABIs
as well as the possible attack vectors when there is an exploitable
bug that is specific to an ABI.

arm64 does support big-endian mode, which is a similar niche, but it
can't easily be removed after it's already supported. Supporting normal
compat mode is the easiest here because it doesn't add another user
space ABI, but I'd strongly recommend not to add any other ones.

       Arnd
