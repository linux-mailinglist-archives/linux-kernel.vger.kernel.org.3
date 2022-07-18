Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B436577C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGRHPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C111804;
        Mon, 18 Jul 2022 00:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9A66134B;
        Mon, 18 Jul 2022 07:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B4C341C0;
        Mon, 18 Jul 2022 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658128549;
        bh=Z2cmY8+eKqIV7mFoiE72EWO95/pjIwP9a1crVM1liS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NaY8xlRcwPnM+zohaXrpoBcxanhOI1nvQuSyg/VK+e4A0wZ2Nuias53yuUxB4xNrH
         fj5dbm3zxoTXbY4W2y0yHDRABf2GvRwOdtFCy4P9swUIFMlsqCNBPKfrQLcbla6wNX
         PgOJ8V3L9ruzZEQV6HBrVre7SJBPUFj39+IboOS/Z7Cikn67hJ0RtNb/ZP3BWpfHBb
         9gDrX23ky5OSKysC3qrmbS0mG2LrKslm1MrvvdCUUjfOCFKFfA89bV9i0ae/0jwBVP
         VGVWxSVsOxBzJl7p34+Yt4R1F3mXPIE6Pa1Sv8+ReOrPVXxGqwm03kVL5kzuXv83px
         5NHGKmKA0qsdA==
Message-ID: <91613bc8-8a9e-00ed-71c9-ebf4eabed396@kernel.org>
Date:   Mon, 18 Jul 2022 10:15:44 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] Add interconnect support for SM6350
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
 <CLG9OKW0OMLX.2XWU1ZHFRR9RQ@otso>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <CLG9OKW0OMLX.2XWU1ZHFRR9RQ@otso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.07.22 16:34, Luca Weiss wrote:
> Hi all,
> 
> On Wed May 25, 2022 at 4:43 PM CEST, Luca Weiss wrote:
>> This series adds interconnect support for the various NoCs found on
>> sm6350.
>>
>> A more special modification is allowing child NoC devices, like done for
>> rpm-based qcm2290 which was already merged, but now for rpmh-based
>> interconnect.
> 
> any feedback on the two interconnect patches and the dts patch?
> Georgi? Bjorn?

I merged the interconnect patches.

Thanks,
Georgi
