Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3A510B31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355389AbiDZVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355383AbiDZVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:25:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B71527A4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:22:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QIgYjN032179;
        Tue, 26 Apr 2022 21:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NCM0dux74g/FcoSNomWfVox3pj4pfCDR3BB5aGGB8jE=;
 b=q7RcniTPtIfcb4nkIv3K7iHArGOWhcpAdU8oi27Ur/seQs17/ghmA/MSkCmoyCvj8AlC
 3tw2QYOfy5EnuMKPf6LKjkawnv10INC8CBVKMzYWjmQNcvkr4O3p7PLat1cZN6UyyAjf
 R+XMHCZEPFwlgyyUi9RIT1Of33pglZjN/uyMw4gwWnOCy8CE+S6b9uNyjuajoMEy/dEd
 P+DdL/kvJpdEg8Aq7OnyBxnTBh5/g8SnpPo0FB7L0VX6fUZmlypnixznIVnJ9DAfDB1O
 QTL+S09p4TB2v+RqrCUGse05BvtGDjtuw2zs0l57R350/4NiiPmYRUywde4eoVjz8Lc3 CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yy36t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 21:22:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QLAWqx030645;
        Tue, 26 Apr 2022 21:22:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjxfwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 21:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoylBl1x4GJKa4KZbs/ih2YqWJVWHplQvaYviPIEB4N2MrXtpjAfTdEQV88K5nBaQoZd5Tr2sFxPZAe0xf5RrEzhZkBeMtgy6FK2AtKQNEQ1QisoSNoyFRzFVxGiCrXId6J14am4mkGGk18KaO/Gp97449ElojzGrJG25fEuqEKnKovbGtsXNR+nBXMQNAMn9czO8KtaE8zR0K5hrW4nxrYOyIKf/2Za2EdxJZbIcuOkY3tXZsXQKCy/SA2Ge5oReh+hwLuWcj4XqtAl8pW3J2rIBKOqpKSPXCvJPefQYb4e5oKxmeT2rTi9rVDsNsiZQgF6jtWdmPGOnIDYNRWREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCM0dux74g/FcoSNomWfVox3pj4pfCDR3BB5aGGB8jE=;
 b=mfugdKR/GtNugei69S/nzJtUMduDvYNsT1O80O8hnUw+29P8E8LEo30QDHtaEuNPcvRJzzxUGDIq1Os1hvhCMgfq+lfGlLY92Z6OjgCYeSdcGj2T8Kcly2G1RQrfftqHwuSyB3u7BtlTihhzoLnNUH/vWPd2VFFSr1MN5dlT/EzYHanjCsHpcK3d14YUqG9AxOgfZcJTu35xsWCyd5RbSCJidlLtlgLTnos89jNR0ok2KLRO2gfTTLCWEBaP0KDR1iL4GXRS0Cnjmpipvp6x3XKiS9azRWvmzFvWJptvALG/JoEAYBqWsBOCYk4Tnq6OePc9+a038+02U4LYngY/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCM0dux74g/FcoSNomWfVox3pj4pfCDR3BB5aGGB8jE=;
 b=IUDFIOeBLHXTlRWMUZRdu+nSPqzfM0VmlJf9D+siTT5zwIg2T04Ob5WT/wZtP0R3JPg/N6yJappHPvwEB4l/ekeUC7iQOO+mJ7jBlNGcHjjb0PHwX7DB/yaB2NSXsDDcbQCXmwx6ZxMJBxGylu3blhiwpQmutmlnATC5fdWfMGc=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DM8PR10MB5448.namprd10.prod.outlook.com (2603:10b6:8:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 21:22:10 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 21:22:10 +0000
Message-ID: <c0a068e7-18e3-87df-676c-e8270cd732b6@oracle.com>
Date:   Tue, 26 Apr 2022 16:22:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
 <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
 <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
 <2b6ed542-b3e0-1a87-33ac-d52fc0e0339c@oracle.com>
 <eae41639-cbca-4ea6-417f-f9b34a7138ea@oracle.com>
 <020aef66-6911-77e7-fd1a-25506dfcd3df@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <020aef66-6911-77e7-fd1a-25506dfcd3df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0064.namprd19.prod.outlook.com
 (2603:10b6:208:19b::41) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68927a65-3f2f-4b8f-fff8-08da27cad313
X-MS-TrafficTypeDiagnostic: DM8PR10MB5448:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB54486AAEA89C0577EA8CE2EBC7FB9@DM8PR10MB5448.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiIgNckxOXVZxVQxQQpJKo9/bz1TdGN7Gbk14ulV+mAXHUyVpSi7Uo/vDee/kXEhsfv3fED6sYCKAQ92o7Wa4NYCII/bzScDZUcPzpVJml7PuqkWoyRyj8cVmXAs8e/NlkwP0dd5+QIoB2rYFFYRsOUkF1xrUWFbDq1EtljZ763SSBCNeQG7Gy8XAufjFbmlQIsc5EhnsBzPEoHbeJ81g1kwNMzDXt+Q4M6y8XJP6C4xdVsP2Z7o2VRizw9dWcykZO2z4S2t6RhWjmiFJMyUIJinVeaPkmw9xHTwzgigI4eHoB8fqCxP4bxKoJGdi7RYATU6zPfHsN+Osi/6Ct93lX+VwE3m9tEvIHdqh5FK5oqnl31rWSTQguie6HRZ8XgFwt2/+oqe84J29Oe3MaQqjAWh/sQ8jVtQNBvLGYznnwAm439vBhfgdUSEU53HAytAfq/dkXCValOrDYYeZkJe73U5EsNJ2wmAlMkVh/ioiVZRyqgKZEu2NvRnN/nZTjsRjuGbEZoMCv3kcrgHxGUybUcqw21Mi07gt/ml1A+fMHHX1z0vmkl1eumagqj/lqJrUgeqToXbJSO4HHYEhF0Hbv4INu9H3T41jJV6hGW57kYA20NTTLrq1jLZLGTv79bsXNh0yfTtmbg8qV8tBCKIDiqgfLhrPJDDGpSwL8my9mMxlHFIMT3UL3lznB/IiNs8qc2xxrzrtneYAQLvmPif7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(31696002)(38100700002)(6666004)(186003)(5660300002)(26005)(110136005)(31686004)(36756003)(316002)(66556008)(66946007)(8676002)(66476007)(4326008)(8936002)(86362001)(53546011)(6512007)(9686003)(2906002)(6506007)(508600001)(83380400001)(6486002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVF6a25DczJLRW51S3pRQ0xXVnhiQ1FVWGR0RnoyZ2w0bGFIQnNJZmpWWk9v?=
 =?utf-8?B?RTVJUHBFaGcyR2hoNCsyVUxROEl1ZjBMK052TFRVN3czOWs3UUovY1o1NThG?=
 =?utf-8?B?UTJ3dUs0c2FWQjhOaWxmMHErQ0xiMnV3WnROU1J3bEtwcmxGR2JwOWo4Ungw?=
 =?utf-8?B?UVNvTWlKVGF6OXNUblFvYUQvbytCMjVrYzdFVG9NOGE4R0RBcGxtdlY2ZitQ?=
 =?utf-8?B?NUMveWx5eVVvUGpMdGdlclZNbGR1d2VORTZkZXZpSFAyaU5mZ2pxVDFuTHBp?=
 =?utf-8?B?UkpVVVpIQXFzbURtbTVxNUFkYTBIcnNJR1VLWjlvTVFxcVQ3Y3lCUVhoYVpW?=
 =?utf-8?B?VTI4Q1NxSTlCT1NPdDdOS0pGeXpobXZJYWZNSUUvM2NxT0YvZmZYMVludmFB?=
 =?utf-8?B?T01QblV1NjltU3oyQk1rYnQ1cHZ4T2ZrUFYrbmpySFZta0tTdDh5MzVWSWdD?=
 =?utf-8?B?WFlENSsvenBjWUdwM2R4V2ZTQ1VyemM5dGptdit5cUNDdzZ6RHhjcWhKMUd0?=
 =?utf-8?B?U1pVNURSdkFZVUU4ZkFtNzA4emowOEc0aXNWQjhnTW1Va2Roa09RaytveE53?=
 =?utf-8?B?czhkQ2FEcXMzUHRhcGxZMGNYTTJBK3c1SkJkd290UWpMeHg0V3AxNWFMcTB1?=
 =?utf-8?B?QkJEK3QxMENvbmZQSzlGOE53YVR2TlNWaitteWFocUZjRTA3YlF6K2RMNmF5?=
 =?utf-8?B?cGp4Wm5kbWtMVjRuUEdNSEtSMzV6RTdWR3U5MFF0L21jZnc2dVQzNnpLMFNR?=
 =?utf-8?B?UDlUemsyZHpkRFB6SjdvTTJmRWE3MGppZy9xVDM3WWduZTdpa3lMNUxGNmdP?=
 =?utf-8?B?Mk5BaU91MUlKb2NsRm54OGxQenY3RXBPZHFudmNqRC9aTmhhaEFmd004NmxU?=
 =?utf-8?B?SEVVemZzQWhQcmZWYjVZUSsySXV0MjdNUXBJdWZvZUthOFJKNHBhKy81WlFE?=
 =?utf-8?B?NUdKTm90bHVpeFpKR3BHbUQyNmpNTlVzSEJGMVNXMHl2MmhreUs4Y25Ebjlr?=
 =?utf-8?B?ZXpPK3pUVTcvNnl6cUlhRG4vdmJhek9yUkxDSllaMmxLRzh4dSszbk5UUXNj?=
 =?utf-8?B?TERaVjlUMUh2d2FIREZxVEttTjJMWHNoUDc5K2ZSTndtUWJ4QURhRUd0eTZm?=
 =?utf-8?B?ZDJubGowOHNrNUt5ZEptVC95U1B5TzhrNVhYbllyd2tyOGdRWjNRSjZWTCtl?=
 =?utf-8?B?Sk9SbkFVdktkNTUrZW83a1NpSk8vR281V1cveVJsRE5VeWlCKzEvZHY5eUMw?=
 =?utf-8?B?SzJET1Zpd3JPQ2EyTVQzN1VTMzd2U3FBcTg2ZW9WbVZ2NnhCVHZwdUJ2d3Ba?=
 =?utf-8?B?V290ZEEwb3A4NzhlclRoZ0VlMU1TY1IvVkdvM1lkbTJrTUd2N2FMdnJ0eGp4?=
 =?utf-8?B?Qml3QTd5UzVDQW0zMGhGa25Md3FGWkVhVUMrOG94WHpPTmFBQmtQS0VRcWsx?=
 =?utf-8?B?WGcxbU9SUGJzNE1OdjZzQi9MTmxwcWdOZ0Npa080SnNsRVFwNHlhZWE0ekgw?=
 =?utf-8?B?Q1M3bXhuVWJHbUxtT3k4NUZQWTFBRjVpb3Q4VEZqKzZuU2xpZW1XMGVSRDVa?=
 =?utf-8?B?ZThTVVJ5cWtwSHNIZksxV0hvb2VKNHl4czdZVEQvZk9hc1VvamlBWHdpcDFU?=
 =?utf-8?B?ZmY2T3diNWlrekZGWFJWVkwrbmNjSEV5NmtRRkxSbFNISlkySkFHYXZsa2JB?=
 =?utf-8?B?VXNjTVNOVVdUWjk4c0VPNzIwYkVQTi95NjlFQWFBMHVJNFAvTDZaZGFrVzk3?=
 =?utf-8?B?NjlURXo1dHNtU2d0RnBTOFFNZzVUYUViNFJxbXpneXVUYkk5aWtBbGt0WEtP?=
 =?utf-8?B?N0Z3bGJSNi9hTytoVWRBcm5zeWp4YTdKOEpRQU1ZVjNHMml5eHF6RXdUYnEr?=
 =?utf-8?B?WTR0cnQwYTV5bU5FMDU2OHhXUTJNSWxUVzUxbXVGc1NqYWduZmcveXU5dlYx?=
 =?utf-8?B?eHpTYlFZYWZXNkR0OXhRN3pQUXRKWkZDa1cyR2dPcThTNndGbkxIRUdNV2xY?=
 =?utf-8?B?STRyT2RENE5hRjNLMW1lQklDRGN1eE1ZZlAxd3Z0dFU4Sm9XVHFzc3N2c09V?=
 =?utf-8?B?QjQrMGgyWnBsT1pYaGNGQ3oxaFhFeVRabGxHZWdiN1U2M1NFUmI3Tjd4NjB2?=
 =?utf-8?B?Rm94VVdGbnNkWkZmUXA4OWNNTWdLY1pVbFRWaXRpdTlYbUZQVTdGV1E1Y2xI?=
 =?utf-8?B?OW05aU1ndjdEMnV4elJWYzNud3RKbFZWek5KdHB4MDI0dysvZVhxYVVNT2p3?=
 =?utf-8?B?Sm16TEwzckMzUTBmUnYxc0lneGpXbkhCYUdtRm81V0RvaW9EdFlDOHc3RVhB?=
 =?utf-8?B?Ym1hOTExQlFUQmpKa05TeVJHWFdraU1XL1NXR3V2WmZnWnFXLzdZOEsrQ2c1?=
 =?utf-8?Q?VaB0g0U4KzmjRa3c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68927a65-3f2f-4b8f-fff8-08da27cad313
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 21:22:10.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJUd5gisxwwd6td0k8yD0zn2w3dY7npJ8v3aeAa3fRfklZ7ROHlokKVyzhyhGmdSAnvW2hV4K8a4XU5sSS5KuYaE92tzdYwIM0Gz1RBj+ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5448
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_06:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260132
X-Proofpoint-ORIG-GUID: cPvs-9bJbbzDyvbcuexKVcNgfGqvoTwS
X-Proofpoint-GUID: cPvs-9bJbbzDyvbcuexKVcNgfGqvoTwS
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 3:21 PM, Waiman Long wrote:
> On 4/20/22 09:55, john.p.donnelly@oracle.com wrote:
>> On 4/12/22 11:28 AM, john.p.donnelly@oracle.com wrote:
>>> On 4/11/22 4:07 PM, Waiman Long wrote:
>>>>
>>>> On 4/11/22 17:03, john.p.donnelly@oracle.com wrote:
>>>>>
>>>>>>>
>>>>>>> I have reached out to Waiman and he suggested this for our next 
>>>>>>> test pass:
>>>>>>>
>>>>>>>
>>>>>>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>>>>>> out_nolock path
>>>>>>
>>>>>> Does this commit help to avoid the lockup problem?
>>>>>>
>>>>>> Commit 1ee326196c6658 fixes a potential missed wakeup problem when 
>>>>>> a reader first in the wait queue is interrupted out without 
>>>>>> acquiring the lock. It is actually not a fix for commit 
>>>>>> d257cc8cb8d5. However, this commit changes the out_nolock path 
>>>>>> behavior of writers by leaving the handoff bit set when the wait 
>>>>>> queue isn't empty. That likely makes the missed wakeup problem 
>>>>>> easier to reproduce.
>>>>>>
>>>>>> Cheers,
>>>>>> Longman
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> We are testing now
>>>>>
>>>>> ETA for fio soak test completion is  ~15hr from now.
>>>>>
>>>>> I wanted to share the stack traces for future reference + occurrences.
>>>>>
>>>> I am looking forward to your testing results tomorrow.
>>>>
>>>> Cheers,
>>>> Longman
>>>>
>>> Hi
>>>
>>>   Our 24hr fio soak test with :
>>>
>>>   1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>> out_nolock path
>>>
>>>
>>>   applied to 5.15.30  passed.
>>>
>>>   I suggest you append  1ee326196c6658 with :
>>>
>>>
>>>   cc: stable
>>>
>>>    Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling 
>>> more consistent")
>>>
>>>
>>> I'll leave the implementation details up to the core maintainers how 
>>> to do that ;-)
>>>
>>> ...
>>>
>>> Thank you
>>>
>>> John.
>>
>> Hi ,
>>
>>
>>  We have observed another panic with :
>>
>>  1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock
>>  path
>>
>>  Applied to 5.15.30 :
>>
>>
> Sorry for the late reply as I was busy with other important tasks.
> 
> When you said panic, you mean a system hang, not an actual panic. Right?

Hi ,

Our setups turn on all the panic on-hung-task , on-opps,  all those 
various features:

./sys/kernel/hardlockup_panic
./sys/kernel/hung_task_panic
./sys/kernel/max_rcu_stall_to_panic
./sys/kernel/panic
./sys/kernel/panic_on_io_nmi
./sys/kernel/panic_on_oops
./sys/kernel/panic_on_rcu_stall
./sys/kernel/panic_on_unrecovered_nmi
./sys/kernel/panic_on_warn
./sys/kernel/panic_print
./sys/kernel/softlockup_panic
./sys/kernel/unknown_nmi_panic


The machine is unusable when this occurs.


> 
> 
>> PID: 3789   TASK: ffff900fc409b300  CPU: 29  COMMAND: "dio/dm-0"
>>  #0 [fffffe00006bce50] crash_nmi_callback at ffffffff97c772c3
>>  #1 [fffffe00006bce58] nmi_handle at ffffffff97c40778
>>  #2 [fffffe00006bcea0] default_do_nmi at ffffffff988161e2
>>  #3 [fffffe00006bcec8] exc_nmi at ffffffff9881648d
>>  #4 [fffffe00006bcef0] end_repeat_nmi at ffffffff98a0153b
>>     [exception RIP: _raw_spin_lock_irq+35]
>>     RIP: ffffffff98827333  RSP: ffffa9320917fc78  RFLAGS: 00000046
>>     RAX: 0000000000000000  RBX: ffff900fc409b300  RCX: 0000000000000000
>>     RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
>>     RBP: ffffa9320917fd20   R8: 0000000000000000   R9: 0000000000000000
>>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff90006259546c
>>     R13: ffffa9320917fcb0  R14: ffff900062595458  R15: 0000000000000000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> --- <NMI exception stack> ---
>>  #5 [ffffa9320917fc78] _raw_spin_lock_irq at ffffffff98827333
>>  #6 [ffffa9320917fc78] rwsem_down_write_slowpath at ffffffff97d25d49
>>  #7 [ffffa9320917fd28] ext4_map_blocks at ffffffffc104b6dc [ext4]
>>  #8 [ffffa9320917fd98] ext4_convert_unwritten_extents at 
>> ffffffffc10369e0 [ext4]
>>  #9 [ffffa9320917fdf0] ext4_dio_write_end_io at ffffffffc103b2aa [ext4]
>> #10 [ffffa9320917fe18] iomap_dio_complete at ffffffff98013f45
>> #11 [ffffa9320917fe48] iomap_dio_complete_work at ffffffff98014047
>> #12 [ffffa9320917fe60] process_one_work at ffffffff97cd9191
>> #13 [ffffa9320917fea8] rescuer_thread at ffffffff97cd991b
>> #14 [ffffa9320917ff10] kthread at ffffffff97ce11f7
>> #15 [ffffa9320917ff50] ret_from_fork at ffffffff97c04cf2
>> crash>
>>
>>
>> The failure is observed running "fio test suite"  as a 24 hour soak 
>> test  on an LVM composed of four NVME devices, Intel 72 core server. 
>> The test cycles through a variety of file-system types.
>>
>>
>> This kernel has these commits
>>
>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>> out_nolock  path
>>
>> d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
>>
>> In earlier testing I had reverted d257cc8cb8d5 and did not observe 
>> said panics.  I still feel d257cc8cb8d5 is  still the root cause.
> 
> So it is possible that 1ee326196c6658 does not completely eliminate the 
> missed wakeup situation.
> 
> Regards,
> Longman
> 

