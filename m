Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20A2509B58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379142AbiDUI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiDUI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:59:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466861AF37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:56:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x3so2743782wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3M6lQ9qR+XwtBcA69Niq8/hSuqGVr5RlCxOMaMetgd8=;
        b=mMmp+s+Ja2DiUHpBrVZO77pItd5U++Mvcinab5CUDClwZImU0F9MxZlJfjA/cYA68G
         37tGwYpNplA/ExK4Ko3ov1ktMzWooeJnSFwcvFiviuvmuLSSYOIDM2nfeYW2dTXKR1XI
         caiFibMXknVu30k+qaDnhGrQhddi47AklAI54uxb+HT4H5eI4Gqpmn03Fk/CO0yYLgAe
         y3r246aD+wjXjzXBF3OyrF5ojrTZlSNARyrFM+GY0FCIsOAWsRDC9KCO6yplSPDfmdez
         CAnOWNRsl089KzWLriQGGhDYt/LuBPPIeYg3FCAwD6N9D18NfIthrO+rG1PrPPL61S8t
         qRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3M6lQ9qR+XwtBcA69Niq8/hSuqGVr5RlCxOMaMetgd8=;
        b=fKt1QjNRWjFKdHyiY4qr2fJ0pi+it1k+HUqjLGer7R15R9tpvNcB7YfY1NEK0gQ6Tp
         QC4Y+rmCbIlrLTwAmR5zS34eGPk355FL7ezdHkvuOyKJMDWblz8ZYK4+s52YCYY5j2Bd
         8gIR7zMJDcEd39LTLtmx98+gGB8K7iSQAZEMi+l/NxdzyoT99eHQ7JbmLrwAnwbySj+B
         6iX2v/5UUcvIL6qpK/1eXReOIOMJaIqaMRGfsazyfUZSnH0CBGn/1joZHBkHml06UrX6
         U0GBeFQ6j0G5/f/M6cic0jzdY67qOG3Cxq5HZk3IvLuNwiUmcJff0trnGQDfHJqHA2+n
         oXHA==
X-Gm-Message-State: AOAM532M6EUkRvrax4BkvTvltBdrHgSF9aNKWyxHn1HIdSBGUjU+wNGt
        2SKcIf5iJGwOTr68qKipEftoY/uFuqWcuFkynhPXqa4QBQo=
X-Google-Smtp-Source: ABdhPJwFjXQ7qiLG3pFwY40a8R3guX2kdTV+gPi012Z9zlkXn1jhZI4HmsSRK5lHO5Psv58dseA+uPHXYVBA/cCwDg8=
X-Received: by 2002:a05:600c:4e94:b0:392:8e2a:d794 with SMTP id
 f20-20020a05600c4e9400b003928e2ad794mr7713336wmq.107.1650531383717; Thu, 21
 Apr 2022 01:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1645795048.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1645795048.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 21 Apr 2022 10:56:12 +0200
Message-ID: <CAHTX3dKyUiyNz1g5sfBqZxn1xdcAcBZ=8OGVVOXX9CUPjGik-Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] microblaze: Add support for reserved memory
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 25. 2. 2022 v 14:17 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Hi,
>
> sending two patches for adding support for reserved memory nodes.
> Till now architecture ignores these nodes and normally use memory for own
> purpose.
> The first patch is memblock dump wiring to be able to confirm that
> reservation is working properly.
>
> Thanks,
> Michal
>
>
> Michal Simek (2):
>   microblaze: Wire memblock_dump_all()
>   microblaze: Add support for reserved memory defined by DT
>
>  arch/microblaze/mm/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> --
> 2.35.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
