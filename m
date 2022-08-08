Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0B58C396
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiHHG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:58:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB1DFA4;
        Sun,  7 Aug 2022 23:58:12 -0700 (PDT)
Received: from mail-ej1-f41.google.com ([209.85.218.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBltK-1oFPsk4Ak0-00CDs0; Mon, 08 Aug 2022 08:58:11 +0200
Received: by mail-ej1-f41.google.com with SMTP id m4so14885562ejr.3;
        Sun, 07 Aug 2022 23:58:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo0G6WOIKCURBtp87O3XkvPsiZpgt41U/qRK7ihkoXBWl5B/qc19
        boPbYvPWWc47ipq2PhNOk8ifGqBQCAThJJ+x/RE=
X-Google-Smtp-Source: AA6agR7+MNBPFkwjMYrs9F5cklCO3PmGk+NVWugFBet3Tm9GK726GURnSLhj9K8pZOtw7GOLS3S01sY9ymEq4UpWwag=
X-Received: by 2002:a17:907:7395:b0:730:b636:2c89 with SMTP id
 er21-20020a170907739500b00730b6362c89mr12935429ejc.547.1659941890680; Sun, 07
 Aug 2022 23:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220807220934.5689-1-rdunlap@infradead.org>
In-Reply-To: <20220807220934.5689-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Aug 2022 08:57:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1-NxPazURDPdKYU0Het+pjL6E3BZMskjQD=aCU91Q=rw@mail.gmail.com>
Message-ID: <CAK8P3a1-NxPazURDPdKYU0Het+pjL6E3BZMskjQD=aCU91Q=rw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys_ni: add compat entry for fadvise64_64
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gN4mlgAA3OCy7aqEGs782K2/DEXfr25l3XOGHgc9OTiys8FwtYb
 Q+0K0/GI86Tj4lOE1slCMfmr72Wy6/jewjOzRN4oBTdLRV6auT+pNh0M6ecqKbosjW5opl+
 p0ei0zGbzgJ1/73leOBKi14u2ywi1iAm+xAG7zvb/nEPPpOVFNmVHJii/qiFdt8SnHEOOr8
 LlMpjSw7ICHKakcXuVJkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x1lfxl0+L/s=:frpwqEAjA06OGFQxSa9p+G
 SaTKaPk3gRcHH+oK18vhvTCX1Tdf0YVo5ireZb21kWRgPBY6a/w91x3mILVzheKYUewkKxp92
 c/GBKT0+eXrrKPcFuSRElRXeJPHI9arVAMsnm5NvhTP9/AMu1PsMytPN0RknILfzlY+VA9HSw
 +0j97XZYTwDZlf/eu9Wnlidu4esKdsQU6RxCvM0mCrY3R09vwqNAElQW0WxCX185ZUl0slcQo
 soEiPlzkhDdbK4QgeUnCBGimZfJ8coc4SS239hom+aHP/i8aEwvv94B2ozk590UUixZFgG/x0
 Cb8bt14hD5P+gkxV+AlDWL0UmmChXe29nhvqIgr9EXty5q3oifV746uTPpaeLJiEaaYDh2Dlw
 0L7qS2aScxWdFlXGrAK8srCrH2nhF3j5d6cg85TkuTn87fBMepJim1xSJr2Swg1L6Hyz29k6F
 VNZTisxlKITuUJMgdvBwsB9yF7ylc7k0qutwb0XTuM6xlvwDaPRguVZvu0DlNiDZyZ6dwmxVw
 tAabVZQKFM54YoPhuBx1PxiUbHp2cTQlOhy5onkHMA1bVv2YUFU/jR1hhXkqppEucUumu3xg7
 ZW4n5YG3eiejD4RW3yjLwGCfDFZpOpRHpz5+7jEvsh4e/78xXc2RJSCwEuc7XfzDSGgSJ4juZ
 TyPOKslL7Kxp0yBjTwtPkDzxqwxkGCucNEjiPp61w4xvw5SWzzZnQqWqcK5iwd/HfMF0N/8F7
 FXp+u7YDAojf/dNjGV0sfVQS3DIh+DyJcewVhw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 12:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When CONFIG_ADVISE_SYSCALLS is not set/enabled and CONFIG_COMPAT is
> set/enabled, the riscv compat_syscall_table references
> 'compat_sys_fadvise64_64', which is not defined:
>
> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8):
> undefined reference to `compat_sys_fadvise64_64'
>
> Add 'fadvise64_64' to kernel/sys_ni.c as a conditional COMPAT function
> so that when CONFIG_ADVISE_SYSCALLS is not set, there is a fallback
> function available.
>
> Fixes: d3ac21cacc24 ("mm: Support compiling out madvise and fadvise")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
