Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA599591607
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiHLTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHLTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:41:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AFB2845;
        Fri, 12 Aug 2022 12:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 293ABCE2665;
        Fri, 12 Aug 2022 19:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1659EC433C1;
        Fri, 12 Aug 2022 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333294;
        bh=Jhp8EImDcFQ1I3lLiz1wueXh3H8v88TA334gDHprS38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7BNH43DCw+v+xi6bUIO8IjHZu13OLO2gwHYyWyWgQk/fLn/1zurdb70n5scDU+R0
         Kb1T0fRxdxZJ51AsCkEhhsHPW12iPK0k3RCkL7THKG8QPWgoL7E2BQQJq1rsfuLacR
         pLu3VSY+TzGU4HzOigDx18OTZEVllGa9Z/jSO8WZw1uh9Cs6TfHNikN11dAr7ICuJL
         ia5LyDsVjJxE9JmhHLmxYZUFlQh5aPVbubKN1TtBVy4RwWAvq3IAP+tGaBz9uPZFOv
         bE5psQgRimPXzFdRQGx/f6/BeO+zL+I0LOIi5Ndh7Gj0UvdvV3S7avv9NwyFUGnol+
         aadhSZ8fNU2qg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82F644035A; Fri, 12 Aug 2022 16:41:31 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:41:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Mayuresh Chitale <mchitale@ventanamicro.com>, linux@yadro.com,
        Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Kautuk Consul <kconsul@ventanamicro.com>
Subject: Re: [PATCH v5] perf arch events: riscv sbi firmware std event files
Message-ID: <Yvas60duFUkSzuz+@kernel.org>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
 <20220628114625.166665-4-nikita.shubin@maquefel.me>
 <18c8e9c74955c08fdbd631a35c51b30f3cff3cd3.camel@ventanamicro.com>
 <20220811112303.4e5f0566@redslave.neermore.group>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811112303.4e5f0566@redslave.neermore.group>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 11, 2022 at 11:23:03AM +0300, Nikita Shubin escreveu:
> Hello Mayuresh!
> 
> On Wed, 10 Aug 2022 20:26:18 +0530
> Mayuresh Chitale <mchitale@ventanamicro.com> wrote:
> 
> > On Tue, 2022-06-28 at 14:45 +0300, Nikita Shubin wrote:
> > > From: Nikita Shubin <n.shubin@yadro.com>
> > > 
> > > Firmware events are defined by "RISC-V Supervisor Binary Interface
> > > Specification", which means they should be always available as long
> > > as
> > > firmware supports >= 0.3.0 SBI.
> > > 
> > > Expose them to arch std events, so they can be reused by particular
> > > PMU bindings.
> > > 
> > > Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> > > ---
> > > v4->v5:
> > > - changed EventCode to ConfigCode, as 63 bit exceeds event code
> > > format
> > > ---
> > >  .../arch/riscv/riscv-sbi-firmware.json        | 134
> > > ++++++++++++++++++
> > >  1 file changed, 134 insertions(+)
> > >  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-
> > > firmware.json
> > > 
> > > diff --git
> > > a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> > > b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json new file
> > > mode 100644 index 000000000000..b9d305f1ada8
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> > > @@ -0,0 +1,134 @@
> > > +[
> > > +  {
> > > +    "PublicDescription": "Misaligned load trap",
> > > +    "ConfigCode": "0x8000000000000000",
> > > +    "EventName": "FW_MISALIGNED_LOAD",
> > > +    "BriefDescription": "Misaligned load trap event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Misaligned store trap",
> > > +    "ConfigCode": "0x8000000000000001",
> > > +    "EventName": "FW_MISALIGNED_STORE",
> > > +    "BriefDescription": "Misaligned store trap event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Load access trap",
> > > +    "ConfigCode": "0x8000000000000002",
> > > +    "EventName": "FW_ACCESS_LOAD",
> > > +    "BriefDescription": "Load access trap event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Store access trap",
> > > +    "ConfigCode": "0x8000000000000003",
> > > +    "EventName": "FW_ACCESS_STORE",
> > > +    "BriefDescription": "Store access trap event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Illegal instruction trap",
> > > +    "ConfigCode": "0x8000000000000004",
> > > +    "EventName": "FW_ILLEGAL_INSN",
> > > +    "BriefDescription": "Illegal instruction trap event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Set timer event",
> > > +    "ConfigCode": "0x8000000000000005",
> > > +    "EventName": "FW_SET_TIMER",
> > > +    "BriefDescription": "Set timer event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent IPI to other HART event",
> > > +    "ConfigCode": "0x8000000000000006",
> > > +    "EventName": "FW_IPI_SENT",
> > > +    "BriefDescription": "Sent IPI to other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received IPI from other HART event",
> > > +    "ConfigCode": "0x8000000000000007",
> > > +    "EventName": "FW_IPI_RECEIVED",
> > > +    "BriefDescription": "Received IPI from other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent FENCE.I request to other HART
> > > event",
> > > +    "ConfigCode": "0x8000000000000008",
> > > +    "EventName": "FW_FENCE_I_SENT",
> > > +    "BriefDescription": "Sent FENCE.I request to other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received FENCE.I request from other HART
> > > event",
> > > +    "ConfigCode": "0x8000000000000009",
> > > +    "EventName": "FW_FENCE_I_RECEIVED",
> > > +    "BriefDescription": "Received FENCE.I request from other HART
> > > event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent SFENCE.VMA request to other HART
> > > event",
> > > +    "ConfigCode": "0x80000000000000a",
> > > +    "EventName": "FW_SFENCE_VMA_SENT",
> > > +    "BriefDescription": "Sent SFENCE.VMA request to other HART
> > > event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received SFENCE.VMA request from other
> > > HART event",
> > > +    "ConfigCode": "0x800000000000000b",
> > > +    "EventName": "FW_SFENCE_VMA_RECEIVED",
> > > +    "BriefDescription": "Received SFENCE.VMA request from other
> > > HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent SFENCE.VMA with ASID request to
> > > other HART event",
> > > +    "ConfigCode": "0x800000000000000c",
> > > +    "EventName": "FW_SFENCE_VMA_RECEIVED",
> > > +    "BriefDescription": "Sent SFENCE.VMA with ASID request to other
> > > HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received SFENCE.VMA with ASID request
> > > from other HART event",
> > > +    "ConfigCode": "0x800000000000000d",
> > > +    "EventName": "FW_SFENCE_VMA_ASID_RECEIVED",
> > > +    "BriefDescription": "Received SFENCE.VMA with ASID request from
> > > other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent HFENCE.GVMA request to other HART
> > > event",
> > > +    "ConfigCode": "0x800000000000000e",
> > > +    "EventName": "FW_HFENCE_GVMA_SENT",
> > > +    "BriefDescription": "Sent HFENCE.GVMA request to other HART
> > > event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received HFENCE.GVMA request from other
> > > HART event",
> > > +    "ConfigCode": "0x800000000000000f",
> > > +    "EventName": "FW_HFENCE_GVMA_RECEIVED",
> > > +    "BriefDescription": "Received HFENCE.GVMA request from other
> > > HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent HFENCE.GVMA with VMID request to
> > > other HART event",
> > > +    "ConfigCode": "0x8000000000000010",
> > > +    "EventName": "FW_HFENCE_GVMA_VMID_SENT",
> > > +    "BriefDescription": "Sent HFENCE.GVMA with VMID request to
> > > other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received HFENCE.GVMA with VMID request
> > > from other HART event",
> > > +    "ConfigCode": "0x8000000000000011",
> > > +    "EventName": "FW_HFENCE_GVMA_VMID_RECEIVED",
> > > +    "BriefDescription": "Received HFENCE.GVMA with VMID request
> > > from other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent HFENCE.VVMA request to other HART
> > > event",
> > > +    "ConfigCode": "0x8000000000000012",
> > > +    "EventName": "FW_HFENCE_VVMA_SENT",
> > > +    "BriefDescription": "Sent HFENCE.VVMA request to other HART
> > > event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received HFENCE.VVMA request from other
> > > HART event",
> > > +    "ConfigCode": "0x8000000000000013",
> > > +    "EventName": "FW_HFENCE_VVMA_RECEIVED",
> > > +    "BriefDescription": "Received HFENCE.VVMA request from other
> > > HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Sent HFENCE.VVMA with ASID request to
> > > other HART event",
> > > +    "ConfigCode": "0x8000000000000014",
> > > +    "EventName": "FW_HFENCE_VVMA_ASID_SENT",
> > > +    "BriefDescription": "Sent HFENCE.VVMA with ASID request to
> > > other HART event"
> > > +  },
> > > +  {
> > > +    "PublicDescription": "Received HFENCE.VVMA with ASID request
> > > from other HART event",
> > > +    "ConfigCode": "0x8000000000000015",
> > > +    "EventName": "FW_HFENCE_VVMA_ASID_RECEIVED",
> > > +    "BriefDescription": "Received HFENCE.VVMA with ASID request
> > > from other HART event"
> > > +  }
> > > +]  
> > 
> > When testing with perf using firmware events we saw this error: 
> > WARNING: event 'N/A' not valid (bits 59 of config '80000000000000a'
> > not supported by kernel)!
> > 
> > It looks it is due to a typo and applying the below patch resolved the
> > issue for us.
> 
> Thanks for catching this - indeed this is a correct fix.
> 
> > 
> > Tested-by: Kautuk Consul <kconsul@ventanamicro.com>
> 
> Thank you for testing!

Can you please resubmit with the fixes, rebased to the current
acme/perf/core branch?

If I get this today it may even get into v6.0. :-)

Thanks,

- Arnaldo
