Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6C59303B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiHONuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbiHONuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:50:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE551CD;
        Mon, 15 Aug 2022 06:50:15 -0700 (PDT)
Received: from mail-ej1-f46.google.com ([209.85.218.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5FQJ-1nPSt90nTR-011BOp; Mon, 15 Aug 2022 15:50:14 +0200
Received: by mail-ej1-f46.google.com with SMTP id w19so13631553ejc.7;
        Mon, 15 Aug 2022 06:50:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo1filHEkzjcOLr533Lo0IZNQNKLeAaoBmDs8G/QoH0dhOQp1ZkP
        tX5J8ZeFiVlkB+5AFg2iCzd+K6YLy6oXAOGq5pM=
X-Google-Smtp-Source: AA6agR4ddlWu40vTUv/Ln9AUKIE3uheuuPTA89Jfa8ZPdbeeYmoqRoIcNERXQHiVgSCeCa+oqoK4aQ5z0iofk+G18YM=
X-Received: by 2002:a17:907:7609:b0:730:d70a:1efc with SMTP id
 jx9-20020a170907760900b00730d70a1efcmr10568938ejc.766.1660571413808; Mon, 15
 Aug 2022 06:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220815131642.35116-1-tony@atomide.com>
In-Reply-To: <20220815131642.35116-1-tony@atomide.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 15:49:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39YQNHjhNXAqEg7i3httWx+Ofx8v-xNY-7NQKxnr7OHg@mail.gmail.com>
Message-ID: <CAK8P3a39YQNHjhNXAqEg7i3httWx+Ofx8v-xNY-7NQKxnr7OHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clocksource/drivers/timer-ti-dm: Fix compile test warning
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P3jcTYmcnM0yOwlbagpqCTDdTPMrBkEmp4UlughW0gYvL+Mxk6n
 B2hcOByPZgew/HDEJABCfcIpXp9gxGwXyza8f4btL1AdFkOun5DTiT6m8FBmERZSvqX3zKl
 /4rrCTUuLg3+M4wDC4V6AYNcaEMqSdeZWOdgzMLVY03XioSQ4qtyFNwf+UXfLFeabxFjsa9
 mYAcNQtnMlGViL6Q4wGjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tPvhK98+KLA=:f0pzGamikhSLTDBgxIdk6b
 +3ySwS5Fv9C2n/m9XQ+m+41XADZ4XLfsSgsBfEcFPanDa3yNCW/rl6ssgLvT1PS8DygCne+mi
 89MJ2eZNlKghUwQjpT32Sy9/N3tsdMtUxwtJJdPYiXZO32sN/O5u3/ni1uFjlPn1U8+NmvF7V
 rCfOYB1cVmdj+RVTSj9SpgzYIqKulqXfPUnn/8Af4tfKU4Jg2P3INinr4ciLUA9FKpzewZnjK
 aVA5pNvC3tLuYWwbzG6tEzyzqNoTCmrcsUqjpcPn8PESQ8Kx4hzU8DJ9YtK3m9fvBx7pLPih/
 rF+2DSCVJK3Z8bY2R+toBAshsXDjvDZjYMMZ8hfbc6lKzzGj8xpWWNUowHE777hiogoAZWhi7
 9ugzzGLTIkcDZu3RwopKjMyGOpcZ8dYVdFVE6GLxO/0DLBqQpiJhtidTiCy+XOPh5csErAtSV
 ++Ez3Kmw1s57Nt7nBmnsSYMpSXC9lbv/Gjs5oACP4YP6BKOuvdO8G5TQxzLWstq5KXvGhElB8
 UfwzClfqHuTmWw7wnNrwtb7kTy4+oQqQYy2W6i5rNRPEM7ayNzCfuB31L1RSOHBnDd1AVK8Xu
 6+ob/vkW2SvARqedAXnqHFF7/T4UHHXFNio/msXpdTRqxsPtbU/AHEVE1/pa7TcVpfvkHKV9O
 r7TWj9zhZxqjst/owd58bdTblfW/3eOIE9hDmyjvjt+5K2GAdfYjhZnRrGGH9JndmYaiS5k1v
 R5eIAHVDPcSk4Bh+5ZpqIcC9Aq6FjVADNce1U0qUYmHohKsX0sOHQaxRMrrgsTdSVvqb2x+co
 v5LfpSJfzArLhDsoU8S6pcRz+2x6cnhT+Rxwzq4/LZ37n/esSwMfthBK5QHX0BsYt/NLApgbS
 +76VL2gGoFAYtrvanOFA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:16 PM Tony Lindgren <tony@atomide.com> wrote:
>
> We can get a warning with COMPILE_TEST enabled for omap_timer_match
> for 'omap_timer_match' defined but not used.
>
> Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> Changes since v1:
>
> - Remove of_match_ptr() instead of adding __maybe_unused as suggested by Arnd
>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
