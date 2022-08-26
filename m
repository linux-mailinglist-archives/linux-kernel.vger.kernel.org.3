Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06985A1EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiHZCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbiHZCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:25:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBC71BEC;
        Thu, 25 Aug 2022 19:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=20px62CgKdyZ2pwfDZVxI7cSmjDuUU373ANc6eVkIj4=; b=yxgPl1jZvpyjIwubW1Rm05LnHa
        lJDVcwL0p4dPy0yHblGQmZ7aZv/8J22Lpbzr5ZIBCBbsXT+pn/O+CqenKuuhZsO+/vrbZw/SkShrx
        7m03p1qKYrMMaeugTxjH5X+eEJiS47WZtMAluQUs0lX/ba9ef0HxXQaH7sZO+UeLj3BtSNuzyH03/
        yC0uxE0VvUMAmn5dDFSzeS143bmBbKxSsIwd7uh6968C7m3uLRqfzL7J+tS1ss425hAisaMBvjnUH
        IGfTwRmL65p+dvvxbeZzlJVKU9gzivlgNCMYrRVVF7g10CBYXR2UGby3EYcqYE/htZRJbNOtzIbHP
        xOoNwDeg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRP1m-005Eci-7b; Fri, 26 Aug 2022 02:24:58 +0000
Message-ID: <090894ea-3539-fdca-b470-49d72cb3228e@infradead.org>
Date:   Thu, 25 Aug 2022 19:24:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <87a67syxa0.fsf@meer.lwn.net> <YwgtoiKl5Azt7Pre@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YwgtoiKl5Azt7Pre@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/25/22 19:19, Bagas Sanjaya wrote:
> On Thu, Aug 25, 2022 at 12:48:39PM -0600, Jonathan Corbet wrote:
>>  - applying-patches.rst should just go.  I didn't prevail last time I
>>    tried to make that point, but I still don't think that we help
>>    anybody by dragging 1990's instructions around now.
>>
> 
> Hi jon,
> 
> If we're about to rm applying-patches.rst, at least we also need to add
> a warning to the doc, saying "This documentation is obsolete and will be
> removed in the future.", while adding the same deprecation message on
> scripts/patch-kernel. The script can still be usable and kept around for
> a cycle. If no users complain, we will go ahead rm-ing.

It already says:

   This document is obsolete.  In most cases, rather than using ``patch``
   manually, you'll almost certainly want to look at using Git instead.

although the bit about "will be removed in the [near] future"
would be a good addition.

-- 
~Randy
