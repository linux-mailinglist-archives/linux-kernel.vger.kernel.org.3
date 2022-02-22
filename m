Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FC4BFEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiBVQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:39:15 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1F14890C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:38:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645547927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nStIt77r8ucuPO2eJ8ghDszb08Jpem5qKR80GoWQJGQ=;
        b=WT49d/GICcZgeuE/6cEJG0OLeG0g0YMwHLlXmXYXKV/PodtBTZITN8sIOroYlR4nmIQYSY
        lLGMxrWeQX7VcUUT4744A37BkbPPQ1A9PriN919/yglESzjz9vwoniBNQ18gNN6oa+kuxC
        ealGQtArXzBlWm7KjG0ETBLhFt0am/M=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220222114812.r6uil6lv2auxadsf@esperanza>
Date:   Tue, 22 Feb 2022 08:38:44 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Message-Id: <C65B36EF-BEB2-44D8-BA0C-52CEDDD40CC4@linux.dev>
References: <20220222114812.r6uil6lv2auxadsf@esperanza>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir!

> On Feb 22, 2022, at 3:48 AM, Vladimir Davydov <vdavydov.dev@gmail.com> wro=
te:
>=20
> =EF=BB=BFOn Mon, Feb 21, 2022 at 03:39:51PM -0800, Roman Gushchin wrote:
>> Add myself as a memcg co-maintainer. My primary focus over last few
>> years was the kernel memory accounting stack, but I do work on some
>> other parts of the memory controller as well.
>>=20
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> ---
>> MAINTAINERS | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 66aa3a589f6a..ecdb90e99ba7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4991,6 +4991,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>> M:    Johannes Weiner <hannes@cmpxchg.org>
>> M:    Michal Hocko <mhocko@kernel.org>
>> M:    Vladimir Davydov <vdavydov.dev@gmail.com>
>=20
> It's weird that I'm still on the list. AFAIR I sent a patch removing
> myself from the list a couple of years ago...
>=20
> Roman, could you please remove me from the list while you are at it?

Can you, please, send a patch to Andrew removing yourself, if it=E2=80=99s w=
hat you really want?
I=E2=80=99ve heard that it=E2=80=99s the preferred way in such cases.

Thanks!=
