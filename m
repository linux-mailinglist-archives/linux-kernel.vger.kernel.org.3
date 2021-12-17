Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444D747961C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhLQVSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:18:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbhLQVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:18:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F64B828A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 21:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C1C36AE2;
        Fri, 17 Dec 2021 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639775928;
        bh=vpQebGd5cJDOS77X2e4vbeX3xmNGzw5+mevdRl3POx8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=n0/d9hx50GfFc4af82eyneKI3cAdS3fJXqhdT5wR51PbtN0kXD3Si3gB3++ETmh/F
         Oj1cpMIyTpv76sZoO/hbyrxK79L2IRPdVnSdY1+2NL80Za+Cxxsi5J/F+iFLtO79lw
         SGRNh6dYCOCxOru0BuLNuXgl1JuxOr8+G5EG3hnMBZOv61/8TySniZ+LDCU9i4Vpjh
         jYtT/t5XGWqEn1YuTd5MU7WUe4BYvOOW7uzB2Gzgz+3b4BUz6mNUrXYBGdzahThTyg
         U7N3TNn37VcN36p2l6Z6W3gRns5J1Ky4ZwXd0kyXhrkR3O1mudO7ISxiomOoFYutw3
         Vd5pDjWbFhDRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 494585C0610; Fri, 17 Dec 2021 13:18:48 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:18:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de, urezki@gmail.com, john.ogness@linutronix.de,
        alexei.starovoitov@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Another forward-port of the PREEMPT_COUNT removal series
Message-ID: <20211217211848.GA636786@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In case there is interest, I have forward-ported the PREEMPT_COUNT series
to v5.16-rc1.  It may be found at the tglx-pc.2021.12.17a branch in the
-rcu tree.

Because you never know!  ;-)

							Thanx, Paul
