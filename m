Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC253BE64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiFBTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiFBTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:09:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952BCFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:09:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252Huhvm028854;
        Thu, 2 Jun 2022 19:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZJM97+Pdw2U+vQHT1XymKdEHrjACb2Vlw+HiKfA2CH8=;
 b=h4DYWHDBxIavOovzknzCoi1V+UXVTo7zwocYUDS+P//vU6XOsSTum57hk/eUl32ZJOP2
 SYTi3NKesO1DnIVftWOsGWjARNSHc2HOcuClAfoEOcI1wPh5ztlbAn2kRoaBwtKdsLjy
 zLsKMFGsH/7TC9uM+fcVyARfKrTCajcraXYOdez68gb1jH2J7ARPV/he8pObEG+wE+sX
 7WTYcf7cubLjwWH9CZq2v58hVUBtTnn5LFKQzIaTEtRZ+0Yd3Pcm3iBHBuMjgLE+/ahW
 8RdEEzEclR9ZTXVXDQMbCG1QntPltxI87ZMv/A6aPWQpifWHSZk+ET05cHma5BEVcplt 2g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7ku12j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 19:09:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252J0sk8010287;
        Thu, 2 Jun 2022 19:09:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kmxyus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 19:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9e6X9U7f7faXE3i6o7Wm5pF+s0fuQje42lN5/E07FI8yVi3gPTrREwsXwnFeODAxMx1VNrqykAS3NkZ9ZUg6Cyia/BXWuMbnsOxPwDbk7PMRoOYSgI8zZnKa5MbTrP03wNP/ulFzFy60kMCvegjw9Ckh84cktAszMY5TTUEyUzwhOs1VH2ZYyihJXau5sJ87YwSbY4hndRGMmkUprro2SW1Z0/GuN7mS9e9ezSFm4ryvPaZmI8skHOmNk2VxgWbPxwA7Gki1gPAUj6UeL3bIDf/5RYfe4IY2qzh5fWDzYJ1skGv0ippgNxYN1SU9RfgXtBn8gyliBodYJoZBNsUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJM97+Pdw2U+vQHT1XymKdEHrjACb2Vlw+HiKfA2CH8=;
 b=kbjVGuNAvhxTOSIaBqQHuppU+CIIdoQA6svUkiq7pSPwmuQEozvAykptrEazrLvcSsQ2IhO7IRTZlBpTZ4Z1gEuEEoiI9S1UiQ8hmWuZQl2B0vPYXEgVmVBAZlfTUQLaW8hRqtOu0saZckQFyO7qjWC/qiOYcIbc1aU+hwoLSeV+CqykRnkv0FmgSBFOugrUxHNhjvSuKMHDPl0tq+iK26qV2qsNHWtuq9qqpCDjiVIOJaef555e+X8RquK9IqU9tbjrtvzaBhxXLpAwKVwZ0xJrZvbbNXADFlc42lIAHyx2qzm/pE5QTOEYpiiaCeUCov67tqw2BJ/8RVHblb06PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJM97+Pdw2U+vQHT1XymKdEHrjACb2Vlw+HiKfA2CH8=;
 b=gHNickKUVm0qPtValK6968a60zLZyFLoFm1mMqBwDhTew7sdAlHiinOj2XKudrOFMZXkeBgerT4mJkkreUQz/QE5uVp+s7vnVp3Epm6LTrlX0cEF1FqtouEbux/Hjq6+L/rTeFb7hJIi4jfDwj0nKpVPaxcEdCXPQ4GMHkgWweg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BN6PR10MB1410.namprd10.prod.outlook.com (2603:10b6:404:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 19:09:09 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::84df:d22d:95d6:b4f9]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::84df:d22d:95d6:b4f9%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 19:09:09 +0000
Message-ID: <3f067ced-8fe3-2e4a-79bb-909b8636db17@oracle.com>
Date:   Thu, 2 Jun 2022 15:09:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH V3 4/8] xen/virtio: Enable restricted memory access using
 Xen grant mappings
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-5-git-send-email-olekstysh@gmail.com>
 <c2ae069d-ec95-50ea-1789-b2a667d6fb4c@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <c2ae069d-ec95-50ea-1789-b2a667d6fb4c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 954a4093-2e31-41b5-e865-08da44cb5f08
X-MS-TrafficTypeDiagnostic: BN6PR10MB1410:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1410A90D265292C38D99A0288ADE9@BN6PR10MB1410.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4buN1rh5t/S1qg7YdJ59gHVneaqoDGSGjHyJzjTYDAPdbwFWucGMTBilz7dZ1eivP44R5qI5g+SFEqYtq42QUvwu2d9BWlfJuK3s0rjok+3c2c/ncKdM77E+flSyv0Sx6HKzJ9ssiaaXnaBYJ3hxrVaoZjd+/G8jWTlWUzIkHk/UpIx4wIf+zPI5lp6u8g/vlr7DClHdDE8MrWXotCxuiXhIRQjadFJhYnEAkZrF8f/Qmi+O7Tkw2QE3YRrmIOOngDDZeSX4RWEoeVeV4o6Nn/G+qIBHqbvY46q42vP8pcGNdk43BVFTdNDjrMZoU7ZVRmBKFKDhcjbTMnKPHokjQcVdJQzBqOc/p6IaciU9UyH85WvA+aanOnM2oeLB9njlMfqBE1fU234uCQgsH3OxV2D/oJ8uiz25zlyFYzHHHnnuukoltTC/+8PJeSbPnrr81FJfuV0iqtJ1kPd3rChqiiopTo3UVa44VLJ6WvdTOquKg9Jq7Z9Q9hpky/KGJvwwN9lT+lZpVY9RyHYphI4XTh5HECyAsmg1FfBmLTKdytpuC4AACt1sZIgT7+98WNjRwGeI6NoYHEVoK+rhufBoYgmpR6HyBGMg3/OGowHh4aQuKYqjrLs4S7kuYnJ/iurYiFRd0Gu9WA7WRgIxOUzrJ5T6tflptO1D1YYrELCTUwaWCbyTOLT1fMSbI7WysvuEmEMZ/9GRPPXjHodaXQv97iQLaZnvhX+oV4vSCxN94JxsbzmEtrHiYMbuxXURSFcO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(31696002)(6666004)(26005)(508600001)(2906002)(7416002)(6512007)(38100700002)(44832011)(8936002)(6486002)(2616005)(53546011)(6506007)(5660300002)(316002)(54906003)(31686004)(36756003)(8676002)(4326008)(66556008)(66946007)(66476007)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxjYkpQMzZhbWZ3ZXY0bUFyTHd5UHppakJOY1NVOTR3RDFCajM5elpQN3Qy?=
 =?utf-8?B?UXRtdE5XcWNMK3RTRFUzYlUzSWhtVkZSUzE1bkdVZW8yRHJPS3pTRCtwU2hS?=
 =?utf-8?B?ZVZBY05aMFRnSDg0TWptb2sySFhOVm5sVmVRZWZEWlVER2pWWkFKK3o5RnJC?=
 =?utf-8?B?c3doS1o3bnIxU1VJSU9IUlgwVC9waGtEV3pEMGVSRkc5ZlFwejByMnc0MDhS?=
 =?utf-8?B?ZEdlQWJzWlQwREhrZmErelRUTjFNMVpCQUgzQ3J2ZkIxV3ZVVlYzWjlXYVhN?=
 =?utf-8?B?b0Zaam5Mc2ZjK0VHOWhYVDMwVm1DQ1Q1OURRb1RSQXZGQXB1S244dzRBOEl6?=
 =?utf-8?B?RlFYdFFEeG41dC9KMCtPcGx1c0R6RERhdEs2ZzYyTHV4Qlc2bVNhcGdVOFc2?=
 =?utf-8?B?NDQ0TkN4T2lIMDZMbFJtVXdhUldZUTIyUXBZa2ZpRnVKZDQ0Z1hQbzFVcVNa?=
 =?utf-8?B?TkNUN0xaYkVlWTNsdGEzZTF6ZDRmVGRTcUM4OWZRbS9BOUVtdTQ1dXB3WWF1?=
 =?utf-8?B?SndmM2J5Lyt1VHB0RGJtMWoxbVNCajBCd1cyazIwOXJmWkdCM3E2aDZJUmRk?=
 =?utf-8?B?TUVhUmRaNDc1OXNERlBNV2RWUW9yb1h6VFRqZDZySXhrUTlFRGJ6RUhLT3c0?=
 =?utf-8?B?cjRBVjdlVXNZWXRjd3g2cFV1RDZLdU9OalEzV0o3RjYyUUJ1MWhWSzB4K1k3?=
 =?utf-8?B?WVM3NFRLOWFwM1dudHVwbjJhek81SVliK3BJQXJjVHVxeVNIamJwMERWbmxw?=
 =?utf-8?B?aHNLYWhYTGl5c3B2WVY4YStiM2doRXI2OWJsOGsxZklzQlpmeHI2NFcvZC95?=
 =?utf-8?B?NEZPOGhEeUt1VFNleUZ4WVlYd0Q5a1R6cWhOcFFGUHJIbG5aWWJ2eUtmb0hr?=
 =?utf-8?B?Y21iV2ltRDRjK3hZTG9JSzFid2pVM0RoNlYyNVByMEZmaTdnbEZVUWhldDlX?=
 =?utf-8?B?NHdEdnpBdFhLTG0rZzJRb0FESElPb1pFQUd5Q3c4OU9mcEMrcFZkcFI0U0o4?=
 =?utf-8?B?SVM0blBEZVBObW5oMWdGK1ZXb01oU3lWcVlSZDducVdsZDNGNVVhdFN4ZEFl?=
 =?utf-8?B?cG4wdGU1Mm9BYloxV3lYS2NnLzF4YnRDSUVXQkM5amFPVDhZWTlyeUpSVmRB?=
 =?utf-8?B?QzBhWnlxMzVUNFBjN2VLSkVKSGJEVlpTeFZQSDVUcTB0WXdpOU5tMnlHMU40?=
 =?utf-8?B?eXo0QzAvQ0NxUDFjN1RPdDdSWUpDeGZsMndXdEg4dmMwMXpKc0dTcC9iVmhC?=
 =?utf-8?B?MEhuVVZQWU1rdEc0QWQxSkFZdDR5QmY0MkNmOGZLelh2TldlYncwSFV1Mytu?=
 =?utf-8?B?aGFmSlYwWTVhdlNmVHhtTkhRNElEWmxOam9WcXRwcjlTOERVU21ENkVXcFRj?=
 =?utf-8?B?U3RQMWdNRVlJNVlxQnQ1akd3MC94RHQvT1VTazhzSVhDSzhMWjVyQ2p2a2NL?=
 =?utf-8?B?eUh5bysyWGpRRWZneGIzeSt2Y2U5Yk9MZnBYQStub2NXZWtZdndaVlVzdHM4?=
 =?utf-8?B?Tm9Qd0lHeU9vbTkzNkVGTGhhTlYvS0pMRS94T1VxZndFb1ZacGFJWlB4dzBE?=
 =?utf-8?B?NVlSTWp4WTUzTFA0UkFxZDNVN2RyZzMzS3A0akM4ZVAwZGdNODRrcGRMQkhN?=
 =?utf-8?B?dksydEVhYTk5TFZVMWdUMjB4K3JFWFFZdlVqVXRkaittS2VCUXl2TE5hY0wx?=
 =?utf-8?B?bWh1WVpkbWo4U1JtYWZpWGY4cW5PTkpBKzRwanNnNWR3RmhFS0FXTEQ0YWFT?=
 =?utf-8?B?a01VRWdtckJ5V0J6WjRDRC9xRWlVWHR2TWVFcGdEd1g4OTVkRUw0SWFOaUpz?=
 =?utf-8?B?aHJSQURaMEdrOTdleXk5ZHZ6UTVCUlZJMUVoWjl0eXBXYjU0dVp5QXdFUFM5?=
 =?utf-8?B?WExCanRLci8ramluSUdyRHhZQjlWcU5BMEZXVTZlakFXNTJlUVpWZzAva09Z?=
 =?utf-8?B?d3RuVElRS2JvRXJhd3YzOGhLZldGVVNDd2x6K09CMFdZcmFlM3k2M05BMm9D?=
 =?utf-8?B?WGh6UUdxTkQ4eThtZnpVSzJsQTRJU0FkUGY0U3YwZ0VOVW9FMlQ0MEVIZHBV?=
 =?utf-8?B?SW9lb2lCWCtDSzFXdzc1N3R0bEwrMS95cnZnL0ljaXJPNno0c1dCZ0twTnBD?=
 =?utf-8?B?cXZtQTFjTThqdzZoTCtROHBicVJZa1owZktGK1ZjTkVZdTVmQmF2bklRSWRr?=
 =?utf-8?B?ZDBPdUFBY21hNDR2K0s4U056L0ZNTWhNdWNiN3Aya1htNjhXeXZHeWZGWXJw?=
 =?utf-8?B?Q1lPek5mK1NzYUZlMlJhUzBtWEt4Tyt5TEZWT2lDZnJvL3BxVUM4THBVM0E1?=
 =?utf-8?B?dS8xaU1OSFpiUGI2TldYcVJGRDk5UmY0SGxxMGZDcVVTaG5tT3UzYyt0WnNG?=
 =?utf-8?Q?LmsvXU33acCAOhdk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a4093-2e31-41b5-e865-08da44cb5f08
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:09:09.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bw1XKOt31RU9RQEgFZQS2W/vxCOXJ1tRXA+CcxRlb7RwoBj0zBy5+qkV5dvoEP6Y387/05npvIJN1fPDo3nwYHaS9qHNgxn4Rge2S013+i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1410
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_05:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020081
X-Proofpoint-GUID: klADcdvqPyFd6R0aWkVEouUJPTVZfq8M
X-Proofpoint-ORIG-GUID: klADcdvqPyFd6R0aWkVEouUJPTVZfq8M
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/22 8:49 AM, Oleksandr wrote:
>
> On 31.05.22 00:00, Oleksandr Tyshchenko wrote:
>
> Hello all.
>
>> From: Juergen Gross <jgross@suse.com>
>>
>> In order to support virtio in Xen guests add a config option XEN_VIRTIO
>> enabling the user to specify whether in all Xen guests virtio should
>> be able to access memory via Xen grant mappings only on the host side.
>>
>> Also set PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS feature from the guest
>> initialization code on Arm and x86 if CONFIG_XEN_VIRTIO is enabled.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>> ---
>> Changes V1 -> V2:
>>     - new patch, split required changes from commit:
>>      "[PATCH V1 3/6] xen/virtio: Add option to restrict memory access under Xen"
>>     - rework according to new platform_has() infrastructure
>>
>> Changes V2 -> V3:
>>     - add Stefano's R-b
>
> May I please ask for the ack or comments for x86 side here?
>
>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


