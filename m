Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727B4D5F71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiCKK0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbiCKK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:26:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DA967460E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:25:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B9B16A3;
        Fri, 11 Mar 2022 02:25:47 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89043F7D8;
        Fri, 11 Mar 2022 02:25:46 -0800 (PST)
Message-ID: <a14da77e-56b5-312f-c415-f716f4467a1a@arm.com>
Date:   Fri, 11 Mar 2022 10:25:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] coresight changes for v5.18
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220303230301.255049-1-suzuki.poulose@arm.com>
 <YipxKx+P7Dyc70vS@kroah.com>
 <CANLsYkxJd-wdnkvL1=WQOEQR2E5TJDK_5XR1QWkkOt8giRfkAw@mail.gmail.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CANLsYkxJd-wdnkvL1=WQOEQR2E5TJDK_5XR1QWkkOt8giRfkAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 00:09, Mathieu Poirier wrote:
> On Thu, 10 Mar 2022 at 14:44, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Mar 03, 2022 at 11:03:01PM +0000, Suzuki K Poulose wrote:
>>> Hi Greg
>>>
>>> Please find the pull request for coresight subsystem for v5.18.
>>>
>>> Suzuki
>>>
>>> The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:
>>>
>>>    Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.18
>>>
>>> for you to fetch changes up to b54f53bc11a584713f79a704c70c488489f524b8:
>>>
>>>    coresight: Drop unused 'none' enum value for each component (2022-02-28 09:51:40 -0700)
>>
>> I have the following errors when pulling this tree and having the
>> scripts check the commits:
>>
>> Commit 5340bf5df9d2 ("coresight: syscfg: Fix memleak on registration failure in cscfg_create_device")
>>          committer Signed-off-by missing
>>          author email:    linmq006@gmail.com
>>          committer email: suzuki.poulose@arm.com
>>          Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>          Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Commit 91a2f2941df2 ("coresight: Fix TRCCONFIGR.QE sysfs interface")
>>          committer Signed-off-by missing
>>          author email:    james.clark@arm.com
>>          committer email: suzuki.poulose@arm.com
>>          Signed-off-by: James Clark <james.clark@arm.com>
>>          Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Commit 7f4cd3375906 ("coresight: trbe: Work around the trace data corruption")
>>          committer Signed-off-by missing
>>          author email:    anshuman.khandual@arm.com
>>          committer email: suzuki.poulose@arm.com
>>          Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>          Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Commit 0ecf2c747437 ("coresight: trbe: Work around the invalid prohibited states")
>>          committer Signed-off-by missing
>>          author email:    anshuman.khandual@arm.com
>>          committer email: suzuki.poulose@arm.com
>>          Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>          Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>> Commit 8b6927d0adad ("coresight: trbe: Work around the ignored system register writes")
>>          committer Signed-off-by missing
>>          author email:    anshuman.khandual@arm.com
>>          committer email: suzuki.poulose@arm.com
>>          Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>          Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>>
>> What went wrong???
>>
> 
> (Sigh)
> 
> I know what happened.  The tree was rebased from -rc1 to -rc3 to pick
> up a dependency with the aarch64 tree that was needed for a patch.  In
> doing so the original committer information was overwritten, which is
> what the script is complaining about.
> 
> We will send you another pull request.

Apologies. I have fixed them now and will send you the updated request.

Thanks for your patience.

Suzuki
