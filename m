Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D13565911
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGDO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiGDOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:55:46 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFEFD09;
        Mon,  4 Jul 2022 07:55:44 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264BGm04020004;
        Mon, 4 Jul 2022 16:55:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=brTErhvCe4ShDsJ5IGo0sShNMnEReS02R6w4QHQj8JI=;
 b=aWt7WlPKtlwzQZ5QWmym+oNhdOpJItxEg2SbEgE5Wlff2bM4JObo7SB/kbwed5Kejpmq
 pyZtmcOuVbrclKVHkFwUzsM9xgbd81Z562DaDoQb4LIsmv5orD/Z1kNv9OEmdSDqc4uU
 2xKLrq/9v+KKxKOpAwUMpw3XeLBeGeQhCa+VYQJmPRExHthdHeg9MNUXwTpkQBHL0gqc
 b3MZvStE+akRxMam7p3+5O96b0ydZzWIKEsAIz/lcwg0dJLr1kxvaQGGyJhi7GXliV+e
 bKXQsyxEfVoJsQf+wFG17phgxVczcsZBV6Gmy54Bzf65SAElG30lI5XTj0zLeK5qMbqU 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2cwhu32f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 16:55:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82C73100034;
        Mon,  4 Jul 2022 16:55:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BD1921FE9C;
        Mon,  4 Jul 2022 16:55:07 +0200 (CEST)
Received: from [10.252.4.55] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 16:55:06 +0200
Message-ID: <ad2ad5b3-9cd4-d0a8-ddec-e078f0ad87a1@foss.st.com>
Date:   Mon, 4 Jul 2022 16:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 1/2] remoteproc: introduce rproc features
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20220701093702.265249-1-peng.fan@oss.nxp.com>
 <20220701093702.265249-2-peng.fan@oss.nxp.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220701093702.265249-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 7/1/22 11:37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> remote processor may support:
>  - firmware recovery with help from main processor
>  - self recovery without help from main processor
>  - iommu
>  - etc
> 
> Introduce rproc features could simplify code to avoid adding more bool
> flags
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_internal.h | 15 +++++++++++++++
>  include/linux/remoteproc.h               | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 72d4d3d7d94d..82247cb5d0c2 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,21 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
> +{
> +	return test_bit(feature, rproc->features);
> +}
> +
> +static inline int rproc_set_feature(struct rproc *rproc, unsigned int feature)
> +{
> +	if (feature >= RPROC_MAX_FEATURES)
> +		return -EINVAL;
> +
> +	set_bit(feature, rproc->features);
> +
> +	return 0;
> +}
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index aea79c77db0f..bbfb3affff32 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -489,6 +489,19 @@ struct rproc_dump_segment {
>  	loff_t offset;
>  };
>  
> +/**
> + * enum rproc_features - features supported
> + *
> + * @RPROC_FEAT_ATTACH_ON_RECOVERY: remote processor no need help from Linux
> + *                                 to recover, such as firmware loading.
typo: 
s/remote processor no need/ The remote processor does not need/

> + *                                 Linux just need to attach after recovery.
typo 
s/need/needs/

Regards,
Arnaud

> + */
> +
> +enum rproc_features {
> +	RPROC_FEAT_ATTACH_ON_RECOVERY,
> +	RPROC_MAX_FEATURES,
> +};
> +
>  /**
>   * struct rproc - represents a physical remote processor device
>   * @node: list node of this rproc object
> @@ -530,6 +543,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
> + * @features: indicate remoteproc features
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -570,6 +584,7 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
>  };
>  
>  /**
