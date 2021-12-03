Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DA467A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357963AbhLCPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:45:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhLCPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:45:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7E5EB82894;
        Fri,  3 Dec 2021 15:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB506C53FCD;
        Fri,  3 Dec 2021 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638546150;
        bh=NK0+94GxhkSwNnYF61GO4/4tWPOhyYP2tPpzhVwXOgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKJQwOW83RLGvXTES7dFKlM83l2TdA1aYZ2ETOSRtv3lg7hWNZS3/eviUptntYQNF
         gr915d6HMc7kj2upm9EZsKZkqx25REtd08TbDGZ66opuODAz81XCDLFQ5DQBQUvMwW
         jfmxC+aIhKWOi0lgIgOJsF8Pat9Yz4IbzkoGnW2s=
Date:   Fri, 3 Dec 2021 16:42:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/7] Improve Auxiliary Bus documentation
Message-ID: <Yao634DbGQ3hjjJo@kroah.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 08:42:58PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The auxiliary bus documentation was not wrong but it was a bit difficult to
> follow.  Furthermore the documentation was not tied to the code so it was
> potentially harder to maintain.
> 
> Add clarifications to ensure that details are not missed.  Move the overview
> documentation into the code.  Finally, add some of the existing function
> kernel docs into the main Aux Bus section.
> 
> 
> Ira Weiny (7):
> Documentation/auxiliary_bus: Clarify auxiliary_device creation
> Documentation/auxiliary_bus: Clarify match_name
> Documentation/auxiliary_bus: Update Auxiliary device lifespan
> Documentation/auxiliary_bus: Clarify __auxiliary_driver_register
> Documentation/auxiliary_bus: Add example code for
> module_auxiliary_driver()
> Documentation/auxiliary_bus: Clarify the release of devices from find
> device
> Documentation/auxiliary_bus: Move the text into the code
> 
> Documentation/driver-api/auxiliary_bus.rst | 236 +++------------------
> drivers/base/auxiliary.c | 152 ++++++++++++-
> include/linux/auxiliary_bus.h | 164 ++++++++++++++
> 3 files changed, 339 insertions(+), 213 deletions(-)
> 
> --
> 2.31.1
> 

Thanks for all of this work, now applied to my driver-core tree.

greg k-h
