Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B544B815E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiBPHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:22:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiBPHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:22:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04C114C;
        Tue, 15 Feb 2022 23:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644996140;
        bh=qKSX+z1Q8081GjEHMiQiiSJ1N4j1zNYo4KymwWAtCC4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g3kJMNiBLEKHjRUBb6+A4cYh8Q07vfqe25MpQMsrf2np+kJPsF2b0/8ODX2mgji05
         uM3UCQtP8d+eND5Jg+B9Bfv5vB5nSV/Tqe+GqX6OPGNTk1VKRmz0bxZJaY7+yLnTuR
         54F6x1KCfa7/cIVaKIRLqMBIQFbpxYC5pToVUZ/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1nUwrd1UNz-00HM1p; Wed, 16
 Feb 2022 08:16:42 +0100
Message-ID: <40052108-afe1-b66c-3cca-03e5e92ea688@gmx.de>
Date:   Wed, 16 Feb 2022 08:16:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: linux-next: build failure after merge of the fbdev tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220216112934.108a27ad@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220216112934.108a27ad@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4m3B0S6nHClGaEmC8CdzNrV8+TNDg4BHiCc9W3pxM6uMBcudpwU
 GxB6eu3RBRe8XwyFKUhny88yb5sy+L2lYlAm2sssFhyaCmhGjLtq3G6kEpWwQ71eY4umEp0
 KvPnX6lElr7Z/L34aLgqGX9Uai9PsQMGXBcHybnB2hdRqR0X6Uoo7yHh1mWaXvk3YAm4hgV
 TCLNdeP5LntzrtwVsOAqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRAH5dmLpBA=:CVZ9lQw5IOIlRS+If/s7bx
 4KxuI+bjMO2pFHTDby4bI7dIMyZtDOi76/0nr21pMc5OOVCUEULoqKCfjy5Z26kpqqMgobinP
 aKFbwHds7vpGPZpxlVLZPVhAM+YMeD548w0MqW4pcKlQ2KYClFNYvafCjF8JOXYFOcZnFNG+0
 iD24cdjovU7tx6SFDfjlD11P3fDm6+rIw2LnUzWIjMfU2S7C6FD2QqoQV6z9ZrIpBNJ9V6BpM
 9lhmYbpAfCvEUs/1s3NjP8m5+QhHchbIfC3QCuywJ6aw73kPhI9siv3DM2bhAAYHaM5srciEn
 ILWyzG6t0bBq/tKjy5nIRkInYqfME+XCaSwZfM0cDorM3M7Ka/2mSVGtUzoI0rtwFXcN4bHG5
 VjD+fzJYfT4VJ2A3tGdB6oLj1M2/5P4EOzH4qXyZOPdz/KopdlaV+Z3slyxpZ7iGpA84Tr8eR
 NtmbgDB3TDnQ1jLNZVymgQ5h+LdfrC8VtpSNUiwcecEXyzpgYSlgzVHy8GeKw1//U1au4X7+o
 gYSjkBMNEwJmG+O+RARW4ViXahKzqMwPoqzVRcO2K2/ZjDied2maXogA7L/vzG4cKy8rbCYCX
 fRkJo1Pncu4iNn4T0XyuNKiogEyXJuSJ7YnTezDjVWIb8Pp/XuG1rheZOBTdI+8M8yoMZf77f
 vfigb4xdCFbaM39jkmzl/fu3iQyLGfMRBTK3MSXvFWG3YHdaz2qularYgDynm0KQ9qb+Fqgzn
 klQ81EfeJY/sDmgDYEMqGoLuqww0byVKHA89pNJcOQtE6sejar7UPRKxaD4MAwRlzmB7JhO23
 pAuBTJPthxJpr8lK3Lu8gVpqCo/QN6VxvqBWYBpGmyIicmsNKPdSFcT3sUwsnS20vB2zqUQoF
 DzZ25Ff23uM3T3Fi/iPsy9euvq0wUzC9MRg0lKz33dQbzQbAxt9O2voGxYnUk2SHEOgAsmK6M
 0D1uTm++YI/pF5Axvt7N1epvN1Fb5Z5UwGVbelCvh5hgEAhV7d5eMT+hJaYQm8T4Ig6l6OqZZ
 JfM8YruBv4BpDAjkwTWQ6R8s6WjJp2AVCaCHmehCqu9XZYPxv0UKo4yGNR/o/LBLlJ1nOa1kj
 5KwoPeO3FsmUDs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 01:29, Stephen Rothwell wrote:
> Hi all,
>
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/video/fbdev/omap2/omapfb/dss/dss.c: In function 'dss_add_child_c=
omponent':
> drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error: 'component_co=
mpare_dev' undeclared (first use in this function); did you mean 'componen=
t_master_del'?
>  1209 |         component_match_add(dev->parent, match, component_compar=
e_dev, dev);
>       |                                                 ^~~~~~~~~~~~~~~~=
~~~~~
>       |                                                 component_master=
_del
>
> Caused by commit
>
>   61038027aa13 ("video: fbdev: omapfb: Make use of the helper component_=
compare_dev")
>
> I have used the fbdev tree from next-20220215 for today.

Thanks Steven!
I've dropped that patch now, so your next pull should be fine.

Helge

