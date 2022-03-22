Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155EC4E3EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiCVMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiCVMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:45:17 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC613D7A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:43:50 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 561D87E2BC;
        Tue, 22 Mar 2022 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647953029;
        bh=ie93YiRfMjsPc2WJj9+BJSUmlGPc1OBg4+w1HWqwKKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J28lNxfQG/G2ZhfYeMrrtdF1Tenb+RxCRsZzuBp6eTs7dQFLOQ7KJdeHRPZoFbvXr
         KmQ18dMrXSygPF7/90gfvZrK2S8LoOtqsHnzuAoKbcHVkuTEzVNDOSdasTaTHaEzDH
         gHEzZ6w9lvpFs6FKo1eyexuiR1EDF3ewtHr8Uw0TdMZDCx3HY2PA/onz1h2WMIneQY
         KKlGJtxXOaua41J6Dzo+bMy6Nya1q9T2D4Jq7qQWO88slEaSH1Euavc0PlYL1jXbHr
         ihB9L7kK1qWRUUMkQcigx6AsZW88stqxo9PmeK0hvQvkqhp83O+kIVSgReAIhHfW4u
         08ozFBl+pqtOQ==
Message-ID: <b998a2a3-a4e6-cf4f-9de7-0224f73ae88b@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:43:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 0/8] Add dynamic memory allocator support for
 nolibc
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322112725.GC10306@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322112725.GC10306@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 6:27 PM, Willy Tarreau wrote:
> Hi Ammar,
> 
> On Tue, Mar 22, 2022 at 05:21:07PM +0700, Ammar Faizi wrote:
>> Hi,
>>
>> This is the v2 of RFC to add dynamic memory allocator support for
>> nolibc.
> So overall, except for the syscall6 implementation whereI agree with
> David that it would be better to always use the "push" variant, I'm
> fine with the rest of the series.

Will send a non-RFC patchset for this...

-- 
Ammar Faizi
