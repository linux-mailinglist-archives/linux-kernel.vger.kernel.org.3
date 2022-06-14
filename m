Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCF54BD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351044AbiFNWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiFNWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:13:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D86C243EEB;
        Tue, 14 Jun 2022 15:13:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0701763;
        Tue, 14 Jun 2022 15:13:10 -0700 (PDT)
Received: from [10.57.84.206] (unknown [10.57.84.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C5993F73B;
        Tue, 14 Jun 2022 15:13:07 -0700 (PDT)
Message-ID: <05636dcb-91bd-a1a4-911b-6cdc7e359a5c@arm.com>
Date:   Tue, 14 Jun 2022 23:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v10 06/10] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220611004331.7343-1-quic_jinlmao@quicinc.com>
 <20220611004331.7343-7-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220611004331.7343-7-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2022 01:43, Mao Jinlong wrote:
> Add API usage document for sysfs API in TPDM driver.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm    | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> new file mode 100644
> index 000000000000..92bc09fbb69b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
> +Date:		June 2022
> +KernelVersion	5.18

We have gone past this release. Please make this 5.20. Also, please 
merge this patch with the previous patch.

> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Run integration test for tpdm. Integration test
> +		will generate test data for tpdm. It can help to make
> +		sure that the trace path is enabled and the link configurations
> +		are fine.
> +
> +		value to this sysfs node:

This is not entirely clear to me/reader. Could we say :

		Accepts only one of the 2 values -  1 or 2.
	
> +		1 : Generate 64 bits data
> +		2 : Generate 32 bits data


Suzuki
