Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519154A79B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiFNDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:41:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C913616D;
        Mon, 13 Jun 2022 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=85bqTzuSH04Q0YY9gl8V6Wefv/U4n0XGaL1+C6IxomU=; b=VPnVhyfNLvA7Hz78B28h9aMsfm
        Zk2TnfPHluiQPiJZDR6+TfVDLxxJ2d1cU1wR2Kt17IVrAqBhGgn7AIuoxjZ2/MtnYiKro+hRYnRm2
        d8cM2ALgU4lAdtxAr+LtvTwTdKlMfwoAH8ClwWhNmNzrcmMtYrVvEqL8Jff4e5K6P6+D/qasvFOX0
        WgUNJvmtdV4mR2dfhlH8jiBq07jNJumo6m9oHdqVyTQCLQw+8RVVIAV53tTekzZFJzsrW8yrioLYe
        UZNruM8zZG1fLlvSkizWK0VN1zYBTkGsCI0UF/Gl5uk5p38AFCBPOeKzYnN7RplGvj3F3Nny083jR
        zGQPcLFw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0xQP-007kZz-AB; Tue, 14 Jun 2022 03:41:06 +0000
Message-ID: <a7adaaab-cbc3-06ce-f3ab-b411598414e8@infradead.org>
Date:   Mon, 13 Jun 2022 20:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: Fixes tag needs some work in the selinux tree
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220614082425.415adffc@canb.auug.org.au>
 <CAHC9VhT9QUdfu5TCZcAuzcC8wBaA8VR2MKWiQE3RWEv5M65tJA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHC9VhT9QUdfu5TCZcAuzcC8wBaA8VR2MKWiQE3RWEv5M65tJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 16:33, Paul Moore wrote:
> On Mon, Jun 13, 2022 at 6:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> In commit
>>
>>   e81ee824e8a1 ("docs: selinux: add '=' signs to kernel boot options")
>>
>> Fixes tag
>>
>>   Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> has these problem(s):
>>
>>   - No SHA1 recognised
>>
>> Also, I don't think that is a relevent or useful Fixes tag anyway.
> 
> Good point Stephen.  I just dropped the tag in the offending commit
> and did a force push back to selinux/next; sorry for the noise.
> 

Thanks Stephen and Paul.

-- 
~Randy
