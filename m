Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B9516E22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384558AbiEBKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384595AbiEBKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:32:54 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED359BCB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:28:32 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KsK7L19PDzMpnT4;
        Mon,  2 May 2022 12:28:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KsK7K1rsBzlhSLy;
        Mon,  2 May 2022 12:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651487310;
        bh=bptxyVnLNXDttaSUgFWYcO2XLQjIKj3V2V77zSKRijg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sYTRVnzK1acffNdh7/XJLYB4Fjo92WqaJCNs/hMVa+uJfHNWBKhAZHNpBtt1fEaMD
         237w1h/545j3O0sw7hscVWWqPSrmj4czUN0G/e84DS0j+Fw9voO3MZkJyguMiD9ffv
         FTxBLd6NoJWv7jjmx56xV1bhdGBqEtTYdhXHZ2Xc=
Message-ID: <32f41b83-2019-475b-b72a-6b824fe796f8@digikod.net>
Date:   Mon, 2 May 2022 12:29:41 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
 <CANiq72nLOfmEt-CZBmm2ouEB_x6Jm9ggDVFCVJxYxKw7O0LTzQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: clang-format inconsistencies with checkpatch.pl
In-Reply-To: <CANiq72nLOfmEt-CZBmm2ouEB_x6Jm9ggDVFCVJxYxKw7O0LTzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2022 18:14, Miguel Ojeda wrote:
> Hi Mickaël,
> 
> On Sat, Apr 23, 2022 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> I also noticed that there is some clang-format configuration lines that
>> are commented because of incompatibilities with versions older than 6.
>> Shouldn't we require a minimal version, at least the 6th?
> 
> I will be increasing this cycle the version to 11, which is the
> minimum LLVM supported at the moment, and then keep it sync'd to that
> minimum.

OK, thanks.

> 
>> About checkpatch.pl, it incorrectly warns about space between function
>> name and open parenthesis for *for_each* functions (specifically
>> interpreted as "for" statements in .clang-format, e.g. list_for_each_entry).
> 
> Note that the prevailing kernel style is to not have a space. This
> should be fixed with the increase to 11.

I was talking about the ForEachMacros exceptions. Should these be 
removed or at least not updated for new for_each functions [1]?

[1] https://lore.kernel.org/r/20220412153906.428179-1-mic@digikod.net
