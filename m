Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92C552811
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiFTXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346824AbiFTXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BB627FF0;
        Mon, 20 Jun 2022 16:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 309A0B81213;
        Mon, 20 Jun 2022 23:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D832FC3411B;
        Mon, 20 Jun 2022 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766805;
        bh=X58+iiXeQw6wvgG7shFEYNloaaswI4dbBtxazIFQxjA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=EtTDuJZ4G5qLR45H2TyVyEbBLsbVVUarp8mYhUCbe9wrRyYO6vtckd4Mmo38kzhA1
         8aQXFhG2xvdkyMGkMi68/lt2o4u0RvPUORVh5lCsdVDvshm1IfXYCXeTwH5XPkGdRD
         X8ruRZSalEs7NF6zVJCKedZMNpfje2Osg56VbbSY2swyvco7Rkp/uAFKWCfaHIjOl8
         iRj/W+Jmvz76vDJPa6ommMIYXI0cnrlWpyC9lk95FBWl9m1cmTAdLEXkNptcFMtYOr
         6DBgI/PahSoTaRendjN/H1t4D6vOcxooWXazZQznMm1z6mI81xzbfJXCR8bmJAIrLZ
         +O3GJ3q8f73ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 887C35C05B9; Mon, 20 Jun 2022 16:13:25 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:13:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/5] nolibc updates for v5.20
Message-ID: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides nolibc updates, including improved testing:

1.	Support overflow checking for older compiler versions, courtesy
	of Ammar Faizi.

2.	Add format attribute to enable printf warnings, courtesy of
	Alviro Iskandar Setiawan.

3.	fix the makefile to also work as "make -C tools ...", courtesy
	of Willy Tarreau.

4.	make the default target build the headers, courtesy of Willy
	Tarreau.

5.	add a help target to list supported targets, courtesy of Willy
	Tarreau.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/Makefile                |    3 +++
 b/tools/include/nolibc/Makefile |   18 +++++++++++++++++-
 b/tools/include/nolibc/stdio.h  |    4 ++--
 b/tools/include/nolibc/stdlib.h |    7 +++----
 tools/include/nolibc/Makefile   |   19 ++++++++++++++++++-
 5 files changed, 43 insertions(+), 8 deletions(-)
