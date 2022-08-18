Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345A25985A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbiHROXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiHROXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:23:36 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 07:23:33 PDT
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84882743
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:23:33 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id OdF4ogsxHlI84OgPJof8qY; Thu, 18 Aug 2022 14:22:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id OgPIoTBOaztraOgPIowWR7; Thu, 18 Aug 2022 14:22:00 +0000
X-Authority-Analysis: v=2.4 cv=VtQwvs6n c=1 sm=1 tr=0 ts=62fe4b08
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=2G8HZ+iZC6G5oy+4y1ze6Q==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=biHskzXt2R4A:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=9jRdOu3wAAAA:8
 a=gFAr9JSBGsk_Eo6_FYIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=ZE6KLimJVUuLrTuGpvhn:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WU67mqJk3z4w/JzxZeaJLl6AEho02qL/TCyDwqgR4lM=; b=QOBphVXqLK1hoKQPmKaLZKBUIq
        zN3VrV0Dz2kdq5wQE9tWScQjb4Ndg/mQt9HAnfjLRtQ8wdNL0qA037BR0Pwylbomvp86BR5astxgt
        AcPuKBDw1evW60DI1hgsylBBxdUS6w3So+egPnUpDZTOptyy2o+byZgthApxD6jvvPZEWfcC5PpN1
        Yi0x56G+Vm+doFbTakCM1DF5sZLU6lnSczFA3+FSd2DBz8qS3Eh1eSnYShyQ+zzAAwRq9mRWaCWWy
        yw4ooE7iWBEsjy+hLcitF3uJ34IaCWGbcNFRlGvFn3MopRwXqtCkAIVT00pg1sEEObbUAmYl7kZjJ
        4dO9zr6w==;
Received: from 187.184.159.174.cable.dyn.cableonline.com.mx ([187.184.159.174]:56051 helo=[192.168.0.15])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oOgPG-00435v-Uw;
        Thu, 18 Aug 2022 09:21:59 -0500
Message-ID: <e2e9fcfc-0bfa-c25e-3084-200ae448697a@embeddedor.com>
Date:   Thu, 18 Aug 2022 09:21:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] flexible-array transformations in UAPI for 6.0-rc1
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Yug4IJHugXBzPWFH@work> <Yv4wUJfrkZ0tmCin@nvidia.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Yv4wUJfrkZ0tmCin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.174
X-Source-L: No
X-Exim-ID: 1oOgPG-00435v-Uw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.159.174.cable.dyn.cableonline.com.mx ([192.168.0.15]) [187.184.159.174]:56051
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLnEQNbdn5oa3WTiBI0mkMAGPp68VZsstTINqaRnskrVnj8meM+4Ky1yJTI4GwQDRCA8xRGlEWXdrAyiSWRhLF4/lObeOTfzrTNtWHXWLWXmn8osgWfi
 luf0t3JJdJfp3xsZDGsT6kfCrnWf1ikNxikY2oHyRH8IFJ5tlrcgsDjEsiBHD68bP6xMhLgXv2ULUVIWOYHT2olB0EPHdHZyoCZtaZvsxMqxGAXVioF6xqvT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 8/18/22 07:28, Jason Gunthorpe wrote:
> On Mon, Aug 01, 2022 at 03:31:28PM -0500, Gustavo A. R. Silva wrote:
>> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
>>
>>    Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1
>>
>> for you to fetch changes up to 94dfc73e7cf4a31da66b8843f0b9283ddd6b8381:
>>
>>    treewide: uapi: Replace zero-length arrays with flexible-array members (2022-06-28 21:26:05 +0200)
>>
>> ----------------------------------------------------------------
>> flexible-array transformations in UAPI for 6.0-rc1
>>
>> Hi Linus,
>>
>> Please, pull the following treewide patch that replaces zero-length arrays
>> with flexible-array members in UAPI. This patch has been baking in
>> linux-next for 5 weeks now.
>>
>> -fstrict-flex-arrays=3 is coming and we need to land these changes
>> to prevent issues like these in the short future:
>>
>> ../fs/minix/dir.c:337:3: warning: 'strcpy' will always overflow; destination buffer has size 0,
>> but the source string has length 2 (including NUL byte) [-Wfortify-source]
>> 		strcpy(de3->name, ".");
>> 		^
>>
>> Since these are all [0] to [] changes, the risk to UAPI is nearly zero. If
>> this breaks anything, we can use a union with a new member name.
> 
> This has trobuled the RDMA userspace by creating new compiler warnings..
>
> We discussed this and I thought you agreed not to send these changes?

Yep; and as I said in that thread, I went and removed all the changes that
were causing trouble, based on this report by 0-day:

https://lore.kernel.org/lkml/202206241055.Eh9MKMAE-lkp@intel.com/

For instance, 0-day reported this warning:

 >> usr/include/rdma/ib_user_verbs.h:1091:2: warning: field '' with variable sized type 'union ib_uverbs_flow_spec_gre::(anonymous at 
usr/include/rdma/ib_user_verbs.h:1091:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
            union {
            ^

then I went to look for the union ib_uverbs_flow_spec_gre and reverted the
change that was causing trouble in struct ib_uverbs_flow_spec_hdr:

gus@work:~/gustavoars-linux$ git grep -nwW 'ib_uverbs_flow_spec_gre\s{'

include/uapi/rdma/ib_user_verbs.h:1090:struct ib_uverbs_flow_spec_gre {

include/uapi/rdma/ib_user_verbs.h-1091- union {

include/uapi/rdma/ib_user_verbs.h-1092-         struct ib_uverbs_flow_spec_hdr hdr;

include/uapi/rdma/ib_user_verbs.h-1093-         struct {

include/uapi/rdma/ib_user_verbs.h-1094-                 __u32 type;

include/uapi/rdma/ib_user_verbs.h-1095-                 __u16 size;

include/uapi/rdma/ib_user_verbs.h-1096-                 __u16 reserved;

include/uapi/rdma/ib_user_verbs.h-1097-         };

include/uapi/rdma/ib_user_verbs.h-1098- };

include/uapi/rdma/ib_user_verbs.h-1099- struct ib_uverbs_flow_gre_filter     val;

include/uapi/rdma/ib_user_verbs.h-1100- struct ib_uverbs_flow_gre_filter     mask;

include/uapi/rdma/ib_user_verbs.h-1101-};

gus@work:~/gustavoars-linux$ git grep -nwW 'struct\sib_uverbs_flow_spec_hdr\s{'

include/uapi/rdma/ib_user_verbs.h:900:struct ib_uverbs_flow_spec_hdr {

include/uapi/rdma/ib_user_verbs.h-901-  __u32 type;

include/uapi/rdma/ib_user_verbs.h-902-  __u16 size;

include/uapi/rdma/ib_user_verbs.h-903-  __u16 reserved;

include/uapi/rdma/ib_user_verbs.h-904-  /* followed by flow_spec */

include/uapi/rdma/ib_user_verbs.h-905-  __aligned_u64 flow_spec_data[0];

include/uapi/rdma/ib_user_verbs.h-906-};

and the issue that you reported in:

https://lore.kernel.org/linux-rdma/20220628004052.GM23621@ziepe.ca/

was fixed at the time:

$ git grep -nwW 'struct\sib_uverbs_create_cq_resp\s{'

include/uapi/rdma/ib_user_verbs.h:429:struct ib_uverbs_create_cq_resp {

include/uapi/rdma/ib_user_verbs.h-430-  __u32 cq_handle;

include/uapi/rdma/ib_user_verbs.h-431-  __u32 cqe;

include/uapi/rdma/ib_user_verbs.h-432-  __aligned_u64 driver_data[0];

include/uapi/rdma/ib_user_verbs.h-433-};

However, it would be helpful to know all the details about the warnings
that you are seeing now, so I can take a look. :)

Thanks
--
Gustavo

> 
> https://lore.kernel.org/linux-rdma/20220628135623.GA25163@embeddedor/
> 
> Jason
