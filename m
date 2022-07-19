Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E825F57A968
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiGSVvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiGSVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:50:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D36D763907;
        Tue, 19 Jul 2022 14:50:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61061576;
        Tue, 19 Jul 2022 14:50:47 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C9F3F70D;
        Tue, 19 Jul 2022 14:50:45 -0700 (PDT)
Message-ID: <b7f42920-9ca7-ae4e-9c71-34846508cfb1@arm.com>
Date:   Tue, 19 Jul 2022 22:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/13] kernel: events: Export
 perf_report_aux_output_id()
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-11-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-11-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 09:11, Mike Leach wrote:
> CoreSight trace being updated to use the perf_report_aux_output_id()
> in a similar way to intel-pt.
> 
> This function in needs export visibility to allow it to be called from
> kernel loadable modules, which CoreSight may configured to be built as.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   kernel/events/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 80782cddb1da..f5835e5833cd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9117,6 +9117,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>   
>   	perf_output_end(&handle);
>   }
> +EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
>   
>   static int
>   __perf_event_account_interrupt(struct perf_event *event, int throttle)

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

