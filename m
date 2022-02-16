Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3066C4B8D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiBPQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:14:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiBPQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:14:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7D2AE059;
        Wed, 16 Feb 2022 08:13:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 32E711F45194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645028028;
        bh=3BUsXE89fj7rTHTZ2Yhpsi6N0U9oLnOlc4n50VFT60E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=evPGizZJx/nOUe+JgN1fgupzxHJO36/YI1+2yhKP6QhIRUN1Gzyqm0qAoWKIg4RcX
         Z8RwxS217pBNbSCQaNkY3Tl/Q9qfDcE7u9I60YmLAt1ZCXqoy+fO/Wh4/wbRsamizS
         sH3HnNDrl2iUng7LD4hxbkEj/FppjDA2Z9n7JFqSjhj3TP/VXk/RTsOHbT65bGmags
         wddJbxb+6bQWQX07Aj7WEmsBWPHyQtNGlXYpQC29DJNUw+gKqG5eqLbnTymB9YiGOC
         HJITtUMnrUrcuCBu97cMrqVXNjeEixrjkscTFFk31Ow0qyBqJ+c/wf3I1lPOYwt4e/
         G7gMUXmc/Sbjw==
Message-ID: <2e3e718f-d547-e85b-ec83-dfb2f28c6447@collabora.com>
Date:   Wed, 16 Feb 2022 13:13:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: linux-next: build failure after merge of the spi tree
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220216161718.2c094b08@canb.auug.org.au>
 <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
 <284e2e05-9402-e480-7a69-3282b7e95b6f@collabora.com>
 <Yg0hbeSPpDa4Oy2x@sirena.org.uk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <Yg0hbeSPpDa4Oy2x@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 13:08 de 16/02/22, Mark Brown escreveu:
> On Wed, Feb 16, 2022 at 10:07:02AM -0300, André Almeida wrote:
> 
>> ACPI_PTR() make it as NULL if CONFIG_ACPI is not set, making the driver
>> suitable for test compiling even without ACPI enabled. Mark, I'll send a
>> v3 with this fixed.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Ok, let me send a fixing patch then.
