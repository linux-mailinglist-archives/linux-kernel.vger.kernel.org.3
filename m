Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2952BD19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiERNVT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 May 2022 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiERNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:21:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C53207B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:21:14 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mf0Nm-1nP7P03tzG-00gY1W for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022
 15:21:13 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ff53d86abbso4879067b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:21:12 -0700 (PDT)
X-Gm-Message-State: AOAM532aocdncswfo+3bluwEcBPO6bXU+DfzhvBcMhTLgIDwdDwGUdR1
        xUlLoL+YptAXCUlo7FxEW1p3kgQDtF8wV1RjV0o=
X-Google-Smtp-Source: ABdhPJwBjy4ur3XLA4K8ugyaq6ZpN4zxCDmLVI7nhrJH0342w016iDhD3WX3/lYGpyx1rpcDzpcnq5gSYG2aj9C9IIk=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr31357253ywk.209.1652880071778; Wed, 18
 May 2022 06:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220505125123.2088143-1-mpe@ellerman.id.au> <c6cbd41c-4cef-d4d7-324a-b4c3e2498262@csgroup.eu>
 <87fsl7nggr.fsf@mpe.ellerman.id.au>
In-Reply-To: <87fsl7nggr.fsf@mpe.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 14:21:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17qq2dpyv1SzD=VmXWAs0JQiyG-AQL=Uv+N6xQzoMsQQ@mail.gmail.com>
Message-ID: <CAK8P3a17qq2dpyv1SzD=VmXWAs0JQiyG-AQL=Uv+N6xQzoMsQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Add generic PAGE_SIZE config symbols
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:vSU/9qQem/qqXcK/9nouj8TNQEbk5M1f1RgDMXWBukLFFK6za1C
 ca0RLl4NezNg7sqC9oSsbFLdIIe2x4IsmvjTYtsYwzbttvcrW+N91J5sShldc5/tJ3CtWea
 rHmKBmQ3MUXv1jJJGRbyINrUheenw2Ev4Img7gYuSg/DeeDMBGDwXvfmeIjyruTR/wdGgUm
 f/UpPGzKmd8+8T5qE1Fpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BltRFptvygA=:K3/2R/fYfF7ot2yyTSj4SV
 hpniwt8UmJ4DeKd68EfR51BJDW4XNPAFB05AAitwa50UKHBkcu2W/WiH8WtN7hGr7JhJXl3Mj
 Ff3c+PDV4M91QzLIGJpgwDOeVME+GYxrLxrgWlRWsKZEM/Ondvq8Xfpq9nhEhhdHOo5EG62tv
 YUxbBNtElef2HJtzEvkRma05kcouLNpPojVul8I4L/GqARSd/AojkFE6ZaHSysbOPdhR2K67D
 5vpMUktKIAywsjMJ2kGde43gMrfmmSkq+9WWBzF2xE4P4YECbsZXMR3BLaNQniHq3A5BVpqPB
 sfsARJ7pzIKf6Zsnw5i+C/7dBo27UGjlqzixs6Wtgk4CrQJjLKGn49Xx4pf+UExLKrqDjJ2ys
 IddcWOPfBDEbCF1Z5D6Cw0GJQqgFHqzfipLokDm0rkngzECCW+OJYRkzuzPenwlllOVUViFle
 IRcb74/XBzFsa6yPBDGs8p1pAa6PgTsQ1kEVn2nY5k3ZkYUQ8usMzeK7TppX5Pwn7XEIcXKzi
 FF69nWsyajr7y5rkvgpPU31BRlCydjuVv/DRPgqlcEsD97NzmAM8Om1KiPyT5rPcPqARlHat5
 YRNp+ECa/biNMqG1imrFXjL7fKLedBAFZoE+Klp1LqKkaTUkxhOeuRE54iHkA0qWL1gyvhKi/
 m+K88ECS2ij5u7t0Mtk2rH0B48xXuLpEvLaYz46gQYP42a0xOC8hwDl6Ktu56HuJW/3M9z30m
 C/wHnZ1jxpF+hB0pUFiqcAJTIYlr9dYH0yyY2Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 2:00 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Le 05/05/2022 à 14:51, Michael Ellerman a écrit :
> >> Other arches (sh, mips, hexagon) use standard names for PAGE_SIZE
> >> related config symbols.
> >>
> >> Add matching symbols for powerpc, which are enabled by default but
> >> depend on our architecture specific PAGE_SIZE symbols.
> >>
> >> This allows generic/driver code to express dependencies on the PAGE_SIZE
> >> without needing to refer to architecture specific config symbols.
> >
> > I guess next step should be to get rid of powerpc specific symbols and
> > use generic symbols instead.
> >
> > We have (only) 111 occurences of it.
>
> I thought about doing that, but it's quite a bit of churn. Maybe it's
> worth it though to avoid confusion between the two symbols.

I have actually done this at some point, but for some reason never sent it out,
see my old patch at:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=randconfig-5.15-next&id=184c7273ee367fda3626e35f0079f181075690c8

Feel free to take ideas or the entire patch from that.

      Arnd
