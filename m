Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406604FB631
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiDKIkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDKIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:39:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D45D3EA89
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:37:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49159ED1;
        Mon, 11 Apr 2022 01:37:41 -0700 (PDT)
Received: from bogus (unknown [10.57.41.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293683F73B;
        Mon, 11 Apr 2022 01:37:39 -0700 (PDT)
Date:   Mon, 11 Apr 2022 09:37:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Do not set llc_sibling if llc_id is
 invalid
Message-ID: <20220411083736.hrpgndcwuvtsgnhc@bogus>
References: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

On Sun, Apr 10, 2022 at 07:36:19PM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
> will set llc_sibling 0xff(...), this is misleading.
> 
> Don't set llc_sibling(default 0) if we don't know the cache topology.
>

Makes sense to me and thanks for splitting the patch and pointing this out
clearly. Your earlier patches mixed other things and made it hard to highlight
this one.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Greg,

Can you pick this up ? IMO It can go as fix in -rc as it is kind of
misleading though I am not sure if it is breaking any platform.

--
Regards,
Sudeep
