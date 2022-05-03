Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA74517D33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiECGP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiECGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:15:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1335DE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651558344; x=1683094344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kK67qFdzKyorcy79eVZf/InLXY5uL/sRLzX8Cbf0k68=;
  b=AvvNZVTnYAusLvYE07uR0FFzGyDO6W3MGuSaUzYsa50rasCBddE6x46S
   1tymDwXTpepIH72JniOgNcNIWbsoxml+7DWZ+A1dliTHw2oHLU8y+INer
   XlTbelfVBFmTE8TOAcBtK41EHl4IoJi1n42uq46U6fHVErVpTH8krw/ut
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 May 2022 23:12:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 23:12:24 -0700
Received: from [10.110.26.248] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 23:12:21 -0700
Message-ID: <a86eb014-a375-cc48-78b0-deb147827248@quicinc.com>
Date:   Tue, 3 May 2022 11:42:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] devcoredump : Serialize devcd_del work
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <rafael@kernel.org>,
        <johannes@sipsolutions.net>, <keescook@chromium.org>
References: <1651505671-1506-1-git-send-email-quic_mojha@quicinc.com>
 <a9d66a63-4a26-9051-1540-69cd0d1056ec@quicinc.com>
 <YnBonb+4K12JIp+L@kroah.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <YnBonb+4K12JIp+L@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2022 4:56 AM, Greg KH wrote:
> On Mon, May 02, 2022 at 09:06:08PM +0530, Mukesh Ojha wrote:
>> This should be v4, corrected in the subject
> 
> Please resend a new verison, with an updated version, our tools can't
> handle responses like this and attempt to find the original commit.

Sure, thanks.
Sent it here [0].

[0]
https://lore.kernel.org/lkml/1651558074-9620-1-git-send-email-quic_mojha@quicinc.com/


-Mukesh

> 
> Remember, be explicit, we deal with hundreds of patches a day...
> 
> thanks,
> 
> greg k-h
