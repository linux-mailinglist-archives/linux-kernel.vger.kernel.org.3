Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3B496199
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381411AbiAUOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:55:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39878 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiAUOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:55:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 376B7B81E6A;
        Fri, 21 Jan 2022 14:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5990AC340E1;
        Fri, 21 Jan 2022 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642776926;
        bh=MVlNwTKTSsjD9YaXoAIBnRQ6AJexfU4zjRakYP8OB7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIZE8spo3XM48oLFMallYi3YYwpKb50E272eF6DDVRbmpqMocaC2vrpZbjb5ZsMF+
         XaIx0O2yg47fuAuGm5Gy8Iu2qrLVtbsp/m6y9ELghbKe+LA1y6Psm3KvCJhO79kVQj
         /a+Doj1Q88+IxTh5VvfA3bw5L9YXJi9/oujGxM2MWkmfkWEwMDqZCVT+qNluny9rId
         +fgAL93eoF5j50P9Qix5qpieGJxhWISa+qBC1ttF5g/wQgOtCp0UnyK0DsMIo1dq5X
         JT4s+TZhYVR7DZd/X4zS2AkSOfpE/BPWyIO1CtyPfYZqZwHZJ7O6ygVo0r6Pu+pP1o
         2/HJVAO2X4hqg==
Date:   Fri, 21 Jan 2022 15:55:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     tglx@linutronix.de, mark.rutland@arm.com, paulmck@kernel.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, corbet@lwn.net
Subject: Re: [PATCH v4 2/2] Documentation: core-api: entry: Add comments
 about nesting
Message-ID: <20220121145523.GB233613@lothringen>
References: <20220110105044.94423-1-nsaenzju@redhat.com>
 <20220110105044.94423-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110105044.94423-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:50:44AM +0100, Nicolas Saenz Julienne wrote:
> The topic of nesting and reentrancy in the context of early entry code
> hasn't been addressed so far. So do it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
