Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B849B54838F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiFMJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiFMJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1F014029
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655111951; x=1686647951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rbm5thygbWWefU+4Ju3dMFUcjhR/h/QPLN3Eqrm7vno=;
  b=e1wc+3zH/HTl17iCo+LQZkiFElBoha35FZHUp5/IHIE2OcGcIVXD3p75
   iQSGqeetF4w3cw6fdueXRCUlyIxC/Chp6pCYiOu2j+6fhaJ/Zf7CWOTCg
   vpuaUAxfvI1Hgi5Yqz6fjKYsO3HyuUy+vju5x07JucOpIi9Uae8LRmdkD
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 02:19:11 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:19:11 -0700
Received: from [10.50.55.236] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 02:19:08 -0700
Message-ID: <6b665002-b68e-5392-a7ff-908a1c853663@quicinc.com>
Date:   Mon, 13 Jun 2022 14:49:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V0 1/1] asoc: msm: use hashtable to check kcontrol
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Jha <quic_kkishorj@quicinc.com>
References: <cover.1653813866.git.quic_rbankapu@quicinc.com>
 <ad55bbd41cc253acb9af6ac068c15dd1545ecd81.1653813866.git.quic_rbankapu@quicinc.com>
 <8735gsznnt.wl-tiwai@suse.de>
 <f3a25238-fcc6-2381-e329-0bd80a3632a5@quicinc.com>
 <874k0tnjkw.wl-tiwai@suse.de>
From:   Raghu Ballappa Bankapur <quic_rbankapu@quicinc.com>
In-Reply-To: <874k0tnjkw.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi

v2 patch looks fine. Can we use this patch to submit to android common 
kernel? There is code freeze for KMI on june 17.

Please share your opinion.


Thanks

Raghu Bankapur

On 6/10/2022 11:31 AM, Takashi Iwai wrote:
> On Thu, 09 Jun 2022 20:16:52 +0200,
> Raghu Ballappa Bankapur wrote:
>>
>> Hi Takashi
>>
>> Our implementation also falls inline with your approach  [PATCH RFC] ALSA:
>> control: Use xarray for faster lookups (kernel.org), but you approach looks to
>> be clean with xarray.
>>
>> is it possible to upstream those changes?
> I submitted a v2 patch, please check it out.
>
>
> thanks,
>
> Takashi
