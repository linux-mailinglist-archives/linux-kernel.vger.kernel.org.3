Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D052AECE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiEQXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27F3C713
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 493F4B81D16
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74A6C385B8;
        Tue, 17 May 2022 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652831154;
        bh=3r4E2fLMic7Ws4eWiodHdrFMqje6RGVyYON9bS01F5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+bBmwqlZnlPNjzJP13zKeSD5+mG8MGF8589xJ2JPHuzIHtK8vX0ALkEqVopzS6gf
         CBENI07+AthUbh9wvQbzaN5nkWUq4FztY8Dfa5PRO/1fF25QF5HKnU6/on8pFStMN9
         3eB7VbxeLoj6kebJz20K825Nd8fnCLachkmMvl/E=
Date:   Tue, 17 May 2022 16:45:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] A few fixup patches for z3fold
Message-Id: <20220517164553.29d6b76eb0cc656556916372@linux-foundation.org>
In-Reply-To: <20220429064051.61552-1-linmiaohe@huawei.com>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 14:40:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> This series contains a few fixup patches to fix sheduling while atomic,
> fix possible null pointer dereferencing, fix various race conditions and
> so on. More details can be found in the respective changelogs.

We haven't heard from Vitaly but this series has been in mm-unstable
and linux-next for three weeks, so I plan to move it into mm-stable
later this week.
