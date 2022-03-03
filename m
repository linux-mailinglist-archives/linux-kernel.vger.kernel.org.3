Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7314CC85E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiCCVtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiCCVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:49:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8AAE5B;
        Thu,  3 Mar 2022 13:48:45 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223LmgLV023479;
        Thu, 3 Mar 2022 21:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1pbqyUEw1bzH9TofM6xgfYFQ/n9JBpL9GVCRuT7xppI=;
 b=FtAQJ60BYY+PMN+N3G67foUKkyYTWhnM98Jm58W4h9Q+XHQkt4ge3AgF0BHdOm4YmRCi
 vawNOnSjR+i0VbD7WEa6UI2tnqWfNxEQkka8YOA8yysEBZz02g0JYu/1ZwTR8K+zoGN4
 Lu3ricPGLR7Gfqknu8zbC37/0zXGC6JwJlJC2LXSuX8fHnUMTMViorRWVU77zpJi9X2r
 HZaBZvQzTCh7Q+O3t1AuejLEBhjemddUGWri3JjnMYEaAUZTMT6pPunIYvSt29+CLzXZ
 MF1Qure8/DhNZX6SWFM0WbLsi8l39fMPkVtZi7YKnMKwmQ0JDQvir4xXDvUSrl6CrzgF Fg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ek5ww8014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 21:48:42 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223Lbbiu028147;
        Thu, 3 Mar 2022 21:48:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3ek4kd0g5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 21:48:40 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223LmdtW14025356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 21:48:39 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93FEB12405A;
        Thu,  3 Mar 2022 21:48:39 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A6B124055;
        Thu,  3 Mar 2022 21:48:38 +0000 (GMT)
Received: from [9.211.103.39] (unknown [9.211.103.39])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 21:48:38 +0000 (GMT)
Message-ID: <b1ec9ab3-d621-fa66-0fae-f966242f3f7f@linux.ibm.com>
Date:   Thu, 3 Mar 2022 15:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com>
 <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
 <YiCN+x2XPiawaweY@hovoldconsulting.com>
 <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
 <YiCU3KI9Dh2psRnK@hovoldconsulting.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <YiCU3KI9Dh2psRnK@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Shm5Iy2_Dk68VoVDh6BUihLcMU3Q8uLU
X-Proofpoint-ORIG-GUID: Shm5Iy2_Dk68VoVDh6BUihLcMU3Q8uLU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203030097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/22 04:13, Johan Hovold wrote:
> On Thu, Mar 03, 2022 at 09:46:05AM +0000, Joel Stanley wrote:
>> On Thu, 3 Mar 2022 at 09:44, Johan Hovold <johan@kernel.org> wrote:
>>> On Thu, Mar 03, 2022 at 09:24:51AM +0000, Joel Stanley wrote:
>>>> On Thu, 3 Mar 2022 at 09:15, Johan Hovold <johan@kernel.org> wrote:
>>>>> On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
>>>>>> On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
>>>>>>> On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
>>>>>>>> IBM manufactures a PL2303 device for UPS communications. Add the vendor
>>>>>>>> and product IDs so that the PL2303 driver binds to the device.
>>>>>>>>
>>>>>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>>>>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>>>>>> ---
>>>>>>>> Changes since v1:
>>>>>>>>   - Fix commit message Signed-off-by ordering.
>>>>>>> Almost there. You're still missing a Co-developed-by tag, a From line,
>>>>>>> or both.
>>>>>> It's neither. This patch was applied to a tree by myself, and I asked
>>>>>> Eddie to send it to mainline for merging.
>>>>> Then you are missing a From line. As the patch looks like know, Eddie is
>>>>> considered the author and not you.
>>>> You are incorrect. Eddie is the author.
>>> Then what is your SoB doing there in the first place? If Eddie is the
>>> sole author as well as the submitter, and you didn't touch the patch in
>>> between, then your SoB does not belong in the chain.
>>>
>>> If you applied Eddie's patch to your shared tree and Eddie generated a
>>> patch from there, then the chain should be:
>>>
>>>          SoB: E
>>>          SoB: J
>>>          SoB: E
>>>
>>> but this is starting to look a bit ridiculous.
>> I agree. I would appreciate it if you applied the patch, with or
>> without my sob in whatever order you deem fit.
> Ok, I'll assume what you intended was E-J-E but that perhaps
> git-format-patch swallowed the last SoB. Thanks for clarifying.
>
> I was going to apply to the patch, but I see now that you didn't provide
> any details about the product apart from it being a UPS and that's not
> reflected in the define name.
>
> Do you have a pointer to device (family) in question?


Hi,


It's a pretty generic pl2303 device and doesn't have to be used for UPS, 
but that is our use-case. Here is a page with some detail about the 
device: 
https://www.ibm.com/docs/en/power9/9009-22A?topic=power-uninterruptible-supply


Thanks,

Eddie


>
> Johan
