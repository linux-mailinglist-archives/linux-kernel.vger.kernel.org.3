Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECE589D76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiHDO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:26:37 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5465E4;
        Thu,  4 Aug 2022 07:26:35 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1BC4740D403D;
        Thu,  4 Aug 2022 14:26:33 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 04 Aug 2022 17:26:33 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
In-Reply-To: <Yuur2x+H5ESwJmcr@kroah.com>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
 <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
 <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
 <973736db-2480-bbaa-d2ce-6e1b6dd2ed0c@intel.com>
 <09c1c94fb9c5006199d88caa88f237a3@ispras.ru> <Yuur2x+H5ESwJmcr@kroah.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c55c2c3b440c05a392230c380dceae79@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-04 14:22, Greg KH wrote:
...
> Are there any plans on getting those changes merged back upstream to 
> the
> main UEFI codebase so that others can test this type of functionality
> out?
> 
> thanks,
> 
> greg k-h

The initial prototype of the changes were published as a part of the
tianocore/edk2-staging[1], and a more up-to-date open source version
was published as a part of the acidanthera/audk. This version is 
currently
being integrated with the EDK II build system, and its malfunctioning
is currently the main technical issue for integrating changes
into the main branch.

It is hard to estimate when the merge with the edk2 mainline happens,
but we are committed to doing this. The amount of changes needed
is quite large, and simply getting approval from all the maintainers
will take time even if they are all willing to get this in.
On the good side, several parties, Microsoft in particular,
were interested in upstreaming this code, so we have moderate
optimism for the future.

In case you are interested in the details, there is also academic
material available, describing the issues and the changes made,
which can help to shed some light on the implementation[3][4].

[1] 
https://github.com/tianocore/edk2-staging/tree/2021-gsoc-secure-loader
[2] https://github.com/acidanthera/audk/tree/secure_pe
[3] https://arxiv.org/pdf/2012.05471.pdf
[4] https://github.com/mhaeuser/ISPRASOpen-SecurePE

Thanks,
Evgeniy Baskov
