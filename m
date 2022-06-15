Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39654CE65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbiFOQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349399AbiFOQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:17:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62155219;
        Wed, 15 Jun 2022 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655309767; x=1686845767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/XGPF/UCiIx5RHiyRCcdECVGuI3Vb0cgI8bym3B3H0w=;
  b=Ik5OZ06l3yVtRnOgK4nWtHltVig1jQ7MBg2biHeKwP8mZOdup98yCsFl
   4f+5YH6x1ET7YKqGQto5LGmUjjI1doLIkJDZd8HXHFeYYHS7qzJjWL9rr
   o7NgdFRfPIQDwZn8Zstf8KM9kTC/aev1l2Gjh1sMQu7kMWHuP6ZOiJjel
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Jun 2022 09:15:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:15:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 09:15:37 -0700
Received: from [10.110.75.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 09:15:36 -0700
Message-ID: <fb7f1065-9a55-05ef-9dce-51c43ba69d2e@quicinc.com>
Date:   Wed, 15 Jun 2022 09:15:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] kbuild: remove sed command from cmd_ar_builtin
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220614055149.1900535-1-masahiroy@kernel.org>
 <CAKwvOdmcLCV6J+PYXCugH=0Pt_=yARZ-Y3SEmYy8F+oBpb1UYw@mail.gmail.com>
 <CAK7LNATxxvBeooj6t1cPYafS7gd9gNX8YOFghvTbbkusFoQ3pA@mail.gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAK7LNATxxvBeooj6t1cPYafS7gd9gNX8YOFghvTbbkusFoQ3pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2022 8:03 PM, Masahiro Yamada wrote:
> On Wed, Jun 15, 2022 at 3:59 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Mon, Jun 13, 2022 at 10:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>
>>> Replace a pipeline of echo and sed with printf to decrease process forks.
>>
>> If you're trying to minimize process forks, is it possible to remove
>> the use of xargs as well and just invoke $(AR) with the parameters
>> splatted out? I don't know myself, but maybe you're creative enough?
> 
> 
> If I remove xargs, we will go back to the situation
> before cd968b97c49214e6557381bddddacbd0e0fb696e.
> 
> This patch tries to avoid "too long argument error"
> without forking too many processes.
> Maybe I am too worried about the potential issue, though...

 From my very clouded perspective avoiding "too long argument error" 
should take priority :)


