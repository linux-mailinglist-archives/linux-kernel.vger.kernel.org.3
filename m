Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C60586843
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiHALhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiHALhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:37:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEA192A1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659353851; x=1690889851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H/cNs/T6KxOCSuS/MaY/NqlNQR3n2uQf3nDlTJr6XOE=;
  b=pkhsgYovpZwGQzwcwURq0lHYDTcvANx+1xDCn+ttzF8Bk9Vkkp9NnEK3
   3CBZDvZ6PE0ZKsaoYnQ9vrJi6witwm0a19aqwWi1eTQviAHUNY/bk+dod
   zN0Rt3n14hmLUi5IC1n5b9HcEVA4XpFSy52T97H69TtIb5iTMDQPJQscH
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Aug 2022 04:37:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:37:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 04:37:30 -0700
Received: from [10.216.43.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 04:37:28 -0700
Message-ID: <c6c8f2b3-fe19-f6e1-4540-89d395b82ea8@quicinc.com>
Date:   Mon, 1 Aug 2022 17:07:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/page_ext: remove unused variable in offline_page_ext
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>, <mhocko@suse.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
 <20220801052848.GB18790@hu-pkondeti-hyd.qualcomm.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220801052848.GB18790@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pavan for the comments!!

On 8/1/2022 10:58 AM, Pavan Kondeti wrote:
> On Mon, Aug 01, 2022 at 10:36:37AM +0530, Charan Teja Kalla wrote:
>> Remove unused variable 'nid' in offline_page_ext(). This is not used
>> since the page_ext code inception.
>>
> Just to be clear, should we say "drop nid argument from offline_page_exit"?
IIUC, drop is something we use if it ever considered to use earlier.
Remove is when we are completely getting rid of it.

Anyway, since it is just terminology and there are already some tags on
this change, I will let Andrew to take the decision and if he decides,
will give V2 with changing the commit message and collect all the tags.

Thanks,
Charan
