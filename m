Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEB4DCA52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiCQPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiCQPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:48:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FC20E962;
        Thu, 17 Mar 2022 08:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FFEBB81EF7;
        Thu, 17 Mar 2022 15:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F9DC340E9;
        Thu, 17 Mar 2022 15:47:28 +0000 (UTC)
Date:   Thu, 17 Mar 2022 11:47:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, andy.shevchenko@gmail.com,
        David.Laight@aculab.com, jonathanh@nvidia.com, phil@raspberrypi.com
Subject: Re: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
Message-ID: <20220317114726.37aea48b@gandalf.local.home>
In-Reply-To: <20220316143646.13301-1-wander@redhat.com>
References: <20220316143646.13301-1-wander@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 11:36:39 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> I cc everybody that reported problems with the previous version of this
> patch so they can retest and confirm their systems work flawlessly.

I didn't do an extensive test, but I quickly applied them and did not see
any issues with the two machines that had problems with your first commits.

But I'll do a more extensive testing on your v5 before I give a tested-by.

Thanks,

-- Steve
