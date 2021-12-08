Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5168A46D7E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhLHQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:20:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22500 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232656AbhLHQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638980215; x=1670516215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZfEVpDcolW9vtFmOupO/FWM3kNMjEQeDJIfM7JIO8zQ=;
  b=nCnyMt0nK9vwyDQB82dD0CwtHPUoTQlGE3PY60tPRllmTev230EVmOr/
   zFRxbUXgBVph28e0TOWXUtTSpiP6HEQpFo210sYNX3r2lk+vOF4E4tZBP
   5dEGmEehoZJr6YYEaBdDZCMsI24WWz1AXdOQArBaTIPW1h8xan4BI3uhH
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Dec 2021 08:16:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 08:16:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 08:16:53 -0800
Received: from [10.48.240.55] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 8 Dec 2021
 08:16:53 -0800
Message-ID: <e7c9b7d4-8fef-57f5-b774-9931f5ff40ed@quicinc.com>
Date:   Wed, 8 Dec 2021 08:16:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] clk: Fix children not voting entire parent chain during
 init
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
 <20211208015324.86282C341C5@smtp.kernel.org>
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <20211208015324.86282C341C5@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2021 5:53 PM, Stephen Boyd wrote:
> 
> Let me see if I can fix this up on application.
> 

Sorry, did you mean you'll address your comments when applying the patch 
to your tree? Or would you like me to submit a v2?
