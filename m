Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D758B754
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiHFRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiHFRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:45:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E1F95BD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 10:45:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3EDAED1;
        Sat,  6 Aug 2022 10:45:24 -0700 (PDT)
Received: from bogus (unknown [10.57.12.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87F553F67D;
        Sat,  6 Aug 2022 10:45:22 -0700 (PDT)
Date:   Sat, 6 Aug 2022 18:45:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] arch_topology: Silence early cacheinfo errors when
 non-existent
Message-ID: <20220806174519.g2kwafoct6cdzaih@bogus>
References: <20220805230736.1562801-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805230736.1562801-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 04:07:36PM -0700, Florian Fainelli wrote:
> Architectures which do not have cacheinfo such as ARM 32-bit would spit
> out the following during boot:
> 
>  Early cacheinfo failed, ret = -2
> 
> Treat -ENOENT specifically to silence this error since it means that the
> platform does not support reporting its cache information.
>

Makes sense, I wanted to send something similar after testing on some
platforms without cacheinfo like Qemu.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
