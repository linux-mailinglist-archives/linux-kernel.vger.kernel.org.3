Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355284AC7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379947AbiBGRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382647AbiBGR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:29:55 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D88C0401DD;
        Mon,  7 Feb 2022 09:29:55 -0800 (PST)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 6FC3460537;
        Mon,  7 Feb 2022 17:29:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 21E852D;
        Mon,  7 Feb 2022 17:29:37 +0000 (UTC)
Message-ID: <6937d748bb04b53b88d2f4363db31bed2ae7550a.camel@perches.com>
Subject: Re: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Mon, 07 Feb 2022 09:29:52 -0800
In-Reply-To: <YgFVFceYQtWq4Hww@smile.fi.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
         <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
         <YgFVFceYQtWq4Hww@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zthdfaupqco63iopoeg9ccn1hhrkrtnm
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 21E852D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18eMtJCweLA/Yw0AFlxD4LnBj6lbsvJ8rU=
X-HE-Tag: 1644254977-164573
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 19:21 +0200, Andy Shevchenko wrote:
> On Mon, Feb 07, 2022 at 08:37:55AM -0800, Joe Perches wrote:
> > On Mon, 2022-02-07 at 12:48 +0200, Andy Shevchenko wrote:
> > > In a couple of messages the constants, which have their definitions,
> > > are hard coded into the message text. Unhardcode them.
> > 
> > Found by inspection or tool?
> 
> Does it matter?

Yes.  If it was done using a tool, then it could used treewide.

> No, a side effect of the following patch.

k


