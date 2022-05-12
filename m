Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8213052562E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358251AbiELUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358242AbiELUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:01:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034F5E747
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:01:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHYY7b003183;
        Thu, 12 May 2022 20:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zpp9cO1dtS12S8qMB5jEpg8zqTVQAGxELZJkSrEz1xs=;
 b=HsPisxMytkM0DEN01xJ6MDAZl1Y7XIYzz4wdnwiieY2B0QYUHFY3ELckQpf/myTUKBKs
 /Z27t5dZSLIqPAE7kBqG7GQgofpnmugRS5m2MNqVzN9inXxd5v9JmLXraGcXuy0EWr4e
 or89SiIBetA644qPE+HDYSh2s65l3Y7Str5TESeiCBEP6DPR4wtO3QubXW9KUAFLjVSr
 6JvmwNrnhb12R22MecwKRFVs/AlOziZPMW0x6jEPJ5PMk++sMGIzY/XFcMry6pFVJofG
 12cKxbZUIzPihPqAqE9m8FM24bNbjVJy964N2KlKU4X7Nt1en5WNlwJ1Abp3Xk2VHRU+ Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04muj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 20:01:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CJtZ5N040728;
        Thu, 12 May 2022 20:01:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf757pqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 20:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFxbaJ0E6jKKbHxaSqnxPxc6YvTovG/qBVuRYodTzR2IgyWk3iuG8FC7iuml8pL1BxPgwNShVhtAVzY4qnladUZjn2rMOktACl9D2FEaW0+E73qr1OyHQIFFtxlUY5Y3Hh3VYFaTIaePj8UBR1SdIUNJoW1Vqeessm3slREp0usYME107+lySHXQ/tXBpk3mC300em4ic3eNICvgclLCTdX/G9lEPmerSWy0htV3cO4KdBu0QOMbnZ8q1kzl4V4E3YoWc2K9IXgYQtRitYra2OlHoD2gP7asXpXIk3v0I64WW2YW/JfrZN7A7hqbxXZjWQ3M6iwRmNpUy8d3fIILrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpp9cO1dtS12S8qMB5jEpg8zqTVQAGxELZJkSrEz1xs=;
 b=bzOCf0middB0eckK82I1GsYNfAYJ6sr8f+kKZNSzUWP5eyQcwhU9PHeWsGH5KH3w6Utaf4F3ZhfW7sTV3q1EwqDCzNSQswTdxu5zhf/WgDr9f9hPYF2KLHbeReL4iw3Ak7+m+q6r2SOWxGE1nlX9TQzWqgQXrFD/bV6Mrv5jwQSNenWRSmXJGnLdldHNxsPUI/oU2fODML3B1gV8E8ZUVEsvBe5citGGLodFGDUZqbhAkztqJG0RMdOtYR3WAO+6ecJhDOXLBo7KIaqr10brM4pFOgNUMsFolwOSiGbHEID8QSWxHJR2kcf5R+FSku4NoDZqaBdrGXn8B6Jf+M8zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpp9cO1dtS12S8qMB5jEpg8zqTVQAGxELZJkSrEz1xs=;
 b=ZHrFqf7D5fuAacvL4JLQUfnskoY7ACgSksq/0BbhqREZF3pFSYIsXDgMHpqeNirSlOvA/KtZpcPnitHbYdDArsjlW2elvbZazc3+IyiPH5P8yD2Ogc/D1fVV38R4J0B8MgAA3q1X1/QcRqO2ziMoEnSD7/hU7bpUmnMEW9m5mvM=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by PH0PR10MB5451.namprd10.prod.outlook.com (2603:10b6:510:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 20:01:14 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4%3]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 20:01:14 +0000
Message-ID: <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
Date:   Thu, 12 May 2022 16:01:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb82885a-cd38-4cef-84fd-08da34522b57
X-MS-TrafficTypeDiagnostic: PH0PR10MB5451:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB545170F1FDB013BC3417CF678ACB9@PH0PR10MB5451.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlTxitYph1bsOSLMQOnLDanYJch9KNXrcYMJT6f2ac3EiydFrChMwz4M7ydetE49k2fzvudkf1Jyz2oFpQ0rUFTjwhBe/VXszcAWV+z89BKSEJd1UPIabW+FbhulkT+BqwdrOj/vziwHd1ZR3RZSAH3u8k0frTJ1aTLzn8zNxwJD9HBhCW3yvgOmXR8LKBL/1pQF3jJ2SZW6Wv075Qkd5A2aBZP+u6L1qsu1wIEN1EDLWbfxplmfjpuUBW/yw93Fw1oSiYEHg6CYfSvcuZtl5p6ZO8LYxAjmmXMXaeVyiYdibnCrBx++L6PdumYuIJU3ngsnXqdB0ZZ1+QCJYUvT5JfRlnudyU2GnlOit3mOHxRBdMCo6ReapC/0gOoC1CwXR7dO0kYF7lTxBIiq5/WHgU40mkiR97bPdBMoFgtNkyjb2PFDoTbDdxOpMX86ZZZa5cQr6J3b+Nlax0ehrOTG7ubYFLgLwYlTuh12ZBOnOjvTxnUpsdlwjzhyseV2YYZUrZaHYLmncD0RseeV3DtXJBbs330CM92Gh+WByFvudFkCFM/B77J5m8HmMYNEjRnPi546Va3kIBh5ORd5f+OLcc6Xd/bCP4YHytVWoHdNw6qGUqcZu2Chc4t4Ix1xOQhTmciu8vdkoi9cFFwTmmlqoOy9ZZj0DATSMkvnqNWjNEd5/MLUJYgn5bXfb+b7MUW29HF8CBCfs2txkWKQj0QnRf5Lsc1flSRd6hXpJ6F0RL+n3Rlq+de+J3V4jTHskR48
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(31696002)(26005)(6512007)(316002)(186003)(6666004)(2616005)(86362001)(6506007)(2906002)(7416002)(5660300002)(36756003)(83380400001)(53546011)(6486002)(54906003)(66476007)(8676002)(66946007)(4326008)(66556008)(38100700002)(31686004)(8936002)(30864003)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENMcUhOM3FGejJNSXlxWW41WXBDQ3kyZ2hFNFIxZmd4WW4xL3lsWjhGeHBE?=
 =?utf-8?B?UGFQQmF6RlBXMk9GZFhaZGdyZXhCb1pRalFENlVSV0ZQdUNHYWcrbnFTb1RY?=
 =?utf-8?B?ZkhWR0hKc3BralRCWExNU0FJL1Z6dUoyM3pqamtiRG1ldHVBbDlYS211dkJD?=
 =?utf-8?B?aHVrMFJHY1RKMFVqWExpckttRk1jYmR4RU1SYW5mVll3RHlJK2xkanNNVTRU?=
 =?utf-8?B?K1BDaEsxTU9mOS96eVdRRnJiTi81dnlLMldKSm9ocjZUbGdMQU5UUXZrRHdW?=
 =?utf-8?B?Tlo4MGUxeE5icElpbW9MM0FPa0dPTElsVWRRbHhOd0Z3dlZOSm5JN0VsSzhH?=
 =?utf-8?B?bmRlbjBDS3ptdklTNU4zSXRDZ2x2K1ZuTkU2OGRrNkZudHJ1LzBMcVQrNmRj?=
 =?utf-8?B?NlZsQzJXR2xOUEo5c25KL01lTVRPWTRKQWpIdDlZbk5XTWc0VFlPcG5HMWpH?=
 =?utf-8?B?djFGaHo0cnljTXZpUDFGTzRYOWtzbHN4S1UwZUw1V1hydktOb0JtM09GSkNX?=
 =?utf-8?B?OWtxbzBjVXJtdFF0cUp4dDRZTG5ZeWJyMXp5OE1tRXVzSmx1ZjQyYU9YdlBL?=
 =?utf-8?B?UHZCVnhXRkJ0cmZveTBXQys1ZjZaU1FSRE9zZXBoQTlLeHpwYXRLamdYRm9y?=
 =?utf-8?B?QUJOWFZWaTFCNTIwV3hVNm11V2p4RjhqS0lOSC9HRE92cGJQb1lFcEFuWGxs?=
 =?utf-8?B?UXVHaWdzMjNYL0I4VnJIbnFnVFhySnh3UWN6S1R0L2xWV0ZoN0hvVWJNeTFK?=
 =?utf-8?B?TzJ2VzFycWxXVnQ2ZXFockFOSmhuVTkzTkNGMEhZY09BN3hTazRwOGpBbjZa?=
 =?utf-8?B?QktjdFhoQmF0V2VhUjh0Vk1ycW9VRU85RG5hNFIwVU9hVWR4ZFBQOHZWL0w0?=
 =?utf-8?B?SWswWEdRdHd4c0lOOW9yNXlnbUwyMEd0TVhoN2xWRHRjNmhDWUtpSTl6RnF3?=
 =?utf-8?B?ODViT1EyM2tKNVovcFBPL0VRTTJYN2pSWSs2YUpTQkdvYzVHdkhQSEppcnVQ?=
 =?utf-8?B?QVE0NWlwTmtIRFlrNmlRTE16YWhNeUl4UFpJNGRlaDFrOVZOUWRpYithMXdm?=
 =?utf-8?B?ZUtvdjNGVGprK0ROYWZqS3FERndCSTdjSWRPL1gvQ1J0OVdjMTFwVUZ5RkIy?=
 =?utf-8?B?OUp3WHNYZHZWcFgxQWlSdUlPZmxQVTZqdDRlYldFOUpaQ1dOVHJVejZkWHp5?=
 =?utf-8?B?YXZaaFEwNTE1UXJ5VEg2S08vZnJ5UTZRTXFVTmIrUW80S3g4anlYc0VrcFE5?=
 =?utf-8?B?eHNxZnBOdG93OHFxUHVSOFNWZWlQTVdMbXkyb211Qmt6MDhTcVlYSGgrNXVu?=
 =?utf-8?B?VC9tb3Rvd1lXTE84M1pWcFA3bWNpUUxadmJiZkJmOHJ1TCtleWVHVzdHeTgw?=
 =?utf-8?B?MlJBam9WWkRuRjA4Ykh2M3pMVUZEUGtRSTMwUG5TcGpaSzlnU1ZvT1diYkVu?=
 =?utf-8?B?N0JyVkZkM1RITjBORUhEclArZUw4Y2txR1lwL1NYVDNhWGFVVzFETldIRFU5?=
 =?utf-8?B?UDhYeFJBZHFseGorbDdmVXFNeDNTZTJLbVprU1pKbDN4TTQ3WnVRQkk0a0xW?=
 =?utf-8?B?SnFKWVIvR2dIQzE0Tk5ENWtiNEhpZ3RmSUc2clR6andzb2JRcGJaZXVSK1JZ?=
 =?utf-8?B?MHI0bTUxazMyWFVlMGVNeWxCbFlUbERMcU5MdDhvNkNQaG1yc01Wd1Y2R3VV?=
 =?utf-8?B?MzJRTjJ0amYwWDl1aTJHTDJhUFpZZnhCY0N2eXlnYVJOcDlMTTYrZ3NweUtQ?=
 =?utf-8?B?VDJEQXRJcnFLZ245YU01c0NlbTJvQng5V0dZb05aQy9ZVmJrVE93d2RrK3BU?=
 =?utf-8?B?dHZCQ3MwWjVqSDFiWTJnVG93cWlheEFCejdXQVFjL3U0aC94d1loQlc5b3Fh?=
 =?utf-8?B?TDJML2R5MlJBQ2ZBOHBqMjdlK3RnRUg5dmQ1VHZPUGlYTmx6Qkl0VjQzYitj?=
 =?utf-8?B?eUFkQnJCczJFYXhDdHYrejJ2WXp5R3Bjbm5MdTlNaFpiY2l2U2hHWDZibys1?=
 =?utf-8?B?elNsOGx6RUV4Q0J1VkI3VnR5WCtwV1VTT09JZGljejAzUVVtMkNFMEJnRUZs?=
 =?utf-8?B?cTVZWGNsS0M2VFZnelEyaUMvQ0VtZWpEVFRlNmpNdk1odStWRUtnMUpMeEVL?=
 =?utf-8?B?cG5jUlB5QWlyOEtLdkFpcGZkNkJSMkowei9Bb1kvL0hLK3RGS2dOME9KN3dD?=
 =?utf-8?B?MkZHQms3OXZLVjVrd1BhWWJJZmxmV0M5V2tqMFlRYkc3QlgzMDNyRmluTWQw?=
 =?utf-8?B?TTZSZFZMajNyclVhWHd4V2NnWnZWcENURXdHOU5OMzJaWlFVc1E1Wm5EVmxD?=
 =?utf-8?B?cDYvZEVhcWZUeTdTcEtJY0JYQm5qMzYvVHBSaVpTLzZHQlVSckZaSEhoa1Q2?=
 =?utf-8?Q?vBfj3Z1lggJOLvmQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb82885a-cd38-4cef-84fd-08da34522b57
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 20:01:14.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCLVrw14NbLOzsL1Wp3gj34D9NVuuR4/obmYd28XJc2EFcwkGAtdEHzoMrmjy3b8OKiQ6C7ORRDWT8o2f3vk4D/wMcbItB+lj0a0t7xh/G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5451
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_12:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120085
X-Proofpoint-GUID: 8gftKrLTqWw2I3u1IC0AfH9DinRfUv0p
X-Proofpoint-ORIG-GUID: 8gftKrLTqWw2I3u1IC0AfH9DinRfUv0p
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/22 2:19 PM, Oleksandr Tyshchenko wrote:
> +
> +/*
> + * Handling of free grants:
> + *
> + * Free grants are in a simple list anchored in gnttab_free_head. They are
> + * linked by grant ref, the last element contains GNTTAB_LIST_END. The number
> + * of free entries is stored in gnttab_free_count.
> + * Additionally there is a bitmap of free entries anchored in
> + * gnttab_free_bitmap. This is being used for simplifying allocation of
> + * multiple consecutive grants, which is needed e.g. for support of virtio.
> + * gnttab_last_free is used to add free entries of new frames at the end of
> + * the free list.
> + * gnttab_free_tail_ptr specifies the variable which references the start


If this references the start of the free interval, why is it called gnttab_free_*tail*_ptr?


> + * of consecutive free grants ending with gnttab_last_free. This pointer is
> + * updated in a rather defensive way, in order to avoid performance hits in
> + * hot paths.
> + * All those variables are protected by gnttab_list_lock.
> + */
>   static int gnttab_free_count;
> -static grant_ref_t gnttab_free_head;
> +static unsigned int gnttab_size;
> +static grant_ref_t gnttab_free_head = GNTTAB_LIST_END;
> +static grant_ref_t gnttab_last_free = GNTTAB_LIST_END;
> +static grant_ref_t *gnttab_free_tail_ptr;
> +static unsigned long *gnttab_free_bitmap;
>   static DEFINE_SPINLOCK(gnttab_list_lock);
> +
>   struct grant_frames xen_auto_xlat_grant_frames;
>   static unsigned int xen_gnttab_version;
>   module_param_named(version, xen_gnttab_version, uint, 0);
> @@ -170,16 +194,111 @@ static int get_free_entries(unsigned count)
>   
>   	ref = head = gnttab_free_head;
>   	gnttab_free_count -= count;
> -	while (count-- > 1)
> -		head = gnttab_entry(head);
> +	while (count--) {
> +		bitmap_clear(gnttab_free_bitmap, head, 1);
> +		if (gnttab_free_tail_ptr == __gnttab_entry(head))
> +			gnttab_free_tail_ptr = &gnttab_free_head;
> +		if (count)
> +			head = gnttab_entry(head);
> +	}
>   	gnttab_free_head = gnttab_entry(head);
>   	gnttab_entry(head) = GNTTAB_LIST_END;
>   
> +	if (!gnttab_free_count) {
> +		gnttab_last_free = GNTTAB_LIST_END;
> +		gnttab_free_tail_ptr = NULL;
> +	}
> +
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   
>   	return ref;
>   }
>   
> +static int get_seq_entry_count(void)
> +{
> +	if (gnttab_last_free == GNTTAB_LIST_END || !gnttab_free_tail_ptr ||
> +	    *gnttab_free_tail_ptr == GNTTAB_LIST_END)
> +		return 0;
> +
> +	return gnttab_last_free - *gnttab_free_tail_ptr + 1;
> +}
> +
> +/* Rebuilds the free grant list and tries to find count consecutive entries. */
> +static int get_free_seq(unsigned int count)
> +{
> +	int ret = -ENOSPC;
> +	unsigned int from, to;
> +	grant_ref_t *last;
> +
> +	gnttab_free_tail_ptr = &gnttab_free_head;
> +	last = &gnttab_free_head;
> +
> +	for (from = find_first_bit(gnttab_free_bitmap, gnttab_size);
> +	     from < gnttab_size;
> +	     from = find_next_bit(gnttab_free_bitmap, gnttab_size, to + 1)) {
> +		to = find_next_zero_bit(gnttab_free_bitmap, gnttab_size,
> +					from + 1);
> +		if (ret < 0 && to - from >= count) {
> +			ret = from;
> +			bitmap_clear(gnttab_free_bitmap, ret, count);
> +			from += count;
> +			gnttab_free_count -= count;


IIUIC we can have multiple passes over this, meaning that the gnttab_free_count may be decremented more than once. Is that intentional?


> +			if (from == to)
> +				continue;
> +		}
> +
> +		while (from < to) {
> +			*last = from;
> +			last = __gnttab_entry(from);
> +			gnttab_last_free = from;
> +			from++;
> +		}


I have been looking at this loop and I can't understand what it is doing ;-( Can you enlighten me?



-boris



> +		if (to < gnttab_size)
> +			gnttab_free_tail_ptr = __gnttab_entry(to - 1);
> +	}
> +
> +	*last = GNTTAB_LIST_END;
> +	if (gnttab_last_free != gnttab_size - 1)
> +		gnttab_free_tail_ptr = NULL;
> +
> +	return ret;
> +}
> +
> +static int get_free_entries_seq(unsigned int count)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +
> +	if (gnttab_free_count < count) {
> +		ret = gnttab_expand(count - gnttab_free_count);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	if (get_seq_entry_count() < count) {
> +		ret = get_free_seq(count);
> +		if (ret >= 0)
> +			goto out;
> +		ret = gnttab_expand(count - get_seq_entry_count());
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	ret = *gnttab_free_tail_ptr;
> +	*gnttab_free_tail_ptr = gnttab_entry(ret + count - 1);
> +	gnttab_free_count -= count;
> +	if (!gnttab_free_count)
> +		gnttab_free_tail_ptr = NULL;
> +	bitmap_clear(gnttab_free_bitmap, ret, count);
> +
> + out:
> +	spin_unlock_irqrestore(&gnttab_list_lock, flags);
> +
> +	return ret;
> +}
> +
>   static void do_free_callbacks(void)
>   {
>   	struct gnttab_free_callback *callback, *next;
> @@ -206,17 +325,48 @@ static inline void check_free_callbacks(void)
>   		do_free_callbacks();
>   }
>   
> -static void put_free_entry(grant_ref_t ref)
> +static void put_free_entry_locked(grant_ref_t ref)
>   {
> -	unsigned long flags;
> -	spin_lock_irqsave(&gnttab_list_lock, flags);
>   	gnttab_entry(ref) = gnttab_free_head;
>   	gnttab_free_head = ref;
> +	if (!gnttab_free_count)
> +		gnttab_last_free = ref;
> +	if (gnttab_free_tail_ptr == &gnttab_free_head)
> +		gnttab_free_tail_ptr = __gnttab_entry(ref);
>   	gnttab_free_count++;
> +	bitmap_set(gnttab_free_bitmap, ref, 1);
> +}
> +
> +static void put_free_entry(grant_ref_t ref)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +	put_free_entry_locked(ref);
>   	check_free_callbacks();
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   }
>   
> +static void gnttab_set_free(unsigned int start, unsigned int n)
> +{
> +	unsigned int i;
> +
> +	for (i = start; i < start + n - 1; i++)
> +		gnttab_entry(i) = i + 1;
> +
> +	gnttab_entry(i) = GNTTAB_LIST_END;
> +	if (!gnttab_free_count) {
> +		gnttab_free_head = start;
> +		gnttab_free_tail_ptr = &gnttab_free_head;
> +	} else {
> +		gnttab_entry(gnttab_last_free) = start;
> +	}
> +	gnttab_free_count += n;
> +	gnttab_last_free = i;
> +
> +	bitmap_set(gnttab_free_bitmap, start, n);
> +}
> +
>   /*
>    * Following applies to gnttab_update_entry_v1 and gnttab_update_entry_v2.
>    * Introducing a valid entry into the grant table:
> @@ -448,23 +598,31 @@ void gnttab_free_grant_references(grant_ref_t head)
>   {
>   	grant_ref_t ref;
>   	unsigned long flags;
> -	int count = 1;
> -	if (head == GNTTAB_LIST_END)
> -		return;
> +
>   	spin_lock_irqsave(&gnttab_list_lock, flags);
> -	ref = head;
> -	while (gnttab_entry(ref) != GNTTAB_LIST_END) {
> -		ref = gnttab_entry(ref);
> -		count++;
> +	while (head != GNTTAB_LIST_END) {
> +		ref = gnttab_entry(head);
> +		put_free_entry_locked(head);
> +		head = ref;
>   	}
> -	gnttab_entry(ref) = gnttab_free_head;
> -	gnttab_free_head = head;
> -	gnttab_free_count += count;
>   	check_free_callbacks();
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(gnttab_free_grant_references);
>   
> +void gnttab_free_grant_reference_seq(grant_ref_t head, unsigned int count)
> +{
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +	for (i = count; i > 0; i--)
> +		put_free_entry_locked(head + i - 1);
> +	check_free_callbacks();
> +	spin_unlock_irqrestore(&gnttab_list_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(gnttab_free_grant_reference_seq);
> +
>   int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
>   {
>   	int h = get_free_entries(count);
> @@ -478,6 +636,24 @@ int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
>   }
>   EXPORT_SYMBOL_GPL(gnttab_alloc_grant_references);
>   
> +int gnttab_alloc_grant_reference_seq(unsigned int count, grant_ref_t *first)
> +{
> +	int h;
> +
> +	if (count == 1)
> +		h = get_free_entries(1);
> +	else
> +		h = get_free_entries_seq(count);
> +
> +	if (h < 0)
> +		return -ENOSPC;
> +
> +	*first = h;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gnttab_alloc_grant_reference_seq);
> +
>   int gnttab_empty_grant_references(const grant_ref_t *private_head)
>   {
>   	return (*private_head == GNTTAB_LIST_END);
> @@ -570,16 +746,13 @@ static int grow_gnttab_list(unsigned int more_frames)
>   			goto grow_nomem;
>   	}
>   
> +	gnttab_set_free(gnttab_size, extra_entries);
>   
> -	for (i = grefs_per_frame * nr_grant_frames;
> -	     i < grefs_per_frame * new_nr_grant_frames - 1; i++)
> -		gnttab_entry(i) = i + 1;
> -
> -	gnttab_entry(i) = gnttab_free_head;
> -	gnttab_free_head = grefs_per_frame * nr_grant_frames;
> -	gnttab_free_count += extra_entries;
> +	if (!gnttab_free_tail_ptr)
> +		gnttab_free_tail_ptr = __gnttab_entry(gnttab_size);
>   
>   	nr_grant_frames = new_nr_grant_frames;
> +	gnttab_size += extra_entries;
>   
>   	check_free_callbacks();
>   
> @@ -1424,7 +1597,6 @@ int gnttab_init(void)
>   	int i;
>   	unsigned long max_nr_grant_frames;
>   	unsigned int max_nr_glist_frames, nr_glist_frames;
> -	unsigned int nr_init_grefs;
>   	int ret;
>   
>   	gnttab_request_version();
> @@ -1452,6 +1624,13 @@ int gnttab_init(void)
>   		}
>   	}
>   
> +	i = gnttab_interface->grefs_per_grant_frame * max_nr_grant_frames;
> +	gnttab_free_bitmap = bitmap_zalloc(i, GFP_KERNEL);
> +	if (!gnttab_free_bitmap) {
> +		ret = -ENOMEM;
> +		goto ini_nomem;
> +	}
> +
>   	ret = arch_gnttab_init(max_nr_grant_frames,
>   			       nr_status_frames(max_nr_grant_frames));
>   	if (ret < 0)
> @@ -1462,15 +1641,9 @@ int gnttab_init(void)
>   		goto ini_nomem;
>   	}
>   
> -	nr_init_grefs = nr_grant_frames *
> -			gnttab_interface->grefs_per_grant_frame;
> -
> -	for (i = NR_RESERVED_ENTRIES; i < nr_init_grefs - 1; i++)
> -		gnttab_entry(i) = i + 1;
> +	gnttab_size = nr_grant_frames * gnttab_interface->grefs_per_grant_frame;
>   
> -	gnttab_entry(nr_init_grefs - 1) = GNTTAB_LIST_END;
> -	gnttab_free_count = nr_init_grefs - NR_RESERVED_ENTRIES;
> -	gnttab_free_head  = NR_RESERVED_ENTRIES;
> +	gnttab_set_free(NR_RESERVED_ENTRIES, gnttab_size - NR_RESERVED_ENTRIES);
>   
>   	printk("Grant table initialized\n");
>   	return 0;
> @@ -1479,6 +1652,7 @@ int gnttab_init(void)
>   	for (i--; i >= 0; i--)
>   		free_page((unsigned long)gnttab_list[i]);
>   	kfree(gnttab_list);
> +	bitmap_free(gnttab_free_bitmap);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(gnttab_init);
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index dfd5bf3..d815e1d 100644
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -129,10 +129,14 @@ int gnttab_try_end_foreign_access(grant_ref_t ref);
>    */
>   int gnttab_alloc_grant_references(u16 count, grant_ref_t *pprivate_head);
>   
> +int gnttab_alloc_grant_reference_seq(unsigned int count, grant_ref_t *first);
> +
>   void gnttab_free_grant_reference(grant_ref_t ref);
>   
>   void gnttab_free_grant_references(grant_ref_t head);
>   
> +void gnttab_free_grant_reference_seq(grant_ref_t head, unsigned int count);
> +
>   int gnttab_empty_grant_references(const grant_ref_t *pprivate_head);
>   
>   int gnttab_claim_grant_reference(grant_ref_t *pprivate_head);
