Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0F4F7E55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbiDGLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiDGLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F691BB83F;
        Thu,  7 Apr 2022 04:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F4D1B82735;
        Thu,  7 Apr 2022 11:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B56C385A0;
        Thu,  7 Apr 2022 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649331983;
        bh=0OT/pbL/bCsecfbmfmzzjwR0DFUK3jYCqf8QkiC0Zg4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MyDiTj+WTQRyjtDcVJWDY6CGKvEpRjIBoRGOPjEE5F9AZB6BnrWVFYz8TrEO7puWq
         nfay/xR3rWhG20lst1aJuOLGWeD/kRRaWquuw6+tec2RCzkNmS2c2EICTzQxiRfQp/
         dyxTbuNhkAsuzUQGQL5p1ksZr0jEzubyok+Ite06os79KyVPnlQVRxOmvpQqGcfkCN
         2ATpd2REoprBPWUQdwYRjbGd1zdgs3/6cj3dBhdsXODAyutWM2zQquA6iwaiLlKqGZ
         H7Xg3iQEncjZ2Z9gjyqs/DdomJ9vwfxevnHyZAGVV2Aje0aZgslyPGFOfGm34H3amt
         iJ/0Zx8CiH7Tg==
Message-ID: <47f0c906-02be-2635-15e9-4ad8866a3a62@kernel.org>
Date:   Thu, 7 Apr 2022 13:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406094156.3191-1-chenxiangrui@huaqin.corp-partner.google.com>
 <Yk21MbGKVi8d9cAy@google.com>
 <CA+Bnokw-8023cvifSZtT8WR4TvUi8K3512TmEoXhKezMjbQNUQ@mail.gmail.com>
 <78ddc1a6-4597-46b7-76f0-32087ed62546@kernel.org>
In-Reply-To: <78ddc1a6-4597-46b7-76f0-32087ed62546@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 13:38, Krzysztof Kozlowski wrote:
> On 07/04/2022 10:15, Mars Chen wrote:
>> Hi Matthias,
>> I had removed camera related files on upstream device trees.
>>
>> Hi Krzysztof,
>> The v2 patch just addressed the v1 patch comment and I had sent the v2
>> patch. 
>>
> 
> Hi,
> 
> I do not see it being addressed at all. :(

What is more, this is your third try and still did not fix the
checkpatch warning (which is the same issue I pointed out). Did you run
the checkpatch before sending the patch?

Best regards,
Krzysztof
