Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16982520150
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiEIPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiEIPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:46:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3C42A24
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:42:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249Emrhl011683;
        Mon, 9 May 2022 15:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zVDW5mNvmiXss3aBH/exmfmaYxUe3y+7GUrP/ax0Etc=;
 b=jPoourL4+QiESyEaXiD8kYWYEvGBJdZybA9jK4Dabd1wt6ms5l1kt1m2RqGRUGmRoKMX
 MjKTGV+w54P9/PsR297niHt5+5ghjJAhDXBnzCBe1e7+YwhCvK7MUhb4o1ZGt3lZ9fKp
 iBVqY8M4WkL8iVbsgaVh+iKJkl+l4JbAJAB43k5OUVEnaojUsX5Y0Z7cIz8cts4D9DnX
 W9/ikDikWy/YI6qfWNPl6Xwz3B0i5BB/m4lRpD0CXfWEwD4vbhTeL7LvX7UzFmK5VSmK
 B/SafqVi2FD6xOCd9CfrEmSx6EUdX+uyUCx6UFif5LfxrAj6AhUQVlZLJcLyEMBLfywq tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsm3y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:41:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249FaBXV004826;
        Mon, 9 May 2022 15:41:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf71r9e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhZUR0Dzen39k2a0RzBX4Nwg7KST6TyiurKvgMeSfCfJWLdCbdLL9AUN5RXbQFoZRVJug5TLpyQsBEq1HWmVsRUSAAK/4lvRhCLb08lrikxU2tOcNebi6PiULV3YRK22pwpWAcA6UWqVQz7dgurqDKRsnEqTk852yy80U0fTw8Yg8l9pDFo5RParWNeGiVnujTA4ydv1olhvzzWp42e7/WSbbeijlY6DQMj32EN9emJtfsZPQGWhYhiwXs3JkqHvb9OKFSy+JL8qvsZswmKjbQZM/Q/udYYvDTw3bVhg1sY0xoHHTKCjyBGiHkXvSjPFFmBxqKKUg9EW8xQdL1QHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVDW5mNvmiXss3aBH/exmfmaYxUe3y+7GUrP/ax0Etc=;
 b=JJaGvQ7V1rZpUQXUI4FCDviJmfo5KRseJzjqzOcCBss2C0zIQcroHNbSxZn/5X9VqtSm4wvdJogWuEIVLHZnsyqnU9leGNpvKSgpm7qkz4wr6iG+r8aNSAYt/sKbVr9S372Cy6UMydK80MxYrcGLwyMFXTeda6jpPljI+2t3wkcAUSYeqXSktV00iAXSy989pPCGlE6LuoqhZTlO25sDc9wI+9EfyX3I3V6hUNh/pcqgGpO4GNKcS2K8/BK6FNhysGclRY28w4KN4cZG2782Eoz7qPViCCwXPLHadWdOXynZwbgqajT++Wip/xhP2LmxMTqaUguBrfjboAS6lh6teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVDW5mNvmiXss3aBH/exmfmaYxUe3y+7GUrP/ax0Etc=;
 b=imgdmSRLCGeUu2hH70Pbe/f8Q+lGlSOn61cONnASjoD5DQVOx2iA7Tg94FNHaiP7swxSpJnAkzsaxZgq3uZXmy8oWwggpCsMIhn0ybcQ2jVn4FI6rFQ6ShnjOmWK/erufDGrMFwrmwLbUM3XfezdPgdHZ7lc+L+KGUMhSkkr1eQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN7PR10MB2547.namprd10.prod.outlook.com (2603:10b6:406:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 15:41:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:41:20 +0000
Message-ID: <9174fbce-6160-ef5c-15cd-2a62502f21da@oracle.com>
Date:   Mon, 9 May 2022 10:41:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 1/7] x86/crash: fix minor typo/bug in debug message
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-2-eric.devolder@oracle.com>
 <72764a3c-8b8c-8652-945e-9b15f31cda15@linux.ibm.com>
 <YnimI5cZWXKeNSHY@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YnimI5cZWXKeNSHY@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a05c54-1e8c-47d3-3461-08da31d25cf2
X-MS-TrafficTypeDiagnostic: BN7PR10MB2547:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB254796E89F9C70DF5935D24A97C69@BN7PR10MB2547.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auuXKFV97BlbN5YuwvCz83tufaxp25aGAa8KPpBFEnCs0H13+pb/fvXepJ1xUQ+9OXKdQZS7Lr0P479ZrQekktTozkoDYb2o9gA4Ui/FO390nV2iXjmwKjg+yhCtpo/z/mqwSf0AU2j1B/GuSA5hyraf1eqJR/osKzPMPa3SLI0cm4pLJRUx5XZluU8ONdIJ8oUA7VPd6Il8A2HeqJeIasIKQ7LqfhjSYqH9rq0h3H8ClwmxF7AXSMauQp7fD6RlrJF84y+bRWiTuI07UApmnCB/iTaG0McvO0PCDw3fe/YPgnSvkzuKuzVgL73Xv8DfQ2BxGTvWzZCYeOJV3nx+izQA/O1+OziuEerY+2JIPHS7FcmpfJwgZc7u5nJVlu77XaXWlV27YpCbZsOBV5BTtbOKrQcejrPnk/1Kv/Fn2CmF7Ckmu7JYbJLmAMi0TzMmKQe6O4z/qcnQXrWja8hMEY9wYVniX+600oEBE7eIc44fQSNEPDTj9tuAIA2dbFk9psuCN+uJoVq6bCbaQxPQjy1QAQotHvTPgqzfLZ543PNV0TjaUZ2qGtBVwTCxjrPpEjHiXHhoUuNrjV4cVF4sz0hGbVU4PpAHiOIkav0uNasidq15PK2bNHYrx9/XTm7zzySpMV+Y8y2DsUqFfvpDQ+G6StEbgWWXboeQE2bSSoQC21NSVMbhLWwqp/3ftaLNj6HJKSEX+T5yXntCg3dvdbVcXpKQs7kHH9hh3x0GyRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(110136005)(316002)(38100700002)(86362001)(31686004)(4326008)(31696002)(8676002)(66946007)(6512007)(53546011)(83380400001)(6506007)(6666004)(5660300002)(66476007)(7416002)(186003)(36756003)(2616005)(107886003)(2906002)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtZZ0IzYUs5SFg5MitLUmErVHZuOUpoclRBcGV0VmZVSXJmYTc1ZGQxV0Jv?=
 =?utf-8?B?NXRFRVM4TXhJZFNoTTlyQ2N1WDVzRmcyRGxSNFpXdjJtdktsLzZxK2pnZ0xH?=
 =?utf-8?B?dnM5OE5xSHBWVDY2OHltMXl4N25lTlNDV0RnaUR2TVpxWVppVzV3a2gzUHUy?=
 =?utf-8?B?d2RpU3pZSnJ4Tm1Cc05QT0hXT1JsV3dGbmhja1dCZ1pWTEd2c1BVRDZHWkNK?=
 =?utf-8?B?Z1VNQWJFSGMrOW9CVXNXcEJyVVl5alJhMFNWL3kwRSt2d0VIVG1oRWtqTHhu?=
 =?utf-8?B?NE41Z0ZYeTc2K0VRQWtXYXpEbjJVK3Q4dmtjUGlpMUJRQS9XTEtsN0ZHVDh6?=
 =?utf-8?B?RE1RdVhaSG9BcWEzd0FtcTVZK0kxVUU0bmcrSE1IR0w2ZDFCTE5mOWM3QzRQ?=
 =?utf-8?B?SnYveFhsUm5NL0lXMVEvekVMRU5HenE4VnZLQzl5dzgxTnVQOWVUZXlIbDdE?=
 =?utf-8?B?ejBUbGMwekJvcEozWE9VaFBaL3VNMXJqV3BEc2NIcFpRWk1wUUUyVGhyT3VG?=
 =?utf-8?B?MjJQUXFsN2RJZjhPMFU2L0RzVXpxMXNsT0MzR2VrZysxbkh2Q3ZaK0Y3Tzgr?=
 =?utf-8?B?dXNQNVJkRThMVmN2dHdJU0dXcUQ2VXVPdEtmYi91V2JDcU9Va29oY1BhMnRG?=
 =?utf-8?B?d0wyY1VJMEQ5T1MxUjVkcENvL2Z0OVRpRkJLQmRBaFFuWmVFU1RMRnJNQXZy?=
 =?utf-8?B?cTZTenN0YUtGaGJ0OEFmYTJqZHRSc2F0UEl3NTE4RThVZzVQS3hHQkR6eXN6?=
 =?utf-8?B?OFBCNE5ZN091cnY1Q0JKTGQxTHduUHQycmhDK2h4b0kxeEh2VTlZVzNac1FQ?=
 =?utf-8?B?SWhLeU9YSTZVQThzMTdmMlZMSzhsOUxOaDZTbythcTNGZmkyZlhJeWh1eXkw?=
 =?utf-8?B?UFJacWU4YWlGanYvSFphV0lybm1ZNE9hbnlZVVl2VTlibExqSW1YSFZkWWlO?=
 =?utf-8?B?OXdHVmZaQkJxMHA3Ny84WTc3V1NtTEVQVDZVU2JmaTdXRHhDZ3FZNm50cGs3?=
 =?utf-8?B?aVBLTk5MaTAwbnFEMzJDQ3VSUkJUcy9mNjdIOEJyM2ZnWWpXdW00Q3k1ZGUr?=
 =?utf-8?B?VWM4dmNFZCtQVnk5TTVrTEV5UEVsT29odDQ4L3N6UnhvTXRLNGREZG1rMCtp?=
 =?utf-8?B?NGVsYUV4YU1RUTZXUVdaUVNGYnVVelgyVjkyMlQ5dTYyekxUcDlXdG1oV1lE?=
 =?utf-8?B?SFJSamxlWWxJNy94d1UyT21XM21sS3ZCY1lGTi9UOE1EN0trQXZsbUhkNEVT?=
 =?utf-8?B?TXhGMjNpVklnV1l2UWp1YUx3UWF1V0lTaHhHSEkzOFM3K0Mxc21HTThRbjI5?=
 =?utf-8?B?M0xOTHkxdE44VVd1YStmZnoxbHBVSEo4UWhnQ0JwaUpVMGpsSTd6TkwrV1Fa?=
 =?utf-8?B?aUduTS9qYVBBSHh5czRaV0NzaFRidjF5STNmZjUxUXZWdzQzVGlhbmpma3ZD?=
 =?utf-8?B?aXNvRzdabHFGaXFsYUlVUGhuQ2pNWlh6QnpjU2VHRldZV2k5ZHJYVzVqMTdi?=
 =?utf-8?B?aTFPRnlRRmVRRUFaaGZtb043WUhMRGQvai9HQXFOdFBRc1RWL0NTREJzVmEz?=
 =?utf-8?B?TVZXZStnaGpoMVhaNzVFakIwMmd0VnRrUWJ5TFh1ejI3UWNNYXlhNGkvcnQr?=
 =?utf-8?B?OS9QYTdUeGdhV1dOa2xHWHRYTit5YzVxUkw2U2tqWmwvZ0E1SDJTaEJRRVJC?=
 =?utf-8?B?T2FpVy9lOHQyZXF4c2kzRU4zeWgxU0VtZDBvbWx0VWpTbXJwVEI2ZGdKcVk0?=
 =?utf-8?B?Skg0NTdqelJWWjBFNkh1WW9meDlFWTNMTEt5aENjeUYwQm03dVEyVlpwcVJj?=
 =?utf-8?B?NjhZU0xEUTJwQmJCQUYwdlJxdEplTWNlQlJGbzhMd1JxRU1Yd3ZFV0o4M0hJ?=
 =?utf-8?B?L1ZuYTZ3WlNabWU0TmI2Z3FPeXNocld1K003WVYxNjQ0YkRFYnNxVkpQSlNF?=
 =?utf-8?B?Y2RsWmpmRUlCcHdPR3hzeDQ2bTV4UHJuU21OcmJVN0JybXVZUklUYVdzMWFy?=
 =?utf-8?B?ZGxkZFE0ZE5lVVp6aUVWVE5wZnBxRWlmd3FRRy9IY3g1ek8xNHhvZHZtS2Q5?=
 =?utf-8?B?M2VJdmdycVkvWGZjZDAvQys0YVdvTnFQM1h0dUM4NXpjaEdXVzVEdi9adDRZ?=
 =?utf-8?B?MXd4SjQvY3h4ZnJzWEV4aVFTQ1RRalFLZXoxL0Q5cnpReWEyd1NySHAyRENz?=
 =?utf-8?B?VG8vVE1vYkNoZDVUSkFsM2FlNitEVnQ4TGM4R1k5UDN0Vm0rYzZBbXhEbjJl?=
 =?utf-8?B?OEZHSWx5bmVZQUNLdjBXYjRRdTZBbHUxTVREOVVLdU1iNDVHRUVxWmFNajhZ?=
 =?utf-8?B?SEVNbTNCTEZ2VW1kUGV0aWNQSzlzUGJWWEZhWE9wM1dlU1J4TVFpMS9XVDZV?=
 =?utf-8?Q?suTNqdTJOlvRcpA7B22jeFt/5Zb6YgxwKBTiB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a05c54-1e8c-47d3-3461-08da31d25cf2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:41:20.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKNm1ru26bk6T4saR2X73DIFi9AuU7+m26awZNPOy9cH7CDu6YuEB+ZVSIm5SCuaZWWOBDYEy7YDj7u0l9k6Qa1IWqGNJoLCnAuI0NdSnl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_04:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090088
X-Proofpoint-GUID: wU76QqkmCIYkcvCt6Pj5eMTy2St3tXwW
X-Proofpoint-ORIG-GUID: wU76QqkmCIYkcvCt6Pj5eMTy2St3tXwW
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/22 00:26, Baoquan He wrote:
> On 05/09/22 at 10:46am, Sourabh Jain wrote:
>>
>> On 06/05/22 00:15, Eric DeVolder wrote:
>>> The pr_debug() intends to display the memsz member, but the
>>> parameter is actually the bufsz member (which is already
>>> displayed). Correct this to display memsz value.
>>>
>>> Signed-off-by: Eric DeVolder<eric.devolder@oracle.com>
>>> Reviewed-by: David Hildenbrand<david@redhat.com>
>>> Acked-by: Baoquan He<bhe@redhat.com>
>>> ---
>>>    arch/x86/kernel/crash.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index e8326a8d1c5d..9730c88530fc 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
>>>    	}
>>>    	image->elf_load_addr = kbuf.mem;
>>>    	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>> -		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
>>> +		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>>>
>> I think we can push this patch separately.
> 
> Boris has taken this into tip/x86/kdump.
> 
Excellent, I'll remove this patch going forward.
Eric
