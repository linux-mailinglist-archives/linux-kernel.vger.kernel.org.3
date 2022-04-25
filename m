Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11F50DBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiDYJDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiDYJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:03:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7713E0E;
        Mon, 25 Apr 2022 01:59:55 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P5rs67026768;
        Mon, 25 Apr 2022 10:59:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ZMtuKaWe+BL2NAy7gcgkV/ofmg3oFgDu9ItvjXw0Dss=;
 b=75wL8opmHS3JmmtJd349aQQa17B+QQpNda5kDfJWtYZnwyg21twFy+5kGHWh76P1qXFN
 dall7bYGGHvUdnPfQvm+250Ac5JY83CIOO0HwE9OsrONHG/yLUQTp2DExxxqFszVi76k
 Zqx2qzxyuXdqp4ZUjeKdnxP+WFfFtdBq5ZQR0sVrPnuYdNsDsZ+BbasjFZ3I0LgJkOrE
 KzGRGIsZK3DG0R7gFWhrOsVzprdYADBFzaVMGm14PSaRUZcaL1jIMerkOew8Iu6I4KnK
 HbDTuGinZn9h2TSCn04CWEvZErvRr+8n5qcpURfEFnBv0dHUghABREVv34OsAKN5yQdQ 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fm6k9037v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:59:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E51E10002A;
        Mon, 25 Apr 2022 10:59:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16E6221682F;
        Mon, 25 Apr 2022 10:59:47 +0200 (CEST)
Received: from [10.201.20.246] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 25 Apr
 2022 10:59:46 +0200
Message-ID: <c3e080e8-d070-ef90-cd8a-6d4bd41e32e0@foss.st.com>
Date:   Mon, 25 Apr 2022 10:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH V2 0/3] rpmsg and glink signaling API support
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <5cde9477-d73c-03c4-4dc0-c63fa0f8c8d9@foss.st.com>
Content-Language: en-US
In-Reply-To: <5cde9477-d73c-03c4-4dc0-c63fa0f8c8d9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/22 11:17, Arnaud POULIQUEN wrote:
> Hi all,
> 
> On 1/18/22 20:43, Deepak Kumar Singh wrote:
>> [Change from V1]
>> Fixed most of the review comments in V1.
> 
> This implementation works for the glink transport,
> But how to manage such flow control for other transport
> layer?
> From my POV it is important that it is also usable for
> by transport backends which doe not have such signaling.
> The idea here is not to implement in other backends yet, but
> at least to determine how it could be handled to avoid that
> tomorrow this has to be reworked. 

FYI, I've started some dev, trying to adapt the implementation to
the virtio backend to move forward with this topic.

It is only a POC for time being based on a new ROPMsg service for the
flow control.

Linux code is available here:
https://github.com/arnopo/linux/commits/signalling

openamp library associated code is available here:
https://github.com/arnopo/open-amp/commits/flow_ctrl

I hope to find some time next month to continue my dev and send patches
to the mailing list. 

Regards,
Arnaud


> 
> More than that I wonder if the flow control could also be used
> to solve the RPmsg protocol issue related to the channel
> announcement [1][2]
> 
> [1] https://github.com/OpenAMP/open-amp/pull/160
> [2] https://lore.kernel.org/lkml/20220316153001.662422-1-arnaud.pouliquen@foss.st.com/
> 
> Thanks,
> Arnaud



> 
>>
>> Deepak Kumar Singh (3):
>>   rpmsg: core: Add signal API support
>>   rpmsg: glink: Add support to handle signals command
>>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
>>
>>  drivers/rpmsg/qcom_glink_native.c | 77 +++++++++++++++++++++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_char.c        | 47 ++++++++++++++++++++++--
>>  drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++
>>  drivers/rpmsg/rpmsg_internal.h    |  2 +
>>  include/linux/rpmsg.h             | 14 +++++++
>>  5 files changed, 157 insertions(+), 4 deletions(-)
>>
