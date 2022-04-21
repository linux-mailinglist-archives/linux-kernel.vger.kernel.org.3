Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C536509475
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiDUAbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiDUAbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:31:04 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91818388;
        Wed, 20 Apr 2022 17:28:16 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0F96A200003;
        Thu, 21 Apr 2022 00:28:10 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 20 Apr 2022 17:28:10 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
In-Reply-To: <202204201625.5BBB91ADB8@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
 <202204191946.2843CF71@keescook>
 <06435f0b44681588052d145a17d60316@overdrivepizza.com>
 <202204201601.8291F550@keescook>
 <4dd9a9a3a7fb6f9af0fa04b8d2e3d5a2@overdrivepizza.com>
 <202204201625.5BBB91ADB8@keescook>
Message-ID: <067ce8bd4c3968054509831fa2347f4f@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-20 16:25, Kees Cook wrote:
> On Wed, Apr 20, 2022 at 04:12:26PM -0700, Joao Moreira wrote:
>> >
>> > Ah-ha, thanks. I think this will fix it, but I haven't tested it:
>> 
>> I tried that, and IIRC, there was an error or warning in the 
>> assignment that
>> happens a bit further in the file. My bad for not having it all 
>> properly
>> tracked.
> 
> This builds for me without warnings, but maybe there is some weird
> config I'm missing.

Nah, I was just confused. This works fine and fixes the violation 
(confirmed after compiling and booting it).
