Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18C4A45DE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377508AbiAaLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:47:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37302 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiAaLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:35:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D91E6133A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A97C340F0;
        Mon, 31 Jan 2022 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643628897;
        bh=2407Vuhcto4kD119wVw/S2J1BcsizFF4juBzYKHE9Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXbYWDO3Ry1Xiy0Fd/uo4V0ovRRG164IaCjllIIFRZ4V0otG8kRVtXT3wBHd75glv
         xRA96Tb3MsGuDQimrSOFfq3pVyQBjqNOli38AQqkZvzYsb8C37WHK0Em0QJ6/7DmaX
         UgVliPm0UJJ3c8uJ3Dq5v8BQNWVcKQ8H/dYqNJ+U=
Date:   Mon, 31 Jan 2022 12:34:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 5/6] topology/sysfs: Add format parameter to macro
 defining "show" functions for proc
Message-ID: <YffJXqWYbflp3Wm2@kroah.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <20220121174743.1875294-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121174743.1875294-6-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:47:42AM -0800, Tony Luck wrote:
> All the simple (non-mask and non-list files in
> /sys/devices/system/cpu/cpu0/topology/ are currently printed as decimal
> integers.
> 
> Refactor the macro that generates the "show" functions to take a format
> parameter to allow future files to display in other formats.
> 
> No functional change.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/base/topology.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
