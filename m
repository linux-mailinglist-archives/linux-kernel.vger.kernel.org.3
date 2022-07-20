Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F457B03A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiGTFJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGTFJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:09:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285426A9E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEEBBB81E11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FA0C3411E;
        Wed, 20 Jul 2022 05:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658293769;
        bh=kHEQ6rWqVQlLVoUqDBOXtFkYFKIbonQwo664UOVxj64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z6QvdWH4483hsHCjyvFgGpQVDXcX5JtPWU/R3X5Yq57ul2AEL7fAy/VVDdXPIcTyj
         BhPR37Xy6T7/0orl/fyh1iTsAy4USJsa9M/LmwBxo7/WtcEBMDRFzL6lPVoWLq34sd
         EgkjmwaLeqfWsacHNj+VBtTBZ0Fe0mBt7B6kmp0U=
Date:   Tue, 19 Jul 2022 22:09:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 00/69] Introducing the Maple Tree
Message-Id: <20220719220928.4388fccdd59a175b0834d108@linux-foundation.org>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 02:17:37 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> This is the v11 + fixes.

Merge into mm-unstable and pushed out, thanks.
