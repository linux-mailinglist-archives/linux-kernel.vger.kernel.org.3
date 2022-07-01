Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3256315B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiGAK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiGAK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:28:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85AA474DE7;
        Fri,  1 Jul 2022 03:28:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834F21515;
        Fri,  1 Jul 2022 03:28:57 -0700 (PDT)
Received: from [10.57.85.211] (unknown [10.57.85.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8F73F66F;
        Fri,  1 Jul 2022 03:28:53 -0700 (PDT)
Message-ID: <15baa17c-b2d1-329f-366f-69ad209a879a@arm.com>
Date:   Fri, 1 Jul 2022 11:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v11 7/9] dt-bindings: arm: Adds CoreSight TPDA hardware
 definitions
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
 <20220620120101.2906-8-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220620120101.2906-8-quic_jinlmao@quicinc.com>
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
> Adds new coresight-tpda.yaml file describing the bindings required
> to define tpda in the device trees.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
