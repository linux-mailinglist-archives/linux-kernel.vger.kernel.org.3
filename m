Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC69542E29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiFHKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiFHKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:46:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61A10D5C3;
        Wed,  8 Jun 2022 03:45:58 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ3hH55gqz67jfG;
        Wed,  8 Jun 2022 18:42:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 12:45:56 +0200
Received: from [10.47.90.54] (10.47.90.54) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 11:45:55 +0100
Message-ID: <9e981523-6032-fd24-08f9-0ef771cd1c2e@huawei.com>
Date:   Wed, 8 Jun 2022 11:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/4] RISC-V: Added generic pmu-events mapfile
To:     Nikita Shubin <nikita.shubin@maquefel.me>
CC:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
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
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
 <20220607131648.29439-4-nikita.shubin@maquefel.me>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220607131648.29439-4-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.90.54]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 14:16, Nikita Shubin wrote:
> From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> 
> The pmu-events now supports custom events for RISC-V, plus the cycle,
> time and instret events were defined.
> 
> Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>   tools/perf/pmu-events/arch/riscv/mapfile.csv  | 14 +++++++++++++
>   .../pmu-events/arch/riscv/riscv-generic.json  | 20 +++++++++++++++++++
>   2 files changed, 34 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
>   create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json
> 
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> new file mode 100644
> index 000000000000..4f2aa199d9cb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -0,0 +1,14 @@
> +# Format:
> +#	MIDR,Version,JSON/file/pathname,Type
> +#
> +# where
> +#	MIDR	Processor version

ARM, no?

> +#		Variant[23:20] and Revision [3:0] should be zero.
> +#	Version could be used to track version of JSON file
> +#		but currently unused.
> +#	JSON/file/pathname is the path to JSON file, relative
> +#		to tools/perf/pmu-events/arch/riscv/.
> +#	Type is core, uncore etc
> +#
> +#
> +#Family-model,Version,Filename,EventType
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> new file mode 100644
> index 000000000000..013e50efad99
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json

where or how are these referenced?

> @@ -0,0 +1,20 @@
> +[
> +  {
> +    "PublicDescription": "CPU Cycles",
> +    "EventCode": "0x00",
> +    "EventName": "riscv_cycles",
> +    "BriefDescription": "CPU cycles RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Time",
> +      "EventCode": "0x01",
> +      "EventName": "riscv_time",
> +      "BriefDescription": "CPU time RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Instructions",
> +      "EventCode": "0x02",
> +      "EventName": "riscv_instret",
> +      "BriefDescription": "CPU retired instructions RISC-V generic counter"
> +  }
> +]
> \ No newline at end of file

