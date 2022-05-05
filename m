Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7751CC89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386617AbiEEXQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiEEXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:16:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF15DD0C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:12:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245LJC26004338;
        Thu, 5 May 2022 23:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MtlT9bbPQcf+Te63lUZBd33TiuAjANxoaIJBqJ97Y7k=;
 b=obdLpVU+iYpuc6kycIMtBsXFUDFqlP5MkCt7mmAVv0WeZP+VMhi1jGNiN0fqvAovc6+K
 UmOKTMZK6oSA4iYov5Fsz8SQiprTbSpjd4DY0yCKGhbGpmgpRGEQatX1lJ7ssZuDB6mX
 P+HWen4Bjod+XqUjo7eBJdKiQ/TjALQdh7fOMrnPEQ4xVocl9JoeX/FrQhGgktxQBuee
 1+A62rBGdc7RP3VnonCNmg1iSh+VmNwLlkPF8QfU0TKywm5G6ZivixlFRHDaO5Fks9Mo
 27VWw/34MGIy74XvYRNLC2x5RosjJz5KXmoJF71t5rYeeDYeOmI92zSmUi80zirDxHoi Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0mtdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 23:12:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245NBcpD010748;
        Thu, 5 May 2022 23:12:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusahc7nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 23:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFIOsBcdG4QBzeqm1JZsac5+Klnc7hC4KMRY30OTO7XJMxvtOmMEJyEtrM9jk63yX4TDurDCtoLQxMFnL+LxnR1suWSDvCLqkRdZ4L6/EQrt1BNIZAsYaYv22riSPYPVRXtxwCBTJCOQPZ/s79oQP9L0482OfJfEvgxO2kb3FuZt/LLGbse/RSf2KxVNzwlAkG32EXRXFBUNfPV5QxGbgY7/xhaJzhtnaOpvCYuyn3dYsplMHA/c+dEQPO/yEb4gZF2nN9vG78ClZaUVfKeWDPbXL4dYZiGKdYjmB2ARNDyXKwoYl3ec5eWvz/Ioav7xzShRZoFh6Ivg9HiS8KMjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtlT9bbPQcf+Te63lUZBd33TiuAjANxoaIJBqJ97Y7k=;
 b=j7fMYEd0D64r2kYCBGheIUlg5Iz0JtEFYXUMeW/Nl9Ktco6R981a1VEwqTSZgITeN26dR5pLW8fcGgeVthtz83JaNzxML3v9ZFklgSfYcGQJdeUZI9z2/pF+NxNTb1EIvSorE7ZgEF15SlWiBJrWBCssrihbyGrJmDQ4yZH0rVMBBHJ6XUCTyzQ50YhLEjWWmXIZZeTeHujmAVTQLa5lc5XM/ONawQTpYwebAWvyM9XoHC4Ht5lsM+5lsYem03k9PN28EpX6DaTAvoHXGVpAhR+PZ20LHUTmWjCVm2X9McK/RVjgKVAnm9EKtkAOlaE13xWCYxUaPY8jniEgY1Yy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtlT9bbPQcf+Te63lUZBd33TiuAjANxoaIJBqJ97Y7k=;
 b=sEBBhkiuMcUz0fNgqoKE3vMaMUgZRN6VBdLVOmp8qwFgEsVh4BdqSZKy/NpFHT1miCek02dAYX7fkpG2yAtpPLS8rZK6jJayJ4Q6j5NZZ/aqrO00UKdX/1eUBurzvM+1Qt5kSigxvHOTmidyeB7SCzCHm878Y6CavTyfNJSKCZU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 23:12:31 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 23:12:31 +0000
Message-ID: <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
Date:   Fri, 6 May 2022 09:12:23 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YnQtL7+GYHwpo4n2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:10:3::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0190565c-2f00-475b-9175-08da2eecbafb
X-MS-TrafficTypeDiagnostic: BLAPR10MB5060:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5060B6342A620BF5CCDC075AB0C29@BLAPR10MB5060.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miAlwCyjE3dDOjqPM0HDEyZmrsdsEUwUbMpUXose6qKokDcqbiSpTQNbLO4SIUwOSSqY89FEb2JUXGQnylIo7If6Dx/dO7Upll2RBjmgB8TZb7qKGaJ3P2BPmd5j3nmFK+r5JtYnmD1+rsTlM7hNd0k7qk3sgzUKjPJsThJDvRV12MqJahuqwNjaRMpBpTkxctKitIOcR8QIfvpev43+u/yyGZrMSdeEybpZaVBPpOGn+rAcRuoaKi2fOyIa7HermpjDKqGJVdP1AopaoKudvbnr57gcuwkzxC76OYWilqk//PVZRTaLVHnc7POByJ/2Phc6mCws/yYTQ66KUakHo6KtjWiahAHKDwXSxe/TE83Ef5h1tB/sL+ChN2yVYa3LDA8/MnxUTwaPgOGheFhs1AWryFS4I+G92hLAKSGyaVJhOVxm+RbWrveHH4WmweXkGSKJqR1gl1pfir8103hNBg9tCsVahexHnuART2XqbfGRIQVHEpZc8mBGAnrLc9eVBX7fpmiBSHFJAhzDh/D0eLghnCWtKtJ0f/eDWbj9u4JOK3DxW1bgJSZAG2kCgUE9Tue+4pSUdsNDj2JyrFyFmIN99xB2VHnzFjm7S7fWKwtAW4wtK/xgn2fwkbibpSpuPVDMePUByQSGjKHvK+hY8s6OAq7WVkSRYH2pJ820dzLrNmVP1omFdYjUvrhY5KKvwsmPPzBY+Bj4A38Y7sLQ1obOyXJN+8O5yeQqraZLBf27ZNph5T/Ffpv+Ldh7Ut+4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(8936002)(186003)(2616005)(508600001)(83380400001)(6506007)(26005)(53546011)(6512007)(86362001)(5660300002)(6666004)(6916009)(316002)(38100700002)(36756003)(8676002)(66556008)(66946007)(4326008)(66476007)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1DckJ0TFZNcU5FNkJOR1orVXR5L085bmFnOEhPRkd0N0h0cURmRmhzV0JU?=
 =?utf-8?B?dlJNcnh1MXRFazlqa282andFbGFHTld4WUJHaklENXFpK1BuMEpFb1J6NTFV?=
 =?utf-8?B?UWd3RjBNT2FSbldwTG1qR1ZURVo5WmcvcStvWk1hYmQyTTVYR3VuczI2ODEv?=
 =?utf-8?B?M1Zkd081SzdpZ0FQUzVCTEg4cGZydWIzK09OdzhreHl3N2IrcWlwcTY4SjBI?=
 =?utf-8?B?cXJBNnpTMG1sNW9IR0lEUFhkNjhYeDkzcGdVVUlGYzVJd0NuNTNWNzA4aVJ0?=
 =?utf-8?B?VmhiMWpZT1BDa3NqY0h5dGVaZzc0TWd4dmY5bkhPakc0MUh3WUEyYWgza1hQ?=
 =?utf-8?B?cWhiZ09SaFpndjRjUnJhMnRiZ3FaTUNqVVNSRGpkYXI1WlBhbE9JcXhEZUxU?=
 =?utf-8?B?WEw4UmlqY0M3Sk5VUFBRWFl0Y3BNY1pGVjMyWERCa0RvNkZBNWtNZ05XZUVY?=
 =?utf-8?B?TU9UN1IrTGlDVTd4WWFGV25La1RTUVB2SWlsRTNLb2dJMmpRK1BuTlVkMzdo?=
 =?utf-8?B?ZW51YS9paEh5bVZQVlM3OWU0ZzNwRDVHTEUyZXc3S2tIOUhSWGNGSmJMZFVr?=
 =?utf-8?B?b2MvTEoyUHp4L3pNcHIyRll5M0JvTUR2UGhGaW4yYlA0TURTOEhNMzV6eDdW?=
 =?utf-8?B?am53T1NEOVlOcDJSRG9sTXU0NzRDODcrUTE5N3JpMUwvaEZkL3haSU5NT2R4?=
 =?utf-8?B?STlDaVlCNkU3Ui9kd0ZzRERQcFdiaWNWUXRWYnJ1Y0U1NitNRnNQajdBYUw2?=
 =?utf-8?B?dlErYjNXM1ZySEdpQzNkZ1VxOTZQRi81YWNibzVBWFJ3MXNQSzJscXRXOEZ2?=
 =?utf-8?B?L3YweC9zc2s2dDlrc0h0N051dm1yd1o4cCszWHU1OUtjdE5MN0l1NmJvVWFx?=
 =?utf-8?B?Y29JOHROSWMyR2ZwRldLSVdIbVlUQmhXaHlIczRhZ0hMbmRxdFNoWGVlYklM?=
 =?utf-8?B?TDNrUkN2RklzbGJudFlSN24zTUQvK3dBdEFnRnF3OGZFeVRLYUNXSlJybGtN?=
 =?utf-8?B?UDdTY2xqTW9aL1A2ZmJNK1lyK3JQNjI2eGs5bi9EMnRwK2xXcUdJVFVRK0M3?=
 =?utf-8?B?TWZBVTJRdW1UUTlUdGFzZS9mKzVtaUdFYjBoTWtJK0hmb2V0bnZDcTEvVWxk?=
 =?utf-8?B?ZmJKZDZ5aXRNNVRLeVZFYXN0NHI3Vis3TEpKUWZpdUNSVERBRG9CVzY1K0E2?=
 =?utf-8?B?cmZ4ZE1zdWNHRk50bUViV054Zml3QUt4QkdJc3Q3NFJXR0Yyd3lvR0pQS0dT?=
 =?utf-8?B?STdYUUc1TUh0UlNOQ2lId2RQNWU4QlpjWGo0U1czUWlKRFVTUkFvSnU3aXoz?=
 =?utf-8?B?Qm5QNFhwN3B2VVV5OHIzb1RLdFF2Q0t4OFNUQVBRaFA1TnBRMWkxZWhWaUM1?=
 =?utf-8?B?Y3ZpVGtsQzlzWElFRHZHWHFXUy9hejZrYUdleUJXWk8ybVJia2puRUhKMmY2?=
 =?utf-8?B?cThqRGhHOUR6VmJvU1BENVNKTHRKeUhzSHVhSmVpOG9pUjdNTE1iU1FKZDlM?=
 =?utf-8?B?amYxZkd2K2tKcUF6WWNsZkpaZm1OVUl5ZWNyWFdxMGNOeEpQSy9PK2VudXFQ?=
 =?utf-8?B?bjcwWThhak5kc0tNamdPR0UzQW8yVGdwc2w5WFA0WHJ4aXlQVEd5MVk1OWR5?=
 =?utf-8?B?cnY1d09jUDVlcCt4RUJmK0Y1aUt6L250eVEwbHRVUkF5K0ZMWm1EVTFjNUFz?=
 =?utf-8?B?RHRFQVhIQW9Fbzd0L28xdFRrN05TVDN1Z3E0STRuSmZQeE1oM2V3RlVGcDNB?=
 =?utf-8?B?NXlCcjA1NkoxVnRmTSs4MmtaTDA0Zk8xMERQdDF2ODIxb0orNkc1NlJEWVMw?=
 =?utf-8?B?bkJYY1lyMEFFSFF4OVpTenNua0JESGYrUEMvdDJTeDhVRDJRcDQycTJBTEJz?=
 =?utf-8?B?RVVXeWhuakxFb2hKS3dUSHV1YXNnR2FHcmROU3NIekc4T28reUhDbDFGcW9p?=
 =?utf-8?B?QlZLaGVrMlN0dUVKVk5iWEpHL3BDNWFobjhRZUloWVFjV0lDam9oVzQ4NEIy?=
 =?utf-8?B?aWYxSGgxOFFDckh2SHpxdEVwOSsyckgzNFFRa3JIcWVhb0w3dFQwVEEvTWZM?=
 =?utf-8?B?d0ZCcGZlbjdSSlp5eFNMWVlpL1hpTGVSQko2Mm5IQXJ3eW1iTWlJaDUyYm9X?=
 =?utf-8?B?bTFzb3FVWEhpR2MyMVhhN0o0eUhxMmJTTmkvV2h6bVd6T0l6c1JyRE9DNFlJ?=
 =?utf-8?B?MklNbmlBbGNCd1RkbzUzOEt1L3VhNC9FZ2hFUS9ta3hGY1dra1dzV05nUVo3?=
 =?utf-8?B?ZmFjdHRyOWtrQW94c0Y3TXdzVEo3QzMwcCs4bXM5a2wrR3RhZFIrdFhOZkVt?=
 =?utf-8?B?emFOZ2tpWWNZS2krMmdJR3hNeFNJekdNTXRGelYwZGhsNjhzYWJTY0RrRWxo?=
 =?utf-8?Q?WtQUz8ATf0PBCn2M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190565c-2f00-475b-9175-08da2eecbafb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 23:12:31.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJbJjbY8ErgBGASwXZNBhuTk8Q+tE4r4y/7F/SdCrCsYEqdQ64oxQqH/umqDcO+umxGfeeyXnNm4x76G9AyCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_10:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050147
X-Proofpoint-ORIG-GUID: EF4LI48z_lfVKxj9JTN2oVm2cpOz2jg0
X-Proofpoint-GUID: EF4LI48z_lfVKxj9JTN2oVm2cpOz2jg0
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

Thank you for reviewing this.

On 6/5/22 6:01 am, Tejun Heo wrote:
> On Thu, Apr 28, 2022 at 03:54:28PM +1000, Imran Khan wrote:
>> +static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
>> +{
>> +	return rcu_dereference_raw(kn->attr.open);
>> +}
> 
> Wrapping the above probably isn't helping anything.
> 

This change is using raw deref at a few places, so I thought of putting
raw deref under a wrapper and explain in the wrapper function comment
under what conditions raw dereferencing was safe.

>> +/*
>> + * Check ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
>> + * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
>> + * accessed outside RCU read-side critical section, while holding the mutex.
>> + */
>> +static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
>> +{
>> +	return rcu_dereference_check(kn->attr.open,
>> +				      lockdep_is_held(&kernfs_open_file_mutex));
>> +}
> 
> Maybe name this just kernfs_deref_on()?
> 

Sure. I can mention in the function comment that this should be used
only under kernfs_open_file_mutex.

>> @@ -156,8 +188,9 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
>>  static int kernfs_seq_show(struct seq_file *sf, void *v)
>>  {
>>  	struct kernfs_open_file *of = sf->private;
>> +	struct kernfs_open_node *on = kernfs_deref_on_raw(of->kn);
> 
> I suppose this is protected by the fact that @of is on @on? 

Yes.

> If so, just add
> the condition to the checked version. The condition doesn't have to be
> perfect - e.g. you can just say that neither @on's and @of's list_head isn't
> empty. While not comprehensive, it'd still provide meaningful protection
> against mistakes and be easier to understand if the deref accessor clearly
> explains the expectations.
> 

Sure. Could you please let me know if below modification looks good ?

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 946a4a8d7e32..a12d5067f8d5 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -56,12 +56,23 @@ static inline struct mutex
*kernfs_open_file_mutex_lock(struct kernfs_node *kn)

 /*
  * Raw deref RCU protected kn->attr.open.
- * The caller guarantees that @on will not vanish in the middle of this
- * function and hence we can deref ->attr.open raw.
+ * If both @of->list and @kn->attr.open->files are non empty, we can safely
+ * assume that @of is on @kn->attr.open and hence @kn->attr.open will
not vanish
+ * and raw derefeencing is safe here.
  */
-static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
+static struct kernfs_open_node *kernfs_deref_on_raw(struct
kernfs_open_file *of, struct kernfs_node *kn)
 {
-       return rcu_dereference_raw(kn->attr.open);
+       struct kernfs_open_node *on;
+
+       if (list_empty(&of->list))
+               return NULL;
+
+       on = rcu_dereference_raw(kn->attr.open);
+
+       if (list_empty(&on->files))
+               return NULL;
+       else
+               return on;
 }
 /*
@@ -191,7 +202,10 @@ static void kernfs_seq_stop(struct seq_file *sf,
void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
        struct kernfs_open_file *of = sf->private;
-       struct kernfs_open_node *on = kernfs_deref_on_raw(of->kn);
+       struct kernfs_open_node *on = kernfs_deref_on_raw(of, of->kn);
+
+       if(!on)
+               return -EINVAL;

        of->event = atomic_read(&unrcu_pointer(on)->event);

@@ -238,7 +252,10 @@ static ssize_t kernfs_file_read_iter(struct kiocb
*iocb, struct iov_iter *iter)
                goto out_free;
        }

-       on = kernfs_deref_on_raw(of->kn);
+       on = kernfs_deref_on_raw(of, of->kn);
+       if(!on)
+               return -EINVAL;
+
        of->event = atomic_read(&unrcu_pointer(on)->event);
        ops = kernfs_ops(of->kn);
        if (ops->read)
@@ -850,7 +867,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
        struct kernfs_node *kn =
kernfs_dentry_node(of->file->f_path.dentry);
-       struct kernfs_open_node *on = kernfs_deref_on_raw(kn);
+       struct kernfs_open_node *on = kernfs_deref_on_raw(of, kn);
+
+       if (!on)
+               return EPOLLERR;

        poll_wait(of->file, &on->poll, wait);

>> @@ -201,7 +235,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>  		goto out_free;
[...]
>> @@ -922,13 +950,13 @@ void kernfs_notify(struct kernfs_node *kn)
>>  		return;
>>  
>>  	/* kick poll immediately */
>> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
>> -	on = kn->attr.open;
>> +	rcu_read_lock();
>> +	on = rcu_dereference(kn->attr.open);
> 
> Shouldn't this be kernfs_deref_on() too?
> 

kernfs_notify can be invoked w/o holding kernfs_open_file_mutex (e.g.
cgroup_file_notify). So we have explicit RCU read-side critical section
here and hence just rcu_dereference.

Thanks
 -- Imran
> Thanks.
> 
