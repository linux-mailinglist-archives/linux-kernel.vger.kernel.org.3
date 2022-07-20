Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B300757C0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGTXL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiGTXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:11:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0245983;
        Wed, 20 Jul 2022 16:11:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 582A42B0;
        Wed, 20 Jul 2022 23:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 582A42B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658358680; bh=wvOBo7L3s5hzVSqyC+eBIMkKXkI71X6wPdDvIB0DoYE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WMdDnEHtzYbsX8Jk8A+UO5C/JlxdwMeZThrkT0TLyhzHLNWJq0YwGdDKOTxbdUsM1
         k2epBp3rpAPN3wlQb4hcP5SPcuEQ46s9lIXLnwM4njqZIAuNz8y2IHrNrCYce7OyuV
         nlsDoTJzM11khihHh9hRDVp6tI1FwaUKC/LxSAGQBZE2cJtAr/Udp+oRoScBL2v9qb
         j6ooDeDCN9u01UX3uwKcOz0+u81aJMN53yi83nL+Cw2Yd3o/RuLVFjfUZQfEIn40WE
         eYB2DPn3fJSP9GgawyoqcZuWDZNx+SIykC/QUQGRzcdDvyh9EuESwOorWZcHwj9pOE
         FDzgNIMTOfslA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     alexs@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/vm: move overcommit-accounting doc to admin-guide
In-Reply-To: <20220720144044.0cd2757be75fe00d198394f1@linux-foundation.org>
References: <20220714055142.214728-1-alexs@kernel.org>
 <874jzbo4x5.fsf@meer.lwn.net>
 <20220720144044.0cd2757be75fe00d198394f1@linux-foundation.org>
Date:   Wed, 20 Jul 2022 17:11:19 -0600
Message-ID: <87zgh3mlbc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> Don't forget that Documentation/vm was moved to Documentation/mm in
> mm-stable and linux-next.

True, that's only going to make things messier.  I've dropped this one
for now; I can either reapply it after the move hits mainline or it can
go through -mm now, whatever's easiest.

Thanks,

jon
