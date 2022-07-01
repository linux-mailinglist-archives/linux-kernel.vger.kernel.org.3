Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F625563013
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiGAJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiGAJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:29:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67DBA1EAFE;
        Fri,  1 Jul 2022 02:29:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4489D106F;
        Fri,  1 Jul 2022 02:29:23 -0700 (PDT)
Received: from [10.57.85.211] (unknown [10.57.85.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6AFF3F66F;
        Fri,  1 Jul 2022 02:29:19 -0700 (PDT)
Message-ID: <7225e043-11bf-40a4-5cd1-61902384d675@arm.com>
Date:   Fri, 1 Jul 2022 10:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v11 5/9] coresight-tpdm: Add integration test support
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
References: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
 <20220620120101.2906-6-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220620120101.2906-6-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 13:00, Mao Jinlong wrote:
> Integration test for tpdm can help to generate the data for
> verification of the topology during TPDM software bring up.
> 
> Sample:
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
