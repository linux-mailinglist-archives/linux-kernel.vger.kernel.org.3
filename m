Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708B512A99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiD1Ege (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiD1Egb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:36:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED754BE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:33:16 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S4LJA2033958;
        Thu, 28 Apr 2022 04:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iCKW0yrERGuzdNcsk+TTKd9Fbk2qUe5WNgFQ65bW3Sk=;
 b=bS1kQjVtj1pwKMFiHDiOap5ToSuj4mRI74SEbjpMrubR9BF+wh67qbYKhVy7OtR+17EV
 pH5r2YAgMb1yNMJu+13H9ZVWabqKoNJvnYw1AeNrApZwtCCsi9657YqKGi/enzeiauLI
 CwZDNIdlfUR+9oF9avPCceGnTKpU5rEWvLmiRyXrnzQP252FSlyVOJHZTACqohshvNhj
 fdd/Apx0keb4NaoghV1LRRIsnvpIvkl456MuJjnNNsj2i4Oc9w5EY7UvnhjYnETwXjhg
 gCVBO9gvwGd/mSKd8WCz4UXzlcgsLvP9dT1Om335Ydf9ZZBMga3hv7J2vzBUvEzmSWro CA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqktv84h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 04:32:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S4WbxO007519;
        Thu, 28 Apr 2022 04:32:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938xv03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 04:32:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23S4JiQF48234776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 04:19:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6AADAE045;
        Thu, 28 Apr 2022 04:32:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CECAE04D;
        Thu, 28 Apr 2022 04:32:48 +0000 (GMT)
Received: from [9.43.113.95] (unknown [9.43.113.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 04:32:48 +0000 (GMT)
Message-ID: <d2684252-8c85-ba0e-2356-29837e836f6f@linux.ibm.com>
Date:   Thu, 28 Apr 2022 10:02:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: ndctl tests usable?
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
References: <20220426123839.GF163591@kunlun.suse.cz>
 <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
 <20220426161435.GH163591@kunlun.suse.cz>
 <CAPcyv4iG4L3rA3eX-H=6nVkwhO2FGqDCbQHB2Lv_gLb+jy3+bw@mail.gmail.com>
 <20220426163834.GI163591@kunlun.suse.cz>
 <CAPcyv4jUj3v+4Sf=1i5EjxTeX9Ur65Smib-vkuaBdKYjUrh7yA@mail.gmail.com>
 <20220426180958.GJ163591@kunlun.suse.cz>
From:   Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20220426180958.GJ163591@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wDpgUURbyXBAy9ZfDpjFB9XN5cBgsnuj
X-Proofpoint-ORIG-GUID: wDpgUURbyXBAy9ZfDpjFB9XN5cBgsnuj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280027
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 23:39, Michal Suchánek wrote:
> On Tue, Apr 26, 2022 at 09:47:19AM -0700, Dan Williams wrote:
>> On Tue, Apr 26, 2022 at 9:43 AM Michal Suchánek <msuchanek@suse.de> wrote:
>>>
>>> On Tue, Apr 26, 2022 at 09:32:24AM -0700, Dan Williams wrote:
>>>> On Tue, Apr 26, 2022 at 9:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
>>>>>
>>>>> On Tue, Apr 26, 2022 at 08:51:25AM -0700, Dan Williams wrote:
>>>>>> On Tue, Apr 26, 2022 at 5:39 AM Michal Suchánek <msuchanek@suse.de> wrote:
>>>>>>>
> ...
>>>>
>>>> The modinfo just tells you what modules are available, but it does not
>>>> necessarily indicate which modules are actively loaded in the system
>>>> which is what ndctl_test_init() validates.
>>>
>>> Isn't what modinfo lists also what modrobe loads?

<snip>

> modules are not loaded before the test.
> 
> Maybe something goes wrong with the test module build?
> 
> It is very fragile and requires complete kernel source for each
> configuration built. See below for the package
> 
> https://build.opensuse.org/package/show/home:michals/nfit_test
> 
> Attaching the log of test run which does not report any missing tools,
> only complains about nfit.ko being production.

I have attempted to fix few of the known issues in the first 3 patches 
of the series posted here.

https://patchwork.kernel.org/project/linux-nvdimm/list/?series=633103

> 
> Thanks
> 
> Michal
