Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2D58AAE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiHEMcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiHEMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:32:48 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C5D33E28;
        Fri,  5 Aug 2022 05:32:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oJwVQ-0007BR-00; Fri, 05 Aug 2022 14:32:44 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 419D7C01B1; Fri,  5 Aug 2022 14:26:40 +0200 (CEST)
Date:   Fri, 5 Aug 2022 14:26:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to c4371c563973 ("gpio: remove VR41XX
 related gpio driver")
Message-ID: <20220805122640.GA6895@alpha.franken.de>
References: <YuzxOoNLdE4Ejz1W@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuzxOoNLdE4Ejz1W@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:30:18AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for mips tb0226_defconfig
> with the error:

this config will go away after the MIPS merge is done.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
