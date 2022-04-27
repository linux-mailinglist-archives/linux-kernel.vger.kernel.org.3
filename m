Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C023511D52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiD0ROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiD0ROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:14:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FB4248A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4969B826BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACCDC385A9;
        Wed, 27 Apr 2022 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651079464;
        bh=AGwDx7+cWoakdmlg+hI61Nz04dn+bM8npW2iCZ4X5+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNccGLwlKlsoO191v5NWE2I3DB+8wmf/xO7RLfiEdIq7/6ZcLQHBpHWo4XV0eGijB
         Jk9HEngiZOPbASj0CHCn8sbwZZ7OyKfsDcmJ6+Fu5PJt7DAxmATJTROtMbJae2DD2a
         2oFsxNEO2HNdxYz6Uagh8lXmpOH/QmuxngaJdo8I=
Date:   Wed, 27 Apr 2022 10:11:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] arm64: mm: Convert to GENERIC_IOREMAP
Message-Id: <20220427101103.9cb55ee5a9682c9be277b468@linux-foundation.org>
In-Reply-To: <20220427121413.168468-4-wangkefeng.wang@huawei.com>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
        <20220427121413.168468-4-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 20:14:12 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Subject: [PATCH 3/4] arm64: mm: Convert to GENERIC_IOREMAP

doh, that's why.
