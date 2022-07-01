Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E756336F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiGAMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGAMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:20:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559331580F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:20:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619HEkM010364;
        Fri, 1 Jul 2022 12:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=t6FV3qFnAfwOIg9iKB8hg+m1E9FTfSemCwk7QsPfiO8=;
 b=Ch0izheeZLiJbHpcI6Vq6JzpHFcgtOFMuA6hqmlFznFjBqO/fJC86p92o0OyDZb+7i9t
 2LhAbPn+6xR1XYXI3+VCP/2e2SQYqBKq3EtEwjVDoLEO/D1QNEZp+7TuSKU4jZWaLPcx
 KzWx3GsRAs/cPXiYN1R6EMAuwpV/l4S2krIwOFMiyk8Fc56XXq4PDDpTmGI9qT742T87
 KLTDmWM/w7IdqsxVzn2jXvWTEwYNXFH4ehkiNHxuv1JtXK3Dv6gfXRfpAA7rsua13hqv
 LncLTZl3iixWZXFIlQGHCE8e1XGrS7WaM49tRtG86ddOK+xhJGdfpgJLNnemskZevrxx Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt8a6kpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 12:20:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261CHDrC026560;
        Fri, 1 Jul 2022 12:20:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtanmmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 12:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH0ZRsYbJPOVXqG+/CeesIZo8dU80lMrVFDAbKZM/ZRsxNNSRlBCui8WWlxDcPiuqsD1X+5cZ435U+E4RS9grUB+7KTJdiMvZ8QxH97Kyb6nykRoaygXUHQnIEDLHvkbkeE7uISH5TX1fVxReAeZVKRMWUzcOfxuwRX0lhc1/OsGSUKw2AfIecM1yLG8HjBOqqoGg6Z1kWFidfvFWn5Pnf97dX0YusUZvKm6SCHQUD88aTpytxIsI9pEodsrni0pFd3XherqWUDH2RiCfMSCB+wLPJiw/9KVWdPVcoZZImeMsDDpJavxgppDqnnjkY8pTQOsBk4YgirIX4IRopwz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6FV3qFnAfwOIg9iKB8hg+m1E9FTfSemCwk7QsPfiO8=;
 b=Q7Lokq6Oe05hFa6AL8/NVTsR1NxeVv0Ne6A2YAIW/z1PJa7XX35Xt0Yt7jFToNSwh3cteLvCoLSLXVOM6N74F0eWZAQ2XQfykYl3QPX3KXfCQ7pqvvW+lYVZcb5CkbAF6tQUzIgokk0xzvP++zmlnyd44c/rdAgL8JSY8nUhSqSar8k6mUstSLpkwfMiTjVv20GUAcjafDoNQyXEuDoyOgZ+LyymELdBam2N7OmoBEbCA+HDBquvhxZCLXLi1wMxlWUUyb5/1mj6Y6yvRdpk0PuQV6JEnNlFVbK5m0SD1sAOqPIJ9D7YTQVwExGxfdSLE1dqWI8i1cuDzgaEhiYRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6FV3qFnAfwOIg9iKB8hg+m1E9FTfSemCwk7QsPfiO8=;
 b=cb8HmpJrIzkqMPmnx+YFdn0FaK1vxB/Kgya2a39spVnX/+owwcow4MnGJBE3UJMETzWpslayaalcFiAMgDXVJRKID3NSxfqIhs7cxjtI2pJ5Om8XMOHbUlqLG7wHJQ2pzVdUq3kV+VBMQc3bylBJj5NfON7CG0g85175MlVlz5Q=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 12:20:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 12:20:36 +0000
Message-ID: <9e95f138-9ec5-90fc-7ea9-cf8cff8bf180@oracle.com>
Date:   Fri, 1 Jul 2022 22:20:24 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, tj@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
 <20220615021059.862643-3-imran.f.khan@oracle.com>
 <CGME20220701112210eucas1p2d2db45881086f41b73527f7536537aa5@eucas1p2.samsung.com>
 <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c92a93-1a60-44ee-a135-08da5b5c1a25
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxfOKQ5K1htT5ZDuIjsB+sZk+A3Igfmu5/ZQV5SX8FYPs3AEWOGliNO7/Jkr7kY3gujcfiKPx1l9PO5a3JEiOWCFXTOdQVM4dUCKaJ/tlzbWMv2A1cjEgv6s2dvVdPBOID+v0mI4nkw4az1PN9NmQSwrvw73yRtP3rvkpYUNKiphBRf2aOBfQXAitqsw258sJO9vpJbOSpAJpkKItWSTJRRtC3AMA+DMSORx1+XcDXhunJFFsPbbwBp3CyRCz6ICW229nlNQ43aJ3Qo3AgKeiP75vy7iBOAqsPukuE73AUPHrww7F9BUSfL3HZY/nTAXzG4Mvn6pf5cIYd6uWoYDxTtDjjJORL2d+vgjN6LqIns5FHc/FKNCOueoaZS8kJ21YQ81jQZBSRO6FVH2GJUiy2A9UAQyLinYrMNGOZfP6yuouJcRCVXmw+RalQXSFOcg2rt9ZKSUmzNjV93V0eriQpe2Ds60wAGt+Mlt99h4sEnbX4504ndro2p94Ssy4zm+3HgibXdTMDeDuP5vYNMAXyR2x/IDRCWIP2HbV/zwbVTCv9AFSAsFUl+iWexxPzRva49UNckMuTtS1pSCYuFEPC4GxzU8C90wXn3iTHJNcxUMynBCtV6c8CUgidEWTsiRWhF4+JqoMAwFtMzsaP1zY8NB5YBHqq50PqiVl0+UT2TV1qVoLLPtlGQTKJYDRt9k/ENcZcoBfQwPOSRirGo5lGixdZSzZuKhepDHH7Q2u3ulQBVibfYShfg9IUi9peNSA30FEbP5KI1Thvutea+89lpYiivlYnp8lIIYt92clWWcVaYfW78KMODq/eG3QJmQM4Obv3I920y25Ft5+iU9WlNuhyOma60wWrRd2xGP/LZ4BG6YokVIIOHfNxiQpEK1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(39860400002)(376002)(186003)(83380400001)(31696002)(966005)(6486002)(36756003)(66556008)(66476007)(66946007)(8676002)(4326008)(31686004)(316002)(45080400002)(6506007)(5660300002)(53546011)(6666004)(2616005)(478600001)(86362001)(8936002)(41300700001)(2906002)(6512007)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHF2WHVFblg4K3p6VldUaUQ2Z0g1ZkNCeFQxVGxsUzBVM0FhbnpiQXhXZ3Q3?=
 =?utf-8?B?K0hySHY4Um9ndmx6UENmeG4yaFJXKytmckF3UTYzRDdqWlFLYzN3NTNLOEwz?=
 =?utf-8?B?K0RNU2tWdGVPdU5rdHZoUG12Ujg1Wk5QR2JLV2tDYnB5cWRvcldDR0xWdkZq?=
 =?utf-8?B?Sks2V2puUlNEUktLcVdyMGtVc0cxcVdpSldTZlpmdnlxSmMrTVo2K2I5RERr?=
 =?utf-8?B?bmVObEFreHVtSWJ0K1RHTHdwaUZOTkljMU9VZWh0bUtrc2Fzc2R3TEl4dFhl?=
 =?utf-8?B?SE13M0p5dm05aVZyZ214NG1UVWx4bTI3cUhLYk9OV0lsblMwR1lzTnpNdFdz?=
 =?utf-8?B?dnd3S001Vm44SWZRR3NGMUd2OUZnR2NUcWhyTktVaWk5Y2JBQ3VwVk9xKzJj?=
 =?utf-8?B?V1gxUUkxcUFBUzVES0VNQ1ZoVkF5T0QvYkNKcFd0YTlPRXFPYUF1MCtsNXpI?=
 =?utf-8?B?bFdZbEt1eVljdnI5UlBzV0R4ZkZQcHR5ZW83VDBvMThjbjlLSk54S013YmFE?=
 =?utf-8?B?ditOUVRpUjk3bFFBSGpXUHFWM2FSZDNCYTN5QU94RFE0ZStZTThaTFY3UEhU?=
 =?utf-8?B?WkFWSlN1clQ3bi9QSFVncGREWnQwdSsyVTFwNnI3R0lOUkh6RFZ4QlJjNkoz?=
 =?utf-8?B?Y0VxRmJqZEZjK3B2d1JrbFg5WmVPajB3eEU4YXkrOUJvK2JRa1NPNDdiVnNj?=
 =?utf-8?B?WWowSkZqS29jZW8rTDhudm5MUHNnRFdwMzJ1TEU0S0hud2N5NkNwUDlJZTF0?=
 =?utf-8?B?bXc2UzBUSlFCRXphbkhwL2VESGF5cDVoTHhEeUR6VFRYb3dXcDUyOG83SVR6?=
 =?utf-8?B?YUJIRHM5NUtBUDZ2bmx4OVVtemtEUVlNd0cxZWJQa29PaHZLNWVUSitBUW1Q?=
 =?utf-8?B?bnJGYkZjVWxoYmtybmtZbHVjS2xhMlNEVjdNK1h0RG52clNLTkIrM1FMWE9k?=
 =?utf-8?B?TEVsMnM1N3dIWURoYXF6ZHBSSUQzd21lSHQycWRWUjZJTFlWcndka3RlUnFG?=
 =?utf-8?B?djUxNjlDU0ZWZmU4cW5BSWdkQkRQQllDNjJVNmZ4K1JkcCtuZ0xLQW85WUQ1?=
 =?utf-8?B?cUtnNGJUVyswdU5UK01OdVhQOFY2Y1d1V0VSUjZvU1d4eGU3VEJkbEpsRGdF?=
 =?utf-8?B?OEVNQmphb1ZuM0pHblpaUEpwWDNmdTRWMDM5VUVuTjdnUURXNUc0TGwxOFRI?=
 =?utf-8?B?QVkzRDAwR2I4VnRXZVRPbVEyUFNLdDI2cFNCV3BnQUhKNFZISEJMSHFtZkdn?=
 =?utf-8?B?dVZRbEg2QXBONkhLQXI1VDZBZzRmUjlUSU95MFRtWHd3eHVRd2xlaFlKTDRj?=
 =?utf-8?B?WitTWHpkOE5MenkzeUlBL1lIVDJLYmk1a0dtWmZrUTVEMm1aSmpSNjE5Mmln?=
 =?utf-8?B?dnAvOGsrTlNNMS9hNkcxb29BWEFUTkZ3TzYycFBCekxMQnpxbXhlM3JzVlFT?=
 =?utf-8?B?Q1Z1czJ0S2Q1bG1WNm5wdXRNR3RxTHRhbURJcEg4Q1NUMXBOS1NaZ0hQa2F6?=
 =?utf-8?B?VEUwd0picXZ0Z3BLWC9IbS9FSVh4Q3ZkN3NrdzRSYi9NWmtIa0JBdE0vRkRY?=
 =?utf-8?B?R1R3NHllRTVtcE5HTUE3RnNQNU10enQyb0g3OGovSnlCVm5teUVVWW15dFh3?=
 =?utf-8?B?cGJLelg2OUhCTnJZWlhEQVBzUDlBT0ZVYWkwSC8xK2J0T2MvR3VsZXJRZzhR?=
 =?utf-8?B?c0xtWU1TdW5rVFJOTUM1cnFBVkZQWktsZVY2QXIvZTgvWi9uM3pBaXVUQXdh?=
 =?utf-8?B?eFJCeWhHM2g4WVhuMGI2aFpsdDB0SUp0WGhiU0c2d05GK3hkK2w5b2ZibU8w?=
 =?utf-8?B?N2VYVUNMeUxaamVxd1Nmam9CKzBwWUtocGs2WHJOcUJDMkZUcXo5aEVxUnRS?=
 =?utf-8?B?c3RWNVBmcUxpdFdFbzkyL2RnRnBla0I1WVlORzNrM0cwbDFQeDlDMXh1ZkZD?=
 =?utf-8?B?UmhLY2IvTmRtMWlKWmFCZWY0U1lMamdBTFNBT1F4TCsxa3R1V3dwWFUreFhX?=
 =?utf-8?B?U1ZkcXB2UlpTbmkzWEk5dGVlclYzYlJsdXJrUCtDNlV0SU5ITTNNQllhcjdZ?=
 =?utf-8?B?RnMyUXcvRDdkS1pMK3h0YTIwbDJIZFp6WkFDSktuSkc3WmRzODF0aFdtSzdN?=
 =?utf-8?Q?UpXrrxtd45BUiMWEBiWty59QG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c92a93-1a60-44ee-a135-08da5b5c1a25
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 12:20:36.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E58kagRknteYbiUsjsJCJmfjh7jXZLbCjrZ9xNpXm/vw9+AaE81h1EEHWEwyX06s8v2MWCBJBHzLhJF7miAFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_07:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010047
X-Proofpoint-ORIG-GUID: VAbuNEQh1YE-HYlr5PLiETGiSQ2ZWa9a
X-Proofpoint-GUID: VAbuNEQh1YE-HYlr5PLiETGiSQ2ZWa9a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,


On 1/7/22 9:22 pm, Marek Szyprowski wrote:
> Hi All,
> 
> On 15.06.2022 04:10, Imran Khan wrote:
>> At present kernfs_notify_list is implemented as a singly linked
>> list of kernfs_node(s), where last element points to itself and
>> value of ->attr.next tells if node is present on the list or not.
>> Both addition and deletion to list happen under kernfs_notify_lock.
>>
>> Change kernfs_notify_list to llist so that addition to list can heppen
>> locklessly.
>>
>> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> This patch landed in linux next-20220630 as commit b8f35fa1188b 
> ("kernfs: Change kernfs_notify_list to llist."). Unfortunately, it 
> causes serious regression on my test systems. It can be easily noticed 
> in the logs by the following warning:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 34 at fs/kernfs/dir.c:531 kernfs_put.part.0+0x1a4/0x1d8
> kernfs_put: console/active: released with incorrect active_ref 0
> Modules linked in:
> CPU: 1 PID: 34 Comm: kworker/1:4 Not tainted 
> 5.19.0-rc4-05465-g5732b42edfd1 #12317
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events kernfs_notify_workfn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0xc8/0x13c
>   __warn from warn_slowpath_fmt+0x90/0xb4
>   warn_slowpath_fmt from kernfs_put.part.0+0x1a4/0x1d8
>   kernfs_put.part.0 from kernfs_notify_workfn+0x1a0/0x1d0
>   kernfs_notify_workfn from process_one_work+0x1ec/0x4cc
>   process_one_work from worker_thread+0x58/0x54c
>   worker_thread from kthread+0xd0/0xec
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf099dfb0 to 0xf099dff8)
> ...
> ---[ end trace 0000000000000000 ]---
> 

Thanks for reporting this issue. It has been reported earlier in [1] as well. I
am unable to reproduce it locally. Could you please test with following patch on
top of linux next-20220630 and let me know if it helps:


From 6bf7f1adc4b091dc6d6c60e0dd0f16247f61f374 Mon Sep 17 00:00:00 2001
From: Imran Khan <imran.f.khan@oracle.com>
Date: Fri, 1 Jul 2022 14:27:52 +1000
Subject: [PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.

---
 fs/kernfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bb933221b4bae..e8ec054e11c63 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
        if (free == NULL)
                return;

+       free->next = NULL;
        attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
        kn = attribute_to_node(attr, struct kernfs_node, attr);
        root = kernfs_root(kn);
@@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
        rcu_read_unlock();

        /* schedule work to kick fsnotify */
-       kernfs_get(kn);
-       llist_add(&kn->attr.notify_next, &kernfs_notify_list);
-       schedule_work(&kernfs_notify_work);
+       if (kn->attr.notify_next.next != NULL) {
+               kernfs_get(kn);
+               llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+               schedule_work(&kernfs_notify_work);
+       }
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);


base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
-- 
2.30.2

Thanks
-- Imran

[1]: https://lore.kernel.org/lkml/0b3c1362-5f0d-44d5-d3e7-c01de59a4e86@oracle.com/
