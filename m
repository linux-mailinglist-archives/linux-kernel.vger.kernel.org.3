Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD74E4505
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiCVRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiCVRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:25:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE02A723;
        Tue, 22 Mar 2022 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o19S8ciBSx0T1mNtvpS/R5JIv5JbexuH29sfTLf8nsk=; b=I7JNU6XuZOvA5rXNhbxQFTveIq
        CFuMhu5azIlbgraq8ry+A+sS3Sm3MGbQHDxofEEWIoj2Kw07vGXLkKEeIZhIRv7sE2H5WLm57D2kq
        K299pHLgmc4UR4bXHtuwWJoqB9SpDImo4AyY7qXSeXrE0Vp9xBzUv2+EQ5CiseDJKW8trq6nEBIcv
        Te1ba1VaCQ7VQLWZVm8cv9GnSeVQ5AG6p/LDEWIpj4mIMXpLDHxRyMMPEjxI6JygjNAIbgTeTsorc
        ASn2iUrRqtXjBL9crbkq8OgXTy0DoSuj23suKDMJ/lm1oDBIRgNTg1Gp/j+xGrhswGqUJ0IFF0GKP
        X9L4su+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWiEZ-00BibQ-5z; Tue, 22 Mar 2022 17:23:51 +0000
Date:   Tue, 22 Mar 2022 10:23:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v4 0/4] Miscellaneous cleanups
Message-ID: <YjoGJ+zDBTPfeQ46@bombadil.infradead.org>
References: <cover.1645605431.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645605431.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:00:57AM +0100, Christophe Leroy wrote:
> This series applies on top of Aaron's series "module: core code clean up" v8.

Queued onto modules-testing, thanks!

  Luis
