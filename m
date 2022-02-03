Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBB4A8B81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353358AbiBCSXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:23:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46296 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiBCSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0802B8339B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 18:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2912DC340EC;
        Thu,  3 Feb 2022 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643912598;
        bh=DdgGyWSLki5WOyQp2k6JeCY8krqNvNnDxCSP04S3ao4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIly+4dW0MAzvOMsvmfLYlxAF0YRFlotbvzXl/Au+2ZQfd0JLubGHMw78YEoszDxC
         fLTkRAvEuHG6f3g8yEBOkaM8caIGUMlsc18Bc4zuygdcRCry6bVzuwDCslUP2pLawN
         gRKfMykTuQXdNCO3vWH5TEmzejR8bbkn7zaOO70/JZnclwTNsyJh25dputhl5UrylP
         /toSbQXKBLO08lPD9yFlRXs1caFUurl3MlDF9ghjzWFmADsnOzP1NCyTCdzxvXEC8y
         QutG8iR5We5qSh9u4njALr63FJx5//i2QqUvaTLLJZIVkYHZjUDYphiQzYJFssXbTa
         U+VmtQI9of2TQ==
Date:   Thu, 3 Feb 2022 19:23:16 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v10 05/10] task isolation: add hook to task exit
Message-ID: <20220203182316.GA475173@lothringen>
References: <20220127173037.318440631@fedora.localdomain>
 <20220127173206.645742130@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127173206.645742130@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:30:42PM -0300, Marcelo Tosatti wrote:
> Add task isolation specific hook to task exit routines.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Maybe merge this into "[patch v10 07/10] task isolation: enable return to
userspace processing" because that patch alone doesn't make much sense?

Thanks.
