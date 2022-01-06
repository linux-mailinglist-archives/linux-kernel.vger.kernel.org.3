Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE48C486534
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiAFNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:21:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41972 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbiAFNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8AB361BFA;
        Thu,  6 Jan 2022 13:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9B2C36AE3;
        Thu,  6 Jan 2022 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641475287;
        bh=6j1fMUfutZuB78M/WJhvLhM7/vnCc0zb00rLQdybbFM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=C1yg/Sd2ig7ay28/kpRTe88LFzKTknzA3/+FGMIr//vBX4AqbsMFlXw2SlgcJ/uRJ
         UH1inmzzYZXVx4V1X8N18aXH7RYLr1ZUzM+zSbtn7I/CSkeImK0HiOGsGVduWTNQxr
         bLVvk//TTBDXDvnmHMQQO/tRgeGtxCgs0Op4SDIEBc7EFKygVD8TGmGZlj+/P98GI4
         I5p74UbV7lJA3QbPyqRAq6uMWmZWLVbI2is6cF6DOBXVfa7LOOxfJXPl9A0nY2RvCz
         HpaWUyPkhZBF5F8CFuShTvHT8E1e2tks5T+BiUNzqev+Z6IpDXi8OguVwYBr/ehxrV
         6O0J2n0C1lBNA==
Date:   Thu, 6 Jan 2022 14:21:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: address kernel-doc warnings
In-Reply-To: <20211216092157.26912-1-lukas.bulwahn@gmail.com>
Message-ID: <nycvar.YFH.7.76.2201061421170.16505@cbobk.fhfr.pm>
References: <20211216092157.26912-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021, Lukas Bulwahn wrote:

> The command ./scripts/kernel-doc -none include/linux/hid.h reports:
> 
>   include/linux/hid.h:818: warning: cannot understand function prototype: 'struct hid_ll_driver '
>   include/linux/hid.h:1135: warning: expecting prototype for hid_may_wakeup(). Prototype was for hid_hw_may_wakeup() instead
> 
> Address those kernel-doc warnings.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks Lukas.

-- 
Jiri Kosina
SUSE Labs

