Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6878152FFD0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbiEUXXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:23:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2341F8F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:23:00 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.107]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtfRp-1naCv71a5H-00v56E; Sun, 22 May 2022 01:22:02 +0200
Message-ID: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
Date:   Sun, 22 May 2022 01:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: vchiq: Performance regression since 5.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rd1cpxzMrn3SOHrTFF5zZUZ+MyEdYrLnnFtzNhw6NDyO+22glyu
 r0DsQ26+qvx7bbyHXAbhlpFs7NcpxGkkiPsahc6ylqEqE7yzbcdGXMkT5GCTU6EzkNaFNbV
 DH5rSUxT4TsO6SX5yC7dQcUnMd0IpcqFKHV8pZVLKeTN5IzMFNeeqy1I812kZxKOuFHjxDw
 r9Ff3KZtGm3XuAGsCR08A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yvu4QkXgvVk=:vO/qTOUlGO8FDcx4GPQGUr
 nrIP7WShLJdoP4371yy0Znn56kBpY2sK9smuDvNBoxWou8x7xGYRln3L1SBVJx61VtOr0Ld7O
 tIQ7/ldbL70jyZ7Lvcz5ZmDFvNEDhOvQuKDyZbL8+2KzKqrtq1BX15/qQstBrJ+0yAquG6soW
 9wXqAmj6HAi/oqT1uITT5Ua/xkNmoyknv2LUqL/SzP18bcg9KcONN4hN0jiC5ADymMkv2WuYP
 l3ViDx4EF9dMKcYV0xd7xjZfOSUF8LuUbFKI2bqJtjRcM1HDcs/WttLF9kp14dZLe4kdAy/L1
 rtQwpDK6L7URTatED8Ku3O6D1QkgKbGQe4Rl138WjX6ZOkvenefQ/LpFX7bYTTIKrelHAE9Ut
 FF7/f71sci3Uem508wNQMMscJ+ViRaMglNcFKH8Z5DPl1OeckarVtWnduCoa0fonFmu5OoPAW
 cXhlFwMZhEpZ81xwGGjmuj7x6ENjCwEc2g9cU7Ab22LU6FQht4A36NZFZgCHSLtgPXMBQMA7R
 yeW4q2BStXLir5l5F/xqhFGLPwJMBRheCOLGOLWK4KB3v2NTzwAMOmm2zxf6hp6V3durEo1ui
 xmYha3dcrXAu4/PD6lwYbaFKBTCm/zs3TP+58GuUf8qH2P3yLj7X51k4rYp7L1ZKTw1MBeXGd
 pelkgNsJdINeBQKioxEPAJTSIPplROLHJMxqk3qQErSJ1kokfGhRIARGr9qTMkb7RZvQfKmIy
 TFw7IBWKw5v6Sh560HtpIWis+oleaatGuu2zXe46m2f14TK+7oDE/3HvSDA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while testing the staging/vc04_services/interface/vchiq_arm driver with 
my Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance 
regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm: 
lru_cache_disable: replace work queue synchronization with synchronize_rcu

Usually i run "vchiq_test -f 1" to see the driver is still working [1].

Before commit:

real    0m1,500s
user    0m0,068s
sys    0m0,846s

After commit:

real    7m11,449s
user    0m2,049s
sys    0m0,023s

Best regards

[1] - https://github.com/raspberrypi/userland


