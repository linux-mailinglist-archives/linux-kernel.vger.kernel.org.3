Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A95AF008
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiIFQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiIFQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:12:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C927DCD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:38:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286FY67i031688;
        Tue, 6 Sep 2022 15:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Gr/Y+jG7NGpoeRocGvkudhbVRDZXNKvIA7QCaPiHjIs=;
 b=OB19HIGsDRcF8EyLa+pRgacpimze2MqVhN06jGgnWMDNUdLvztvFgXD5+JAScrPxNuaI
 1VKwWxs8ciuRVxOR9YoqgvogQEndCRUlS4x72h2PaVaYKYC98jykI/frOHAmikyoBON5
 HAjTzqayYvPLMzpp03K2cF683Y0X0SZNKeh6O1p97xsvdOPaSeAqkbXpPca0TO87nxUv
 lx2YBg6O6zRvCl8XvJBPDcttX+3hWOthDC8z8ila4NhQBW+pWR7+kmE938gitZNy6RFy
 7cYDXYPhgAFT9aMeZobduL/Z7FaDy0kdp+IFaSb2Ro2sh95wxV7HP775WW1hJ51IzUT3 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc66xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:37:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286F6rFH031261;
        Tue, 6 Sep 2022 15:37:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc31uuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTYitIHw2Cc3vuQNJjFfwostRYwUbWfSpUhFdG6V3Uuq3F5keB12B4opYEP383prZwoXzWQvOb3+uPoFbQRaKLWWifjdG54EAwmsGfR9xMlAuuUYUFWAq4w7OY+6K98GI6vGWsgAb3Fw3hu7xKupZl9/CWcvqhDvsigkJUcJPy14UXn9T8UwnWdZGqO14ypCfAXwuKLzY1GJ7rDIrN+xeAEbOGyPLI7JYWTIrdf4Ed/wvNSVBvHtEAmFfh/EZUshaZ34+mxUlRLl+jP+jJuaJZQPSVWo8DHYcRL5wmxgucu7+ziu8V+NB/7db2QIHnSN940h/X+pPs+ptzbg+iNW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr/Y+jG7NGpoeRocGvkudhbVRDZXNKvIA7QCaPiHjIs=;
 b=ZR/XvmG7ECcY7Z17clDJ9ldkdOxdpyICPr/fJcOsQ+ptLbArIMoGblIiaYopG/yv0L2V6peSgybjtLoTaK/Vkn2LwWQ9/Rti2QyINym4HJuxOr1hsZ4I/szkUl2Gq/PM0FeO2F9GFZ7nTqAuHGOhKlMhxzHclxfGx0/vhi4qu1X/uqCquCQco4UfNt4sJRQo3Up5s6qytP8ue5CVVne+FFmzKD80scw9F/zjcxzhXQ6tcvcT2k1gmPotyXf1hfqGCAkNDMx0T2LWWVuPY4Sd8XIbQnMK1RYJQlOLQpBlK+/cgoAT9ITKgzqhGm0hTB8SNeXBEHYJKF8ve3r1Ib4OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr/Y+jG7NGpoeRocGvkudhbVRDZXNKvIA7QCaPiHjIs=;
 b=fIX1I38JXgxutY7FrCfHbT5OUbcJmjOL642waR1DerF/5CuP87eElqXFhHqZTItm0XwCltMoxtWSaeETb1x0PGK0SLRBQoBFf3rAxgm16Iea/JQRynj33oszcYITAHvnRZHV9/0hwDKbduDXLdyzqHivgyQSWo9dGcSLkNHzk44=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 15:37:16 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::e1ce:c71a:bc5a:594d]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::e1ce:c71a:bc5a:594d%5]) with mapi id 15.20.5588.012; Tue, 6 Sep 2022
 15:37:16 +0000
Message-ID: <7f001993-fcc5-10da-3aa1-b6c7bd5ed149@oracle.com>
Date:   Tue, 6 Sep 2022 10:37:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v11 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-8-eric.devolder@oracle.com>
 <YxVqqUICujTHnzsM@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YxVqqUICujTHnzsM@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:36e::26) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d55ff84-c703-4896-2c74-08da901dace8
X-MS-TrafficTypeDiagnostic: PH0PR10MB4693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBFKJjNgKNNRbT3zYt/mFSzb63OHMV6NE9pDiqK9PXrjbJLPxKP92HLZYrnHHo6O4wV2xyl8M9eRwbgmtvsUPbXw5yV76zMmR+CgMvZvj8REU/iZ2wna5KdAxU81IpWIpQK3QYNNlsH2lSRXI+EcNgX20Y1d9cPmGHQcRgCf8CEU/L9dEmKzC+PczvZ0yieaMkwJCWWmbAqcFyrihDod9uvq1GLjreU2EHoYZgntFexIkGUM844OxjWmccKifcqcjx0ZI77b+wARpGOMtgaLfDSlGd7mqVI0//Thp4INJ2Mpscq8CA50UQJxF3RgRDEXgdSEb7Xw9Oaf7DtZmrsn+lKcemVESzwhV8+nqFmpgr2AySXrq69qVMEZCKFs14IR76RWT+Xd1UQnk3ai4fyfc4CegOHXcGML9iYzbmXMAL54tIPTniqlQ/72lGGIxYuwFYqcJ/rbok5RzJH3onNpVj6hU2bUc87CUyfw3cxgi4xTBsjeg4opjRRwpccOzjfyx16Qoo1Ybhm4/zvxiWzb2La5sy0IaPxzxszT8siO1H26uwnTj6y3UhL47Br2tk6wZWNSCwzUkypK/1TZaSdqNeZS+keZROCNO89B9ckqHm/03nWiSdpndC07JLH0TNzv+y3RXbe7T73F8pIB01x+AIRGrabHBJxbwsj+QDT+HujWBQ4gWsvxs051LHP1CAqzsGmVxbxGFdwVOpsQnyong/8+jKuaVnF3EEXsfbWyfY4hqXetqPNxd8vuYvTagywGXmY7+1Aw+MRahCVNai+OgF/cSEYsBMt9YMYp1q2Tgvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(346002)(136003)(86362001)(107886003)(186003)(478600001)(6666004)(41300700001)(6486002)(2616005)(31696002)(6512007)(38100700002)(6506007)(53546011)(83380400001)(316002)(5660300002)(6916009)(66946007)(8676002)(36756003)(66556008)(31686004)(2906002)(8936002)(4326008)(66476007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdwYXBtQVphWDNhcXVjMmFuS1lPYnJRS2lxYXF4a05qUU5hYkkxQTNwSlkw?=
 =?utf-8?B?S1pZSkpzZUdmWUZZVWVRUDlIUGFrekZ2VlFGb0t1ZW9IRHJXNVBkSGdFaUhw?=
 =?utf-8?B?UDM3WDFyYTR2SzZyY2dIN1dkUGZtSTV3Zk1Tc3JOc0ZmVnhrd2R0YjRuTkla?=
 =?utf-8?B?Z3RhLzBBM3RVQjZDWVQxa0pPeXdHMEhSenl5M1d2YWp5YndQajhoWW5nYWRZ?=
 =?utf-8?B?WjZESEhvUWt1NEZnczdYUWpwVVJaaDZpYlZBVFUyMzYzaWhGMlhmMlpQT0Zh?=
 =?utf-8?B?WHY2ckw1NGM0OUZWV0RyU2RjOTBOQ3N6bEduRDZZSFlqczhWWXNadHU0MGQy?=
 =?utf-8?B?TTRNSVpOK21GeXk4dit1WTRjemJiWHQweFBGd09aTjF3dmhKc0NRaGN0WXBH?=
 =?utf-8?B?RXJkbjNzbW1VN3pxcFJOM3ZKT3UveHRJN2kyalgrZDFQK1ZxZHJFUjFCUlQw?=
 =?utf-8?B?RHlZZlpXSjN2U1JrSlZiUUhnWXhSZzdwUmVISEl2OUV6QmpNOGZTTFlzbkZk?=
 =?utf-8?B?cTAzT1hrWHJ4ZkJ5ejJZWTQ5ZG1FY0Q0RzZkNnVBNkVjSmV3UVhqQXhBRTNM?=
 =?utf-8?B?MndiU1B2UTF4TDlJenlkMCtYbWZ6NGRiVy94cHlCcnBRbVpXdnRzcnZrdmVK?=
 =?utf-8?B?OUI5UDBOREhOaCtqSFl0VVB6bkRPdWcxeDRLbEJaMVViWnltanU0R2ZPS1J3?=
 =?utf-8?B?TGVURk56VzVxWnNiK2cwcWI1RWNsVnNBblAyZC9ZMTUwZEY0OGpKVzJmdXVY?=
 =?utf-8?B?K3lqYnBhNVNud1d0OHBlRnU4NWNRbENOR1pmNEtPSndXa0xBbDdHVndHU0Q2?=
 =?utf-8?B?WmxRZXg0ZlJ3QjZCV2M3MFdacmRLWkZHR2tJdVRnUG51K3NMN0VlL21lZ0JH?=
 =?utf-8?B?Rnl1aHNVaUhTcWF3SUdMbWkyWnpjbTJQYWVvOU1Ld2tRYk5rcVRndVFUdGZU?=
 =?utf-8?B?ak9RWUg2WEJiWEM4Z01PQlk4MVQxQmFPRDZHTU0rcXdaYStkZTJBdXU0RU92?=
 =?utf-8?B?RTFuZVlnWmd4VXh4RFRKdnB6VFJ0bUFaKzVzNGptRk1VN2hxWVVNenVkU2VJ?=
 =?utf-8?B?c3QxV3JVVStsZmFDYVBnU3ZuZVUxTmFCSE0vZzFmTnlNSVMycUpLUWxDQ3Fy?=
 =?utf-8?B?bjE1dDFRSXAwWjM3S3ZiTzZtYzBRSWI1WXNUbUxoSk1JL2tqajJUL3VzQzRz?=
 =?utf-8?B?UTBjMm9nZ09kNE9OLzJ3NUlVVGdWNFJXeWhEUVFnWTdCM0U1N2ZlQnIyRHp2?=
 =?utf-8?B?RUdRaXlXUDJDeUNsckg5M3p0SXVmWDFGQmxmYUpKU2hwTENEeHZWUXFnRHdK?=
 =?utf-8?B?ZGJtRXJLcm9LNFM4QmVrQ056ZERWVHlhT3plNGVxKzhrZjNwZEZDd2JSeldO?=
 =?utf-8?B?V2ZORFh2Rm5yZk1lYXBQTU1nODF2YTN3NWVVdzdZenRic01mSDR3OUxlc09o?=
 =?utf-8?B?dXpHTXk0LzFidWFCM3JxNFZlUkRhOHQwRXB1NTBjVzRhdXVHUHdjalJ6MzJQ?=
 =?utf-8?B?L0dBZlJncTNaN0s4cFV0elRXNk9BanQ4VGU2aks3UE1iaVhMRG5oaEFrdzNC?=
 =?utf-8?B?VGJSVm9GRVViL1hJWnhidXF5T3ppY1o5b0Q5RWhlMVd1NUZFT0RqMXVNeG9Z?=
 =?utf-8?B?eVhzYkVPMElteWRNRVlma0hwZ2VmK2hPc1NuazlSc3gzZ05tQkJlS2NjTXF0?=
 =?utf-8?B?Mm4raDBWWXM4MmxqMUVVU3VQM1MzM25rcDhEcENDQ2lIVE11TTFMT3lLSjRI?=
 =?utf-8?B?UE85M2wrcGJxOFZoUldXMkYzdTVSd2F6RzIwTGR4K2tBVG9nSjNMVzJBUStQ?=
 =?utf-8?B?U21oYTE3SUxTd3BLWnFockszV2NwTmkyd1k1OUVZTTFvMUpWaUozbHQ5b2RV?=
 =?utf-8?B?MHJJRlpBYjJpR3NGZ2JDNTA1c1pRZDFwWDBndEgxc0xzbG9ZVHVwdVQzcDc3?=
 =?utf-8?B?dTRJYi80UjBrSGh3aFk4clEwTSsrYzZMMTJjUDVzRUVJQitQZFRSb2NIdDVI?=
 =?utf-8?B?V1p0ZHZQNU5xWnk5OVZnSzFBcndsY0FtUU9MeXBlMm9ra000bzh2RnE2a0xR?=
 =?utf-8?B?VmRKYUhTVHFhVEw5WkZoNjRKcHR6Y20rNERVemRGVHhnR2Rqa3cwL0ZoN1Iz?=
 =?utf-8?B?ek9KRzlWMGxHM1V6dGl1Q1F4dnd4cVhsNCtrL0wyZUt0RFVTME0xVXp3U0p0?=
 =?utf-8?Q?oFYgi4KAf85vkvtqlg5VJoA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d55ff84-c703-4896-2c74-08da901dace8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:37:15.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyxvSea6PdZWqaqKFzKdw+3KMbceyKezrICEnWPuIF7FcMTnPesUwD+PZ8oaJ9b/rtXKrm1hwP5n987zDK6MS5qMUsqjtSHWaaYDl8cKMQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060074
X-Proofpoint-ORIG-GUID: G1aK_TXvQg32uPPWohCXn25XlgyJj1t6
X-Proofpoint-GUID: G1aK_TXvQg32uPPWohCXn25XlgyJj1t6
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 22:19, Baoquan He wrote:
> On 08/26/22 at 01:37pm, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> When loading the crash kernel via kexec_load or kexec_file_load,
>> the elfcorehdr is identified at run time in
>> crash_core:handle_hotplug_event().
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. The kexec_load is also supported, but also
>> requires a corresponding change to userspace kexec-tools.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig             |  11 ++++
>>   arch/x86/include/asm/kexec.h |  20 +++++++
>>   arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 133 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index f9920f1341c8..cdfc9b2fdf98 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_MAX_MEMORY_RANGES
>> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +	int
>> +	default 32768
>> +	help
>> +	  For the kexec_file_load path, specify the maximum number of
>> +	  memory regions, eg. as represented by the 'System RAM' entries
>> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +	  size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index a3760ca796aa..432073385b2d 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>>   extern void kdump_nmi_shootdown_cpus(void);
>>   
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>> +#define arch_map_crash_pages arch_map_crash_pages
>> +
>> +void arch_unmap_crash_pages(void **ptr);
>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>> +
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action);
>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>> +#endif
> 
> Check these two functions again, wonder whether this is a common usage
> to show support of a feature. I don't remember where we do like this. We
> usually define a global variable to mark it? Anyway, it works. See if
> other people have comments, I could be ignorant.

These functions are for use in generating the value of the associated the sysfs attribute.

The default-value function (which previously was a __weak function) is in include/linux/kexec.h and 
the arch-specific override in arch/<arch>/include/asm/kexec.h. This default-value function sets the 
return to 0, for not supported.

I looked around a bit, and don't necessarily see a precedent. Then again some of this conversion of 
away from __weak is still making its way. I did briefly experiment with using a variable but decided 
there would still need to be a similar function needed (mostly likely on the subsys_initcall) in 
order to properly set the variable. So with the move away from __weak, it seemed to make sense to 
just keep the individual functions as they are now, in the spirit of the move away from __weak.

If the variable is still desired, please let me know. I'll post v12 at the end of the week to 
incorporate the fixes for some of the nits previously identified!

> 
> Other than this tiny concern, this patch looks good to me:
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you!
eric

> 
>> +
>>   #endif /* __ASSEMBLY__ */
>>   
>>   #endif /* _ASM_X86_KEXEC_H */
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9ceb93c176a6..8fc7d678ac72 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz =
>> +		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>> +			sizeof(Elf64_Phdr);
>> +	/* Mark as usable to crash kernel, else crash kernel fails on boot */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	image->elfcorehdr_index = image->nr_segments;
>> +	image->elfcorehdr_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +/*
>> + * NOTE: The addresses and sizes passed to this routine have
>> + * already been fully aligned on page boundaries. There is no
>> + * need for massaging the address or size.
>> + */
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	void *ptr = NULL;
>> +
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap_local_page(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap_local(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + *
>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>> + * is prepared in a kernel buffer, and then it is written on top
>> + * of the existing/old elfcorehdr.
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +	unsigned int hp_action)
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/*
>> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
>> +	 */
>> +	ksegment = &image->segment[image->elfcorehdr_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = arch_map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/*
>> +		 * Temporarily invalidate the crash image while the
>> +		 * elfcorehdr is updated.
>> +		 */
>> +		xchg(&kexec_crash_image, NULL);
>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	arch_unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif
>> -- 
>> 2.31.1
>>
> 
