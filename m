Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBE4CDE88
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiCDURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiCDURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:17:06 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66D107806
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:13:11 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id A8F9A80EAC;
        Fri,  4 Mar 2022 19:28:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id D6DAF19;
        Fri,  4 Mar 2022 19:27:34 +0000 (UTC)
Message-ID: <451bb2c394b05928c815f1eb349a1281a687a608.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Date:   Fri, 04 Mar 2022 11:28:31 -0800
In-Reply-To: <CANiq72kWJtOTmcXNO+t4NY22v6xM49Z-U2aSB4apNd96PYbD4Q@mail.gmail.com>
References: <20220127151945.1244439-1-trix@redhat.com>
         <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
         <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
         <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
         <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
         <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
         <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
         <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
         <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org>
         <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
         <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
         <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com>
         <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
         <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>
         <CANiq72kWJtOTmcXNO+t4NY22v6xM49Z-U2aSB4apNd96PYbD4Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Stat-Signature: hyg3dz78tn3se81k3zw45k8tm7sk1h45
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D6DAF19
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+VgJSiCgMrlaHF7nxKS3V69xPErNMNUTw=
X-HE-Tag: 1646422054-460497
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 19:48 +0100, Miguel Ojeda wrote:
> On Fri, Mar 4, 2022 at 6:37 PM Joe Perches <joe@perches.com> wrote:
> > 
> > I rather doubt clang-format will ever be 'close enough'.
> > 
> > A human's sense of 'taste' for reading code is very different than
> > what an automated tool produces.
> 
> Maybe,

Hey again Miguel.

Is that statement really disputable?

> but it is a trade-off. If it is close enough, the benefits of
> automatic formatting may overcome the downsides.

IYO.  I think using an SCCS with better language understanding rather
than a line oriented one could be an improvement.  Such a tool could
allow arbitrary style reformatting at check-in/check-out.

> > Also, try looking at the changes clang-format does on a file chosen
> > at random:
> > 
> > o columnarized definitions -> not columnarized
> > o odd line continuation placement using spaces and not tabs before \
> > o odd array definition layouts
> > o per line definitions with comments poorly laid out
> > o individual line definitions rewrapped
> > o enum definitions on multiple lines compressed to single lines
> > o u8 array definition layouts where the first element has a separate
> >   meaning than the subsequent elements are compressed and made
> >   difficult to understand
> 
> I am not sure what you are trying to show here -- some of these are
> precisely the things that the tool could improve or have already
> improved, and we may just need to use the new option.

All of these existing code are more human readable than the code
reformatted using clang-format.

I used whatever is the latest clang-format here with today's -next.
https://releases.llvm.org/download.html

> For instance, for the columnarized macros case, it is possible to
> align them since clang-format 9. For array of structures, there is
> also a new alignment option since clang-format 13. Etc.

Then perhaps you as the maintainer of the kernel's .clang-format file
could update the entries for those new options.

I believe the minimum clang version is already 11.  Maybe higher.
I don't track clang or use it very much.  The clang version I use
though is 13.

> For the wrapping and related bits, now that the limit on 80 is a bit
> more fuzzy, we could perhaps tweak the penalties to improve the
> decision making.

Please have at it.
But perhaps tweaking will just improve some cases and worsen others.

> In summary, what we should be trying to do is improve the tool
> configuration and tool itself to see if we can get it to be close
> enough to the kernel style to make it more widely used.
> 
> > I think _some_ clang-format output is ok, but the concept of
> > enabling/disabling specific reformatting bits would be quite useful.
> > 
> > And sprinkling "clang-format on/off" lines in the code is not good.
> 
> Definitely, but it is fine in some exceptional cases.

I don't think so.

> > Any control codes that determine when source code layout might be
> > immutable or allowed to be modified could be should be tool name
> > agnostic.
> 
> I don't see why would that be a problem, and I don't understand why we
> would use several different formatting tools (the point is to be
> consistent, after all); but sure, we could propose an alternative
> spelling.

Thanks.

There is no "one true editor".
There will not be "one true source code formatter" either.

cheers not jeers, just keep at it.  Joe

