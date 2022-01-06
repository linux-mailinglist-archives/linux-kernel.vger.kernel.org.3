Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F848660C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiAFOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:30:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50510 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiAFOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:30:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C011CE2544;
        Thu,  6 Jan 2022 14:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD3AC36AE3;
        Thu,  6 Jan 2022 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641479399;
        bh=gWRqBSoxWX1Qs4sWr9Xuz/rS/kcCD4KDasnZZ/5Yn84=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cFuwVLrRf4cGsi8kNIwAIDi6yZBBbpLJgg0HyY6GWxDUKLL3zU5sASMfJKfObaQLX
         h8K146F37gqJQdlYpvYbePBnYM5t/Jhs6Wjzkq+aIoWKctVn5ybIhDpb/AP2SOUGlM
         jfTKnATER5MKbgIRXdbDQi1TYBlxRYEXOanrm7RGzINxT4D4d3QYNIilxOJQMzaNe6
         /BiDcuqkc/zYXmEliVe+goT3gt8Gvkcs79PKmq07nybTMXgOLLFRXfRXa3ec+4mnf9
         d+C6ADp00Lc+mKrE/aljGmbOH18/Hss4wqIxDGvEzysPSvPEMJkMNbB9Fi/I5UoqtU
         bI92y8SrRnNKg==
Date:   Thu, 6 Jan 2022 15:29:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, phoenixshen@chromium.org
Subject: Re: [PATCH] HID: google: modify HID device groups of eel
In-Reply-To: <20211228114650.31981-1-xiazhengqiao@huaqin.corp-partner.google.com>
Message-ID: <nycvar.YFH.7.76.2201061528200.28059@cbobk.fhfr.pm>
References: <20211228114650.31981-1-xiazhengqiao@huaqin.corp-partner.google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021, xiazhengqiao wrote:

> EEL keyboard belongs to VIVALDI	device.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Could you please provide more verbose changelog? What user-observable 
issue you are fixing here, etc.

Also, unless xiazhengqiao is your proper legal name, could you please 
resubmit with a proper full name as indicated in 
Documentation/process/submitting-patches.rst ?

Thanks!

-- 
Jiri Kosina
SUSE Labs

