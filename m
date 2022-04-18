Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D27505FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiDRWws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiDRWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2FDEE6;
        Mon, 18 Apr 2022 15:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B58C461037;
        Mon, 18 Apr 2022 22:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FA1C385A1;
        Mon, 18 Apr 2022 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322205;
        bh=8cvzy785zxSOa8gRzab5YX1xtJ4ASbKug1EYu+u63YY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=jTwwtzPi2X7Vwe4OeKW8EYi09RCIEoGyWaUqPrvJTCRNM8KAYqEqefgj8AHR7R67v
         kuHETQ/a574Y4LdgYOvsn6DP9d8J2/x7lXFMBk5dPThRSXiXuJCN5K41baxUNvWlmL
         I7HhjIjyej63FWQ0cEGSStciX9slpos80RfKadJhPHnlTWuEd1LqtK6B0RuosvQtS8
         cZcOLsvH1AI86N8jPiqqOeKBwNIN7lVO/BWXxvOUBuwRpwGUWeBujaLJYtM21yt/H7
         rot9NnZOw01bu1iJiu3JFgFuU8YVfR16rUEor4I7fb6UAITd6FJfrQo2iYY4MxSd0Y
         xo+tkAW889TTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AB9195C04BD; Mon, 18 Apr 2022 15:50:04 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:50:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/2] Documentation updates for v5.19
Message-ID: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
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

This series contains a couple of documentation updates:

1.	Add documentation for rude and trace RCU flavors.

2.	Update RCU cross-references as suggested in doc-guide, courtesy
	of Akira Yokosawa.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.rst                         |    4 -
 b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst                 |    2 
 b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |    2 
 b/Documentation/RCU/Design/Requirements/Requirements.rst                       |   32 ++++++++++
 b/Documentation/RCU/arrayRCU.rst                                               |    4 -
 b/Documentation/RCU/checklist.rst                                              |    9 +-
 b/Documentation/RCU/rcu.rst                                                    |   13 +---
 b/Documentation/RCU/rculist_nulls.rst                                          |    2 
 b/Documentation/RCU/whatisRCU.rst                                              |   18 ++---
 9 files changed, 57 insertions(+), 29 deletions(-)
