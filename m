Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B74CCD62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiCDFlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiCDFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:41:40 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC20180204;
        Thu,  3 Mar 2022 21:40:52 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 0B31E60509;
        Fri,  4 Mar 2022 05:40:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id C2D561B;
        Fri,  4 Mar 2022 05:40:19 +0000 (UTC)
Message-ID: <d2a50ca6452a13c94e94e839577b5914e96bacbb.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Tom Rix <trix@redhat.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Date:   Thu, 03 Mar 2022 21:40:45 -0800
In-Reply-To: <e7e99791-aade-55fd-ac75-71478699cbe0@acm.org>
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
         <e7e99791-aade-55fd-ac75-71478699cbe0@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C2D561B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: pfa1qqoto4gy63dmwcu3nhims99qie7z
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/+W/G5d1Zuz5xkbUKDfxKDyC4BrjmJ8jI=
X-HE-Tag: 1646372419-180514
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-03 at 21:22 -0800, Bart Van Assche wrote:
> On 3/3/22 15:38, Joe Perches wrote:
> > One argument is that churn leads to difficulty in backporting
> > fixes to older 'stable' versions.
> > 
> > I think the churn argument is overstated.
> 
> I'm often backporting patches to older kernels and I think the churn argument 
> has not been emphasized enough. Backporting patches is a normal aspect of a 
> product lifecycle since a kernel version is chosen when development of a 
> product starts and bugfixes are cherry-picked from upstream selectively.

Stable backporting is almost certainly what people get _paid_ to do.

IMO the most important tree is the current one not backports to stable.



