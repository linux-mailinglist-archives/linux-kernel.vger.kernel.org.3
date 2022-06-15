Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7054CD77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiFOPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiFOPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89B30F4E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0BE617D0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38986C3411C;
        Wed, 15 Jun 2022 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655308289;
        bh=YMAkR9zIrmdqS/6EOyVX+UljQv+WcxcGfDTx8YhjXaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j/pXI8YNlA4qXs/2wfrwFC4vrqJIZ6vJ6TBpg7rwUV7lJu45hn4hl4q9Nkwb/ajA9
         PonHf7ddrRXargppmxaikaWwcfxJXfbDqaq0WuibRY0xFSTRXR0eTwOk1Br6VwOj0b
         7joESKKJzXZQZhPTt+T7GSnOPeybinEeB1KKFm6BKvAj5zy9OldcXxWEgg8GWbVsXt
         AJOW9KnjRDeLxQeXIsMMip3DK+A5aJQ4W3VnQQrKh1n8nnjn8BDcND+8n00cIPrBIp
         pp0nE+5ItjCItYxl0vZe3bdWm135ZghJ/8tPM2SIRLIWITO5JrlFAw76GwLe3CJ9A3
         xjomiaeKnqU4Q==
Date:   Wed, 15 Jun 2022 08:51:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: Re: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29:
 error: enumerator value for
 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer
 constant
Message-ID: <20220615085128.026f1c56@kernel.org>
In-Reply-To: <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
References: <202206091828.eNkyL2EI-lkp@intel.com>
        <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 16:11:17 +0200 Arnd Bergmann wrote:
> The bug is that 'i40e_aqc_cloud_filters_element_data' and some other
> structures in the
> same file are broken when building an ARM kernel without CONFIG_AEABI, which has
> unusual struct packing rules and triggers the static assertion.

What are those packing rules, out of curiosity?
