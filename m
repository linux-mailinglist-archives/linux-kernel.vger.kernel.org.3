Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E254B521
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbiFNPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiFNPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E61A81D;
        Tue, 14 Jun 2022 08:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE06612C5;
        Tue, 14 Jun 2022 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68808C3411D;
        Tue, 14 Jun 2022 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655222033;
        bh=tzwTRrFZAMJPPq7ecbtUI4HyV63VU6K1AACFhR5zqsQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eu50ignc9yRb5mIbzTwy2FNyIF7jCgD5BRTNkIVlSh980z2gHu3TmmVKH631rl+0N
         0F/Q6DgxqhobBNg4k7Dqm/H908nM3EyWEBHTrqZYajynrbcaf9jaQxeovkk3Dc39jx
         KhhnfJt6fOB7j+rthwtz33dRNLamvpmG8fuXCzvSWCAIjN1r1iwUehYfr1O86u9Gy1
         caswm5gOJnWBBAgYLK5LGf1gac1i1J3vQJ65U9o5kPa00Ag6DpDTXmURtbuH0NeHT4
         0Q15+oxLOvVoPWnuNUXBtYa7dg95Lxe35dxF+L9qMuje88kPtdbx9fSUT1BGtzCBBt
         PSYZbjLo5b1xA==
Message-ID: <eee82dd8-494f-4171-b56a-438ebf67a785@kernel.org>
Date:   Tue, 14 Jun 2022 10:53:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] arm64: dts: intel: socfpga_agilex: use defined GIC
 interrupt type for ECC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        niravkumar.l.rabara@intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
 <20220530072530.1685970-1-niravkumar.l.rabara@intel.com>
 <0b5bb492-dfe6-0388-491c-b2afc531f35b@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <0b5bb492-dfe6-0388-491c-b2afc531f35b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 02:31, Krzysztof Kozlowski wrote:
> On 30/05/2022 09:25, niravkumar.l.rabara@intel.com wrote:
>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>
>> Use defined GIC interrupt type instead of hard-coded numbers for ECC
>> (Error Correction Code) memory, which creates edac sysfs interface.
> 
> Ah, ECC was about device node... sounds fine.
> 
> Anyway, please always include tags you received.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof


Applied!

Thanks,
Dinh
