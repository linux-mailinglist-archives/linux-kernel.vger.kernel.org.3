Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D82558392
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiFWRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiFWR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83EA54BCC;
        Thu, 23 Jun 2022 10:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B54CEB824A0;
        Thu, 23 Jun 2022 17:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F48AC341C5;
        Thu, 23 Jun 2022 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656003815;
        bh=jKjruXX1sjySvlt6+Dk/ueMHXXvDNfCqn/TvVfnFmc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeYjlCBpIJ0AsjhUe1Tq87zvz5L/Y30JqDG47n5q+klGHl46f9DEasbeePItJwiB7
         0GjRlr8hvLe4LqPd8E6Cmx/vXHSBqBflVWY6kAMfA9qsj/kvFoFJcSNYWmqmVI/rjg
         QhP6cJ7mO82/186oAZ2hKZq0bYzmIktIu8xIBt34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 056/237] MAINTAINERS: co-maintain random.c
Date:   Thu, 23 Jun 2022 18:41:30 +0200
Message-Id: <20220623164344.769988559@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164343.132308638@linuxfoundation.org>
References: <20220623164343.132308638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d upstream.

random.c is a bit understaffed, and folks want more prompt reviews. I've
got the crypto background and the interest to do these reviews, and have
authored parts of the file already.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11307,6 +11307,7 @@ F:	drivers/block/brd.c
 
 RANDOM NUMBER DRIVER
 M:	"Theodore Ts'o" <tytso@mit.edu>
+M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	drivers/char/random.c
 


