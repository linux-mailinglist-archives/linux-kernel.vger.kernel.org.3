Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B150C304
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiDVWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiDVWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:32:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0201F1EADF8;
        Fri, 22 Apr 2022 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650662760; x=1682198760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3GRkzkRbPkOfe9vQY5hmWO91T7iWle1ZZJGqwNmrBJw=;
  b=rBCP99fijRzxs6siqoIQTnMjky/q+MOegYiL3ZZBlLJSp0kHUVDLaoUG
   wqj/6A1Kgl9k/WMTXTHxIlcabMdj3OSwGBxpy1CYSr8e9fll2KWVgosxg
   neqFlppQXmYqlxD2W3XiSmS954Cb4TqenHcDc+n/+ZTe5Jp8zW/8YjRTg
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Apr 2022 12:07:46 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 12:07:46 -0700
Received: from [10.110.72.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 12:07:45 -0700
Message-ID: <0d290fab-28ca-77f3-a6d2-415d990f0f91@quicinc.com>
Date:   Fri, 22 Apr 2022 12:07:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/7] kbuild: more misc cleanups
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Alexander Lobakin" <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20220406153023.500847-1-masahiroy@kernel.org>
 <CAK7LNARzPPRnnAayau3bwB_uj17_uirY+F9rAV048oMp-c-WMw@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CAK7LNARzPPRnnAayau3bwB_uj17_uirY+F9rAV048oMp-c-WMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 4/15/2022 12:20 AM, Masahiro Yamada wrote:
> On Thu, Apr 7, 2022 at 12:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>>
>> I sent the first batch of cleanups:
>> https://lore.kernel.org/linux-kbuild/20220405113359.2880241-1-masahiroy@kernel.org/T/#t
>>
>> I took 01-06, 09-10.
>> I dropped 07, 08.
>>
>> This is the second batch.
>>
> 
> Applied to linux-kbuild.
> 
> 

I didn't see the last patch (kbuild: read *.mod to get objects passed to 
$(LD) or $(AR)) applied. Was the last patch intentionally skipped?

>>
>>
>> Masahiro Yamada (7):
>>    kbuild: reuse suffix-search to refactor multi_depend
>>    kbuild: make multi_depend work with targets in subdirectory
>>    kbuild: reuse real-search to simplify cmd_mod
>>    kbuild: split the second line of *.mod into *.usyms
>>    kbuild: get rid of duplication in *.mod files
>>    kbuild: make *.mod not depend on *.o
>>    kbuild: read *.mod to get objects passed to $(LD) or $(AR)
>>
>>   .gitignore                  |  1 +
>>   Makefile                    |  5 +++--
>>   scripts/Makefile.build      | 31 ++++++++++++++-----------------
>>   scripts/Makefile.lib        |  6 +++---
>>   scripts/adjust_autoksyms.sh |  2 +-
>>   scripts/gen_autoksyms.sh    | 18 +++++++++++-------
>>   scripts/mod/sumversion.c    | 11 ++---------
>>   7 files changed, 35 insertions(+), 39 deletions(-)
>>
>> --
>> 2.32.0
>>
> 
> 
