Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18565432D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiFHOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiFHOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:41:26 -0400
X-Greylist: delayed 91453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 07:41:17 PDT
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B33F307;
        Wed,  8 Jun 2022 07:41:17 -0700 (PDT)
Received: from myt5-ca6a6e6c0c8f.qloud-c.yandex.net (myt5-ca6a6e6c0c8f.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3b1a:0:640:ca6a:6e6c])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id E12756CB67AF;
        Wed,  8 Jun 2022 17:41:14 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by myt5-ca6a6e6c0c8f.qloud-c.yandex.net (mxback/Yandex) with ESMTP id jHhEC4bm6W-fBg4bMNT;
        Wed, 08 Jun 2022 17:41:14 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654699274;
        bh=kbcWG7z8hVYH/9ji+sJIvTclsAnw9XhdMRAxX2veCeY=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=d+FYZIQfI623WY4DWp0DvX/qyw9CAjhvrgGyXVEBveQVm2xFf/8wfbjM0Ve6JjP5c
         I+W0AufQYClhW2qe6tNXClkucR4AUecvdGN+aEsB1dIg0PBObMWJn3Aemclkq7/nKU
         +sRET8c3nyVnamnYBb9Gi8jp/vrWG+ausqsvvH8Y=
Authentication-Results: myt5-ca6a6e6c0c8f.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id biE6ZnHqZS-fAMuNMp1;
        Wed, 08 Jun 2022 17:41:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Wed, 8 Jun 2022 17:41:07 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     John Garry <john.garry@huawei.com>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?B?Sm/Do28g?= =?UTF-8?B?TcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v3 3/4] RISC-V: Added generic pmu-events mapfile
Message-ID: <20220608174107.7b94e545@redslave.neermore.group>
In-Reply-To: <9e981523-6032-fd24-08f9-0ef771cd1c2e@huawei.com>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
        <20220607131648.29439-4-nikita.shubin@maquefel.me>
        <9e981523-6032-fd24-08f9-0ef771cd1c2e@huawei.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, John.

On Wed, 8 Jun 2022 11:45:53 +0100
John Garry <john.garry@huawei.com> wrote:

> On 07/06/2022 14:16, Nikita Shubin wrote:
> > From: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.pt>
> >=20
> > The pmu-events now supports custom events for RISC-V, plus the
> > cycle, time and instret events were defined.
> >=20
> > Signed-off-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisbo=
a.pt>
> > Tested-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> >   tools/perf/pmu-events/arch/riscv/mapfile.csv  | 14 +++++++++++++
> >   .../pmu-events/arch/riscv/riscv-generic.json  | 20
> > +++++++++++++++++++ 2 files changed, 34 insertions(+)
> >   create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
> >   create mode 100644
> > tools/perf/pmu-events/arch/riscv/riscv-generic.json
> >=20
> > diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> > b/tools/perf/pmu-events/arch/riscv/mapfile.csv new file mode 100644
> > index 000000000000..4f2aa199d9cb
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> > @@ -0,0 +1,14 @@
> > +# Format:
> > +#	MIDR,Version,JSON/file/pathname,Type
> > +#
> > +# where
> > +#	MIDR	Processor version =20
>=20
> ARM, no?

I've messed with --cc-cmd badly and didn't include every one in cover
letter, sorry for that, attaching link to cover letter:

https://lore.kernel.org/all/20220607131648.29439-1-nikita.shubin@maquefel.m=
e/

They are ARM inspired indeed.


>=20
> > +#		Variant[23:20] and Revision [3:0] should be zero.
> > +#	Version could be used to track version of JSON file
> > +#		but currently unused.
> > +#	JSON/file/pathname is the path to JSON file, relative
> > +#		to tools/perf/pmu-events/arch/riscv/.
> > +#	Type is core, uncore etc
> > +#
> > +#
> > +#Family-model,Version,Filename,EventType
> > diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> > b/tools/perf/pmu-events/arch/riscv/riscv-generic.json new file mode
> > 100644 index 000000000000..013e50efad99
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json =20
>=20
> where or how are these referenced?

Currently they are not referenced in this version of series at all,
their purpose is to be used like "ArchStdEvent".

Through any RISCV implementation should have at least these 3 events.

Yours,
Nikita Shubin.

>=20
> > @@ -0,0 +1,20 @@
> > +[
> > +  {
> > +    "PublicDescription": "CPU Cycles",
> > +    "EventCode": "0x00",
> > +    "EventName": "riscv_cycles",
> > +    "BriefDescription": "CPU cycles RISC-V generic counter"
> > +  },
> > +  {
> > +    "PublicDescription": "CPU Time",
> > +      "EventCode": "0x01",
> > +      "EventName": "riscv_time",
> > +      "BriefDescription": "CPU time RISC-V generic counter"
> > +  },
> > +  {
> > +    "PublicDescription": "CPU Instructions",
> > +      "EventCode": "0x02",
> > +      "EventName": "riscv_instret",
> > +      "BriefDescription": "CPU retired instructions RISC-V generic
> > counter"
> > +  }
> > +]
> > \ No newline at end of file =20
>=20

