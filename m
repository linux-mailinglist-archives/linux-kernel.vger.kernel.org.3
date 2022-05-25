Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B1533A16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbiEYJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiEYJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:41:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D9BE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:41:20 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 47B8D40D403D;
        Wed, 25 May 2022 09:41:15 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 25 May 2022 12:41:15 +0300
From:   baskov@ispras.ru
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
In-Reply-To: <Yo3nLFcaGQCKERHx@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-3-baskov@ispras.ru> <YnztqAtNEvnF5YcX@zn.tnic>
 <d783442602a1c546d3727b939f5cd199@ispras.ru> <Yo3nLFcaGQCKERHx@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <00fd3ad6cfa74689007afd41895f29cd@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 11:22, Borislav Petkov wrote:
> On Wed, May 25, 2022 at 08:25:30AM +0300, baskov@ispras.ru wrote:
>> There are currently no arch/x86/include/asm/shared/ directory,
> 
> There is now - it was in tip but wandered upstream two days ago. :)
> 
> Thx.

Oh, thanks, I'd better rebase then...

--
Baskov Evgeniy
