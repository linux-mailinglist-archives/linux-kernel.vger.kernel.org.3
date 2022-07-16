Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D957720F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGPWsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGPWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:48:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A91EADC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:48:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ99t8024361;
        Sat, 16 Jul 2022 22:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uKdMkqz3E2oTHDk7To4ERXtK95ZP047rw2nRDj0jbtM=;
 b=jXGVlyL2f4oV+G0SR8SbR1s9XuHgoli6KGsxxAl06UNwkwBUcI/Tvbue39YYyTfYKhED
 WbCrJER4fYv0Tu1o/6FelWI1t2URBAdCEhwX8lU1EO9TKs4knR8mfErjE8c7A40gT6nn
 T/7jwSvvxPAsMRoq2IjWMRdv9BrGLtFNitBOZah4DrgpUVntoKkcHtAhNUzmKji5PSfy
 LQ2Kl+DSZsZBGwPTd2W8mDtGn4iAfG2ECuYvegh+t3azEXzJU59YHO0dPExvWR1ZOREH
 o/ZJJCaKkmPcNTCy2a4qbrDIzG8VCuVO67CdaYtoSk05FDwNvCPyPXwqdcxXxsfI4JI+ Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8s6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 22:47:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY4lH022122;
        Sat, 16 Jul 2022 22:47:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1k70r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 22:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8bQu7LIrWEucKcf1eNXLotv7i9piKTkNLuSxoVzo90gAw9R2qyH9Bc/2obMW5bfnH2gxtZG21TGjrX5SrxllrGGr6eqJf2QpBoj8L7EggQpULA0uy2cG7t8d81/t/Udr1O66DMlnRRIdxgyDPsJHs4QUMz5Skosw8GUSYoTuuspOKYBEwdf2wZPg4y14+a9+LAcW96UT1zw5MQBIbHY3c8zO40ME3BqOwk/JrOudIIp8z6sYnWH9TogFciQN1y8ZPdIAcoKDObPsJaErd03y0waD9o9jK9ZbIRPIqogrjPiyOPw7Rbp/3XGeDiq75dG+2K1N/VNljk4S2z0OLJoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKdMkqz3E2oTHDk7To4ERXtK95ZP047rw2nRDj0jbtM=;
 b=IQCNpEipV+EZMWccufNrtolHk9mPGFgkwThQvKowzHn/nn+m9CLwnwTXY63bv7RwN1AiFWclivDMLw1wUzZ0jmLRedBTBzTto56SZ0GgXScYj5LKsyYBoQLiNFa8Sv1+utNBVXutrQ4K4jMYwbtkMh6llZfKp7RxTe3KpqDvLDAp+SW51dOyF9x52JamSp8Skn68+zKjSvieLDmak84h4YOOXT5YigKKkPMYvBCZHPr8EsJb+6kjl+sChzJBXNrtg/WE27rr1OgFVVc3mqChCxem9XpDcIAtS8cywd92bELGMlmEm2TMwT6kj++R9XDdjvQvDGaLKrbPgZByVpyQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKdMkqz3E2oTHDk7To4ERXtK95ZP047rw2nRDj0jbtM=;
 b=WeUVD1VLfKzvINRMASO264IewzNlbmmlYh6S71HNSRNrx0RJARdO+vDKgWuvvdXw2rmv4t/uRXka+FjbDFVwM71ZXmknD0wRtbzyQQhyfxnSG9yzunHSBgtHPqX0N1Ws/5MbE7jbVmq+OnkANl+A4fP/lL9UOIIfG6XiJAfOy0g=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Sat, 16 Jul
 2022 22:47:10 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 22:47:10 +0000
Message-ID: <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>
Date:   Sat, 16 Jul 2022 18:47:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Content-Language: en-US
To:     Nicolai Stange <nstange@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        Ben Hutchings <ben@decadent.org.uk>
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
 <Ys3MI7cv2yKj9RFc@kroah.com>
 <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
 <875yjxrp66.fsf@linux.fritz.box>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <875yjxrp66.fsf@linux.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0090.namprd06.prod.outlook.com (2603:10b6:3:4::28)
 To BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 094a27b7-e244-48b2-8ed7-08da677d1e5a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4190:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdEO53L4WYbh6vNCO7Ow7JO4g4mYXzy1PhD82MamuNkDZUGIjzEDqJ6CLEn8GPqGCMWZzd2qOp38A5zQm5/Rx+ntsHqNpHhaOAphCqkIKwfdKc/ajtXcaWzWCG/w8/U72koH30DptMM0wugaMc2f9cQOlbUZviWxTI1y/noy4bidUV3l/10OBZaIfx0m9HwrCDVGorSR3bSKx4k61+2+z5Qgt4+QV/gb+ddo37s24Q7dP/ITC+EZKP6RpkWs1Cg7f17pFpTZkulIMvrDzEAu2SdeZbzyalvh3bKNqOW260CCreBKTFw1yTR0CQPYn26QHGYzVQwlJllsKVZSI68+QXcLWwjWWtYHJjQrJc2BurIBJCMHQuk1sGb7owK10nLwk+vVJVsAVK4t4wQBSOzbWP5xcggZwvaPdHKV5VXM8y0zU/jT/jAwQN3DLjjJJa7QXl8h5OUBATGKdM/sv3H172ORsSAXai+MMtrtNmDaae0GC4P4rNAuMjfTE+Tj1xa6nblHveiPIdmolkFYaC5rSr3+WV0pEiH5xzJc82I6CydKuuWPk8LAWdwPGcsZZ7kU5b/9GUczgv1exBpmmaMP9UTW/GPtC0Y1xeKkhicTFlucgFIzxMN3Bu+8YMhl29f5+Rkt8N7MneGagG6oHPOh/rcxjptqB1buyo4wk5K+gZ6uYMvxEYuB3t69QcZxQQNfGuK0VHHnEIcKrSyssqIXfSuxtBKxfpUCWXwfYmYEIJA8KjxO8V4kqRT9oEo2NRlAmTCSMFD4ILjmuifNstOKtwoxW23LR8fudxoIJw5feGaC5Mfnw6DSMQZMNoOqYTovFHo6BVpk2tqfZ86sBxl7vDZEd3B2bbR4okgZvehma8a26uwR4yFa7TxoMS3WWtIg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(376002)(396003)(366004)(6666004)(41300700001)(53546011)(26005)(6512007)(6506007)(2906002)(66946007)(66556008)(66476007)(38100700002)(8676002)(4326008)(5660300002)(7416002)(966005)(6486002)(478600001)(83380400001)(31696002)(86362001)(8936002)(36756003)(186003)(110136005)(54906003)(31686004)(2616005)(316002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0MweW5VSjFKTEt1eHoza2R6Y2RldytMZGxWYURVamhCbFI5NVJEbEZCYnhk?=
 =?utf-8?B?Vy9FVnFKeEVyTTU0d3h1UWlTZHFRU21rU3FVMkhMMGVJeFVNOXlvMzFNRW84?=
 =?utf-8?B?dzFJc1BReFg5akZKM3FhazFObmJnektXb0huU3k2OEJYM3NlRHk0OE12c3gr?=
 =?utf-8?B?aHFPYzRyQ1hxQTJzbTR6dmN0TnhXRGthY1pZLzhWZ1VqL3o4bFRURjRkbnpR?=
 =?utf-8?B?NzFTRVRCc2ozZTF2R3BPVExQSXlWa0NLUWd6bDl5SHRxVWF4OVlic0tiOVlL?=
 =?utf-8?B?bk10MCsvNlNzaUFKUGRuMVFGUXh0YUM5Si9lazBPVWdnbjJxdDIrMlp1emwy?=
 =?utf-8?B?ZWJLYUEvMG1IeGlZUXV3dXIrUUxaN0ViZ0IxYnpjNTJaOFcvS1lPSDRYMXF3?=
 =?utf-8?B?emtDWGxtdzVMUDNxT1JLS2FKcnNCOStZOEtPQjZ2MzJmVmN5dW1panI1TDNk?=
 =?utf-8?B?Rm1FVDNZaE1zMU1SRzdsd0p2aUlFZDZ4YnZHc1QzTHl0cFVNY1l4M2JVNGhz?=
 =?utf-8?B?akJHMmdHTVR5dlJSMGJQTVl4UGpLdHJDNHNvcjJ4L2JZdzFiMHo3eWxvMVIv?=
 =?utf-8?B?TFdLM01EbEhJdDJvWnJsakFYTys0K1lSUVljamFSWitFZm54TExoSEloNlh1?=
 =?utf-8?B?Z3hxUGhXWUl5azlCdlFKUkxBWDVZclJlb2tHQXovNVdWZGliMUtLSklPWmF6?=
 =?utf-8?B?K0ZtYXdLenFqdTZuTUhkMjFrdDh6QW1jaEI1S0JVNTZNS0EweXAzZExDbllZ?=
 =?utf-8?B?NmhEckRUYzRXTE85cHo3dHllS2tVWlJWQ2JTZHppL3RMQmlLYWVEWDZtZkdD?=
 =?utf-8?B?MFFlSmhOSXFnOTFxL05rZFg5Zi9ydC9WbGJzenBZemV6dlpuVXVSRWFsbndw?=
 =?utf-8?B?aFN3bzVidXN3RGFzZEJpMUc1djZEL1oyL0dQcExKWmxzdHBZcEhKeVh5ZXpi?=
 =?utf-8?B?MVVOQ0RpSjZSSWhpM0RVTWhsQnV6bXFiYVE5ZTJIZmZzQnpZYzd2TGlWRTc2?=
 =?utf-8?B?elFLemUxTUljQWUwelRYeTZncENDdCtxSUQxRWdwdysyVlBYNzFETWhsc3E2?=
 =?utf-8?B?b1VSV2hJWG8zeWF1d0FSQ2gvQUVtbStXWHNSaEMzeUtKc3BCSThLQi91Uk9m?=
 =?utf-8?B?aE1Wai9PcVoycXBQOTlkcnJTa0JTeitHTXo1c0VlR1FZSTc5ck12OGhPWGR4?=
 =?utf-8?B?bDIxT09LL1RUNEh2amQ0dTB0THJ2ZExRblVSRWJwalVINzdpQzQxblBtSHlN?=
 =?utf-8?B?VXhLdVZnSFBVUFhwM2lYYi9nczVUekdOcWwwd2hYc0xGZ3JwbkJFcGxkMUJ6?=
 =?utf-8?B?NzNVTjBpaXZOV0tmY1ppQVQ2bXNsZ1gwdFl5MElFcGdaMVdmb3FuNUVMV0hi?=
 =?utf-8?B?OFIyRDhwM29uTGRTNHlvYzZ2b083WEdUeTdwV01ZSmNqbjI5dU9zeEtySXli?=
 =?utf-8?B?OGdxTU50Y3VOanlWSytsY3RhTk42TzB4ckFoNEM4bUNxTXJLU0l1cnUweS9H?=
 =?utf-8?B?emlsOVJ6Vm1SYnBSQXZCY2JHdU9DQ2daWVp1RWtGdnc4N2I0bVpMdC8xWUNt?=
 =?utf-8?B?T0dqUTA4TjJyTFQ0OStwQzIraWdMd3ZmQVNuQUZRRVVZVmY2MEpldmdJTWI2?=
 =?utf-8?B?UnA1UjRIUXRoSXJIK0V5VHNzQkttTU10bjRQRUdtWktyZlNiYXdFbVhiL0U4?=
 =?utf-8?B?VFducEZ6eS9zdWNPenFpV3pOZ3JmeDFFSFBpbFdsYnVwUTNnSzg0cVVUb1dv?=
 =?utf-8?B?My9NS295YmpydnVIMnNYK3RmUS9SQXl5NFcxOXlzaFFKNUh4YXhRekgxNGlm?=
 =?utf-8?B?NnFraVJOT01xcDNGbnhtaEJxSjRxaHhEa1pvb3BDSFc3VFhUSS9UOExTSlY2?=
 =?utf-8?B?VWdCR3dVeHRrb2VGUFlkU1c0djNxUXBTM204OVJRbTlIWWhJbU90UXpwR0lO?=
 =?utf-8?B?VUQyVFZqQVBBdmducTVDVlV3YXZuaS96MDhJK1RJbWpkazFwQjhiVUNOeW1y?=
 =?utf-8?B?dmZRKzkzeWFmVWE4K3crblhjNk5KY3NvTkhTRWtTTDBvQjVhVWR3UXgydmFu?=
 =?utf-8?B?QTNjTEswQk9YL1lscytpQ1hLWk5wSlgxenM3a1NlbWhvOXU3VHMrNi93QWsz?=
 =?utf-8?B?UGZxTWZRbnc0eVNPM1pQODhVNkE0c0NOWk44bzdCQTd4dG95YTlPcERRdmxP?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094a27b7-e244-48b2-8ed7-08da677d1e5a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 22:47:10.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nh37PECMHjU+ML83Y8Kv77vrO3TPti7oG2NCWOXh3xOf4oPLH9rnSfveSz1H7aLqh4BRviEQBho1YkOkKoPrQzWU402XfAksNBz2U/YEPyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-16_19,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207160100
X-Proofpoint-GUID: OGvBwwcZGHL3kQYk7FqZyMcBbqjnKKHC
X-Proofpoint-ORIG-GUID: OGvBwwcZGHL3kQYk7FqZyMcBbqjnKKHC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/22 12:35 PM, Nicolai Stange wrote:
> Hi,
> 
> I see a patch for this has been queued up for 5.10 already ([1]), I'm
> just sharing my findings in support of this patch here -- it doesn't
> merely exchange one warning for another, but fixes a real issue and
> should perhaps get applied to other stable branches as well.
> 
> TL;DR: for this particular warning, objtool would exit early and fail to
> create any .orc_unwind* ELF sections for head_64.o, which are consumed
> by the ORC unwinder at runtime.
> 
> 
> Boris Ostrovsky <boris.ostrovsky@oracle.com> writes:
> 
>> On 7/12/22 3:31 PM, Greg KH wrote:
>>> On Tue, Jul 12, 2022 at 03:19:39PM -0400, Boris Ostrovsky wrote:
>>>>
>>>> On 7/12/22 12:38 PM, Greg KH wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm seeing the following build warning:
>>>>> 	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction
>>>>> in the 5.15.y and 5.10.y retbleed backports.
> 
> The reason for this is that with RET being multibyte, it can cross those
> "xen_hypecall_*" symbol boundaries, because ...
> 
>>>>>
>>>>> I don't know why just this one hypercall is being called out by objtool,
>>>>> and this warning isn't in 5.18 and Linus's tree due to I think commit
>>>>> 5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.
>>>>>
>>>>> But, is this a ret call that we "forgot" here?  It's a "real" ret in
>>>>> Linus's branch:
>>>>>
>>>>> .pushsection .noinstr.text, "ax"
>>>>> 	.balign PAGE_SIZE
>>>>> SYM_CODE_START(hypercall_page)
>>>>> 	.rept (PAGE_SIZE / 32)
>>>>> 		UNWIND_HINT_FUNC
>>>>> 		ANNOTATE_NOENDBR
>>>>> 		ANNOTATE_UNRET_SAFE
>>>>> 		ret
>>>>> 		/*
>>>>> 		 * Xen will write the hypercall page, and sort out ENDBR.
>>>>> 		 */
>>>>> 		.skip 31, 0xcc
>>>>> 	.endr
>>>>>
>>>>> while 5.15.y and older has:
>>>>> .pushsection .text
>>>>> 	.balign PAGE_SIZE
>>>>> SYM_CODE_START(hypercall_page)
>>>>> 	.rept (PAGE_SIZE / 32)
>>>>> 		UNWIND_HINT_FUNC
>>>>> 		.skip 31, 0x90
> 
> ... the "31" is no longer correct, ...
> 
>>>>> 		ANNOTATE_UNRET_SAFE
>>>>> 		RET
> 
> ... as with RET occupying more than one byte, the resulting hypercall
> entry's total size won't add up to 32 anymore.


Right! I haven't thought about that part. I think this has been broken since 14b476e07fab ("x86: Prepare asm files for straight-line-speculation").

It still shouldn't matter as far as correct execution is concerned which is probably why noone complained.


> 
> Note that those xen_hypercall_* symbols' values are getting statically
> calculated as 'hypercall page + n * 32' in the HYPERCALL() #define from
> xen-head.S. So there's a mismatch and with RET == 'ret; int3', the
> resulting .text effectively becomes
> 
>      101e:       90                      nop
>      101f:       c3                      ret
> 
> 0000000000001020 <xen_hypercall_mmu_update>:
>      1020:       cc                      int3
>      1021:       90                      nop
>      1022:       90                      nop
> 
> 
> This is probably already not what has been intended, but because 'ret'
> and 'int3' both are single-byte encoded, objtool would still be able to
> find at least some "starting instruction" at this point.
> 
> But with RET == 'jmp __x86_return_thunk', it becomes
> 
>      101e:       90                      nop
>      101f:       e9                      .byte 0xe9
> 
> 0000000000001020 <xen_hypercall_mmu_update>:
>      1020:       00 00                   add    %al,(%rax)
>      1022:       00 00                   add    %al,(%rax)
>      1024:       90                      nop
> 
> Here the 'e9 00 00 00 00' jmp crosses the symbol boundary and objtool
> errors out.
> 


Ah, thanks for explanation.


Then I think we need to replace

	.skip 31, 0x90

with something like

#if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
#define SKIP_BYTES    27    /* RET is 'jmp __x86_return_thunk' (5 bytes) */
#else /* CONFIG_RETPOLINE */
#ifdef CONFIG_SLS
#define SKIP_BYTES    30    /* RET is 'ret; int3' (2 bytes) */
#else
#define SKIP_BYTES    31    /* RET is 'ret' (1 byte) */
#endif
	.skip SKIP_BYTES, 0x90

(I don't have patched 5.15 so I am going by what mainline looks like)

Or replace RET with ret. (Although at least with unpatched 5.15 the warning below is still generated)



-boris
	


>>>>> 	.endr
>>>>>
>>>>> So should the "ret" remain or be turned into "RET" in mainline right
>>>>> now?
>>>>
>>>>
>>>> It doesn't matter --- this is overwritten by the hypervisor during
>>>> initialization when Xen fills in actual hypercall code.
> 
> It does makes a difference though: even though objtool reports only a
> warning, it still exits early in this particular case and won't create
> any of the .orc_unwind* or .return_sites sections for head_64.o as it's
> supposed to.
> 
> The significance of not having .orc_unwind* for head_64.o is that the
> reliable stacktracing implementation would mark the swapper tasks'
> stacktraces as unreliable at runtime, because the ORC unwinder would
> fail to recognize their final secondary_startup_64() from head_64.o as
> being the end. Note that livepatching relies on reliable stacktraces
> when transitioning tasks.
> 
> 
>>>>
>>>>
>>>> So f4b4bc10b0b85ec66f1a9bf5dddf475e6695b6d2 added 'ret' to make objtool happy and then 14b476e07fab6 replaced 'ret' with RET as part of SLS fixes. The latter was not really necessary but harmless.
>>>>
>>>>
>>>> So it can be 'ret', RET, or anything else that tools don't complain about. It will not be executed.
>>> Cool, thanks.
>>> But what about the objtool warning that I now see?  Is that "real"?
>>
>>
>>
>> It's not real in the sense that the code there is not real, it will be overwritten. (Originally the whole page was 'nop's)
>>
>>
>> I am getting a different error BTW:
>>
>> 	arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction
>>
> 
> I think this one is (mostly?) harmless, at least as as far as the
> .orc_unwind* generation is concerned. Josh would know more.
> 
> 
> Thanks,
> 
> Nicolai
> 
> [1] https://lore.kernel.org/r/Ys+8ZYxkDmSCcDWv@kroah.com
> 
>>
>>
>>> I don't run any Xen systems, so I can't test any of this myself.
>>
>>
>> You can't test any changes to that code --- it is rewritten when Xen guest is running.
>>
>>
>> We probably do want to shut up objtool. Josh, any suggestions?
>>
>>
>> -boris
>>
> 
