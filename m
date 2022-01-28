Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A44A00B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbiA1TMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:12:03 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:63735 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233548AbiA1TMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:12:03 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id CA844607AA;
        Fri, 28 Jan 2022 19:11:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 5CD0635;
        Fri, 28 Jan 2022 19:11:43 +0000 (UTC)
Message-ID: <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Fri, 28 Jan 2022 11:11:55 -0800
In-Reply-To: <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
References: <20220127151945.1244439-1-trix@redhat.com>
         <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
         <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CD0635
X-Spam-Status: No, score=-4.87
X-Stat-Signature: 8653peheyynksmpug8otea4tq5jr88xn
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tojhrHoxBG59eMTBbAjVdRtmbSPVhEWY=
X-HE-Tag: 1643397103-49658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-28 at 09:59 -0800, Tom Rix wrote:
> On 1/28/22 9:42 AM, Bart Van Assche wrote:
> > On 1/27/22 07:19, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > checkpatch reports several hundred formatting errors.
> > > Run these files through clang-format and knock off
> > > some of them.
> > 
> > Isn't this the kind of patches that carries more risk than value?

Risk for whitespace style reformatting patches is quite low.

Nominally, clang-format changes should not produce a different
compiled object file unless __LINE__/__DATE__/__TIME__ style
changes occur.

If it does, the clang-format tool is broken.

> > Additionally, this patch conflicts with a patch series that I plan to 
> > post soon.
[]
> Long term, it would be good have a reliable way to automatically fix 
> either new files or really broken old files.

That's really a maintainer preference no?

Especially so for any automation.


