Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED64C9E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiCBHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiCBHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:51:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E813D4D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 23:50:26 -0800 (PST)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M91Tq-1nJI9901ry-006AEh for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022
 08:50:25 +0100
Received: by mail-wr1-f47.google.com with SMTP id d3so1343031wrf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 23:50:24 -0800 (PST)
X-Gm-Message-State: AOAM530cLTp2ZSF081dVs5hO/mtFkXMCqWh31xubTLwUaOStnL2A65pG
        FdJFchzgycG2KZu8wnDFYDLucc+HqGEIRD0t8VE=
X-Google-Smtp-Source: ABdhPJzDeM0G5MOHlH66c1u/2IvGZJwerk9my4q53qyjwY7VN7CtoZ4zQPQ14Se6j89VC+x72C/zMlxsnwsPi0e/Udk=
X-Received: by 2002:a05:6000:1866:b0:1ef:8a14:ab6a with SMTP id
 d6-20020a056000186600b001ef8a14ab6amr14141948wri.12.1646207424663; Tue, 01
 Mar 2022 23:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20220302074245.257153-1-alankao@andestech.com>
In-Reply-To: <20220302074245.257153-1-alankao@andestech.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Mar 2022 08:50:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2s34a0gcuZ31ns8mZx2Ve-DF8+z_EhURwbOeOth2ayKw@mail.gmail.com>
Message-ID: <CAK8P3a2s34a0gcuZ31ns8mZx2Ve-DF8+z_EhURwbOeOth2ayKw@mail.gmail.com>
Subject: Re: [PATCH] nds32: Remove the architecture
To:     Alan Kao <alankao@andestech.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5h1Wge0u0t5llxPwdIPbFP6/6e3OClSA0aBqzucMJlJKfl0m/+6
 nppzQtjGKKQ2xkGwfAuIE+uiUPlaOYrMRkzDMD34UNSgojaqm+iRoxLvBeJpypEgmdxj8mC
 lo2e1OV/u+AF40S9MlpFuhlXT15Mgm1obM7d0V+zibGjSCR1SodyInE0LMAFcyLG0MyS8xF
 11TB5Hxf0wsCjTcoLcXWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2oZBGAoq3vQ=:vhU+Nm/lDAGRbRtrLX8yte
 AluUAbr+isHaCBF6X0SJLX9fSuNRKL2q0kDSdUaJNwbbqLifdhCNARU9XjgG7uvPFpdD9kVmd
 /trh4FOeB0vpSup+vrUBTVBdwLrf4BInzfVv3wToYvI4Kd0WrYoB+TQXQqRyfheaSYIU4baG3
 LnovIE4bjIDJ1gAnEHOanNz7rnSe+AGAsEMIjLv37HazJhgfqYk86zdMnNcEt/V3uz8R5I80j
 rNou33w2/IyQkikO2V0j43DkAxW5s7c+aPnz9tQNP3DD4W2ZOAKkQKV0J9e7xeai10avMQY/0
 PCRzuU3eTJZnC0avXD3PQJTsp2+IQN9mL0RxQkp1keI4w70+r95DPspTinpCSZntPvqP1US0x
 UOi+c1HiLFh+fuUiePiOl0QotuVF5GR6Xo2pBJzan64ayu32GMQSqRHNafSuupTUCpip1z6Vk
 51MtKQcX7pVOAsozGYNRM7gpFn/4gykNFjgu3pTezdIWY0gJ/xooEhwRT9cBdG3kbLye4fHHK
 W9Yc/o1rpBixShgg7vvsOUf4KXQrgQJkC+jIRoevjNnU4sTF+QFTBsV+9nMkbZUAJc1aQxu8Y
 McFnG3xx90fuUOR8bv8J8VltS7hiPV9LSupyi+j1ueWzBM5b1wMi4+mQd1cs7l92493JlnRY2
 fN5Jvbby+99jg50Mahm0+rnmx5MLKeyApm7gtPREi0oJoRPOFmq6d9RiopTQQ+xttis6u4qTh
 xsUbv+GyMJp0f/Xj8sohrm1JhwP+dnuax+en9P+bNUa6ZNSEIbbRer0U3y0vAyPieX64DEGoz
 5/vghAmUuIP8Mpy3Djbnopr/S4WfeXDN5Y3hhh0PNA3XCTmhCo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Wed, Mar 2, 2022 at 8:42 AM Alan Kao <alankao@andestech.com> wrote:
>
> Previous discussion is here:
> https://www.spinics.net/lists/linux-mm/msg286280.html
>
> Signed-off-by: Alan Kao <alankao@andestech.com>

Applied to the  asm-generic tree now, thanks for taking care of it.

I'll probably amend the commit to have a more detailed changelog when
I'm back in the office next week.

         Arnd
