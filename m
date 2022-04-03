Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D84F0B73
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358116AbiDCRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiDCRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:01:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39132985;
        Sun,  3 Apr 2022 09:59:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2339hvIM016332;
        Sun, 3 Apr 2022 16:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ECapqoXQTj+JWJV0C+eWUc6pfbqMn1tVL8tnUxt+Zpk=;
 b=lQ/mvLHEKrcwMlkLHffJUPIzERAJIwWRnIyu27fuijiFcYSjEVO5RHgK+pvw6Osiwp0Y
 gFFrzNwhI+XaelIQ67QQx9f6UlSS/UpXFlcOserucdpXJLOmZmX/2uesXLw2G6VyM7LP
 cIinwk7Hd6MGOYrbs7M0yU1wY8i332r/xTlWrRQS+m+InwGOdHXJG88dlBhIjSHSNyyo
 KsQHXRFSx/PB/0wirnU4LYC+GRxtN1qfJeTqZww+mrcBiLeZ970pobqGazcbzXqrShW0
 ejM9+DCxLxzi5xR0CV1Fxejodynst7ctSq+eeyL23mYKnAYVVxmAmA4/LvL3wvCCx6Bk Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwc9jx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 16:59:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 233GtTfH020749;
        Sun, 3 Apr 2022 16:59:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx1j837-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 16:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCr0FXQmgcwcyoWNUIaERs77uVHfaTBZMKuANcZHGgBgvHM3xaLByYuqH4pW+uuBRFvxoGCzDqWRoesNBPHAbt6aWaq7ofQl7xoMjKkJ23rcEsI7fuD8YlAt7gVnRJr32nsVPDWwwZntYWWKP+WBeJlPJXb2vklu8o0/ia0r2qDkCrtcjJ6W4A7R9osu6RfsDzhoux+/1pg/gimnnFyTF+rMpU4wVFfEmQl7C/5Fr1gvsv2/aME48s2y8bacT/WJ79TEQ0zqcGIsyX8pRtqOPp+7J8wjnGryZlF8PNq9kAwt9nkXosUnelRKxVLJDxCzTd1XSMN1XEE9tU/040okqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECapqoXQTj+JWJV0C+eWUc6pfbqMn1tVL8tnUxt+Zpk=;
 b=H5v0md0zU6O6U05bohsvDPDVXaQ7aPRsWZAZziWhyE3zAM9M2B3U1XcpyfhtykilRq7Vw5/SOGrRVkBfdcjLVAfW/4THVSYOI6dUbYaoBW50cAmhvIP6idJJzQI61FRklt7wr97Jggqw+9A7UagzIBfvFNG7TGmA64Wtec/ACbX2cH0rJMGhCeZ8HE51gg1vW6RqRo6ZawxPCDTyo2fO+jPI+LB1qhw0EgAA6DaN2Rc5KjjuARL10fRI69GPuHGs3MI/V3NmOaY/+N4R2ETYdBwcRSHJtXfXypEdMpmaWtwEw292zclN4L7Eg8s3N7ETbKK3reV1CLMSyhIkp/WpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECapqoXQTj+JWJV0C+eWUc6pfbqMn1tVL8tnUxt+Zpk=;
 b=uKqYPc559tVhwB1k/3C60SLAyFUO7MgRr99AYM4Y1DgVNsLlUpNChB4w3NNaW4lyVXxt7hWphwaVTQQ6/S4IwMK9TKxpRviDDEvNAb/honLXve/Sp3gjaOWINdUxqQQTdiLTbsCjX8SdHmI5ffzE6Fx3CLy2ueDWHwr6TT6G6do=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR10MB1655.namprd10.prod.outlook.com (2603:10b6:910:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Sun, 3 Apr 2022 16:59:02 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 16:59:01 +0000
Message-ID: <775f75db-edb8-8f39-2592-862756811710@oracle.com>
Date:   Sun, 3 Apr 2022 11:58:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi: core: always finish successfully aborted notry
 command
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220401035020.1043239-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220401035020.1043239-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e1dbee-b26f-4614-2a3e-08da15934099
X-MS-TrafficTypeDiagnostic: CY4PR10MB1655:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB165567C533AE4CBB5CB48C99F1E29@CY4PR10MB1655.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RWgkHHhvB5K77CTzNARZcFa1qcNHbc8rMR6wyrn5SV1/8rQ2aE4+lUpxZolBworkMF5kSU3pP95n29EfvdXD6ABlnwm0Sn7m5WcS3/y+/oq+plngjrKkrr6qtE/lTFGGGh/LBNlght1KNLgIZYUCQ5XRTNth1k+fmmDvGp0GGyze3zXhsftxF/EHpQJHuzdB4SHGCi4G5Yy1PhRqWcC3Ot/bKdqXo8fQR1PMwGGKtcJTnT1s1GqzYra/SYXC1QjSmFnR2Ltz5IS6cD2ooxkycKm9Bnb1AOg5FovLlTXznT+tg66/0155KA5iyIcf/Q/+c46pDGG1AqSsKA+UR8wHqc0uYu59MsYkEaknluQifw7O0dVpJdpqE08O4igF6zZbEC8ExPV5ln7KUyp48iPHFjHqYW0d2iZaf0ZdtlXF7AWOnMNERws4/wy2JKZjD3Ev3+6Upa3FTvDK6ObU3RaweG7K1uV0ZMTEuUD+Du+LKQt+zLQVkHYRwO2hxLtDgG0bWEIfU1rODv4k35kG76tEJqxqPXlNAmavxF0xUZXTxygdZxGaJHNBFAwDU/TBla2SP+BVNzlKGs6IcN0hJn+50gfDWYqzfu5UzVtBeNmYsagA0j6pf11/N2aGpS3JQ3+ANVebJCgt/uNmO46NtM5wXrS9L6N9oioZAH8F74T7h3hxVuWoFaUlz9h4L0WU4IQaz2n+yNYWJDV2uvcsl2bX9wQiNCJxkQU1tdO0b6CIgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(8676002)(6486002)(4326008)(31696002)(83380400001)(508600001)(66946007)(66556008)(66476007)(8936002)(26005)(6506007)(110136005)(2616005)(38100700002)(86362001)(36756003)(5660300002)(186003)(316002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhHQWZ4SFNkVS9xRDJJNFMzbm8zSjRjelNBSVU4Vyt4UVZod2p5N3lKTkRx?=
 =?utf-8?B?NkU2NzUyRTZSazFFRnh3Ylo0T3VWS0tNVm1aWHYvcVNBcU94eGJuZ0szZzlK?=
 =?utf-8?B?UDJCeDQzTWovaVFzMGFlazg4RGQwdG5BSk11Z2hSOXA5WnR0Z0V1SDgva1o1?=
 =?utf-8?B?QkRnQWxnaVlrUmRxdVlIaG5sRHo4V0RDd0lWV3VlSDZkdzJKa0toajM1RWE3?=
 =?utf-8?B?eERUc0xOZDlUT2VJZnh1aXU2a25BcnhZNVZmMUNIMDNFRFpJaWpiVlhLaGFD?=
 =?utf-8?B?Vkp0TlI0NjRPUkpNMWNWUWl1WWNXNytaMzhZMk9IOE9TbThhMk1kQzZKV0RL?=
 =?utf-8?B?SkxMN0FpLzRtNVpMSGN2M0sxRFYvR2YvaWRiY0JnOG80cEdTMmNaRHJ5bGdj?=
 =?utf-8?B?QUF5bG1qbGJ4aDdqbEhWQjh6L3Bzc0hFOVFrT1pkejJPY1VxNTUrV2dNbGky?=
 =?utf-8?B?bFBabjlIc043WmZtUnNodHlVR0w4RXhxWUcyMXhLTXVGVUpHdjVJYTNJZzJZ?=
 =?utf-8?B?dU5va1RnM3dyRXhJTGowQUh5OERNRUNENVdlMVhCVEY5UzJ5WW9PWUFSbWVZ?=
 =?utf-8?B?V1R2MjNxVWhJVmdEMjI1MDdhZ3ZaNFd5M3JMK29TbDNXSzA5SHZTcThYc0t1?=
 =?utf-8?B?ZUJuRUxCT3pDMTNuVklLRENPUzUxRGxMdm1oZkUrUWswRUZhcGJnbzJzSHJq?=
 =?utf-8?B?T08rV3dtb1BBYm04MjFqQUpXY0V6a0dXR1RKWTUvY2I3L05Gd1FYU3NLcm95?=
 =?utf-8?B?RlRJY1JVcC9KQWh2bmFTWS9wTGVYYnBTSkRpSlpHNzlndVRzMTh1RUZrSDdy?=
 =?utf-8?B?bFJIZ2hzRThGdWNFMmxWd0lKYkpIa3JMcFVtaWwza3pjVkEyemtwSHZ5Q2Q4?=
 =?utf-8?B?di8wOW5KQjNpUkhsYmcybDZXUDFobkpzZmFXUFZFUjFmWFA0a0UxOUVGUUxD?=
 =?utf-8?B?MU5jd1U1QjdLbEZ2RVdsYW52MjVPc28wNE9iM2RqVmhWOWlkbkl5cE9GSlpy?=
 =?utf-8?B?TCtEVHQxSXFUZ0lYRW1nWWJVclg0QTZhTmhGTDZYTmFHTXN3WkhrYXc0RURO?=
 =?utf-8?B?bkRuMHhqbk0xclJnMUxaMTE1T2FKMkxVcFZoZzkzT2VvbFdHbVYvSnpOd2du?=
 =?utf-8?B?bkxzdjlkUnpRMkoxdnE4ME1JWGJuUEtBSUEySkc3SjNmcUU3cjl3WStXVWwz?=
 =?utf-8?B?c2dOc2Z2NVlEWEFGelNHby9nMyt0VGxRNVhmT1N1a2RpWmlxSCtTbmhHWGxW?=
 =?utf-8?B?N0lHMEdCZUxFekZNVE43blU0Nm8vUmREeVhOZFRtR2pFWlBOYmtKK3I4Q0hS?=
 =?utf-8?B?bFhXUmtiL0tIM3pnN3d2MzRwRlAxNTV0L1pvVFp5eUpWNktsWGtTdFJGbmEy?=
 =?utf-8?B?bGJNNUYzSTFMVm0vS2M0eW9qRzBpTG85ajFJYVlWWHo5bGNLRVBQdDZURm05?=
 =?utf-8?B?S2grMkk2ZnBpdXYrSUV0WUV6Q0hzQW1CUWNBbWJUODNLNmtTdFFieTJhM0FZ?=
 =?utf-8?B?bFZVdnNOSmI4VldwZUJQczBvenZRRy9iTmUrN1VSRGVkd2Jua1lhYkFwTXov?=
 =?utf-8?B?bHA1elRqTitWQWJ3Y2VXNlVUQTlkeTd5M2dPVysydFhwd0M1OG0vQTY5bzM1?=
 =?utf-8?B?ZXpjUzNVK2tCTUo5bmxvNFBzK0JRTkJwRnFUOGFFMlhmTk1YT2dyMExLRDlT?=
 =?utf-8?B?K0hUYktVMnBSbEtWckw2SWg3QVM0bnlKVWtNSkNiWWpORk1oTG5RR1R6TnNo?=
 =?utf-8?B?K0lyRGVvNkxYc0NQR1JyYUJpSkY1WWZHekJFMFhHTk1ubkozK3k0bm9IeU16?=
 =?utf-8?B?bU9xRmVSQnBGeldRTjVLTHByN255K1JvSjVEMVlaNmZ6VWlGYlJiam05T0hi?=
 =?utf-8?B?b3Vzei9sUUw2YjFGeE5TYmszN2lZUHkvQXQ4RjJWRHFyR25rRm95UjRKMHl3?=
 =?utf-8?B?Q3Y5UUhjYjJhWWluWGcvbGlpTW5BdDZXeHAyd3VyUEtqOHcrcjhMOE1FWmVG?=
 =?utf-8?B?ZDNHMlJUbWpXOEg1cGtLQXp3T3JXRXlwQzcyQ3JEYWJPK0R0aVd6ZXpleGVz?=
 =?utf-8?B?VjdwTVNDbFpHS1R3NFo0TjF0NHRGaTczeDVCdytxUy9BYjlkMy9JekpxSDJ3?=
 =?utf-8?B?YS9RdWZac1FwRUFhMXA0WGQ4YzMyOGMwRGhYNXQ2cHJwK3hJaDNiRG5SUzhB?=
 =?utf-8?B?U0Qybk9hSHBDQWZMcjVFUDdDZ0FaMkFkTXVCdlVRd3pyTGNJdWw3bTVVckwz?=
 =?utf-8?B?a0I2UlZXdXd6VVRXK09pb0JROExTZzZTQ3ZEQjFlRVJFdEFteEhyZUJUZTZ3?=
 =?utf-8?B?cFp0eTAxSSsrdDc1WkVaWDNMa2cxcEhydy9iM3FSSmk0c01LTlZkUmtBczZV?=
 =?utf-8?Q?pTBDVPrFrAJNjZ5E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e1dbee-b26f-4614-2a3e-08da15934099
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 16:59:01.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtpW1OOA8C6aYTYxC+N/e0jOTw0yW/67y4PQtjiulXiMBdoccIZm+FoR7tszKsmwHXvJIvZSJaGazj0/NS4qiSjvkDWSOfgH+6L+QyITpf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-03_04:2022-03-30,2022-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204030112
X-Proofpoint-ORIG-GUID: Vc5PvtW9S26ZWfIBU53rF5DmBx9sajOs
X-Proofpoint-GUID: Vc5PvtW9S26ZWfIBU53rF5DmBx9sajOs
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 10:50 PM, Wenchao Hao wrote:
> If the abort command succeed and it does not need to be retired, do not add
> it to error handle list. 
> 
> Adding command to error handle list is an annoying flow which would stop I/O
> of all LUNs which shared a same HBA.
> 
> So here if we successfully abort a command, we can finish it via
> scsi_finish_command() which would reduce time spent on scsi_error_handler()
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_error.c | 55 +++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index cdaca13ac1f1..15299603b7ee 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -173,41 +173,44 @@ scmd_eh_abort_handler(struct work_struct *work)
>  		goto out;
>  	}
>  	set_host_byte(scmd, DID_TIME_OUT);
> -	if (scsi_host_eh_past_deadline(shost)) {
> -		SCSI_LOG_ERROR_RECOVERY(3,
> -			scmd_printk(KERN_INFO, scmd,
> -				    "eh timeout, not retrying "
> -				    "aborted command\n"));
> -		goto out;
> -	}
>  
> -	spin_lock_irqsave(shost->host_lock, flags);
> -	list_del_init(&scmd->eh_entry);
> +	if (scsi_noretry_cmd(scmd) ||
> +	    !scsi_cmd_retry_allowed(scmd) &&
> +	    !scsi_eh_should_retry_cmd(scmd)) {


I don't think this test is correct. Did you want all ||s?

For what the patch is trying to accomplish I'm not sure if it's
the behavior people wanted. Do all drivers have configurable
abort timeouts? If an abort takes N minutes to complete ok,
and that's put us over the eh deadline maybe the user wanted
that device to be offlined.
