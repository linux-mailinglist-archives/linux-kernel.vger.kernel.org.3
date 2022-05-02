Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9474851691A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356350AbiEBBOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEBBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F464F7
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 18:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 316D261152
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AC7C385A9;
        Mon,  2 May 2022 01:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651453847;
        bh=QSdbLDY8OEEnCs8IwOLxXH42/mMfjNSfFMJDUVsWZS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1HBJbrBybzbVoarj4q68LxO4berjctu9IAwP0+ipavbXkWfQVqE8TD/fPnALKiAW
         8yV+AjVo7W8r7xcE5mviBAJxvzxwpxsyEHXCqkZUCO3f1OxG+ahhJUVmETzY74iFWj
         FspNqO2WJ+GPDTJA1mUgDfvTx7huHOxzFj1Sdv1o=
Date:   Sun, 1 May 2022 18:10:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>
Cc:     michel <michel@lespinasse.org>, hughd <hughd@google.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Barry Song" <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>,
        peifengl55 <peifengl55@gmail.com>
Subject: Re: [PATCH] mm: fix align-error when get_addr in
 unmapped_area_topdown
Message-Id: <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>
In-Reply-To: <2022050110235766139218@oppo.com>
References: <20220412081014.399-1-lipeifeng@oppo.com>
        <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>
        <2022041310411426044561@oppo.com>
        <2022050110235766139218@oppo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022 10:26:35 +0800 "lipeifeng@oppo.com" <lipeifeng@oppo.com> wrote:

> Why did the two patches suddenly disappear without any email or notice for us?
> And they had been merged in linux-next.git on April 5 and 13.

They caused me some merge issues against mapletree, which I had
resolved.  Mapletree is dropped at present so I set these patches aside
until the next version of the mapletree patches are available.


I've been holding your patches until Michel Lespinasse has had time to
review them (and hopefully explain them to me ;)).  Please review
earlier comments which Michel has provided and ensure that those
comments have been fully addressed so we can hopefully move forward on
this.


