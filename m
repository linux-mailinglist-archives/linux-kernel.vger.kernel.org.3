Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C05A5870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiH3Aba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3Ab2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:31:28 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD575CD5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 17:31:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661819485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r4QeogjwqOyod00pwXueTiLBwRNnNk9TbgNgpC8jRyM=;
        b=lW649dghZi2aSZmXsWxQX9YSihkZ25F0cFt2pf7t9wHzzWNZfRyh1iPz9zmOF4Vm+LnbT7
        9ZVnI5L+VSMsRoyfchdyzJS/U/yQtYVlDEiA424Gpy2I7YiAggdJFNXnJ0EBZfGip9YWh0
        zLvQU9LWY6GICPNo7ozktZZszNa93Jo=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Subject: ip6, escaped_string tests
Date:   Mon, 29 Aug 2022 20:31:17 -0400
Message-Id: <20220830003119.1793219-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr, here's the tests for ipv6 address and string_escape_mem(). I looked at
the clock code and it's just printing the name from a struct lookup - didn't
exactly seem worth a test.

There weren't any regressions from the printbuf patches found by these tests -
however, a recent fixup patch for prt_u64_minwidth() was wrong, I'll send you a
new version of that patch too.


