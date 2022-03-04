Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A934CDB14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiCDRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiCDRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:38:02 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B353B5B;
        Fri,  4 Mar 2022 09:37:14 -0800 (PST)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 0D6B625AC1;
        Fri,  4 Mar 2022 17:37:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 8345420033;
        Fri,  4 Mar 2022 17:36:54 +0000 (UTC)
Message-ID: <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Tom Rix <trix@redhat.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
In-Reply-To: <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
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
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Fri, 04 Mar 2022 09:36:47 -0800
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8345420033
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: 1c6ug8i9pqxuqjhad1yefjg3b57awop5
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18PthH+crZJzJrKjbbP7DvDY/cONgYvkvc=
X-HE-Tag: 1646415414-943187
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 15:02 +0100, Miguel Ojeda wrote:
> On Fri, Mar 4, 2022 at 2:46 PM Tom Rix <trix@redhat.com> wrote:
> > 
> > The churn level will be very high.
> 
> Nobody is planning to reformat the entire kernel, at least not until
> the tool is close enough to the kernel style, which will take a while.

I rather doubt clang-format will ever be 'close enough'.

A human's sense of 'taste' for reading code is very different than
what an automated tool produces.

For instance, clang-format does a quite poor job when comments are
intermixed with definitions.

Also, try looking at the changes clang-format does on a file chosen
at random:

$ clang-format -i drivers/hid/hid-sony.c
$ git diff drivers/hid/hid-sony.c
[...]

o columnarized definitions -> not columnarized
o odd line continuation placement using spaces and not tabs before \
o odd array definition layouts
o per line definitions with comments poorly laid out
o individual line definitions rewrapped
o enum definitions on multiple lines compressed to single lines
o u8 array definition layouts where the first element has a separate
  meaning than the subsequent elements are compressed and made
  difficult to understand

I think _some_ clang-format output is ok, but the concept of
enabling/disabling specific reformatting bits would be quite useful.

And sprinkling "clang-format on/off" lines in the code is not good.

Any control codes that determine when source code layout might be
immutable or allowed to be modified could be should be tool name
agnostic.


