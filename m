Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B719547E47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiFMD5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFMD5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:57:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC212F00D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:57:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25CLCQp1029706;
        Mon, 13 Jun 2022 03:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KG14P2TM148vVQXg7+Ea7fiMQd0OFS2RupI3bS6V/IM=;
 b=bzUa9NeHLOPmuqJijE1Q3zblmL5y1E8cQ4VARxnh9+izhoyqLW7dJfo0aADfCuidxL4j
 WrmpOgeT71fuaVQJsKJ4Oir5Wiku2hleZQ2xMZO6fIyJkcJZ8B66MtRaPQOcNXPVvLg5
 SKzX6fALWQUbWDDvW9kI5/eeEgpNqqpqfPZZIuyZvYukcgTeVYUPc4dRhrKndSNPu2DI
 Wp7+LATotq+oiO2w1iHpUOD4Qmqtmmqt1P7TASoLVmLPQ73ZAZTKd8Y55xy46TiMKkED
 yJbvqh+eps97k2JxbSvGG3rSffTMeeJziSQ1vqP4quJuYYl2g7xYW5eMtJU4DGugOGmK Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkt9y49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 03:56:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25D3uoLi019918;
        Mon, 13 Jun 2022 03:56:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg2x3ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 03:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnR7n6MCuixzjoqc8lqH6PHgFuXZxxEWsk9yjr4WNj7RUiXoNNk5PdOkslIufYVXzVwznOMg6j3NFfAlCXSiiB0YS785MYdfd7XnDfI4hpdD/F7AQ0GTIzKj0HYO34tnM4YEkAEIbBe8teNht4XkAQ25ctoBd0PoiynrkMlxmWdbmdsORBLKDFESgdLvzFMvX554jxgv30IbkgiTQ9Zlezo9tC2s6PwO39nmzDYraBBmx+4T+EjsclTdDOwL3OngUjweNSOou7jfuYXulZqC9F/9wlvhr5IdtKG0OW6j93PhQZb9gXm/XaAGgOELMMybzbaj687qhiNSPrRw0v201A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG14P2TM148vVQXg7+Ea7fiMQd0OFS2RupI3bS6V/IM=;
 b=i3KXGX4jKJif9CDeaKz1eN3NoM5Wl6afqWXrA524Go4fDaoKyOJT+nDkBYgi164oR2k4cQqO5Kr0QgaQj8mIkIJBJtppuKifcJc72bcUCtNGv28EMcrZrIvsgjKSGyQhn9hLRAjcUu5oG4YZ6jeJ1gHffrhNGjHzVXX8qFmdnAAz+sTb+UpB7pVrCHSUtwq6IQ6li39AEStq8Hjg52HoX73qrGroToKwVbm5yw+UXR9dfqCf4s6QiOWcxAF0Fx4Hff561GyzzjNBbagbeZmpeHpSEB8IRFCm9xubBGADmCpwGJ1TEsF9Fq5J8QwXLfTizdmq8uRiMm30KT+sxIbiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG14P2TM148vVQXg7+Ea7fiMQd0OFS2RupI3bS6V/IM=;
 b=gVtMqqCseCNsbbKBpS84U6nI0M05OHrLJz3dNLPfrR5H9W7Ewg17BRlCZQFPQoiKvURqmB20DTR8by3RQS/XLHIwEn1kaCjOpViEmvy6eLn1KiFvNXrpB12QxP0yXVnDr/aNEi9PvFPRLqOut74cg8J9vDea+1biug0ohP86B0E=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5514.namprd10.prod.outlook.com (2603:10b6:510:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 03:56:52 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 03:56:51 +0000
Message-ID: <61868aa1-6c88-ecd2-beb2-67b87673b805@oracle.com>
Date:   Mon, 13 Jun 2022 13:56:43 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
 <YqalHuEB6OjjUosV@slm.duckdns.org>
 <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
 <Yqaqbas1JaWz25jB@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yqaqbas1JaWz25jB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0012.ausprd01.prod.outlook.com (2603:10c6:10::24)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d54d11-111e-4cd8-11e6-08da4cf0bf99
X-MS-TrafficTypeDiagnostic: PH0PR10MB5514:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5514A43111156D8226A48DCBB0AB9@PH0PR10MB5514.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVHr8XFGdRVXKn8VvJ4HUYGiMTtAfjYYfCxbsoaQQLcr3vsoDCM43dq/wWvyANHkuU0AxFLwCTAZY0yEmg/ppvl+reoVl4puMsTFsccKi8PVKOiCiWFO7qyHsCRvShfFJKDR4We7aWbW9ogkQUC3JePmQkLw5yfZOvP79K9w0RUYox78j40zSoEVZDuZeQCCx3SLr/kbzOBFl8OlxhuOvRgO5rTOu/OUpiOaLENw0z5TSz2LPhPuGZ7WaWFBz6volJafG99ndnq/5/WRxo/5YXmwWlNe4bCHyMIlMhcjqbI22OYsurwk7SB9Syr9jLDp7M7YxrfnM1lQLHYEi+S3C7+kXpGaIfwC1zB58YfMj9d3pMWxr29cvfVKkZe+xLkJ/1BcqPf2vQlWpL6quCA5zLw78YLuudp8cem2iWo4yMbmR+c1nL0q19+bB/Q2iy61DXT/MO1J39HhtRKAhXkJLDUW7+3aSdYTCI0Q3z94Gx1FZA6nli9JomcG5oWTwiNojnJ4Y7yuFkJ/WdM5V26PwKmV5xIFE+9K/+B8wuqNH7vUC+foZDla30AMYVrrbpAqKaNcuO2u/jV+DQrfYnUHGXcl1hX8GwuVhvNv6oYDH+kM6jauC3SRP6w8qAQY3MaBk9x6RErdtmabg0PmH+33dx0Nk5g5nnaGPszw010Iow0xNtdoQpK9UrgYLdZyxmdOB0Pz+CCnqZYWGVwdUR2ZY1uAHMBqHQRmyPcx5dULi8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(8676002)(66556008)(4326008)(86362001)(508600001)(31696002)(6916009)(316002)(66946007)(66476007)(38100700002)(2616005)(53546011)(6506007)(26005)(186003)(6512007)(6666004)(83380400001)(5660300002)(31686004)(2906002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1Q3R2k2WURKN3lzS2toNjRjSXg3NE1yajNWN0wyeGZHZERsT1hyaExyMUsx?=
 =?utf-8?B?aDRrVGNjckRLcTBncWhWQWF6cHNzc05TRTIyVytuS0t5TWxkOFg4NGt3TE9M?=
 =?utf-8?B?LytKZnhPL3ExMEZ2KzBPZ0NFNGFBMlVCbzB5dHFEM092dXFqMzJQbHE3VWFU?=
 =?utf-8?B?WXlFYlpmQ2p0TjZuUE90VVcwckVRVUcwaVZ5em1aazNnL2Vhb09NaDVlQmg1?=
 =?utf-8?B?N3ZhZFdBYzVTS0U2Q3VHSTJrZXkyNHJ3Y3VVNmRWMlpsQWJ5UmowdmgzK2hw?=
 =?utf-8?B?LzZoWWI2cm44Q1BJK3owOEVHOURmc0I4TzkxM3dQZjYzYnhOTUJvZWtxaVlR?=
 =?utf-8?B?R1ByZEhyODBZc2RjOTZic2xWS3UrQzBGb2lzbWxnUW4rZ2RtOEJ5dDVJVFpF?=
 =?utf-8?B?T2JybW0zWEZwV1IwNEw0Sis1czJYMVhGWkFXT09pcDZ6aXROSTNsSm1DazIv?=
 =?utf-8?B?UmJEMHppSnlqczVlUFdRU1d0WU8vWmNqMk4rSk54VEZTbnFNSi9IZ1RBQWp1?=
 =?utf-8?B?d1IzelgxOVdFWGJRRnZNWVB4enUwZ1FjN1hFWTR4ZnB0cXZVd3hjUHk2UXVp?=
 =?utf-8?B?M2FTU2F6TTEzRVhici9YdldoU3d6ZDhMMFJRVDA0c0h0NkpRWUVMeGt3Ym5T?=
 =?utf-8?B?dlZkQVorQXFoYXVNM0xxN1RSZmlFNkpuc2N4Y0RvMWJ5dHFhdWNtLzhIVUgy?=
 =?utf-8?B?cmRRcEZQYWNBdmpWN1QwTlczQ0Y0cjdHQkQrY3V0SEZJTWtGLzQ4Yy9MQUZi?=
 =?utf-8?B?MUpuQ1hDY0pDTXFxbUZsODNUdWU2dzVZQW1lT1pyd3l5MXg4NVR0ZXhQdzF5?=
 =?utf-8?B?SzJJbkxxNUpCTFVjeDh5YUsrUmdDNHJ1ZTJlY3dGLzllQlhPOGJ6OWdFWmhT?=
 =?utf-8?B?SzNaTjN3VE9mNEdNK0NDY3VtZ2JORVpwNmI0ejFTTnh4U0d3UlYxZWViVk1r?=
 =?utf-8?B?V3ZVUlNVNWN2S3NoRUNDYzF0Mk5PY2U0bGNCQ2tiQXdZVk9hS2ozWGx2NHZL?=
 =?utf-8?B?em8ySm9SaUxvVnFRa2lMUkZpZThTalFmQ1FidmJtQllEL3BlZ2QzOHJyellS?=
 =?utf-8?B?TTlFZThNd1c3bEJYSTNlRlFvWm90UTZiT09HYnhlM3NudUtLNXRRZXVCVWJn?=
 =?utf-8?B?cjJXU05qUGdQenVnaFhUU3l2R2RLRHZ0VVZSWndqTjBTSnhxUkFBSXZSM1M4?=
 =?utf-8?B?ZUN2QUIzR01CYXpJQUVWaEZ0QW56NkxCVFVhdVU2MmlHR1JROHptcDg1S0Vu?=
 =?utf-8?B?Y2hXYnRGdElMRVdKNGN6QXc5anJBVXNRcjJ6dHg5TUh2eVI0aVpkU3dNN0s4?=
 =?utf-8?B?SUNmY0dJb0UvbVo3c0JzdmtZU1BNbzlhZWxJeHZwcHBKVFVTc24rMnVZbm1J?=
 =?utf-8?B?emZKWUZZejhVbUUxMUo0bVIxaFlTUnJzUlJLUkRzMy84Nlp3bExrU29BUUV5?=
 =?utf-8?B?WFBHZEJ1QzZDV1M5T2M3MzhlYWVwcFNXenZ0RHQrR05lWGg1MnpSOUVsSito?=
 =?utf-8?B?UGswNEl2bi9JaytXdkdTNG15QjhTUkovOWVQalhCVTlUUnNwclhNWGplUWlo?=
 =?utf-8?B?cDBhbFpoVGk4eEFmQmI5ZDZnWTBYZVliV09kWEh1Tk1RczhaZDhJTGRzQTQv?=
 =?utf-8?B?Q0NvaTNSMGIvZHhaRkkrTWhPb3dvS1FhMGI1dVRjYW9jMTZ2cFZSdk9jbk5G?=
 =?utf-8?B?U1VhcjNUSEJhcVFyTVpZQmdycGs1OEduZERBMUVsOUxsUTkvcmdPb1VqdXFX?=
 =?utf-8?B?MWIzNFRWMk5RWW1ETXFKeEtGaUtJenRDTHJ2bUgrZEJDR2p3UDBld0pTcEtn?=
 =?utf-8?B?OGdvTjJDRmxOMzlZOFhqSUVlWVFwbXNGSXhXUmkxNGQrclZ3NXprN2xERUt0?=
 =?utf-8?B?ME5yZGFvdWY0aE9ZWm9YM0wyaEFDQiswOHRtWnBNUHVlamUrMmRxUHJ1anV5?=
 =?utf-8?B?b3lhbW8xUWRQNHNiNElhZnhnbXBZdlJFNmZvS0ErT2ZsN2o4UXMzQ2ZENDZh?=
 =?utf-8?B?a09pRGswZVRSOXFqTWgzb1RMa3pxN0x6ZnJzRE5uVWgzL2p6bnpYUThHaDd0?=
 =?utf-8?B?T1ozK0dDTlg2dEpMUWhoMkxxWWhuSnQ4OWtrQ21vZ1QrZ2x4bGZ6V05xOG5v?=
 =?utf-8?B?dGVrSExEaUNYV1ovMUxJZzIzQ3BsZGJzMDkzeGYzWktmUW5WRGVkcXJsWGxE?=
 =?utf-8?B?T2Jwb3hyY2JQRTNDdHhhMUcyWE04aVk0SXY5aUEzMDlUU2FxWWZWM201ZmNW?=
 =?utf-8?B?UTdIVFlZRFo0T0NDY2JxU1VKNjR5Y1l3Y2dCMklybTN3aUhLbjFQZisyanBO?=
 =?utf-8?B?Nm9kZVFiR1Z5OTBCN1NrVHMrUy9DOUpiVWNyRXhKTXlDcDVjRUZWa2R2d2VY?=
 =?utf-8?Q?m2ANOJKM0Xbw24y0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d54d11-111e-4cd8-11e6-08da4cf0bf99
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 03:56:51.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbU9LRRiIuXJLKKLTcC49XoD+v6XfSGvGPz9KcdIIQVNOtufDdnYX27rhs/KSYWmKVA68O2ta5RDQ+B3fEvrtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5514
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_01:2022-06-09,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=625 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130016
X-Proofpoint-GUID: g3geutz3wgzg7U_h6gN0FBOgeCMx1t7N
X-Proofpoint-ORIG-GUID: g3geutz3wgzg7U_h6gN0FBOgeCMx1t7N
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 13/6/22 1:09 pm, Tejun Heo wrote:
> On Mon, Jun 13, 2022 at 12:55:14PM +1000, Imran Khan wrote:
>> I took below phrases as reference:
>>
>> If the access might be within an RCU read-side critical section on the one hand,
>> or protected by (say) my_lock on the other, use rcu_dereference_check(), for
>> example:
>>
>> p1 = rcu_dereference_check(p->rcu_protected_pointer,
>>                            lockdep_is_held(&my_lock));
>>
>>
>> and
>>
>>
>> If the access might be within an RCU read-side critical section on the one hand,
>> or protected by either my_lock or your_lock on the other, again use
>> rcu_dereference_check(), for example:
>>
>> p1 = rcu_dereference_check(p->rcu_protected_pointer,
>>                            lockdep_is_held(&my_lock) ||
>>                            lockdep_is_held(&your_lock));
> 
> So, both are saying that if a given reference can be under both read
> critical section or a lock which blocks updates, you can use deref_check to
> cover both cases - we're just using the stronger form of derefing even
> though that's not necessary while update side is locked out, which is fine.
> 
> The protected one is different in that it doesn't enforce the load ordering
> which is required for accesses with only RCU read lock. Given that all
> that's required is dependency ordering, I doubt it makes any actual
> difference and it likely is more useful in marking a specific dereference as
> always being with the update side locked.> tl;dr is that you're way over-thinking the rcu deref code. Just make one
> deref accessor which encompasses all three use cases.
> 
> 

Agree. I did over think this and went for the safest interface that I could
think of in each of the use cases. I will remove
kernfs_check_open_node_protected and use kernfs_deref_open_node_protected in its
place as well. This will cover all accesses under kernfs_open_file_mutex.

But we will still need kernfs_deref_open_node for cases where
!list_empty(&of->list) ensures safe access of ->attr.open and where we can't
ensure holding of kernfs_open_file_mutex. So we will need 2 deref accessors.
Right? Just asking this because you mentioned above to come up with one deref
accessor that can be used in all three use cases

Please let me if this sounds okay. I can send updated patch-set with these
changes in place.

Thanks,
-- Imran

