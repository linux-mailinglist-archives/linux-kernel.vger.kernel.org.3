Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC8539537
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiEaRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346410AbiEaRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:05:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB88DDCC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:05:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFuWca007300;
        Tue, 31 May 2022 17:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xiguyp3NbD6/X0Ke2hFELDlS5vee0Gh2mXk/DVfofpA=;
 b=GIL2Vc82wdP5zGTziivLfwPhm9U1jgDR70jZwf171EHos9Vev6QVgtUP7gVXU75AhjVd
 pln1F4v7/x+pxpLiqcog92I3caiHzPFjtu8mVlOh/qvi4KaGiVX75/FySg0Nl4l05hY1
 P/1/z9vcRIdy3p8d/5+dvOpglypKmXI26aEDX+Ll4o//R7nDyvgGUU8VT6LGKIOAv8Oy
 DMAejfWR/JbYZmy79nZJ2aGcgPbWkEnUwwgWfW0YEVrJqAwKGM3TzQR6R58KiuBPSgIZ
 P0jW6vsArC9NieHZXthEmxpyLwE0LkdJH+H1hlOuyPdQpXQ5Tzwu7eZ+OlgMTVOIgffO 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauns6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:05:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VGpRgL036599;
        Tue, 31 May 2022 17:05:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jxfcmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlru86Hmmo0QjqK/D+FvjCTjg9lLhfTphlNbbzHrz3NEyD5nMz4DtrpPIONSigICUYibs0ZulGdkC8Y4WJao+lhyMHmqG3D5HDpOMU6o8mT2UlR3RPzwhS+z/VA5kI3WqynS4CngViCvTdfxwTjQPtPvSBcuxuxq3mU9bH32xBb7twNnwlHmQjzB377A5DbI+hHRC4HQaBm8Mvxo6rdqLmhNZJQ/l/jgpRw1aT4/+Bb14jplfq6DSupBcHnxBB1Oe1IzmheS9VQAwTstDqzEj6HjfXVPGqkxNDN5tFEeHsJDx+TdIHGSrlFzAuNHe5htznFawGmDw9ECzSakxXqcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xiguyp3NbD6/X0Ke2hFELDlS5vee0Gh2mXk/DVfofpA=;
 b=QjTmXF758P1BGLzHUtQzt03g6gd7zLahxhcixuE6MFbW6MEpOPwGPUdKGs9JnJnEL3sRjIJlXVHnVuYm2CxuzC8DSrjA7E7PVROAMfFl3tblqC8HzP3gFun5eEEfcMa0rD6X41v21V71T4DFbLhxoo7POysrEOgmlGxxDzOjPHZnzxNQnCds4Qx6ikLqe5dY2vNo42MQAQNamLFIb5Owl5r8pgJYAMWVPBbckn6rI9gZwFd+23mv/IXC0H/yl+Cd8Chw/IkaJo3UPWiK2y0gtAcNWxhtMt1OcPdGR9aBYNbOcQAt24Mb7G3ZSqq50wgbAG0yKIfQcWcvduNkNqd0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xiguyp3NbD6/X0Ke2hFELDlS5vee0Gh2mXk/DVfofpA=;
 b=U+yn74fNb5OTvL5zk/Ua25e9+Tl3MJxNkf0FumNNNMnPtG8Qpg6iIlaubd4+LSEYBxEL62ib32FHt118CBkU2H7fwipoO4UCrhKNosj9zdx4OqpLASlSoNhOCw7WGw4oYVpHJBihOymbDfCz3hTJDIcz0Rt3vMIpZ3aIK4uxZ2I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5529.namprd10.prod.outlook.com (2603:10b6:510:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 17:05:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 17:05:24 +0000
Message-ID: <95bd9375-36d2-7e34-83a8-d9eedfe70956@oracle.com>
Date:   Tue, 31 May 2022 10:05:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <YpUhe6BSfflOVz7b@xz-m1.local> <YpV3qrSHGsIuvifX@FVFYT0MHHV2J.googleapis.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YpV3qrSHGsIuvifX@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b4be85d-6743-48ba-661f-08da4327c06d
X-MS-TrafficTypeDiagnostic: PH0PR10MB5529:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB552959DFBC3669A3A1A5EF47E2DC9@PH0PR10MB5529.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTKFEJLP8cYa4XCIrtdR+GexH90XKwXJW7p6b38ap9DH5ZmlI+F8hD/GoGmoHziP+y+n/EDJ68031drCBnK/fcemaFiSWGyNT15Oan6VJX7qb1sSHMNQBAN+ke29xmu6n5kKLNOquyOfjqbHhbXP6k/8+yKv6PR+DB785zZRRCS5svGAnNHLWfHiVoTVibSHXp709CnrzwQcPzMR9o1nZIkyxt/1T+6ofeBgfI/nbR8dXiadxsyAHFTBinUwfJNCwn0BDGszb5QvbQMkHRKQzJ8EvlOBSDMwhnlbGUj26d+GmlSimZ5D5ybH7Nlnw31UeI+eLKJfzkQ//yDv+4O8nw1KM1l+JJyq7LsxLgn+8audVS9cmk7g3keb7Hp0Nbi/euMLDysL+iLPYEXXheoVuM8fBzrG3vlhULeNMOmrd0bTjpetiosGlVWoAHKmOEv7MKiHfxCsax70vypRKXefZOfsPSTJovCdYsFdpiTzZiAe+W0OJ7hM8h9Nhe9uO4uPc+pxLKZbgJYAyDViWXygXmZ7ofo3RdXLwBj2WSuNFbPFvRyo2HOWOlm3jv5fP15xIC0/b+oea47NBXL7IXuiV6/2Nte+vbdgsRiciuVXSq/fPTUfLxauV+RwXHpKRrOFOxXY5fUBY95y6YD02VSzHNHli4VRgQZbtX+RchPbRPMCWMpC8s9/PnxNw6bpUS6YEQKMlmPE540jG2Vt4yFh1lJN/E4XQJPdLhsg8S9lTUNxnBaYS4fA3m7ueXmFhjVpcIj+3lvCZKr5RctgFWLHsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66476007)(66556008)(66946007)(38100700002)(31696002)(4744005)(36756003)(7416002)(38350700002)(316002)(110136005)(2616005)(8936002)(86362001)(186003)(5660300002)(52116002)(2906002)(508600001)(4326008)(8676002)(53546011)(26005)(6506007)(6512007)(44832011)(6486002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDFhaEwwQ1JVVTFSaUh4SFlZOGt6NDRZYmtiY0k0OEJVSnRyMWR2UlZlVHVu?=
 =?utf-8?B?Si92RkIzejFHMU1uc1ZybVlRdnhBZ0d5WStlVUdsTW1KQU9EK2tVZks0V1M3?=
 =?utf-8?B?bVpDOVdELzc3UlY0WnE5Uzk3R3FybDByZDkwVk1KYis0Y1hFbnBlbGU5bldp?=
 =?utf-8?B?bi83RnJSdkxPWGlleEh3bFdJcnZlRjVsYWJIOVpKMHJRaG1vbm1kVm1PV3kx?=
 =?utf-8?B?VzhzRThvci9UTUtiTGVxRGUrVEFkWG5QRVBQakh4dVU1dmRDWEVWdmM0NU4r?=
 =?utf-8?B?d0RDUHUwOUlma0szSXh5TTVWSmlhMEhMR3k0RHBrUGRhMnppYS9VdTNsTkp2?=
 =?utf-8?B?OHMwU2ttbjI2c0tWWUJtK2IxUXdTek5id0xwcWsrQWVrcTFzajY0UnZSNnZx?=
 =?utf-8?B?cW1vMmxwMWtySE00ZTE4US9sK1A4UitFNGs0Yi9QMTEwT1ZCVGIrTVNlRTl0?=
 =?utf-8?B?c0VoSUp0Y0xRZkJFa2prRnhkbCt6WEcrUTdMMGxOQ3B0R2w2VW5Gc0s2MlY3?=
 =?utf-8?B?Z0JYeXlCZFJWTXgydUMxM0Z4WmpOWDNwMm1ucTB3VXc1QlFXRUFHak9CYitR?=
 =?utf-8?B?eEs4cDhSTllZK1ZGOXpQaDM1YS9rY05pZHBZWlNZZDZUT2dSV25CT2lCM3BO?=
 =?utf-8?B?MzZtdVBPUGJMS0tQajZRcGx0bW9ETWlrTUh3UzlIZnBPNlcvci8wWDlWZ0ZQ?=
 =?utf-8?B?bTJnNis3dHVzdTc5TlV6SytTM3VVeXV4dnNSUDdidzRTNkN6aFJJNGJOQ25Q?=
 =?utf-8?B?VnV2QTlNYWJxeXJCUkM3akw2QmRUY0dKSHpXaTRoZVhDWTQxSG5QVWM2QWJI?=
 =?utf-8?B?SjdoS0FuQzByUHFFcDhiY0ZWNm9XTktDYTVwMEFPZTJnOFl4blZmaHdTZXU1?=
 =?utf-8?B?cko1VjBSa2krUnVXQmhldWJPWmo0MFRBM2ZqRVNYZnUydEpldWVLUk1GZDdJ?=
 =?utf-8?B?VG16UFJmQVNKeUh6WWYzVXF2OXRrNkJVVHRBeWRSeG9hTTY3QVdrU3F3OFRr?=
 =?utf-8?B?SDdwVjN0cFlDbUlFSmwyZnpZMDN1SVN1S3F5YlRmWGRvaXNSNFRuN0daMUVi?=
 =?utf-8?B?dGFPMFpTQUVYVjkxUXNDUkQ4MHBSejhvQWtYWnVyaXN1dEdhZWtCQTNsR0xJ?=
 =?utf-8?B?cGdTSmg3dXk4bTB0azFyRXJiRVhub3RXalptVGdNV00xRkRMVVArdCs4ck9z?=
 =?utf-8?B?cS9ZNkpYOUdHTjZUVDBLRlN1OWoySkxTRklvYU9lTUczYVNqZUo4SkJFMEZ0?=
 =?utf-8?B?YUxpWjZkaTNpN3dnZ0s3VHlOSTZ3UkRYYzR3SXEveXI0cEo3WkFBeVJuZmRN?=
 =?utf-8?B?bkhZWjZzb0N5aWtSU2s5UnZocS9scmxweWFZYzY4ZHFjR240M2JBZzZXMWZ0?=
 =?utf-8?B?bjRxS3hCOVlHWVNZN0V5ZmJZYytPNmY5RkhLYjVjRHJTRVo4c2lTb2JrVHpR?=
 =?utf-8?B?YnB2ZGxXbTY4M2NSRzB6elAyYWZMWEd0SnMyQUc5QWs0U3ZxK1NFSWVFbnd2?=
 =?utf-8?B?MG5OWkhvayszQmp4MGJqbWdzSkFVaEY5NE1QVTZrZjRQeEpWV25EeFJkNUxr?=
 =?utf-8?B?WE4veEo2cFRWV0pHMEZ3a3lzbHNPcmxTa1RHR2hDN05ZNGE2S2V1Tm5nRm1K?=
 =?utf-8?B?SGdpUGlueUo5b1lBZktMNFJvMzYxWFdYN01mekNHelJOYWxCNkMrS1ZMRW1a?=
 =?utf-8?B?R0g0cjNEN0dPKzZsVE40elkweXF4dVpJQVI4UW0yUWF3M3FNcmVPc3F0aHE2?=
 =?utf-8?B?S2MzS1VrMlBOd2tKQUlpNkMyajlhNVU2eHl6NGEvYjhMSzZxTmpScVVscTRh?=
 =?utf-8?B?MkpaT2FqMWVsVzZXUEJHR2UwWkZsSlo0cXZOTzRsYmhpYzhNV0VWWVp5cHdR?=
 =?utf-8?B?NDNFc1E5b1JxV2huWU5leC9ZdkxML05ycVBHUG0vNFRNY0YrRmFpR0hyMXJD?=
 =?utf-8?B?SlFIbytHWVp0VFRqV0NSSFF0alIxeUo0L3ExYXJVbS96WmJVcWQ4OEtPa0hl?=
 =?utf-8?B?WmZ3V3F1dXJIMHFrWTg1R2twdGE4RTE2K0VFek5qS1pyb3hXZmVvN3hDUnNU?=
 =?utf-8?B?NFk1UDFGT0psbTdmc2l6WXh1ekhqVGxOVUZuVXNMQnhQTHMrckpNcVVUM0pM?=
 =?utf-8?B?dHlTOE9nK1JxVmMzbnE3S0Fod3d0WU9zZHZGRENEYTIvV3VJdjVQSlV4SkZI?=
 =?utf-8?B?b0o0d0YyOHVPMEEvazlCekZNYStRbk0zb1RHU3Evb0FqN2FsTkw1cGx6N3Fn?=
 =?utf-8?B?bnovMmJKS0wza3NzbHVDYW5TRTJFbVRWZlU3M0xVdDU0U2cwa3lWVXRxSHJE?=
 =?utf-8?B?OWt6K1ViWWwxcXNGOXU1c240UitUb0J3UnFaekpGQ0RQSUtSNjNZaWU4M0RS?=
 =?utf-8?Q?LYKq3V6BLuJWCM/8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4be85d-6743-48ba-661f-08da4327c06d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:05:23.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8n+1UOPi9lXnnwfJgJamq+F5i5Yl2RwfaU4IhNbmRUUGQM3wY8EufBPFCzewcfZT69ydmmmmuI8DOAgX8nv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5529
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310080
X-Proofpoint-ORIG-GUID: z7rcaOZ2SRZvtErotTyi53r8uauLW7dB
X-Proofpoint-GUID: z7rcaOZ2SRZvtErotTyi53r8uauLW7dB
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 19:04, Muchun Song wrote:
> On Mon, May 30, 2022 at 03:56:43PM -0400, Peter Xu wrote:
>> Hi, Mike,
>>
>> On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
>>> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
>>> +{
>>> +	unsigned long hp_size = huge_page_size(h);
>>> +
>>> +	if (hp_size == P4D_SIZE)
>>> +		return PGDIR_SIZE - P4D_SIZE;
>>> +	else if (hp_size == PUD_SIZE)
>>> +		return P4D_SIZE - PUD_SIZE;
>>> +	else if (hp_size == PMD_SIZE)
>>> +		return PUD_SIZE - PMD_SIZE;
>>> +
>>> +	return ~(0);
>>> +}
>>
>> How about:
>>
>> unsigned long hugetlb_mask_last_hp(struct hstate *h)
>> {
>> 	unsigned long hp_size = huge_page_size(h);
>>
>> 	return hp_size * (PTRS_PER_PTE - 1);
>> }
>>
> 
> +1
>  


I like this as well, but I wonder if we should put something like the
following in just to be safe.

BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_PMD);
BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_PUD);
BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_P4D);

-- 
Mike Kravetz
