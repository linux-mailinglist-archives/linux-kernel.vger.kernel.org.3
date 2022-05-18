Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554252BA57
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiERMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiERMVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:21:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F018362
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:20:59 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8nnU-1nm7mp3pPq-015rbq for <linux-kernel@vger.kernel.org>; Wed, 18 May
 2022 14:20:58 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ff155c239bso22415777b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:20:57 -0700 (PDT)
X-Gm-Message-State: AOAM530ixRG2fC0+nbFAe5rounzddXShL19xyCt1Q4YjCoz6QM3aXMWX
        9QtjCM/FT6Tj8DrfSSHoTE3UFcM4zTr08ltSY14=
X-Google-Smtp-Source: ABdhPJz+l0wS1nVeYafL+Ay12/JOAIvZZBhyFl7cQRy9NnTlRIP6H8dI/62vEluN48oSLHCTIuVuFHzZmV31lVc5m8c=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr20495418ywe.42.1652876456640; Wed, 18
 May 2022 05:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220517062929.3109873-1-anshuman.khandual@arm.com>
In-Reply-To: <20220517062929.3109873-1-anshuman.khandual@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 13:20:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3eR-eiY4Y8TNbyQNZiFXoEA8rk5EObZXg-D=JmxjnGCA@mail.gmail.com>
Message-ID: <CAK8P3a3eR-eiY4Y8TNbyQNZiFXoEA8rk5EObZXg-D=JmxjnGCA@mail.gmail.com>
Subject: Re: [PATCH] amba: Drop builtin_amba_driver()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YovaPeljDeZWzcM5S7kkutcg/hx3cpkPpP9QNrLljwsjUR5nz+8
 XR/9rjv9KMYMvewFll4ACPLHfEm1wPaAvfS9SsHR8KPYnDmQtNepAo72yguAwWth2TwgVUH
 sq5CGJE1bgWXvNQyw5qwvj0wf2CE5zvdjvilYC8spd/kVkSIARyvDjdmSMak+/TUozCj03F
 OpnzCWbHj+EAHujXfMg8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qo/08GCtF4w=:GBY67TvoDSsf8j1QAhVxMq
 /nUMltcEbVDPkAHvpaLGYDAo73EH6DV9mQSGnNbGBk0jnhTUurNHtJFR9J6XVGq4Jb+IhGbmn
 h+RG2pQHSTRCxsy5hRVuBN6DNKoEMinXmaFSo4y1yAuAKkcNPlKRj1SuTFTiZC/M/kfuo0Vfj
 98nb0wMUmZCCDAVB75vSQTx5KucSqLWeWtFUSn4ikePAJhtxg9z/W82BQdtrfB/lBE0Eqd7kP
 MF21+Nq2WDm/aiEhrbXRKrElACTxUztNNJNh5Sql0PUjWqeZ0D8obChVA81xWwbYQujPQ9a7D
 WUrWwqnjONLIMIthT+vAiIBfiUym0pelFaQZd70IAIo6JtwS0sCMVo/4wHVf+livIiPas7YJO
 EBzn7rolGw+IykoF9j1BY6Gd/zP2Ilj3zaRElqzGbzkgx9KGcM1UYcF0iE+rXhmFM9GjrAJfP
 nugzF4PMyq0UUcQPp+oWdAIbF6IgS/TxDFOIaNK1I1ChG5palIofz/ENnm4ImUuwWVMykSQw5
 ZlKAa+TAL3+a/w5K9iK632ybW6Hq1CkpKggKdK2KFRTk102uy0FI/sryIqULHP2YmzTDbLNsU
 ZhisGZ6dTRtp+5Nf0MYVF4d2Xux9rgC/0q6H4E/BQQfrnE7sui2gy2Cx5SHJyyQ4yA/FmxbaG
 JuBlyy7q3lX707S8BukitVslsNq+lbdXJIbAs4AjED6NInjQzsKqApGsZj7GuxNM9oveFZE8C
 lsoRHKj1pOxLPbCkIlPO995t+zPcaQyuq6WnZbTjx8cyocEVWMO5JVk55rY+0BHk4MjvpXoUP
 8cN/KawXFmHRirXTuaEdXEToWBhK6dSV4TBjzKIFeJgHumkPAtSoGNkqLBGRdFjRRpMJ4wEbu
 q8JcWUHN0sSIxYqSJF9NrGTlmYzdQZOph+5qt7SLs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 7:29 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Drop builtin_amba_driver() which is not used anymore.

The patch looks correct, but I don't see the purpose. Are you trying
to discourage
having amba drivers as built-in? Otherwise the next time we get an amba
driver that cannot be a loadable module, someone might want to add back the
same macro.

        Arnd
