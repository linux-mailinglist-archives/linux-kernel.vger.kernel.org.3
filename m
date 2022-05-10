Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06AB522337
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348466AbiEJSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:02:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5825AF85
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:58:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AHpicl024511;
        Tue, 10 May 2022 17:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RlV+UcybTstIpIuDKfuw8tsTeZAYteYjVvd9x5SUKe0=;
 b=QFFkNrF114EJWSOfyyu7KpubjqOEG9TIC9hMeJlXWzOUGSTqvJ8k33NdocI4f4q5X0ps
 f2KIBSto3rXLrY8hU7eorfe8xKIFo8iGR4evbzr7WXfrc9MByK1TnI3HcVcEx3PfKsOb
 vKLkp0OIXPh1M0sRg4sYmINDSA91KlWWM5LsmJ8+0hu6ZYPy+dT9XxRzZ5q05to5/u94
 BKVyg8Fan5X2T7X9wCbgkYwaZNL73/xDPX8tswVInvlnhXGuqDcT7s/B79iZbLI03Ask
 UHfN1pLgx+3dkS0CQnrY7bNQuotUHtGNbwQ9tE16Z7hkA+TOI7hHdMDa/aRDvBNMjoaC Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2fk3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 17:58:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AHjbWf010807;
        Tue, 10 May 2022 17:58:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf79mst2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 17:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9+13IvTZ5U13KcFjNnq3OhC50sFrcOfxlzoTT+IBEp/fQxdS1s3E/WIrSuanbMeWqqaZuE1yQ1PN1uJDd6Q6zLHVf47qQfquyLuzRQs6PN4xUzBD3/PQrP4EV6eMW7oPYpnBAd3Zzs+GkxPzIJk5M2wzMqzpJxPBEwOxJ8gNDtyhY748o+ZZcsTJcRs07oYPZuDbKGZ724l26YAoQPaRdoPeOGb2/0JqokElGuCrQrpElZgsep45MEcFzSOfG+oX8ycwj8feBLEjq4vTjzGhQ0AUeY+9BhGiyfxzPCQZgZzieTaxdiYl8jcyBF4fSMxy1vfru2CFbcmd4MB2SidTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlV+UcybTstIpIuDKfuw8tsTeZAYteYjVvd9x5SUKe0=;
 b=DMVTsfKnqBk9ZQE4dm2wc2uha1m0aiL7LdrUhUhfVzBGuvY38Jxkq6wI2eputMcTzWloMRyUmLdPFcGgE9Ou9NVZxRoymWXFqNnrXay2VE52029BKblIy3lxTgmGmAK+ndn3FkKDVACEEwcDtZvrS1hbIhS8mPZLViF8u2nJ2S8fe3n4GkfD58ano4Viqa2XFnB15i0ZRcV2XE6YDv0uDhzFrGsnTJ6tyuPsBbdYsymIQ6FqKtSuFFSpsYXUaH924XDaOK7zAOLoIjSKSfSfBRooTyI6nDmnOqjwC8VtAxHjrtNBqoKhZ1d7SGAC+pq9+fZXzp7BAT6Fq48wUSozSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlV+UcybTstIpIuDKfuw8tsTeZAYteYjVvd9x5SUKe0=;
 b=HtoIH8OuwgJ4NE1eC19F8idnhgxEkSqJBlc9cCp5aakiKcBpGp0jNlBUMbxdNYm6tMllW2bZ+OHlGnyIt7ip1aMMu+bI1dUIFRgK54OWHj9Wz9cmbQDOJgVoFFKz0xMudfNpiW/1yCWwP5504BAYd1l+zrd+A8kgR0zISN7yk+I=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 17:58:32 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 17:58:32 +0000
Message-ID: <7fc12b09-1897-1938-bd58-9b1b5bbd4be5@oracle.com>
Date:   Tue, 10 May 2022 10:58:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-2-elic@nvidia.com>
 <f279bbbb-6af2-95f4-08c3-97ba72deb6cb@oracle.com>
 <DM8PR12MB5400F639C76A0B8198666299ABC79@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400F639C76A0B8198666299ABC79@DM8PR12MB5400.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a68a5aa-23f8-45fc-4473-08da32aeb224
X-MS-TrafficTypeDiagnostic: BN0PR10MB5079:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5079C2BDF48F22A580A08080B1C99@BN0PR10MB5079.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fLr8wXsCW/3RPIWBvHwx6NlqJ0x8QkXV8SlP6HzREubwsame1DhbU5nqZBzdtEVXb0OAvHo4V2BHfqGBa4Ngmfs7v278sq1A+vNusGKaO8iz2YUmNUFHjRVgLwWPMqH9jLHMCI1jHevq+eW7yQRQP9O4QZywmOzmfZGk/gQtF2PUPObjJKa/PCRuMtq9YLYRTp+2QIV9h8+VCL5mB4jHsUKKvQ058cu6h8iX/KlCWSvez9RwtCYruOgO4OuHJelBrbaIkEEQIZi5QgfX3J1jTbgFSQecaizOzmvTo93r1AxkC2eWPTYrxGEdy64GJa/ByJFAxMyIBlwlonVO4CRFFrzBxhR4kFoT5tk541jL6NixBfZGguEnOEWlugZlFnJRbpH3seujtFQ331nQB/oLFGL2FtnpvydbOQo9iEcopWtcMp6cnWbJDVc3/9H0Mljv67PU3j72P0Za0qZT6ocGDUniPacc/I89vERyKmO5Dsr5fG6vHRs0g9ymVJvTWZi0o72P2a5xOwP0NnUxx8+305KbYH8nFohfKeI3DWj67lWS9jJo4WdQdCy63dLWuzZopdZ3r/ZmmVFkSPmpEP4DJMXiaASRQZvbujgYiJ6RXW+ygOq6hR6dwoic/rGSNOOwtDXrMFy54SlEQ4KK0zFSKxoMmMbWv+rBo9KzFP4NBeoEK/5Lh/UuS7TElc4jCuPxngIb0Ad4evunyvv2dYUd9z7nThQ1QM1awB45A7KIt7FcX7ivXcVeLgfTu46+48o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(26005)(508600001)(2616005)(53546011)(316002)(186003)(6666004)(36916002)(6506007)(86362001)(2906002)(5660300002)(31696002)(83380400001)(36756003)(54906003)(66556008)(66946007)(66476007)(4326008)(8676002)(38100700002)(31686004)(8936002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNQdjErWnhFdU5PZ1Jva0JhNEg1eklnL0RmcHZFYzc3WDljOWlVY3ArcUtM?=
 =?utf-8?B?M0pTRmYydGxqbitXTHN3YkpOZDY5bjdsSHhhbmZCZlhoaDdndStnTThocGpM?=
 =?utf-8?B?NDRFMlBMdTkxc2x4Y3pnMGRaWm5pMVFzVzFmclZVRXNWc3NnTk9LL21OWkNT?=
 =?utf-8?B?amNUL1FGSXUxcGpqRkphYk5jZ2oyWUdXdTRVeGVqR0orSXo5U2pISjN2L1ZV?=
 =?utf-8?B?ZUQyczNvT25CZkxJbGtSTk8vTEYwemh6MlV2UUlmN1VzWmU0R3dXQ2V4TjBK?=
 =?utf-8?B?VVF6eDhaTUN0SVptUjZLakVLSFJ5SUxZV1ZMRUFJODRGZ29WaG1LQ3lERENQ?=
 =?utf-8?B?WFVNbEFnN05MWTZPaGNsOThvSXA1bk5qekxONGd4VnhTTEpVcExEdWdwamds?=
 =?utf-8?B?YXlNSEtxVzZyaW9hSDhLN3kwcUNpa3ZNRTZtaVlrZWh2VFBWMUdMcjlPdDlT?=
 =?utf-8?B?M1pTMVpPWGRCUDFLR29QT2xGaWYxajZZMHJEUGtWZ2Nhd215ZnNKRTd4TGlU?=
 =?utf-8?B?ZlpLaEJFenpMdWRCOStWa1A1TzJkNEwwcmtDaHNUWkVjMTUvaTRoYUtsK0xo?=
 =?utf-8?B?bHVmKzFva2RvcWhlK0QvUnBWTCsvUm53cVQ0Vk5yL2s5UG5GRU9sZ1VIZE5o?=
 =?utf-8?B?TkUxRC9jQUlPWXU0dTBONVhrQWxsRG00akNheFFieTlUUnFFa0JlOWxRdVQr?=
 =?utf-8?B?TkpWVVFzUUdWZEp4WXZRVllYdVBHUjlPOGlkMFZRMWFmeVF1R2s0TEVQQ1Yy?=
 =?utf-8?B?VDJzdnZLb3BudnUzWjdvcHV1bTRqT2xTR0d0TEZ3VGp0TnUwVDErdVlXVkNu?=
 =?utf-8?B?VytaZHFQUW5kTXpQOEZDdHVZNGc0Q2VsU2E0UytFTzZkNS9qNzE5Skg1Rjls?=
 =?utf-8?B?b2tWT0o5NndSakxDYkR4WFZkRDVzSlBmdEt5TTlRbWFGOEJiZmIrMGRNR1RN?=
 =?utf-8?B?VENYZnA1RVpzZUw5VjQvUk5uazZ1Y01EOUZ1dGh2aFZxandJNFYvQ1oxWHF6?=
 =?utf-8?B?czdDWlJ3UEl4Y05DdllmeE9ZTnZqU1pha0kxVWM1aG5UUHkxVStVTGRsclZj?=
 =?utf-8?B?U1hRcWdtWVZyWkpSM0MzSE8zQ2RtTmlTM3NaS0FOQmlXM2xtTm5QRUxoZW9o?=
 =?utf-8?B?ckRuQzVJT2E1ckpSTHgrZkJOVE8yUVBxanpwTU5tb0kxVVNrdG9yM212OC9q?=
 =?utf-8?B?MVQyVmpUUWFOZC9nMEJGVUNjTU1yVnhsb3I0cXdlajkyUmIwcmFSTEZWNWc1?=
 =?utf-8?B?bVVQK3YzMUxmc3FOcGVRaCtnSnJvV0gxcmJwcnIyRTFXVWQrNE5udUJac0g2?=
 =?utf-8?B?RGNOUC9Ia2xXaHp2WGhacFBEQzlsWERoT29ndHhJWlZlOW1ZRHEwZTA5MWg2?=
 =?utf-8?B?cXc3OG5CYlhYOFZJMVpWc2VXalJFY0JRSTlZazlaVThVRXIyNFVmMHpkS1NY?=
 =?utf-8?B?Y1BBSHNKMmQ1YW1sMjVSZGFNS0cvL2FnKzZaaWIvbDhMb2R2N3hlV1dlSGVj?=
 =?utf-8?B?bitTZ3d5dy9lYnlaNHk2U2VQZFVTcGsyclozaEFyTXU4Tlh2c1dWakNBMk5X?=
 =?utf-8?B?ZHhHcjBwcG01YXV4YWVqcmozRU1oMklxdyt0bzdPSHRSdUZ5ekV5RHB1MGVy?=
 =?utf-8?B?NVo1MzA0VmNDb1c1MFJDZjhud2U0NlVoTDgyZFR4dWhGRnlpMkIzcll6Mng2?=
 =?utf-8?B?cE1OQ2RVNi9hTXMybnlVc2Q5MGdkendDOXBHanArZ1FmNm1XTmlZUDR6QndB?=
 =?utf-8?B?MkpPQ1h2ODlOUWZxN2lVMlFTT2RETzkvMkg4VVY3RlB2R05OaXNZWGc2a1Uv?=
 =?utf-8?B?TWtDV05oWmxsbFM2OTRMaXdia1Y2MVFVVUZaV2VTamFyQ1VpYXFiTms3N2N2?=
 =?utf-8?B?QWd3WjdTRE9kOVh6VGxkSXpIbmxEa0Z2SEVqNWtpL1NNZlIwaytJOUFPaFdB?=
 =?utf-8?B?Vjg5Z3ZScjVHWGE1V1pmWW5DZlNCeldIS2s5a2pqMkhXTnorWm1RZGFTYit0?=
 =?utf-8?B?SmQ4a3dYbG9SZk5QM1BxSnd6SlJmN2pUUlFpSTUzSlRQbVNBOVM2WDNrSkdI?=
 =?utf-8?B?VEdQejlxK3VRU1A3cEFiT1dPcHRMTm1DK1o5VmVicjlLOGxEekZMaHpmWW4r?=
 =?utf-8?B?NHRRTGVrV0NNbndCUGRaSzhWVklJVnRoZzFVbXJHNkI4WVBBRUkvTFd3YkZP?=
 =?utf-8?B?TFFGUlp0OEV3S2NLMjRnTFZVM3RrYjBLZnNDQWpSV1VZNkxpNUs1ZExDeW44?=
 =?utf-8?B?Um9VRU1qaXhwbVlmYi9LbUo4MytGN0dlNTRhZnd3d0s3N1d1eTliaTFKbEJa?=
 =?utf-8?B?OUlISmJMQzdsSW1vL014UXpUQ0x3MnZSUXAyTFdkSlo4dElqdXpTdHExWVIy?=
 =?utf-8?Q?CGYeYt4+GEfCWXmA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a68a5aa-23f8-45fc-4473-08da32aeb224
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 17:58:32.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Sq66FGDFl+0zTGZcSjAkJZU2ePYfryc59AFr3gnlm2Fng70hVxNruvYwOGHgJcA0cSOSceYv0RQCNVZIj2BCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_05:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100077
X-Proofpoint-ORIG-GUID: R0UPlPfa5oyi_70UJs9rvcsFr-2sLRI0
X-Proofpoint-GUID: R0UPlPfa5oyi_70UJs9rvcsFr-2sLRI0
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2022 12:44 AM, Eli Cohen wrote:
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, May 3, 2022 2:48 AM
>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>
>>
>>
>> On 5/2/2022 3:22 AM, Eli Cohen wrote:
>>> Allows to read vendor statistics of a vdpa device. The specific
>>> statistics data are received from the upstream driver in the form of an
>>> (attribute name, attribute value) pairs.
>>>
>>> An example of statistics for mlx5_vdpa device are:
>>>
>>> received_desc - number of descriptors received by the virtqueue
>>> completed_desc - number of descriptors completed by the virtqueue
>>>
>>> A descriptor using indirect buffers is still counted as 1. In addition,
>>> N chained descriptors are counted correctly N times as one would expect.
>>>
>>> A new callback was added to vdpa_config_ops which provides the means for
>>> the vdpa driver to return statistics results.
>>>
>>> The interface allows for reading all the supported virtqueues, including
>>> the control virtqueue if it exists.
>>>
>>> Below are some examples taken from mlx5_vdpa which are introduced in the
>>> following patch:
>>>
>>> 1. Read statistics for the virtqueue at index 1
>>>
>>> $ vdpa dev vstats show vdpa-a qidx 1
>>> vdpa-a:
>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>>>
>>> 2. Read statistics for the virtqueue at index 32
>>> $ vdpa dev vstats show vdpa-a qidx 32
>>> vdpa-a:
>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>>>
>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>> $ vdpa -j dev vstats show vdpa-a qidx 0
>>> {"vstats":{"vdpa-a":{
>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>    "name":"completed_desc","value":417548}}}
>>>
>>> 4. Read statistics for the virtqueue at index 0 with preety json output
>>> $ vdpa -jp dev vstats show vdpa-a qidx 0
>>> {
>>>       "vstats": {
>>>           "vdpa-a": {
>>>
>>>               "queue_type": "rx",
>>>               "queue_index": 0,
>>>               "name": "received_desc",
>>>               "value": 417776,
>>>               "name": "completed_desc",
>>>               "value": 417548
>>>           }
>>>       }
>>> }
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>>>    include/linux/vdpa.h      |   5 ++
>>>    include/uapi/linux/vdpa.h |   6 ++
>>>    3 files changed, 140 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 2b75c00b1005..933466f61ca8 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>    	return err;
>>>    }
>>>
>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			       struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>> +		return -EMSGSIZE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>> +			     struct genl_info *info, u32 index)
>>> +{
>>> +	int err;
>>> +
>>> +	if (!vdev->config->get_vendor_vq_stats)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>> +				      struct sk_buff *msg,
>>> +				      struct genl_info *info, u32 index)
>>> +{
>>> +	u32 device_id;
>>> +	void *hdr;
>>> +	int err;
>>> +	u32 portid = info->snd_portid;
>>> +	u32 seq = info->snd_seq;
>>> +	u32 flags = 0;
>>> +
>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>> +	if (!hdr)
>>> +		return -EMSGSIZE;
>>> +
>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>>> +	device_id = vdev->config->get_device_id(vdev);
>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>> +		err = -EMSGSIZE;
>>> +		goto undo_msg;
>>> +	}
>>> +
>> You seem to miss VDPA_ATTR_DEV_NEGOTIATED_FEATURES from this function,
>> otherwise I can't image how you can ensure the atomicity to infer
>> queue_type for control vq.
>> And should we make sure VIRTIO_CONFIG_S_FEATURES_OK is set before call
>> into vendor_stats_fill()?
>>
>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>> +
>>> +	genlmsg_end(msg, hdr);
>>> +
>>> +	return err;
>>> +
>>> +undo_msg:
>>> +	genlmsg_cancel(msg, hdr);
>>> +	return err;
>>> +}
>>> +
>>>    static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>    {
>>>    	struct vdpa_device *vdev;
>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>>>    	return msg->len;
>>>    }
>>>
>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>> +					  struct genl_info *info)
>>> +{
>>> +	struct vdpa_device *vdev;
>>> +	struct sk_buff *msg;
>>> +	const char *devname;
>>> +	struct device *dev;
>>> +	u32 index;
>>> +	int err;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>> +		return -EINVAL;
>>> +
>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>> +		return -EINVAL;
>>> +
>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>> +	mutex_lock(&vdpa_dev_mutex);
>> Given that stats_get() is a read-only operation that might happen quite
>> often from time to time, I wonder if it is now a good timing to convert
>> vdpa_dev_mutex to a semaphore?
> No sure I follow you. You still need that the process that took the lock will
> release it. So in that respect we should still use a mutex.
>
> Did you mean use readers/writers lock?
Yeah, I meant Reader/Writer semaphore, sorry.

-Siwei

>
>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>>> +	if (!dev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>> +		err = -ENODEV;
>>> +		goto dev_err;
>> Missing nlmsg_free().
>>> +	}
>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>> +	if (!vdev->mdev) {
>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
>>> +		err = -EINVAL;
>>> +		goto mdev_err;
>> Missing nlmsg_free().
> Thanks will fix.
>
>> Otherwise looks fine.
>>
>> Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>>
>> -Siwei
>>> +	}
>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>> +	if (!err)
>>> +		err = genlmsg_reply(msg, info);
>>> +
>>> +	put_device(dev);
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +
>>> +	if (err)
>>> +		nlmsg_free(msg);
>>> +
>>> +	return err;
>>> +
>>> +mdev_err:
>>> +	put_device(dev);
>>> +dev_err:
>>> +	mutex_unlock(&vdpa_dev_mutex);
>>> +	return err;
>>> +}
>>> +
>>>    static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>    	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>    	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>    	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>    	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>>>    };
>>>
>>>    static const struct genl_ops vdpa_nl_ops[] = {
>>> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>    		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>    		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>    	},
>>> +	{
>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>> +		.flags = GENL_ADMIN_PERM,
>>> +	},
>>>    };
>>>
>>>    static struct genl_family vdpa_nl_family __ro_after_init = {
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 8943a209202e..48ed1fc00830 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>>>    			    const struct vdpa_vq_state *state);
>>>    	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>    			    struct vdpa_vq_state *state);
>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>> +				   struct sk_buff *msg,
>>> +				   struct netlink_ext_ack *extack);
>>>    	struct vdpa_notification_area
>>>    	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>    	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>> @@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
>>>    int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>    void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>
>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>> +
>>>    #endif /* _LINUX_VDPA_H */
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index 1061d8d2d09d..25c55cab3d7c 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>    	VDPA_CMD_DEV_DEL,
>>>    	VDPA_CMD_DEV_GET,		/* can dump */
>>>    	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>    };
>>>
>>>    enum vdpa_attr {
>>> @@ -46,6 +47,11 @@ enum vdpa_attr {
>>>    	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>    	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>    	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>> +
>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>> +
>>>    	/* new attributes must be added above here */
>>>    	VDPA_ATTR_MAX,
>>>    };

