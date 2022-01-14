Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4248E89D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiANKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiANKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:52:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EEC061574;
        Fri, 14 Jan 2022 02:52:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E94B3B82476;
        Fri, 14 Jan 2022 10:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C573C36AEA;
        Fri, 14 Jan 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642157559;
        bh=wo2dhJtJfnIqUDQ1rm2VSd0RBlNXRccjQS6OJ+p7tT0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lCoGDwZ77hekEv1USTc1TlU5PJWyHIKu1yoEQiByztBfqfO97l28+mu936v0202Lf
         X9QgrH57iEUtRc/6dDeA2ZkmhJyn+uWVumQmKl8EoJQCQ5qAijX0lElzm4eJV7ZUF+
         H4MvhpVHIKj0Kse13yjmc5zc1ogCKr2wf30myocr/SE9PcD2jERmPJdfd9Y+LnM0Ca
         svVOMZdo7GSmernlTYFYr3+Y/uUsjPQEAXWq9FXUO5rmWKbguQJnM8C7NZVxYJ9/aE
         fquo+9rJEVYQeztp5Q2nB2XNwZXNLdJ/Z7Hy5aqI+3oNBztxhbCLg+DTXjy2Pt2WdO
         EE8TZtfrNzs+A==
Date:   Fri, 14 Jan 2022 11:52:36 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Ting Shen <phoenixshen@chromium.org>
Subject: Re: [PATCH] HID: vivaldi: Minor cleanups
In-Reply-To: <20220107232305.3190198-1-swboyd@chromium.org>
Message-ID: <nycvar.YFH.7.76.2201141152210.28059@cbobk.fhfr.pm>
References: <20220107232305.3190198-1-swboyd@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022, Stephen Boyd wrote:

> Perform some minor cleanups on this driver. Include header files for
> struct definitions that are used, drop a forward declaration that isn't
> useful, and mark a sysfs attribute static as it isn't used outside this
> file.
> 
> Cc: Sean O'Brien <seobrien@chromium.org>
> Cc: Ting Shen <phoenixshen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to hid.git#for-5.17/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

