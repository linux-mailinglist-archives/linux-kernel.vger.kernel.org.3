Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C74E6FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356435AbiCYJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbiCYJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:13:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02ACF483;
        Fri, 25 Mar 2022 02:11:59 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M597q-1nWZWT3NFU-0019g0; Fri, 25 Mar 2022 10:11:57 +0100
Received: by mail-wr1-f53.google.com with SMTP id r7so8851426wrc.0;
        Fri, 25 Mar 2022 02:11:57 -0700 (PDT)
X-Gm-Message-State: AOAM5330E7tVEe7klAHzU35seyNOgkR7kSSWIO9CjV5Wsd5lZF0lu/HA
        R2j0qLyrt7/v+jWkunZ8i083AyX0gprN4czaYNg=
X-Google-Smtp-Source: ABdhPJzlSwDWgsgZpeRugVuvy428D1qgQK8pZuiKTRIYi9OSl8H4ndqwB0mRzcaYHlfTvLPePtNJpSY9MHEOxziK+P8=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr7999785wrw.12.1648199517413; Fri, 25
 Mar 2022 02:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7> <20220324062547.GA15504@9a2d8922b8f1>
 <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
In-Reply-To: <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Mar 2022 10:11:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
Message-ID: <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KK521CCvDxK0Z7Twh5nGXKg+ZVj/4+ilIiLkkLJMHPDknwqKe0H
 JYbuSGtA5NBRsH4PLE25G26CR+0SplfR5HMQ7HX/G8IA1X8Zi5zsgUJB+qGXGC+1Onrxley
 R/YxbSXEa13Ycdp6qsRKrbf1v+5HjCRQX81gIVA4Dq3u31Gl9GNZotQC7uCOtmWfeBHXU9b
 efVA89nR/i22IG+azzkuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/+L8lfuVZs=:DCKxVX5SyQJV2SIwGnXTDm
 /dWBJcS8KIoC92+6wotEEkxV7YqjLg+QBU6wKenhTdnKkOAtt3r4adi2CNEXfhrCQ5PqCpr3Q
 DXS8/N6nq80zu2A10VFc6gf4puHQC+2Hw+bUd3LaiNtxE2l0ispZqqKFJ/v00t+j23PpjEdlu
 /xF9u/N5UKEkDuZiDeZjeG7Q+RBqH6pp/hJ0kbmav1tf+9rvERrfr+sTDinLcRQ4VyePkEzKg
 AtxuWldRGe7iMNdNgOGBQmI7ysTFkCZqMuo+irgWIb6c0VpUUILkEkbViT2RxsLoJ/vfA1b3+
 7OEVvJV1lr+1OZD1w+NI0MR4xr3fbt1V/7LXEpyVbllkY/5UNuTavnxZMt+ay0iM/RFBKjR21
 PcmXylt3Wzg0HPLxd+t6PQYHU/skO9A39VJMHYj4BGzRzispdy+1Kj77msYh/I+8Psg/KlmPU
 FBtOGaOhDqtPMui+R+mABzRqnZdzf0aPxFuJlV25xkmPBbJvL/ZMeNoHqPsqWIKb5Ccldz7bV
 rXkXE5xGW+07MzRMlrxENX+h71O0YLWg4eqzkpTk8iJsntjIvRYZMqCLt0q4hLRftPNlMQJxM
 z+F6d6bDVCMuG3j6mEZ9tgSuJUh3CzB1eGpxp89kMO1kMwVjHGW/xAtVE+Iy7VhA8Qtd0MyiL
 fhkh7RNO/7wv5AVwLXfxIbHPTWm5C96ASydVmGzq3W6A+fxWxGWg4CNGDyIrwM8xGrAE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 24-03-22, 11:55, Kuldeep Singh wrote:
> > Fixed order of values is important in case of properties like
> > compatibles etc. In case of dma-names, yes order shouldn't matter here.
> >
> > This patch is more of appeasing dtbs_check warning rather than fixing
> > something.
>
> Exactly my point. We have seen similar type of issues with other tools, like
> coccinelle, earlier and such patches were rejected as the kernel was just fine
> and tooling needs to be fixed.
>
> > It's safe to go with this patch.
> > I am not sure if there's a provision to exclude dma-names from fix
> > ordering checks. Rob can help here in providing better insights.

I think it's a question of the scale of the warnings: my understanding is that
there are only a handful of dts files that trigger the warning at all, and it
would be rather hard to change the tooling around this. Since the proposed
dts change is clearly harmless, I don't mind applying it.

Kuldeep, you have probably looked at all dts files in the kernel, can you
say how many of them are affected by the dma property reordering?

         Arnd
