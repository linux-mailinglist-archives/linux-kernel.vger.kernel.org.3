Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBDC5766F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGOSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGOSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:55:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1012E6B9;
        Fri, 15 Jul 2022 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VSI08QL3zOcYcSXc4Zml7HpuS/20FxcTomrvHdgOTaE=; b=c1odVyZNW30ww9ohbjmFkmSTTY
        sPKVXAMoqxdvFFOjIiw5K8QrsACAD9PaWHFIKpsR1DTQvbhH+X8QlfM7SvVMJMPGCc+EZ/9GWrB9/
        dH/IOypF29o9QCeoVcdUeuxUgKXYVqSitI33OnGI1Uoi0npv5M7aWmxR8AMjXApOO34r/3WOBv1Ch
        HxoAk19Py715q9803K+VVVDyetOppFWKbnv6y0QX15Tvxza9+mQDHR+qQpb5e7uCDqucmWXFUMbtx
        uNOoG7McX4u9QLpKB4Xkcp/rbgbPvOqKtAIBtlifkFw/M5KfBR6HeZtJ3GvMs6shoT322xBnsKCzJ
        ZkojPzRQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCQSu-009XtJ-CX; Fri, 15 Jul 2022 18:55:04 +0000
Message-ID: <1bd8c899-6675-d3cf-3f3b-bea48e216c9f@infradead.org>
Date:   Fri, 15 Jul 2022 11:55:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Documentation: process: Update email client
 instructions for Thunderbird
Content-Language: en-US
To:     Sotir Danailov <sndanailov@gmail.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
References: <20220714131152.12709-1-sndanailov@gmail.com>
 <ae06388f-a062-132b-ee61-8ad68f227970@infradead.org>
 <efca1b16-2492-fa68-119b-8c3cfa05cadb@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <efca1b16-2492-fa68-119b-8c3cfa05cadb@gmail.com>
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



On 7/15/22 01:11, Sotir Danailov wrote:
> Thank you for taking the time!
> I didn't expect the original author to participate. :D
> I probably should've sent a cc to you and others as well, sorry about that!
> Didn't do my research good enough I guess.
> 
> On Fri 15 07 2022 01:18, Randy Dunlap wrote:
>>
>> Does thunderbird v91.11.0 qualify as newer or older?
>>
>> I tried to use the external-editor-revived yesterday with v1 of the patch..
>> no success.
> 
> Do you think that the whole section about the
> old "External Editor" extension should be removed?

No, I don't. It's useful IMO.

>> v2 of the patch has more useful info (about native-messaging), so I installed
>> that and still not happy.
>> After pressing "External Editor" in a tbird reply window, nothing happens.
>>
>> Wait -- hold everything!  Exiting tbird and reloading it
>> fixed all problems. :)
> 
> I probably should add in the document that the user should
> restart Thunderbird after all modifications, just to be sure.

Please.

Thanks.

-- 
~Randy
