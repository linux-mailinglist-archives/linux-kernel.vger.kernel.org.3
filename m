Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8A476F95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhLPLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhLPLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:12:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C1C061401
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:12:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so85422683edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u932GSJV/GiPJyCOKRpzkGtZtSK7Zimpx7ighFqWdyA=;
        b=Y/ZqAHeW8Qwu+zofeZd1pQNga5/fSIV5qRSMPXGSqvD3IKStFRfrrMLLqVeVWJZ32d
         u8RnVz5OUjaP/6eJfX+Wg7yLXHgR0uWdHomIvl8ElPlWDGKBrHrZ9sZ1RUmssix/6srF
         nJKwjyOaUV/cAYZTsC5Fv0Iu44mMlKMtzyaCbY2mKGZZYPN4y0OA2xDTnqclTWqXabRt
         28/sPwJbPfp1rWoNTghkE8pIFF4FvYE9Ug9WBCYPSZey/EPznKnyr8RGQ85tLiBBMyW2
         rfshIzMTSJemvNy6SNdnFfzxMYiH8iqPC5fCqq0feXz9XuhKRaG2jkgv4nSZ9ZSGa8tH
         seBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u932GSJV/GiPJyCOKRpzkGtZtSK7Zimpx7ighFqWdyA=;
        b=PgR+MLglWwLlJrWo4B6nPcGkftvI+BEgh/AIUVtWFR0lM/wla3LhmHCXcJzh1hvpG1
         Bq/PO6OdLpRnhP7Ade35hmSLXlNxfW2pj1nOlY+jtVi+cmoUFydtRAWSjQBBX/IqF+GJ
         mxobHAGg2et2NIBa15aKApcbAhO1zJ+OViGa0elSodheZfKG0k9UaVG88Osb5jU0W4To
         jf9lQJwDR1Nmp/urFei39r06n/QkrFrLiqatDcbtQL29l3uWMjFtb1BDnW7TTTaLYOzf
         z4e/drZVfYTgEwQl/ddy+ZVrfBGvA6bXviU+y1ctCMSFDQ0I7qrEKpwd+qCCyOrG482i
         SZew==
X-Gm-Message-State: AOAM532wd1lt9Fpje+dq8LzS16YuyK9yvgZdh2z8P0MiETAgytiX2qTC
        U2a2BkGlbJuRpURHiBbN2E5Hag==
X-Google-Smtp-Source: ABdhPJyn492ffTJC/7N7g5UlnS7AjuujBXBAP9C6Q/ktkzMEn1VbO8Zd6kp9N06Wn8/BO2etWoDLFg==
X-Received: by 2002:a05:6402:1ca2:: with SMTP id cz2mr19401692edb.302.1639653123810;
        Thu, 16 Dec 2021 03:12:03 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id w7sm2263755ede.66.2021.12.16.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:12:03 -0800 (PST)
Date:   Thu, 16 Dec 2021 19:11:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf arm-spe: Synthesize SPE instruction events
Message-ID: <20211216111157.GA27239@leoy-ThinkPad-X240s>
References: <20211215184605.92787-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215184605.92787-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Wed, Dec 15, 2021 at 06:46:05PM +0000, German Gomez wrote:
> Synthesize instruction events per every decoded ARM SPE record.
> 
> Because Arm SPE implements a hardware-based sample period, and perf
> implements a software-based one that gets applied on top, also add a
> warning to make the user aware.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
> Changes since v1 [https://lore.kernel.org/all/20211117142833.226629-1-german.gomez@arm.com]
>   - Generate events with "--itrace=i" instead of "--itrace=o".
>   - Generate events with virt_addr, phys_addr, and data_src values.
> ---
>  tools/perf/util/arm-spe.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index fccac06b573a..879583822c8f 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -58,6 +58,8 @@ struct arm_spe {
>  	u8				sample_branch;
>  	u8				sample_remote_access;
>  	u8				sample_memory;
> +	u8				sample_instructions;
> +	u64				instructions_sample_period;
>  
>  	u64				l1d_miss_id;
>  	u64				l1d_access_id;
> @@ -68,6 +70,7 @@ struct arm_spe {
>  	u64				branch_miss_id;
>  	u64				remote_access_id;
>  	u64				memory_id;
> +	u64				instructions_id;
>  
>  	u64				kernel_start;
>  
> @@ -90,6 +93,7 @@ struct arm_spe_queue {
>  	u64				time;
>  	u64				timestamp;
>  	struct thread			*thread;
> +	u64				period_instructions;
>  };
>  
>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
> @@ -202,6 +206,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
>  	speq->pid = -1;
>  	speq->tid = -1;
>  	speq->cpu = -1;
> +	speq->period_instructions = 0;
>  
>  	/* params set */
>  	params.get_trace = arm_spe_get_trace;
> @@ -351,6 +356,33 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>  
> +static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
> +					     u64 spe_events_id, u64 data_src)
> +{
> +	struct arm_spe *spe = speq->spe;
> +	struct arm_spe_record *record = &speq->decoder->record;
> +	union perf_event *event = speq->event_buf;
> +	struct perf_sample sample = { .ip = 0, };
> +
> +	/*
> +	 * Handles perf instruction sampling period.
> +	 */
> +	speq->period_instructions++;
> +	if (speq->period_instructions < spe->instructions_sample_period)
> +		return 0;
> +	speq->period_instructions = 0;
> +
> +	arm_spe_prep_sample(spe, speq, event, &sample);
> +
> +	sample.id = spe_events_id;
> +	sample.stream_id = spe_events_id;
> +	sample.addr = record->virt_addr;
> +	sample.phys_addr = record->phys_addr;
> +	sample.data_src = data_src;
> +
> +	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
> +}
> +
>  #define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
>  			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
>  			 ARM_SPE_REMOTE_ACCESS)
> @@ -480,6 +512,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  			return err;
>  	}
>  
> +	if (spe->sample_instructions) {
> +		err = arm_spe__synth_instruction_sample(speq, spe->instructions_id, data_src);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1107,6 +1145,26 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  			return err;
>  		spe->memory_id = id;
>  		arm_spe_set_event_name(evlist, id, "memory");
> +		id += 1;
> +	}
> +
> +	if (spe->synth_opts.instructions) {
> +		if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS)
> +			return -EINVAL;

Will this break some perf commands, like "perf report" or other perf
report commands?

See the the function arm_spe_process_auxtrace_info(), it invokes [1]:

    itrace_synth_opts__set_default(&spe->synth_opts, false);

So synth_opts.instructions is initialized to true,
synth_opts.period_type is set to PERF_ITRACE_DEFAULT_PERIOD_TYPE (2),
so the perf tool will directly bail out when synth_opts.period_type is
not equal to PERF_ITRACE_PERIOD_INSTRUCTIONS.

If we only support period type PERF_ITRACE_PERIOD_INSTRUCTIONS at
current stage, I think we use the checking like below:

  if (spe->synth_opts.instructions &&
      (spe->synth_opts.period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS)) {

     ...
  }

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/arm-spe.c#n1180

> +
> +		if (spe->synth_opts.period > 1)
> +			pr_warning("Arm SPE has a hardware-based sample period.\n"
> +				   "More instruction events will be discarded by --itrace\n");

Okay, Since Arm SPE is statistical profiling, so this is the right thing to
do.

Please also address Namhyung's two comments, the rest of this patch looks
good to me.

Thanks,
Leo

> +
> +		spe->sample_instructions = true;
> +		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> +		attr.sample_period = spe->synth_opts.period;
> +		spe->instructions_sample_period = attr.sample_period;
> +		err = arm_spe_synth_event(session, &attr, id);
> +		if (err)
> +			return err;
> +		spe->instructions_id = id;
> +		arm_spe_set_event_name(evlist, id, "instructions");
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
