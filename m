Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3587452B15F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiEREYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiEREYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:24:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD773204C;
        Tue, 17 May 2022 21:24:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id DC3401F41051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652847873;
        bh=q3PUZokaxHBvIl14+i4VCe145SqJn/VE2++JUWP5Sr4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=AKfSkbSlWfUxxXdy93cJtGoGa9dkrIpQTupD8ow0bKjoeEIfP2Cu5fwA/qjk1XZ++
         hfh9UpFC5FN8pFMG2F3ximXMUxFaTgXh119iioAP6lVHKw9EwiuNqiGkMytv0VIkHa
         14XLCeCovWXvsaWNpcqCosK8UZmoiQJdcbTUrCikbZDVIXj7StinTwUX8pK3GUOuOr
         ILch+2Ea7R+HLqO13Zo6BT7lIeZEogdVjx9H4K1zLFrS/HNuq5mOt2Aq/CN3raQEqr
         IWnOWVeuFqWZaxKgFQQ/iO4HsaXLNDdjUFBfrdVTePdBrwCn/DumCiNwsvPZ1vIZPK
         IALi8nrEcXtAw==
Message-ID: <e47f4a9c-469b-898d-f390-c199b16dd609@collabora.com>
Date:   Wed, 18 May 2022 09:24:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220516213832.19127535@canb.auug.org.au>
 <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
 <b159beea-c7ab-b175-26c2-496f82443470@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b159beea-c7ab-b175-26c2-496f82443470@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

On 5/18/22 8:23 AM, Bagas Sanjaya wrote:
> On 5/17/22 20:09, Muhammad Usama Anjum wrote:
>> I've found these warnings in local build. But I'm unable to fix them.
>> Apparently, there doesn't seem any unexpected indentation. This kind of
>> same warnings have also appeared on some more files before this commit
>> without any reason.
>>
> 
> Hi,
> 
> I've figured out the fix on [1]. Please review.
> 
> [1]: https://lore.kernel.org/linux-next/20220518031750.21923-2-bagasdotme@gmail.com/
> 

-- 
Muhammad Usama Anjum
