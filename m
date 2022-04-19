Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B550719C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353801AbiDSP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353792AbiDSP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:26:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606C38785
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JFClgX009092;
        Tue, 19 Apr 2022 15:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jKznoZgZ91bnP9mr259O3Y0pYxBlPeVbI6hSBGG/ZPM=;
 b=rCPRk3xS0r+k3JA43034voDqmkwOAd6RJ7FuvkBVnLNkJUlJ+l3bKW/RKlQimx/0UAXv
 etxW71LdFtNDSu1Sf7vDhJdEZdCaPyMfOKCppE2ZgKskyRQZQ8sh3TJsectDBpc3VuA+
 hgJqJ40nxYrzSPXTYMbp6VYxUHHTL5ngbQSvNTRJmT3y16YFHGUuwnzbvbXh4O9kY5GN
 3BbpBCOglfemDVnDxPmBLnl864UQVsnOfjRi9/9taiF+8DIte1dOq7a2bjYG4aJJlnHf
 VeKsXuQuPlgFMvr8k6P3qpBFUKbF9phgj8KsOzdvTtGR00+yt95tLbqkmC1NfKHklSWn Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2pd6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 15:23:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JFAhWY032048;
        Tue, 19 Apr 2022 15:23:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88wsc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 15:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvH6kIY2eziVe+uxDx8vjY3QK9h8F6h3UUxtjEWUjGQxjByg3hfqZL29DGOrhrboIlcmSoS+LsNuUVJPDgi0NWFlTNRMZG6o01FXw6kFcOZ34bEhmMf4OfoT7wH49GFz+mIkVzYk2RGNfasC0bO+cDOoBw3L2LO+dtKWfyhsJQVx9b5f+XhWPL/HTMJIq7NnQROzP63vEz4Z+yuAhaXuxKjMIZhTgBEi59OgUGPOTAcY8cknIX0gwWPgoX4WgX7fh7yScGDXcOmRlzaqQHTBxJ6qxj6tmer8oilJGfGMly7N2+VWI21QKGfFX/wPtMfi6B3K1eoH3Bm9dIbRrXct9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKznoZgZ91bnP9mr259O3Y0pYxBlPeVbI6hSBGG/ZPM=;
 b=aOg8RDr6mTohXFo69qx0DG3er3ZcJduASBd7EVrKfKnTNVzTAtLEFvLJDdg4BvE4+5ahJvSbxrEl0WT7BFMs3fnBOGkOvIWPGxzk3CdXXdIwqxxhgFY0ZAQJHp+Yt7sEfD2kXue83iiK8EUUMEamzyLpmGCuxtwWfDo7Zt1cB8DcXjRE2iU+DMSrkvhfZAblXxM/fEyRg2hh6gAj5n03g+z82xzjpbHu3atMC0k64zepOjriQUkLUeuubuGcaVIgpnFr3oLCNMy8QPBstcTVRerqlHAkOAN5BIMSb4kplXoLnZlcGfkxnoiqz/fMqUjQO+tZVDfUG3YSkZ9h0Dv8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKznoZgZ91bnP9mr259O3Y0pYxBlPeVbI6hSBGG/ZPM=;
 b=gESudFE5rcsg8s5oqSiFoq8ZkV+hgkq+oTtRj5oL3zezMddObWFuQOYutuvhjzxU9pasf+CgrIhDqCRDOepmLGHgvASz+azL0E6aHTSruKzCU/hvOXCvcogeqcUaKBdrz6MKAhKS5lYeQ5vNKI+JJGQRum9XHDFyxXY7TyhNWOI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM6PR10MB3052.namprd10.prod.outlook.com (2603:10b6:5:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 15:23:46 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 15:23:46 +0000
Message-ID: <60e71b2c-d79e-3545-f58d-bcf63bc44331@oracle.com>
Date:   Tue, 19 Apr 2022 10:23:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs: jfs: fix possible NULL pointer dereference in
 dbFree()
Content-Language: en-US
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220411104534.744772-1-r33s3n6@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220411104534.744772-1-r33s3n6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c43f45-e981-4441-083a-08da22189886
X-MS-TrafficTypeDiagnostic: DM6PR10MB3052:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30525662928876491217673D87F29@DM6PR10MB3052.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg196VEJZHuvY+P2o3Axosz/MRYGW0p6y9gmXF7eLkLhJ1VWxRwSAL3hEuTyMPGTxNrM80JhIYE+St+pyj0p/60Kp4TCcQCCvjf82Gznt+pO714cU3Bia3V7ONirjGsBEWh7mwAFztwQ2b/7lVyCTNUXvIDQE5R4Wi8+1tH3PvdAdWGBo9N9+/YNX7G/658TeDD65qhFIvvsZJ3yW1Ba+/xdXgnJIPvqx2sQSrg5434D2VEKDil9NIMlbG0GhsTJQgGUdrmXnPoxg5k6N9ghEFvV8tdScXStNuM4G64TnEBq7veJ5GlrKqDxcF4i0hU7zSAhzrsgkDbtdMBU+VpqH5la03V8h96l2GvfOtW5QPxOUJJ/zkdMKeR8oO5BZr2wCeFQiQpYCIgjMIfq6Mw11pkCMgOjAzXI2IkR4/jUG79FfKEutrzuf0uk3NQ9vwxvT22aSnu1ISE5HAqw3fhzo9w4ImwAcu7hczQuv8hn91hGilX11WiaoacFYz1smox2DKyjtyOfjxi2tf1abV9DdQYuu3mvGreFJRR2gxWAbeQ+aVx42MZpNKiDml0UDKL6TRj73kOdf48CkihjJ89mTAS7FZcE9X/zoWADP/UfFxf7+MTGT3GxpeurttdBfyGqnTqdtVjGRAEFvoKl7x1euvsFsGVohg7NOut1s2nfWuoP2Gr1h5eEMQ7zeirEldR6M0te63g3TKDw7xOk8u3g/hIDK1ClstzTrXhtWqDWb/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(36756003)(2906002)(8936002)(31696002)(31686004)(186003)(316002)(44832011)(6512007)(6916009)(66556008)(38100700002)(6666004)(508600001)(6486002)(2616005)(66476007)(6506007)(8676002)(4326008)(26005)(86362001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lxS3hsamdVNk5rOW1nSjlVOFdWRkdRTm1hSndxYmR6QWNTNjBpcStobkFq?=
 =?utf-8?B?ZWJTSFVwdHp5QmRUdWZXVmw0Vkk1eFRlOGlSN0FyQ1VRM1NVSUp6VHlUNTdj?=
 =?utf-8?B?Q2xWS1ZVQWQvSm1UZ0JDTithUGVBME9Xd3lhL0U0NVEzSnRPL3pPbVVtTE8y?=
 =?utf-8?B?d25tUzdwOXNieWdDd3FvTjl2RmdrSFlsbldIeE1oNnhZR0x3Mko5ZStPb1B0?=
 =?utf-8?B?YkVPVVRuL2k1QTJqT1hVQXFLQU1mRXQ0aHd6Q1RZa0t5OHlESklrYjVMMkNL?=
 =?utf-8?B?enRzN1hycGsrVW15bHQvWUhTNFlQSjJIVHMrbjdXRzdZU3dkazdsejFLdm0z?=
 =?utf-8?B?MDVMVFRaOEJRcExwa3U0WXRCRzlocHpENGlvOGdJajVMblFaNlVVSlRlZXA0?=
 =?utf-8?B?Y0kvbitKUWJkb3hGQlBTVkFNS1l5eUZrUnBLR1RlQ2I4RWp6VWZmd0pNNmdD?=
 =?utf-8?B?MGUxT3VRK2VqZkpiajd3UXpwTlo4UkF1RlJMNHBoeWM3b3VlRmZzbzRsMDRn?=
 =?utf-8?B?d21ZUU5lbWRYL2E1cXZleTJDU1NTZC9xSlZrYm0rOWFsVDVzRUlnQUFFeCtJ?=
 =?utf-8?B?engwdy9GVzBzeFlxcUlNcmpQM29CQ3VOWE5SQUF2b3NrbGpTSlkyenQvODEz?=
 =?utf-8?B?Y3pva1YzM3cwMXZlWExybGdEMGhOaURIaUVzYjY3YmZucnc1M3UrNllGS1Y3?=
 =?utf-8?B?R0daWVRqR2lMWExGM0JDaEF1SHhtMkNTaEFueUlIUTAvYVFHUXhWeFQvQUx0?=
 =?utf-8?B?QncvN2FwZGlQamZaVEMwa3RPU2k0MjF2MVA2c0ZRTUw4Y2lBbW50bUd2WjV2?=
 =?utf-8?B?RGVoZmd0YkhPcHo2aUhpUHN6Z3NPdXRrRHhxT2JoalIzVTI3QktlYloraTBF?=
 =?utf-8?B?bU8zMGp5ZFpTRUF6bnVaQXd5eUhUYTR6aGxSRCtIeUNpOGgxTGk3YmQxSGxD?=
 =?utf-8?B?QXJ5U2dnOHJUV2FTNC9ob25kQk4vTTNST1Y1TXBEaUZMOGxiRU9WV2o5dkky?=
 =?utf-8?B?cjlmdDYzQTN0dW9GSHdTWTg3Y2hOTSt5YXJFUEZFWmlCcXBSN3FaSUVBbCt6?=
 =?utf-8?B?bjdMa05wRDFIb0Jqcmh1TlBIZ3N6c21LM01hb0RPYkMzMmhrZ2haQVpiSmQy?=
 =?utf-8?B?ckVRdzdiT3N6cTIzeDJTK1YwQnRpQjlUZDczcHhRVlhXQ096Z0tLMVduVzFW?=
 =?utf-8?B?TnhkcVhrT0cxNTZsSy9oMDIrRXlVUWNhWEs1eU96ZGFYbGRRcXhaSVdnaXRz?=
 =?utf-8?B?aHAxaHZRWEZOTkw4K0IwNXZVWXUrMHMvYzRHd1VxNlRlYitmQXdVZjRFSEZD?=
 =?utf-8?B?MDVwMzN2VXFpTTllQ3J5VkxhMGQzOGdjWUxMWjFtVkVDaGpVNGFUZDRObTk4?=
 =?utf-8?B?Q1V3TFRBODhjNzYxbEZKTkdnREkvdDZJZXBERFR1eW5vODlQeVdkZjlyWGl3?=
 =?utf-8?B?UUVhaHM5MzhZQVBLVmlRaFdWWEdTUnZWUVUvY3JHSXkyc1JBWktxSFlCK0FS?=
 =?utf-8?B?dFZySGhnU2VacVhFWGdmT28wQnlWVDhzTUd1QmZHYzBRZlVkd2NXRTBCU0Jn?=
 =?utf-8?B?Y0VOR3VxbVhiT2hLaEMvM2J6Q1FUK0tpd0l6ME1wdWRIdU1CL2hITHRNV2ox?=
 =?utf-8?B?S281ZSs0aXdtWkhia0NJaTV2ODY5VW5rWlg5ZUZ3RE9JQVkxRFhFV1NZM1Ni?=
 =?utf-8?B?d1J4cDFVMmhSOGVNamxTNXhhWHUvakF4MjIvMHNLUVBsWm5LeFcydHMrKytl?=
 =?utf-8?B?QmZ3NmFFVC80WVlWNTA1V2RIenF3WHJEcWhBSDVnUTNJRVdUS2ZzeEg0RnBi?=
 =?utf-8?B?ZHc5cVphQXgwcXB3RVE4OTBwaHlVeEpNeEZkUC9naDIwNGc0SkVOSVdHSTU3?=
 =?utf-8?B?UktEQ0JNMHh1T0Z0WjhpT2REd0hWSW5xdkI1dktYNWdlK2FuOWQ2YnJCc2Np?=
 =?utf-8?B?cC9JMFYzTWFpYi9oT3VyNWluOWxLbm50Y0FyMlFManpGQjR4bjc4R1pxUE9P?=
 =?utf-8?B?aFlEZlVwL20va3hRMjhlT2xPdWsyVXB6bVFWSHJQUWdPem5lM2YweXFtTkZa?=
 =?utf-8?B?ODBTSDc3eGNhSFlETkZzazA1MVJwdGNBQVhtQUVJeGFmQTQ5SHN0SEorQzFT?=
 =?utf-8?B?N0N3QXd3ZHlDSEYyWXZMT2srK21qZjJzU0M2Z20yWEJsQno4RjdGci9KN1ll?=
 =?utf-8?B?SnMxYW15ZkZic0Z3VFR4RjFoclNReU1CZ2dTaGFKZ0VDdmVIS0cwWUxoZDBh?=
 =?utf-8?B?dTBBd3ZjTi82bXdhOFJFNHlyWWNFOG9NL3Vhb3A4dE9ZTko0emlrQzZ3ODFM?=
 =?utf-8?B?YjJwR2w1VHo0LzgzekNXajI5REM3MXY5Nkw0V29GT1N0aUx5aW1CcWI0NGNH?=
 =?utf-8?Q?uNZgCUv7I1+ddBE0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c43f45-e981-4441-083a-08da22189886
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 15:23:46.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7xd32DJF8t/7bzW7isBjoylLau0X8OfSnd2/n+hsaJEiEwEPYfgul3/8jCFIEqIdaclWUQ065sAJdZjR3+2xUYFKN9RiEBsd7PSxkR7XiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3052
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_05:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=896 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190087
X-Proofpoint-GUID: WONDJQUi9m_vywzuPvcuC1khAvxuDChc
X-Proofpoint-ORIG-GUID: WONDJQUi9m_vywzuPvcuC1khAvxuDChc
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix! It's in the queue.

Shaggy

On 4/11/22 5:45AM, Zixuan Fu wrote:
> In our fault-injection testing, the variable "nblocks" in dbFree() can be
> zero when kmalloc_array() fails in dtSearch(). In this case, the variable
>   "mp" in dbFree() would be NULL and then it is dereferenced in
> "write_metapage(mp)".
> 
> The failure log is listed as follows:
> 
> [   13.824137] BUG: kernel NULL pointer dereference, address: 0000000000000020
> ...
> [   13.827416] RIP: 0010:dbFree+0x5f7/0x910 [jfs]
> [   13.834341] Call Trace:
> [   13.834540]  <TASK>
> [   13.834713]  txFreeMap+0x7b4/0xb10 [jfs]
> [   13.835038]  txUpdateMap+0x311/0x650 [jfs]
> [   13.835375]  jfs_lazycommit+0x5f2/0xc70 [jfs]
> [   13.835726]  ? sched_dynamic_update+0x1b0/0x1b0
> [   13.836092]  kthread+0x3c2/0x4a0
> [   13.836355]  ? txLockFree+0x160/0x160 [jfs]
> [   13.836763]  ? kthread_unuse_mm+0x160/0x160
> [   13.837106]  ret_from_fork+0x1f/0x30
> [   13.837402]  </TASK>
> ...
> 
> This patch adds a NULL check of "mp" before "write_metapage(mp)" is called.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index d8502f4989d9..e75f31b81d63 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -385,7 +385,8 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
>   	}
>   
>   	/* write the last buffer. */
> -	write_metapage(mp);
> +	if (mp)
> +		write_metapage(mp);
>   
>   	IREAD_UNLOCK(ipbmap);
>   
