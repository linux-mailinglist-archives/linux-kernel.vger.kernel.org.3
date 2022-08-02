Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34358813E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiHBRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiHBRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:43:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B1384E855;
        Tue,  2 Aug 2022 10:43:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E21477;
        Tue,  2 Aug 2022 10:43:11 -0700 (PDT)
Received: from [10.57.13.116] (unknown [10.57.13.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704B73F70D;
        Tue,  2 Aug 2022 10:43:07 -0700 (PDT)
Message-ID: <7ff0a9c5-b009-7b45-ac85-8ce26619a00a@arm.com>
Date:   Tue, 2 Aug 2022 18:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 0/9] Coresight: Add support for TPDM and TPDA
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
References: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
 <3f714c34-277d-ef71-b527-f758172160f9@quicinc.com>
 <20260db2-8c7e-e2b6-2385-74f433e4b55e@quicinc.com>
 <23ae507d-1a01-9a33-52fb-73ac9efca8aa@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <23ae507d-1a01-9a33-52fb-73ac9efca8aa@quicinc.com>
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

Hi Trilok,

On 02/08/2022 18:33, Trilok Soni wrote:
> 
> 
> On 8/2/2022 7:43 AM, Jinlong Mao wrote:
>> Hi Reviewers,
>>
>> Please help to review V12 series of TPDM/TPDA patches.
>>
>> Thanks
>>
> 
> Suzuki and Mathieu, we are almost there it seems in getting the 
> acceptance of these patches, so I hope you find the time to review these 
> patches. I guess it is almost a year now for these patches and had a 
> good amount of reviews and revisions :)

This series has been reviewed for the previous versions (which is why
we have it in v12) and this one depends on a series worked on by Mike
Leach. We cannot push this without the dynamic Trace ID allocation
scheme, which is clearly mentioned in the cover letter for this
series.

As such this series is in a good shape, assuming all the comments
in the previous version has been addressed. So, we would rather
get Mike's work priority and pull that in, so that we can eventually
get this upstream.

Kind regards
Suzuki

> 
> ---Trilok Soni


