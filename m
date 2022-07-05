Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A307056797A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiGEVqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGEVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544CBE36
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91A1CB819A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A7C341C7;
        Tue,  5 Jul 2022 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657057594;
        bh=U8oytdS3Sr57mzpNJqhOx+S7S3Yftn+YrpA6G/d0ItY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dIg6MhBa6xYSPTs7RjUTZ8605gQPii0BYb1N7JlDui/MkPWQ7yCvaevDDIQiwEW9o
         LDG0vnRMHil+vPqRDZntNLqspvGDqFeQJM1aNbScYUVFHHdjdjNLXa7P9Nc7/uWAdR
         J8flvTzpces08pwNfxJiTe7wEBx8dLq9RhmFgX8d3Bwhhr9ndudziO+wXmMSZmrDGk
         1zreAgk62aZB/p5gxLjV3+4fDOP/WcYjRUuUcWq8DSnptKeGcpKVfbC6XnzO19u36E
         gnLMOj9xf4iZFPd+cKNV09NxxuHnx5cSpHI/xPyp3D0WGTWyltNLGoQr4Nw7XghMcX
         y8fKfgQZyrXkg==
Message-ID: <725b7b32d65b4026313f658954f9f7ad31bd2c64.camel@kernel.org>
Subject: Re: [PATCH v7 0/4] tracing/probes: allow no event name input when
 create group
From:   Tom Zanussi <zanussi@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 05 Jul 2022 16:46:32 -0500
In-Reply-To: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuan,

On Mon, 2022-06-27 at 10:19 +0800, Linyu Yuan wrote:
> take kprobe event as example, when create a group of events,
> p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
> according to this format, we must input EVENT name,
>=20
> this change allow only GRP/ input, EVENT name auto generate from
> KSYM,
> p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
>=20
> similar change apply to eprobe and uprobe.

Thanks for making those changes!

For the series,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Tom

>=20
> V2: (v1:
> https://lore.kernel.org/lkml/1651397651-30454-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 fix remove comment in V1 patch1,
> =C2=A0=C2=A0=C2=A0 remove v1 patch2 as it is NACK.
>=20
> v3: (v2 :
> https://lore.kernel.org/lkml/1653795294-19764-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 add selftest cases for kprobe and eprobe event,
> =C2=A0=C2=A0=C2=A0 remove macro used in v1,v2,
> =C2=A0=C2=A0=C2=A0 change location to generate eprobe event name.
>=20
> v4: (v3 :
> https://lore.kernel.org/lkml/1653978552-18637-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 fix comment of kprobe/eprobe test case.
>=20
> v5: (v4:
> https://lore.kernel.org/lkml/1654171861-24014-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 for eprobe, when only input a "SYSTEM.", it is invalid=
.
> =C2=A0=C2=A0=C2=A0 add Acked-by from Masami Hiramatsu (Google) <mhiramat@=
kernel.org>
>=20
> v6: (v5:
> https://lore.kernel.org/lkml/1655168698-19898-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 change some code order according review comment from T=
om Zanussi,
> =C2=A0=C2=A0=C2=A0 some minor changes.
>=20
> v7: (v6:
> https://lore.kernel.org/lkml/1655776787-18133-1-git-send-email-quic_linyy=
uan@quicinc.com/
> )
> =C2=A0=C2=A0=C2=A0 move log index to a separate patch according review co=
mment
>=20
> Linyu Yuan (4):
> =C2=A0 tracing: eprobe: add missing log index
> =C2=A0 tracing: eprobe: remove duplicate is_good_name() operation
> =C2=A0 tracing: auto generate event name when create a group of events
> =C2=A0 selftests/ftrace: add test case for GRP/ only input
>=20
> =C2=A0Documentation/trace/kprobetrace.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++-=
---
> =C2=A0Documentation/trace/uprobetracer.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++----
> =C2=A0kernel/trace/trace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++-=
---
> =C2=A0kernel/trace/trace_dynevent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/trace/trace_eprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++-
> ----------
> =C2=A0kernel/trace/trace_kprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++----
> -
> =C2=A0kernel/trace/trace_probe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0kernel/trace/trace_uprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++----
> =C2=A0.../ftrace/test.d/dynevent/add_remove_eprobe.tc=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 ++++++-
> =C2=A0.../ftrace/test.d/dynevent/add_remove_kprobe.tc=C2=A0=C2=A0=C2=A0 |=
=C2=A0 7 ++++++
> =C2=A010 files changed, 64 insertions(+), 38 deletions(-)
>=20

