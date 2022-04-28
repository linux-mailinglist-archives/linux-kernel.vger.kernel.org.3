Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7047513AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiD1Rbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiD1Rbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:31:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645D4D62E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:28:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SFb43S003733;
        Thu, 28 Apr 2022 17:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XalejWd/TpYK3hMBPtOuBEHexHpvgC/cob49MJuDxhI=;
 b=vFvlZ91HRX47BsSd43G+pfRCCOI6nAF6Q3Ko+P9ctmVb0NjjYbNEWS5Kwd4P2v0d4oKe
 iFUbF4/b5HmNUm2SM83yGN2VIMXYh024nkTUslN48aKJgr2WCUp0wE7QwyaDrDjxy7gJ
 51gG8zfxsf05SgT5QuAbOqr90HgYb6qgOjXrWlJ0v1T4dolwbyAJEjpF3nLrzHvZMeMt
 w82/j4QpU6oi0jBABTXCyKpvz563m6tNGbDMT3oKvPlPqZYAjAvwemLwpr1eCPu+qgmM
 lHi4oIwrUijokj50nQD7UMYBtB3zJpuYHfBRHLIP7zzU6rsNAlY8LszWu01r1ChAdw4F rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4v9uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 17:28:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SHHVLF022878;
        Thu, 28 Apr 2022 17:28:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yp593r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 17:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqWmjuC5yxlI+ieAg3YzT9TVJ6w2EonHrmdI5hAG4TMNjHj9Zk3IHerRHlI/Qe96+uKL/EmeZlzwCrJxRNVsokHvrwGjBuCBoZyCsLUnJMkTSNvbF6Sh3w3FJFTi3ls6RiT8QPTsIS/PwyV2nyAtrozcG5SVtrBLGBcvYkenW30fVZzdFOAovDUkbyn4QsiQfUZOMhyXVUtPLQ4B5zMk8rophsSQMfrZg5s/vlDwU0154UePUzy3PNW98m5cJPhiKxj90qvtK60HcWwazrR9YJr7hmhFsMCpvYGa7D9QlgS1EaaJy9jAi3PPjPdCqFzs668UdNxYjc0BqdIH6Fn87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XalejWd/TpYK3hMBPtOuBEHexHpvgC/cob49MJuDxhI=;
 b=lmEPP8Rlr5P+zxLgawkU4rb0g7i+H44EvMRYXrEppxoTT58H4+2+dxAedfcnZ0Q2b72mrGsBXI8ZTKt+fmv85aHW1Q90IOSp+im8DBAYCptPKqA+nhIlRlqBlOWjStCkNlV21HclKKNaOBwtJJ3KmJ0HxV/FtjDZ9Zqm1hAcw1Y1dtnZbCabfLcH8vBN68h5jCZLrpUqcZ5O1MUyRuo0jzdTs0BQQRHmq1YcgG4/b/DZZFtzVTohYSOyNzRqjalYaGe8BvbLRmo/irjLYrEKsHJ0scd3paquhdsqEuZSQiZgnzcd3SPS87T3uN2BhK4w/Vpnzu8EefNApsU53uOdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XalejWd/TpYK3hMBPtOuBEHexHpvgC/cob49MJuDxhI=;
 b=VquUCEp1VAXoWaQMjzUdemqKine5UniszegyX95fG7ZbFqkIlaKcYNExFoX2jtK92N8PTUbqFqS5fkcW2Ts7utp8xPck4Emj4r9Mx6gx4aNrh8ug9LNtF5C1XeoLUaGktiANPfWsZiXMtAbDaAoO+N1xp6eQxy3E49sU13SHDAA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 17:28:11 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 17:28:11 +0000
Message-ID: <4d0d58f6-50e4-45ad-888a-59bd8b34ad15@oracle.com>
Date:   Fri, 29 Apr 2022 03:28:03 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v8 00/10] kernfs: Remove reference counting for
 kernfs_open_node.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <YmLfxHcekrr89IFl@slm.duckdns.org>
 <f2ca9d19-023f-76d9-5c76-6f08ccfbe348@oracle.com>
 <YmbYsI0wkH01u5M5@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YmbYsI0wkH01u5M5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:610:50::25) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0014aeae-556b-4d6b-a65a-08da293c77aa
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4035ED5553D9B4C07DC273A6B0FD9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iNW6W6yLyBHUBrJwjRE1vEYv/RzrNqfTwd1hagbjbl35IdM424h3uyN537L8Yv6BIYC5VTF10CtwDnzuwSWBT70Cn2eMRdUhxqKWOBTtJX/WcVGmG0QwaOVNgSGV/+KaeoGce4hwwp5jwyM4uy2zaeo7QFnpw04wJnvL1MEA0PUZ2L59mYTYIXEYTE7dBKNlKAxm4wh+rH6AAbc5RAfV1Zoz7Ft9zfhM8WM/WP1O4XSSv28CuvHkLJrHD0ic988GnOGsaB92Ae+v7icpULUBYsxsUJkeWBed/o9/R1UkzZb+ZYvvy4HHzQymJi3TDgeEsyDhWCrlOPfMFZQGbwWGl8hhrA5Ij0SWgT12/FRQGoFjaPjYZDZ87lJj5yA+oV9BJqj9lhs+lBEr09sfPTnDEa3JZX9IPLJ0M9TQMveNnb2UWDbTXeSEJzFypaYo3cWFTO+abAx7h3ayjJXtl9oXQA4oEyT3doZDNWSpuD8ng/1I+gg003uyEon8wBZRo2TFGM8xiGw3EhF4tm17zD/LsnONuAQJ/jO/FfMVMnnAk85Nn+OF6gMnTnSzxZQXQ4XIQjtOqMyEdSD37Imubq9JkE7VrehdZdxJHPqJ2BOL8JZIn5do+JC5dd3jYIsHNblLlLx1QsHpgfZamFSIgh21AVVT537NsahRHqijxxG9Womv9CLFRaXhydCVViYGLN1ARzaSHbytfHUrINw+Gmb5iAAbiBZFYe4OgCwtKgD1FgBV1nzRxzPZg7YLvaXmQ0lqI2tBQ0QaVyRtATYjawA1yylwb3wMjWIEHf8Rjjiw7/b700sq9YNulzW7oXQz6lZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6486002)(2906002)(6916009)(83380400001)(36756003)(966005)(316002)(8676002)(66476007)(508600001)(66556008)(4326008)(66946007)(2616005)(26005)(186003)(31696002)(86362001)(6666004)(38100700002)(53546011)(5660300002)(6512007)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5zcVlRNzdIQlJZOFUzYStYaVM2dUZneFk0bzJWNy9HcVpYNW03aG51Mm9U?=
 =?utf-8?B?SFJqVXd5eU1SRW5aWC9sZHNGRll4b1J0U0pzSUUwYU9nNDRDNWNiRGtYWFRS?=
 =?utf-8?B?OEdMQy9kaFdCQWRQYjF1Rm9lZWFnOENkcWxxeVNKTlcxV0QyREcxKzIvZ0Jh?=
 =?utf-8?B?dVN3U0dhajZKUHNzeVFsb05RaVczN21lSDNBWHViUlRKL3VUdEJLcmpKQmVx?=
 =?utf-8?B?RWNBdGZYUVNqMnZkU3pvcnRNUVFVWFNpVk5kMFVsaEVoc1FDb0pueWJUUUNZ?=
 =?utf-8?B?VkJLQTdYc2w3UGpib21LK1VFUjZ4VEN0ZURLWnNDMUppcWExQU5uRTErc1BD?=
 =?utf-8?B?SVRQYW9lMkc5OGdZN1hoUE1SdGVmU0sraEcyUEoxdCtLWXRMMHVwc0dDZGsy?=
 =?utf-8?B?WmpGYnVhL1BJd3lWVEJUM1hZM1BuRWloNTRJOTZ0ZG5HVVI3cHZrNzM1bW9P?=
 =?utf-8?B?bE9LWTZ3Q3p0QnZyUjNCUVBQMW9iblE1N0Vsbm15V08vVzArSTlNbTg1dlNw?=
 =?utf-8?B?c1BwSnV1WTdjZmdocVM2amJDbHYyWjVvM2dXZDhjQjQ1cWh5REpvMkF6b2h2?=
 =?utf-8?B?aHpHQzZyTTVTbHg1bzAvbDBpRk5yYmdnSUJWZ0JVT245QStRcUsrWncrbVZ0?=
 =?utf-8?B?bUNwRmJPaDFleWxBK2hkK2gxZUc1YXM3aVRWNDB1OHIvY1FqN0ppK0EzN3g1?=
 =?utf-8?B?eUxqNTBJYmwwRTBYVTVlZ0ZWcnhsWUZHQmZ5S2VWdzhkbnhsVFpOdm0wZUpC?=
 =?utf-8?B?SDcxbzJGbGpSK2JQTWxVeUNhMTRqMlJJR01GV0hhRXpXdEtUbnRMVGovM3A4?=
 =?utf-8?B?Z1lBc0kxUC9UREFsZlRkV2xrSGVEaGZaMTNZL0xhOHJocUZFWU1pN3R6YnNQ?=
 =?utf-8?B?YnVWWTdGN2pXQTJWL2VIT2pYN2dTbUJ0alhSYUwzNGVVaGJKcDBUbkF3Zlpz?=
 =?utf-8?B?QlFIV2hLZ2VVTCtGa2JsZjBrVDR3Tm5zaWVEUmtsdG9Wb3lSSEh3NWxXWFVI?=
 =?utf-8?B?dXF1NG9YQ011YjEzQlhRTVN6UXBQZ1NhaGdkTVAwTXpFR1R1cGpndVRXdHBJ?=
 =?utf-8?B?aHZ4cjB5WHlWYTlMdVR4d2UxdlZsR2NPcWRkTVBTVHlwemVkb2kxQ1dYd0ZT?=
 =?utf-8?B?akY3USs2ZktMMnorWFhHVVNtaVBOVnFpcWhTNXVGOXJtelVNR1pPWlltQzNE?=
 =?utf-8?B?RGc4b3UxTDBNWDNIMjJHVDc0Q1FlWXV1Q0NWMkNRanlGcUl4SllZYU0xN3Bn?=
 =?utf-8?B?bHIyQXRGN2kxNmlEYi9iNkRBU2kxOG9Namt5eU9SSVhZQXBrUEdYaTVmV1Iv?=
 =?utf-8?B?RkNnNEN1RDZUd1VCNDZzM3NwdFFtOWZ3UGVxSnE1N0RCU2piTVpPZVQyZU4z?=
 =?utf-8?B?QzBGWDk3cnpWdm9aRG1kNkd3NmdESnByWWR0ZG5xM0pWcG5MQzlFandzd0x5?=
 =?utf-8?B?eUlHWTNINHBCNDd0NU82Zy9UTTBLSFBWZUUxK29nNDNuQ1J2c3Y1dG0wTnd1?=
 =?utf-8?B?WHZTRk5Za0s1MkhxZTUxVFZZT3hkcTMvWlF5U004ZlZ3YjVQczNNYnZubUI4?=
 =?utf-8?B?Mnd3b0ZLUk1wVkZzNDMyRWNIQU92Uytac29Ecm5oWmN0QjNKbkhZUU4rS1ZR?=
 =?utf-8?B?YXA4clFUVldneHR4dHQ5cDE0RGQ5dlJjcS9VWFhWUHhGU0FSKytBQ3ZwWUQ0?=
 =?utf-8?B?RWQ4ZjBXdGRTWjQyMlVBNXRaTE45Sjd0VmM4ZTFCa2xXclR4cWZNNUhzL1JV?=
 =?utf-8?B?OVZnZkhIdUFPczM4SHZNREtPbmJkNU5Bdm1kS3QrenJzSFh3Sko5K1BkTVVL?=
 =?utf-8?B?U2lmMDd3czBsZVV1R0hBemJUYVI5SXFGdG9lL00xck43OUxZSzZpbDQxVXB4?=
 =?utf-8?B?WnNhbERHRHpYblNyTzVIV1RGR2gvaXNPMG5lM0h0Nm9CWCtOZmg0Vjh0dWU0?=
 =?utf-8?B?Z043bVlYZXVFTC91M2RVNFFZcnJNLzBWRHlOWktrY3hvbFByUUw4UkFuSzlk?=
 =?utf-8?B?L3lTa3pyb3dxMXJWbkFHS01FUzkrdHZkd2lHWlhjYkFKLytHOEU5S2lQU1I5?=
 =?utf-8?B?MmpSVm5vT2pqdXQwaHVYQVRNQUFHUHdPd2pZSk5XUG9yL1ptT29naWtpdjY3?=
 =?utf-8?B?aG5Rd2RCM0E3MVVLdTRVOE1GZlJMVUlQZnBLQzFOT3ZFOFVWTDk4U1pDUnVT?=
 =?utf-8?B?UG1JakJFOUNxVlU5NTJ3cGpSeUlnKzE5ZXpGK2FPdFYrdHlZNzViZEVHMkdH?=
 =?utf-8?B?YkdwUkRkMDRjQkJSOXlGTkVNMS9EU0RrZCtodjEwa1FtSy8zVUpzVlErNS84?=
 =?utf-8?B?UmIrczVTSjcreG84aHVUVVNFejlCb0VEbDl6cDlFZnhsVFdvUE5GeklvWkd6?=
 =?utf-8?Q?N8sZJj7EhlDLKeGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0014aeae-556b-4d6b-a65a-08da293c77aa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 17:28:11.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ7skCZ6vajDY7Xqn/3fpY4xZLeJLncTGoA06IvkT20N5nJMG1jQfKbNgBXcEzuNja22tAEl5iegUs54TnGRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280104
X-Proofpoint-ORIG-GUID: M2U0MM0BllkhR4Oq1YQZL-u1ZPDh1r9X
X-Proofpoint-GUID: M2U0MM0BllkhR4Oq1YQZL-u1ZPDh1r9X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 26/4/22 3:21 am, Tejun Heo wrote:
> Hello,
> 
> On Sat, Apr 23, 2022 at 06:49:49PM +1000, Imran Khan wrote:
>> Thanks again for reviewing this and I agree with your suggestion. So far
>> most of the concerns have been around usage of kernfs_rwsem and those
>> can be addressed independent of first 5 (even first 7 )changes here.
>> Just one question in this regard, should I send the new patch set
>> (addressing open_file_mutex and list conversion) as a separate patch set
>> or should I sent it as v9 of ongoing change set. I guess first option is
>> better but thought of confirming once before proceeding.
> 
> Either way is okay but I like the first one too. Let's break it up to
> smaller pieces so that we can make progress piece by piece.
> 

I have sent first 5 patches after addressing your review comments. This
patch set can be seen at [1].

Could you please have a look and let me know if it looks okay.

Thanks
 -- Imran

[1]:
https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
