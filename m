Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F04507049
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiDSOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbiDSOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A462A279;
        Tue, 19 Apr 2022 07:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9939160A75;
        Tue, 19 Apr 2022 14:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E5EC385A5;
        Tue, 19 Apr 2022 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650378186;
        bh=r+/LbAXLgUeTEiq7rAEkH2u3ARXKg3d+g9o5geQA7ow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rGaFFQnM7jDwpPyilC+EndIxcEW5O9KgQtOIfWZq9Kp1HLbd1Bx0v6KSfEwEqBFzv
         c+7OkPywHq/0smkIS3wxMkgbbNQL/9wpgOk+a/OK08dedIAKGbsF9fYS5+VBksMJIh
         EJRVA0oWTdshkjdFBRKDL/l6XlG21KJfRecZ/vvG1LaGbQwzYL/YaAmujsQiMCGKdp
         v9fX8nEaY/uPh+HVUjhmYZhP2JFQWsZsYj62KmiJPngzO/UmA4VNv5DxvVA/TyRi6n
         oJug6JoayyRp87EKEdR5r7ZipEpbCTGPMVO/Bg31knG+1W42DcJru7Xb12T8/NLrmp
         hzi8ZRFItXj8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9AF6E5C031F; Tue, 19 Apr 2022 07:23:05 -0700 (PDT)
Date:   Tue, 19 Apr 2022 07:23:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/2] Documentation updates for v5.19
Message-ID: <20220419142305.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
 <371488b0-1baf-8cea-628f-83c9b0383c88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371488b0-1baf-8cea-628f-83c9b0383c88@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:08:48PM +0700, Bagas Sanjaya wrote:
> On 4/19/22 05:50, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains a couple of documentation updates:
> > 
> > 1.	Add documentation for rude and trace RCU flavors.
> > 
> > 2.	Update RCU cross-references as suggested in doc-guide, courtesy
> > 	of Akira Yokosawa.
> > 
> 
> Bulding htmldocs with this series, no new warnings found.
> 
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for testing!  I will apply your Tested-by on the next
rebase.

> -- 
> An old man doll... just what I always wanted! - Clara

Nutcracker?

							Thanx, Paul
