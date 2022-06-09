Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F3544994
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbiFIK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFIK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:59:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5081AD8D;
        Thu,  9 Jun 2022 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654772361; x=1686308361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VU8o8/MxiBPpS613WG31zcx2hVkLcBiOKxwc0JXNnV8=;
  b=By0vbVlaYN9P66cDxKTKKqkBwUl7WWUTxu9VPLF8+Q8NPPjxTCqFlMle
   rdKv39ipeXfj+yqkT/lg85ZjqtW4yJFYY/oLoQMnQ+tqYMkdaFG9cBxS1
   ZrlZ1sAZ4Ual0CTlLAae3eFgvLwh24Rg3vtHPrJRU8RRrJXORmJrJ7JBP
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 03:59:21 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 03:59:21 -0700
Received: from [10.253.77.106] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 03:59:18 -0700
Message-ID: <38dab556-e285-7271-bc95-98bb052c888a@quicinc.com>
Date:   Thu, 9 Jun 2022 18:59:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix set up CVSD SCO failure
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1654763558-20721-1-git-send-email-quic_zijuhu@quicinc.com>
 <5148cb92-8904-baef-ca78-5051612f044b@molgen.mpg.de>
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5148cb92-8904-baef-ca78-5051612f044b@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/2022 6:56 PM, Paul Menzel wrote:
> Dear Zijun,
> 
> 
> Thank you for the fixes. *setup* in the summary is a noun, so no space there. In my reply to v1 I suggested:
> 
>> Bluetooth: Fix CVSD SCO setup failure
thank you, i will correct it as your suggestion within v3 patch
> 
> 
> Kind regards,
> 
> Paul

