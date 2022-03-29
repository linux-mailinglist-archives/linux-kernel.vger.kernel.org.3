Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F414EA529
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiC2Cal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2Caj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532C24222F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F3F61312
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58984C340EC;
        Tue, 29 Mar 2022 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648520936;
        bh=m3aHrZw0MOu3AgIVU047xcdAr8o3H2N/8bR8YugTxXg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k7ZwWMwLPkKX+wdGaJUvBAHidyCOQ+hVUUsVmR52RHBWZskTfarRpa5Fdpmp5Vkn7
         PXHnj6gDNsuI43n6NTF+XYek3oI4juTKlUpbQ/CSTpQ49no6ExcW94y4vseUNHPtgf
         UZOroHrN0WnfvcoBE72ZM7uX8mM4CB+UmzIR7ljiXkwUVeU+O/CDIlC0RYScFoiG/z
         pIET4a592iVOuI9KhwAw3POH4QGdByshVvMZI0hM53EeEX7Gl/Zg+uhEttuE8NXlBI
         ZbcElVZSgmNOnpE1P/kXdvhoJqF7010BZ8uPH+CVkWuC9QmvOTDyd51fnYXu/3xwFU
         vIukZLMF5/m+Q==
Message-ID: <04f0281c-7173-6a37-f573-b28f7a30f414@kernel.org>
Date:   Mon, 28 Mar 2022 20:28:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [net] 40867d74c3:
 kernel-selftests.net.vrf-xfrm-tests.sh.No_qdisc_on_VRF_device.IPv6_xfrm_policy_based_on_address.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Ben Greear <greearb@candelatech.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20220327141424.GD32190@xsang-OptiPlex-9020>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20220327141424.GD32190@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 8:14 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 40867d74c374b235e14d839f3a77f26684feefe5 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

Thanks for the report. I have a fix under test; will go out this week.

