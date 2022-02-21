Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF74BD835
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiBUIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:37:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiBUIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:37:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163039D;
        Mon, 21 Feb 2022 00:36:56 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2FsT0hvLz67yS9;
        Mon, 21 Feb 2022 16:32:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 09:36:54 +0100
Received: from [10.47.94.94] (10.47.94.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Feb
 2022 08:36:53 +0000
Message-ID: <e980945f-b319-a77c-1583-6bdb78297d7c@huawei.com>
Date:   Mon, 21 Feb 2022 08:36:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     <jejb@linux.ibm.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@cloud.ionos.com>, <chenxiang66@hisilicon.com>,
        <hch@lst.de>, <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
 <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com>
 <yq15ypail31.fsf@ca-mkp.ca.oracle.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <yq15ypail31.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.94]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2022 21:53, Martin K. Petersen wrote:
> Damien,
> 
>> This series and my pm8001 series have a conflict. When applying the
>> pm8001 patches on top of these libsas changes, patch 28 has a fairly
>> easy to resolve conflict. Let me know if you want me to send a v6
>> rebased on top of this.
> "fairly easy to resolve", huh? Sure, if you manually rework the entire
> patch.
> 
> Please send me an updated version of #28. The rest of the series is
> fine...

Thanks Martin and Damien. I'll mention potential conflicts in my cover 
letters in future to help co-ordinate things better.

John
