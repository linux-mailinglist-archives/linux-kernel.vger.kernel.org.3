Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6857BC93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiGTRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiGTRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:25:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0958388D;
        Wed, 20 Jul 2022 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SVv1mJFZgdLvqAT/dc54K/PPq+LfXgZ/F5lxQKzL04s=; b=yzstOkdryQRuZvjnG4hYCZYTbr
        AidRt3Quccsh2KnHEvYwSz0JLj/7MHhcRtbWkzXv8quL3Iv1XhAJ4bLHTPj5Umrd1cTe6jfSc5djn
        Qcn3WcYPSXvrxX8QoBC6iCXBV7yVpS1rPwl1fbgcF+iaVysmgyFtvU7FIZEZL61q9cKDGPSvXv93K
        yH2MmH7z3UvdYmD1O0Ia3rSf0JxIszxWtUAA7+C8EwA+Vjr9FYDGDgHwhLdFXrbb6naictjKBWtpU
        snxIyS6VR1byqiFM5to8WgMbxDOM+lmznClaVpsE9wzCyGWpYz02On65VrluwdTpXIxa9V2of8aBZ
        +9H7pUYg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEDRk-008azp-Uy; Wed, 20 Jul 2022 17:25:17 +0000
Message-ID: <f6966a4f-7010-6dd1-cf6d-6f42fa393607@infradead.org>
Date:   Wed, 20 Jul 2022 10:25:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 20 (I2C_I801)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220720225211.20f9fa80@canb.auug.org.au>
 <a4ed17de-de0e-8267-851e-51a762223cc5@infradead.org>
In-Reply-To: <a4ed17de-de0e-8267-851e-51a762223cc5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 10:02, Randy Dunlap wrote:
> 
> 
> On 7/20/22 05:52, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20220719:
>>
> 
> on i386 or x86_64:
> when X86_PLATFORM_DEVICES is not set:
> 
> WARNING: unmet direct dependencies detected for P2SB
>   Depends on [n]: X86_PLATFORM_DEVICES [=n] && PCI [=y]
>   Selected by [m]:
>   - I2C_I801 [=m] && I2C [=m] && HAS_IOMEM [=y] && PCI [=y] && X86 [=y]
> 
> 
> Full randconfig file is attached.
> 

Sorry, I just noticed in another randconfig build a similar issue
with LPC_ICH:

WARNING: unmet direct dependencies detected for P2SB
  Depends on [n]: X86_PLATFORM_DEVICES [=n] && PCI [=y]
  Selected by [m]:
  - LPC_ICH [=m] && HAS_IOMEM [=y] && PCI [=y] && X86 [=y]


-- 
~Randy
