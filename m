Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D45003AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiDNBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDNBc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:32:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05A51E6C;
        Wed, 13 Apr 2022 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rdV4U6Dx5iBLv5DSJriCcbwBfEfG5Skakdx5e0vTqJI=; b=EN4GFDr93s9t6NJdwQfwKiAi05
        WytFxzB96JCnVezYDMLImqtxokbbECrU18PxzXhNYzUsUvJrkJmJfkX5B6ah0ftKjIk011Lpq6TGC
        KuarskbrFY4pDbFdQ22n59wvmEmY8gxnNAXJjbJq7hujNwvsot9N/C3Lz0IfPrwOvCtOPpQ+CzEpZ
        YdvRJV649mCwtHBtNnu7L4EPoodVgujxcEz1ZHKPVh8OBuhUSodGpnF6u+3dO63/IZ50OLaZhr9OJ
        NMPrrH+mZxbEo4zRvOmUMyNGh4Olf/EH/8KrqwXQVGOCexHhAtq/hjUwkVj6bzCNbjnGAMyhAk+bb
        jJQ9JQJw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neoJ4-004qna-RZ; Thu, 14 Apr 2022 01:29:59 +0000
Message-ID: <909c4006-255a-a70d-afa2-c821a6e7b28d@infradead.org>
Date:   Wed, 13 Apr 2022 18:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] kernel-doc: support DECLARE_PHY_INTERFACE_MASK()
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
References: <20211030020813.32654-1-rdunlap@infradead.org>
 <Ylavaf+OlgTVeI6a@shell.armlinux.org.uk>
 <6fe36857-1c94-a421-0701-caf9c38b1c92@infradead.org>
In-Reply-To: <6fe36857-1c94-a421-0701-caf9c38b1c92@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 08:19, Randy Dunlap wrote:
> 
> 
> On 4/13/22 04:09, Russell King (Oracle) wrote:
>> On Fri, Oct 29, 2021 at 07:08:13PM -0700, Randy Dunlap wrote:
>>> Support the DECLARE_PHY_INTERFACE_MASK() macro that is used to declare
>>> a bitmap by converting the macro to DECLARE_BITMAP(), as has been done
>>> for the __ETHTOOL_DECLARE_LINK_MODE_MASK() macro.
>>>
>>> This fixes a 'make htmldocs' warning:
>>>
>>> include/linux/phylink.h:82: warning: Function parameter or member 'DECLARE_PHY_INTERFACE_MASK(supported_interfaces' not described in 'phylink_config'
>>>
>>> that was introduced by commit
>>>   38c310eb46f5 ("net: phylink: add MAC phy_interface_t bitmap")
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
>>
>> Thanks Randy, sorry I missed this patch.
>>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>
>> What is the intention for merging this patch? Will Jon merge it?
>> Your tags said To: Jon but you don't seem to have included him in
>> the email.
> 
> Hm, I didn't notice that.
> Guess I'll resend it with your R-b.

No need to resend it. It's already merged into mainline.

-- 
~Randy
