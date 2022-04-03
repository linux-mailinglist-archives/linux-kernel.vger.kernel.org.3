Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA864F0B88
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359641AbiDCRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbiDCRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:19:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70F393CB;
        Sun,  3 Apr 2022 10:17:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2339hvJQ016332;
        Sun, 3 Apr 2022 17:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Avh3r1/OlKFe2fyV+aKbBCWqX71UFZmNPszztdVR+dw=;
 b=bVstqxc3PeCOR8Ce8wEixzZya+uEiKtbsDLBugaH1/Uw7G3fPk8EcovNQdjco4ufkWGL
 Q47gsrpC7tvRq9HXeI3fpnoBIB4Yzy4i2j4n81hQ+aXQlhz6QF8JXAj8ZqplZCjn0rRZ
 cWTenWWLKHUtplO8y6ekxMAunbe7Vno6F+fCeVeXF/eIgXh/765LafgzCk5t89jSw3Gb
 4kaVfOMOAkaS4gwHtUmxnVW2b5fKiukvI6/9IE4DyHXFdE4X22ZmHLXrbo6QBiVlsOW9
 mMac+4gs1ezauNWYYyKISuJNmeL1GnmpFmDC/4ZzinIhUaJCEVqf4dnHpm0kDsG5kuJj lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwc9ka2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 17:17:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 233HFZTe001221;
        Sun, 3 Apr 2022 17:17:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx1ttdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 17:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLVwUZXpsGEYtYqfYY8wgISPbGOwhu4Mtr9cq0dJ2uvl/+81BbFV7peUm5RlePmyuUpPIW4ps9llHZ8ZUzYl8Alcjd5iaQA9qdTQA6wlJollRM6UdGu/K1tD4FRj9mvQstFLBbfyvepc+i41z/GTiWbWdcT0pfCEm38dPo7munaLrfIIHgP9W0wAtBQzPBh3ri0IrbqAXKPCoPQN8Wz5OpUhA06hLLGq3vKpmB0gOQeMKGXV0MO3C8Im9pI+kN5Ga8vrqqcNNnKVALJVxM+CHHtmQ476bZQVWVPoHdPe3HxLe4n/yGgQzQKgOUpUaWCX64vBY28d+k9YL/NIPfVQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avh3r1/OlKFe2fyV+aKbBCWqX71UFZmNPszztdVR+dw=;
 b=Dt9iA0TXYBjzXHkKbHWjSrjxEqJgvUsSqcDIN5MHY8m2OPyfmDBSxCKzKsyaLiEZyftDsEe8Nk4pzS4FecBGRK5Z3uRirHnlC7zceP/9QD0MqSkNAW54XvraimSj+L7DqkuJGSc5q463X5T5xIx6fk3XL5gHryxPNonUQ/2fDRekIv8ZHUMcHGajxPJNf8gNEQ4PYHFCc6AYVfEp/pQ4sIugFXcPFGUY4rpvraktQPrDVyvASkAK4tG6+rB6O8cC0s0T2wNJpduTwiQW+0yqSNXAAp6rz+jQ6yuAcKsD6jUxEGg11t6Ib2Xlj8WNY9+CSVPH5PkrDYr38wHy0Z1FQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avh3r1/OlKFe2fyV+aKbBCWqX71UFZmNPszztdVR+dw=;
 b=xfjyekLL1lbTYXlMVwZe+NfG3UJHvYJH2xwXyChtRax/7Ohxdm7OsJ0RgNVXrbCFzoxzJ0osSRTTF1dTDUzdJhijvTD27QqWI7pw6T1jWYMWjDp5xyXzyQl7usjkig2LRGe9xJlDOHTkvfHFocD3sfjx/xhidzqrpcEKQeILxqQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 17:17:07 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 17:17:07 +0000
Message-ID: <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
Date:   Sun, 3 Apr 2022 12:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
To:     Wenchao Hao <haowenchao@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
In-Reply-To: <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:610:cd::25) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec41662-9d17-459b-7137-08da1595c7ba
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54390FCE5536901C80701935F1E29@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElVxZ+Nj6VpPEvZDxZbSLBJbe0PyXPbVWCUjKk0T6QzGei1EfZRGMy7Axxw2/D+qcf7A91HG9qk8ogTsVWcAbCLxpJYUfmymOrja9Mx3EynSzky76BGqUQ7tsTMkeu1VeUyyYwLlKbg2IQI7kSCbHxHo5IUs4bqozgxEh5p+R1ObEfqKx50jOuc9fgOxhqn6nQgZ/pG6M538SZpf671ncYEIqmHHAYQ3cdrOZvj8xE1ioqlmMjWOqjFsww5EodQ/RSxMR59gjzY+RA18whMNzKb8fWxvyVNSUFri18KtMew0MnKboRyJE+gIFVzsuyysphFJCSXykNG0eN9gbBwEHHGVQHvlwyRk4Io78eMxweqS6fmgmw55f2gmI4xa1RlXF7Wrj6xOEB8rBHhbh8DnVY0DQA3smMPYxFlWDlBei8xLUCrnnjHIxYQfhxGShE/PGHJjSHhrX9vKdii/xZSiPPQfg2AwvIC+1Q+p+7rNWTxGLvjAKCKaJh9AIfnlsfuLu9+MXZW+V3VIdnv8qRchuFqitmPyXt69sZ7QBCrhbJtghwWVt6SuCdtOd+SHCW7Jv1lLSmKaYzKg436C26T9FNyoZ0bE5DPAkVJW5p6zq8yr2edTND9qgjdO7OHsNzYPvVANNgwf3PG0py7lQiLczX8Sr3SkyvaIRDvmpt9Wu7gnocrOjk93f2lrDxPQ6a50k7jabl3yMzcrnQM8a+yzvuqYt/EGk9KLmhyXXG/jd6QItAje6tJgQGwzm6WREThP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6506007)(53546011)(4744005)(6486002)(508600001)(8936002)(83380400001)(2616005)(86362001)(5660300002)(31696002)(38100700002)(4326008)(31686004)(110136005)(316002)(54906003)(66556008)(66476007)(7416002)(66946007)(36756003)(26005)(8676002)(186003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRPczdxTkF4T0pEM1ZEVDF3VHZxdWNseHdFeG5NelNrUkhuNkZFQkpPVEhm?=
 =?utf-8?B?VmxJVllRTWp0c2JCbDhxc3RYSEpoSlVNS2NMYjFkZlF2dWF4aThUK1Z6N1Mz?=
 =?utf-8?B?dkVLR3ZKUHA3ZzBzeko5ZkJFMi9ublN4WklFYmFUMmw3cmFJSnhxd3gvSDBF?=
 =?utf-8?B?Q3MvL1MyYndXamZNeHdzZ09JdjZjK3l1aVpnSjR2RStXTHduV1Bod09jVmE0?=
 =?utf-8?B?ZG5adjl2ckR6U0ZORnlNK29Rb1phRUNSMmkzQW94SlpNb0FDTnI0eWJDSFZx?=
 =?utf-8?B?ZitHZ3NLb29GZlZXV01wcUdGNXBRSDFhL3pnUVJjajBvWDh4UDRkRVJBbUZI?=
 =?utf-8?B?SHhHUVBOYVB3ODZ6T1Q0bFJGanFMaGE4MXluVk9PUGdhd1l3bWsrR2tjY0Zv?=
 =?utf-8?B?Z0Vza05JdEpPSnd5bW1icFhOcGhmQlhsNjhyWnFmYm1RV21SalNFeHhCdHBl?=
 =?utf-8?B?dmJaZzJ1Z0NZakFVMmxIZFExamNpRnFNQWJ6TjV1V1lrN3VVVGVQNloxcHN1?=
 =?utf-8?B?cXJNcVlVYloxYUtGanVId2JvNlA0M0ltcWxFRVVJd3BMdmY3K3BMalduZVhZ?=
 =?utf-8?B?aWJpamFndnltbXFPcXNTSjFhSzdlYXRxNVhvYzFUUFlsMFdqTUxWbmQxdDl4?=
 =?utf-8?B?M0RlR1VsT3dDZzZTSG1hZWl5TlVyOEZLUzdrQURnZ1JkcCtyNW1LUFVQZE44?=
 =?utf-8?B?dmovaFBQRzVmVnE1c2RxVnVONTBuUyswVDg3bUhwc3hpRy9Tem1HSVpwMjRs?=
 =?utf-8?B?cHAyT0g2T2ZOK2FieGJORnRXU3dERFpoenIzcEhmWmd4RVpSNHd1Rm94b2Ft?=
 =?utf-8?B?dU1sMUZ0S1J3Z05YU3cxS0YvVml0QXorWXZPZWRpa0FvUEJRTFUvZFhOL3JK?=
 =?utf-8?B?M0FCNTRKaEJKa2tzZFRhUVd2VFJnMnhRV3dWcHdWWk0weUpUd0NkRlpBRlUx?=
 =?utf-8?B?d1VraHVuSXkvc2xnVUJraUJLOVJ0Q3BGdkFTbWtGb3NBYkJXZVcxZnB4K1ND?=
 =?utf-8?B?UkV1RlFLYklRMm8zMnh2NjZxQ3B1bUpjSWZ3b09Jb01HcFI4U3daT1lISlB5?=
 =?utf-8?B?aURYdEgzaWR1dmFJN2s1NFRqeU9UTktNWjBka3Z1SyszNkdpdmVld3g2VWd4?=
 =?utf-8?B?WHQrMFZIYkVNY0s4R2JTbHNYeU9YTEZwY3l4b0prdEpnOVo3bGRwaU8xRmQw?=
 =?utf-8?B?NHZ1Ykx4eDU1NlBiYk10citMMk15K2VoNUhLRGFiOFpLLzlDQW1TY3pkYWdl?=
 =?utf-8?B?b2VEUDh2d1ZjWmR4RnhhT3hJb1dKRk1kN29TR3BNN3pNdHhpWkdlWWpGYVpX?=
 =?utf-8?B?NS94cXZ4OEk2RDVVQ29Ha21lZVJGbmVEcmtSYk9waVZpMTU4NWJmejkyekdz?=
 =?utf-8?B?dnVkdEhxb2NHcnVvc0R0dlltYmZRQkI3ZDZUNU9FK3BqcGNPaHk3Y01pVklY?=
 =?utf-8?B?SFM0d2x3enk2eFV4VkU4TWw3cmw4UU5JV3ZYSWl6eTcrRVFHY28rZlJOTlNw?=
 =?utf-8?B?U2ZRSElPTDVXelBtNVV6akhLMVF2U1E0L3NGa01HVGlET2dNVStVSXU0Y0FB?=
 =?utf-8?B?RXkxaGZMdHZQMkFxVXZpWkRUYzVYZHo5SWNQSmY5a2VFTjFWc042em1QQmZJ?=
 =?utf-8?B?cys2YXIvSjNmdmhwTkVGMGRLSG5nN05tcDVKSnZtTXZJemJsKzI1N0JRVEtT?=
 =?utf-8?B?VWFua1Eya3J1UzJRSlBGY3g4NXhnZGY5Vi9ESko2SFNndXlQVFhtbUlmbktW?=
 =?utf-8?B?STIyZnJwR2FaYVhXNkUvb1V0cHgwVE1aSml4UHYreDFZOFRCUGZ3RHRwWk83?=
 =?utf-8?B?cldQV0ZMNjZ6a2Jmb1BOSzY2d1R0aGdiUmJEVVNKekQ3OUlZVlRjdG5TM2pG?=
 =?utf-8?B?U0JsblJRamh3Q2gwcEtPVlpsTS83aHlDYVlnaHlyR25VTVpvTVlIYzVnVHNS?=
 =?utf-8?B?NU5XUjNKVFdLNk5uWnFDWElIS3daUjF6QXZ1VEdhemQ2b2NvSTl5ZEJCeFg0?=
 =?utf-8?B?OFhsWkk4N3RRZUQraXJFVDFlUkNKblhORXRsTml3YUcwSm82YXVvSnFxZGd2?=
 =?utf-8?B?clFoaTZYL1p6VWU1OXI0QUxjbnhnVWw0K2x6MDdGUDlyQjJ6VkpQRmZSR25v?=
 =?utf-8?B?Sm1tMGNjSUJDdjdTM0xDVVVRaDRmQ3JXWGUxdUVmaXc5UGhzRlFQbGFsbWFL?=
 =?utf-8?B?WFNIbEtJcXpERGJ6bDZNQjZNcHR6S3BzV3pqU0FqVXpycWxLcWsvT0Y4OXlj?=
 =?utf-8?B?ZWZwZmNRSDhVWk8yZkRtVzlpS2dsbFhvc1B4bDBDRHBmQXlFTm50OEZxR1FQ?=
 =?utf-8?B?MlZ6ZHZpVWc4bVdXK3Qvdkt1UU44NHRURmM5TXYwanFXa0NNaUpTcXkvUTI0?=
 =?utf-8?Q?aBWWa/igfIBzz/R8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec41662-9d17-459b-7137-08da1595c7ba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 17:17:07.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Jj3YVI/rfAivtg0EHPNB43wBlgJ+YeoZp+cWtP8oL4XtOQ+qO0XntpGdEfYm4Ppabp+DENX9syO6Pacvz2AATm+4cFS4sVqCtMm4WXt5TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-03_04:2022-03-30,2022-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204030115
X-Proofpoint-ORIG-GUID: C9GxHwVmq-E92NKojfqDVjBf-_3N0bK8
X-Proofpoint-GUID: C9GxHwVmq-E92NKojfqDVjBf-_3N0bK8
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 12:14 PM, Mike Christie wrote:
> We could share code with scsi_ioctl_reset as well. Drivers that support
> TMFs via that ioctl already expect queuecommand to be possibly in the
> middle of a run and IO not yet timed out. For example, the code to
> block a queue and reset the device could be used for the new EH and
> SG_SCSI_RESET_DEVICE handling.
> 

Hannes or others,

How do parallel SCSI drivers support scsi_ioctl_reset? Is is not fully
supported and more only used for controlled testing?
