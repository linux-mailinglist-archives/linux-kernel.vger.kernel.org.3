Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EC58862E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiHCELg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiHCELb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:11:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B51D0DA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:11:29 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220803041127epoutp0445031a1320257686a5e2871fd33bb11b~HulrzoNLE3086430864epoutp04y
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220803041127epoutp0445031a1320257686a5e2871fd33bb11b~HulrzoNLE3086430864epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659499887;
        bh=nk0HgHTb3YmPbS1gAOn05D8FZD3X0XhQ93Vr7Llg3x0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mfyPa+F3D0uLTFIE3/dpTjOqq4vVvtzcTBTIc8mYzuoJfO/LL5djTo4UVN7I46DlV
         aq9AyTS6sqoeaLUbnQTctCgOsqP0RwAE6ssmjlPf1WbxQ+VqWytjQhqd/aeewebRUq
         p/OoE1wdg972zniPLa8B5aI9G0KqfufBAjtQZcEk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220803041127epcas2p1f1aaebfc58c526c02d20a35f053e16f8~HulrXhzgs1348113481epcas2p1F;
        Wed,  3 Aug 2022 04:11:27 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LyJML3nTkz4x9Q1; Wed,  3 Aug
        2022 04:11:26 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-6e-62e9f56e9d65
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.AD.09642.E65F9E26; Wed,  3 Aug 2022 13:11:26 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v6 5/6] scsi: ufs: wb: Modify messages
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAGaU9a_YZDxaeOCErnQwFF9mE7bARDf4sw3F3ai1DiWwNVMFcw@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220803041126epcms2p82bafb63e4f135d09017519ed3066f914@epcms2p8>
Date:   Wed, 03 Aug 2022 13:11:26 +0900
X-CMS-MailID: 20220803041126epcms2p82bafb63e4f135d09017519ed3066f914
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmuW7e15dJBj82y1icfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBZfLu5ntnh5SNNi0Y1tTBaXd81hs+i+voPNYvnxf0wO3B6Xr3h7
        7Jx1l91j8Z6XTB4TFh1g9Pi+voPN4+PTWywefVtWMXp83iTn0X6gmymAMyrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaBT7OZCqaIVFw4
        P4O1gXEqfxcjB4eEgInExefZXYxcHEICOxglWl9OZgGJ8woISvzdIdzFyMkhLGArca//OSuI
        LSSgJHFuzSxGkBJhAQOJW73mIGE2AT2Jn0tmsIHYIgLqEkf2HmcDGckscJZZ4t+UL2C9EgK8
        EjPan7JA2NIS25dvZQSxOQUCJab8msgMEdeQ+LGsF8oWlbi5+i07jP3+2HxGCFtEovXeWaga
        QYkHP3dDxSUlDh36ygbxVr7EhgOBEOEaibfLD0CV6Etc69gIdgKvgK/EkdlzwcazCKhKzFv2
        HGqVi8T6hzfBxjMLyEtsfzuHGWQks4CmxPpd+hDTlSWO3GKBeaph4292dDazAJ9Ex+G/cPEd
        854wQbSqSSxqMprAqDwLEcqzkKyahbBqASPzKkax1ILi3PTUYqMCY3i8JufnbmIEJ1kt9x2M
        M95+0DvEyMTBeIhRgoNZSYT3jsvzJCHelMTKqtSi/Pii0pzU4kOMpkBPTmSWEk3OB6b5vJJ4
        QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTItdfDe9nBwrkznhSt1B
        BuGiJVyP82Ra9y1bb6Zzg8nV4u6vTw6WtUd/e2p/+ROaa9Lz3csgqOyXgqzDzB8RC/pZo6aG
        FT1ed+p8wePNb0/4Hjvd9e7tnPcH7j53NvA6MJuje9sh7dD151y/FJ8LddzKlPOs7P1SWVe9
        4Gs3nwhsWLWp5C9vuTTTOaZPlz1mS6v3psuejvoodb6Bb7r+mpfO3185OLVYxE05lP4pxPBc
        W0/vjfzY07UTgtdsei/ZNntHVMWVBr/z8T2GYl9OVzfeWs37ZZtdwZl3cacfzZzbHsmyKWXJ
        uV5e10Nnzi+/lf5yTn1wDY/1PpnFdqpGqyXuKVVoszx637h4woLwT1uUWIozEg21mIuKEwHn
        3okyOwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <CAGaU9a_YZDxaeOCErnQwFF9mE7bARDf4sw3F3ai1DiWwNVMFcw@mail.gmail.com>
        <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stanley,

>Hi,
>
>On Tue, Aug 2, 2022 at 4:29 PM Jinyoung CHOI <j-young.choi@samsung.com> wrote:
>>
>> Messages are modified to fit the format of others.
>>
>> Reviewed-by: Avri Altman <avri.altman@wdc.com>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
>> ---
>>  drivers/ufs/core/ufs-sysfs.c |  2 +-
>>  drivers/ufs/core/ufshcd.c    | 23 +++++++++++------------
>>  2 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
>> index 2c0b7f45de4b..117272cf7d61 100644
>> --- a/drivers/ufs/core/ufs-sysfs.c
>> +++ b/drivers/ufs/core/ufs-sysfs.c
>> @@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
>>                  * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
>>                  * on/off will be done while clock scaling up/down.
>>                  */
>> -               dev_warn(dev, "To control WB through wb_on is not allowed!\n");
>> +               dev_warn(dev, "It is not allowed to configure WB!\n");
>>                 return -EOPNOTSUPP;
>>         }
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 5099d161f115..dcd7f03db2a2 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -5737,13 +5737,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
>>
>>         ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
>>         if (ret) {
>> -               dev_err(hba->dev, "%s Write Booster %s failed %d\n",
>> -                       __func__, enable ? "enable" : "disable", ret);
>> +               dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
>> +                       __func__, enable ? "enabling" : "disabling", ret);
>>                 return ret;
>>         }
>>
>>         hba->dev_info.wb_enabled = enable;
>> -       dev_info(hba->dev, "%s Write Booster %s\n",
>> +       dev_info(hba->dev, "%s: Write Booster %s\n",
>>                         __func__, enable ? "enabled" : "disabled");
>
>You need to rebase this patch to follow the latest change as
>https://lore.kernel.org/all/20220709000027.3929970-1-bjorn.andersson@linaro.org/

I am currently working on the latest 5.20/scsi-staging.
In this case, can I refer the commit of 5.19/scsi-fixes 
and add commit to 5.20/scsi-staging?
Or can I reflect it in my change?
I have no experience, so please guide. :)

Thank you for checking.
Jinyoung.



