Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD3589937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiHDIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F43AB01
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1B86B82226
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF1C433C1;
        Thu,  4 Aug 2022 08:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659601328;
        bh=KLpRf8GWODIrXa1KLD+EWJqERcB8DPQYRo2/5i5npqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0w1ZjDVk1uwds7LK50xsibM0QoIS44ocB+lWbdXS+t41QrHuSmBZszMb/9/wZCTq
         dlKIEXlcGMqDDmA5x5zDFicOOBbWSfYTKZjlKPCK3y14OzRf9tCx1EJU4/h/mjEUtj
         cGzvnuvBZlorA7oa//m+yGzdNidiyvm4XP5D0qViuvSikmbHNFiOGmSDdAIh/nItpB
         eTNwtlsd95jU+EzUpbL6YlsjkXFTfD0XqifF5ap/YQPUQ9XJM/rWuhORaN2uF7qRDP
         O+I3W1ABLRZ4YjuGwUIOM5F9PhtCdmMxqbEsZPXM12CQXZDr8Zyz9CNyXZ5F92pNG1
         eeUIjcPLYgC0w==
Date:   Thu, 4 Aug 2022 08:22:05 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YuuBrUmiRYoaSmPw@google.com>
References: <CAODwPW-eQ-dYvfCGZ13tOzh4gPdLU9ZoFg9joWpRTX22OXa4Ow@mail.gmail.com>
 <20220802140343.3468976-1-jrosenth@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140343.3468976-1-jrosenth@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:03:43AM -0700, Jack Rosenthal wrote:
> cbmem entries can be read from coreboot table
> 0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
> entries in sysfs under /sys/firmware/coreboot/cbmem-*.
> 
> Link: https://issuetracker.google.com/239604743

I doubt if the Link tag would be useful for public.

[...]

> Reported-by: kernel test robot <lkp@intel.com>

Suggest to drop the Reported-by tag even if the robot reported some compile
errors during the development.  Given that the patch isn't a fixup but
supporting something new (which isn't "reported by" the robot).
