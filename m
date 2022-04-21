Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4850AA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392626AbiDUU7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbiDUU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:59:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB5BC92;
        Thu, 21 Apr 2022 13:56:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LHU10W024600;
        Thu, 21 Apr 2022 20:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DCAlBd4gJJ4mg164jNQlULsCgbg7QT4wMjEDmqu3oQU=;
 b=szHJiSXXNd0mZojzxqen7E5GqZIL3vU+8CzD4LzI66yTNREXXUhA547TNbx1xX6fqU6u
 50vDYp7apLkJ1tqinj/CerEYYcrK4NtbvKB4F+xIhfNItHB0UfKxgTP6V6o/zHAk2Lxh
 T5Gbx76H1JT19YMYWQL/Sfk7GFLt/QaQZbMdrk0kw24XZYkbUYRxO7NFzO4oKEuXBZwt
 +mHaH2RLthc/7wEBHTUdFJUJEAKKGWNl7p/2Dfs2rZF01eMhI7nVLttC8ZDetBkQKorw
 licVHDqAAHTfbjgSSAvo1PTdwjOyTne7b7Xb31MUGDM87pA8O0CB30FEl7bT3d96TCsV VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9mtu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 20:56:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LKkSwT026569;
        Thu, 21 Apr 2022 20:56:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8ctfy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 20:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjPNhiTaEDzYuoK27u1DcoOWbVOEpRZGXtmqdM9h9TUtI+D624AuMTWx2Ro5jExZWlQ7asodiGSPdyLe2ZVKMTnnXf5sHMfTcLIZbR0Mk3C9ommUPjhT//V6fYJOYi2vKn1EAVmfXK2w35ypuRO4mS1yKdXdB85LXfyJ4DQlnKq0QuoIgfyQc/pafvrYPmTvPt8hIyCjDh6PYkhbobpv/1e7xuZ+V3IlO6Y4NHoktrjjEnPIWEMXLmn1a5QkxlV2ir7HKKrP6q6fVx0p62IIGUhloT296RpKULE6/aLlnN+zwnlZvao7a8kH58sB/ujFxdBXn4pqJFI5xcOOmfQ16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCAlBd4gJJ4mg164jNQlULsCgbg7QT4wMjEDmqu3oQU=;
 b=RWX8UlBVyAbIc9nC7XoxKL6FCvM5dUB0V/dsXkRD1AkbOpQUUusfabj48lGrqdZwPF+lqRdtrR1NDbyEK91Dt3h0cwIggar5hxikA+GzePPQ93oFPjC4kk8dbqiLM9Ub7Tj+Nwk7MQuj1Uim5qmrV06oYEdPcjYlvq2sC0SMELPM8nFmtvzzznkfZbaz3apdB6GBOkpWl9Ux/v7JigIh/UBgybmyVc/So2IUCasR15fQ4nrD7jTJIUQWKhnGzsxCSSqMmw6YR7BANLvnH0g4JRxGBsDdj05pQ0S4KemkKUU8cTyptCb/jUbNz8PMU/qBcIdz8NTc6hz14crAu1zNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCAlBd4gJJ4mg164jNQlULsCgbg7QT4wMjEDmqu3oQU=;
 b=rnW2HWYKWYtVY85tUkJcnYsJk2UKIScTAuLZVIsC0z0QmOSB4ODKdL89pPBYqpd3rNjRK6D4aho1aOazbD5kpoGkt4quCGRq1YlMa0B/cCcIQvBsjJUTNxvWj/bwxvblPC5CBvIrR8AwgZ/EhbnilVsiB7Fe/zi1i0SZADfjFtE=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM8PR10MB5430.namprd10.prod.outlook.com (2603:10b6:8:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 20:56:44 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::4455:2c02:503:a182%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 20:56:44 +0000
Message-ID: <d4d36fb2-a26a-9fbd-acc6-fe97ab93fa66@oracle.com>
Date:   Thu, 21 Apr 2022 16:56:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] xen/scsiback: use new command result macros
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-3-jgross@suse.com>
 <e4bce8f1-c6f5-cb99-8a1e-97b09ea1f840@oracle.com>
 <bf19c5f8-badd-5afb-fcaa-a16483783a27@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <bf19c5f8-badd-5afb-fcaa-a16483783a27@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b75503d-3210-483e-6b13-08da23d9715f
X-MS-TrafficTypeDiagnostic: DM8PR10MB5430:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5430745D61CA34FADD002BC58AF49@DM8PR10MB5430.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AG9Fc7IQuhWnUSTcrUGHpCebUQwvbJFy/NbdvplBmdWqqPOdk5/xkvVoTbtf/IRDHkalV8SG0cv0twa8z9fKfdXCnnIdQ027bvtYRf1lexG5/o1whfgtKdD5UkuPmEBkLkikeLJjCYsxCWbO7buSfxWJPyIPU+HuMqIpwzIoCgTlJ6AOKPqfGl0zG316ITD2iUo5S4soVcrrkMyL/wqhUo+w+Obxg/ffsXxnUHOQSTAZNOvSMLTiv/TULHUT8xUhbKRPuVq2w1BmQhwvLXLzKfY1fcALpM8O7TgEkvNo89lez5oUWWx5upS7Oyw2YkBxGFCGaWh+JKf9n8QnMuHaMjfAsGd/SMHPGHfJUeio4eyGCg3ytdHs7MXXTXqVO4zxEVxl8Yw74/CLQHRUVffR+TvWEYTRKkw4pGOkwsnVaNqq/fwQ9zY2EXP+W2W0qFmen97V7tqanzpi4qZrV2VOq9dlGXP0atI4hkBtBLAAxsh4c6ei+z1D/mt/gFJ7dN3Y8Qg0wZhvgP2+wB+vz4qbUuqAPo35L8IdfDUT3x9oCCBvoCmVeqDbzIQ6YyW8uI3uu3lyy/GBgnGFOr14YQZ46PMOG2uausoAidfS92aR/f2B7HYxA2XIFiVe0jddMJi6TeNSY6i1lgQQDcIJHpaCWP5B3ILLvaAEFojWmPhQ+C05sbq6FRCmQUcE1sFcQiLdZFZdXvjAJMiIMxA78rakrP5uNhnbat0WvLFDyePhGaPN/gJ53+JbiSNnEs3H5h3P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(66556008)(44832011)(53546011)(26005)(4326008)(8936002)(186003)(66476007)(2616005)(8676002)(6666004)(6512007)(66946007)(6506007)(2906002)(5660300002)(508600001)(31686004)(6486002)(38100700002)(316002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDkxRmIySDZEaXZGcXB2dkNrSC9JeUJXSXRHNG9Ub0p5WENUc3V1dlUzRTlU?=
 =?utf-8?B?TnRsV2ZwTWNZblhRUVFiTERoUmNoZDV0ZHpiMmVyY3VnUTVrSDhPdDN1T1lo?=
 =?utf-8?B?ckVlRGliV05WQ3RoQXNtTjkrYTdvbGNYTUFJSnJIZjkzeld5UFJkcmhYc3pj?=
 =?utf-8?B?SjY1L1EzeXFLVUg1cnZKWGdjWVA4VEVtdk5YZmlxMThsR3NaZVJxT1NsWFpt?=
 =?utf-8?B?YjRWbndLRmsyY1FwOThuSkxEZVlCTmo1R0hBSmd3clk5STBEbFpRYzZCTFJC?=
 =?utf-8?B?cDhqRU1SUjhvdklJNlpPcUlURTErVHQ0dTd6UzhXSEt5akVJOUlvWFlvQUZS?=
 =?utf-8?B?SmpWbjJndjNFdXlCRG1DRnV6V2FUUi90OVhNOU50YWhkM3RUVFIyRExnSy9P?=
 =?utf-8?B?RXhMSExlU28yRnJkZzVVSVcvYTA3Y1VxOVdOWEF3RDJCdkI1U1NxR0tHeXJQ?=
 =?utf-8?B?cEdveWpEN3JMSVM5ZWsxQUk4akdjQW1rTkdSdVhVL3RDZ1BFNU8rVzRRN3hH?=
 =?utf-8?B?UU0zdk11eW14WVJVY05nV0FCaGk0ckVkb1RlcEVvTklHZ0c0VjFXb0g4WXVT?=
 =?utf-8?B?aVFsMjFWMW1zSndNV0NEcldCVUNhSW8wTjFIaXYyeUlGekFrbzEvdy96Z2dJ?=
 =?utf-8?B?UVlRZDhTZmlBaXJtRmE4RkRQQmJYa1lVZ25mK2hIYkNqYWV0TTlLZ0JiaVN2?=
 =?utf-8?B?ODNXcHV4bTV0Y05oNW8yc0RNc2NRcStuVFRvUlBRS2NIWlZCZTdEWEc1MDRR?=
 =?utf-8?B?cnV3dHJ6OTRpRkhhOHB3OXRNUXRTMm0rUWRERmpvWVNHaTdPOHZSeldrazM4?=
 =?utf-8?B?YXYzMmFZQmgxR3BtRGlvc215NE9vS0lxNDJna0JuNXVLZFQvNll4M09OZVR3?=
 =?utf-8?B?eFBBak1QbG96cDZOcTh0M2h1bnZEWUNSeDFEd2RqMHBOZ1dPd0JMc0UwMktm?=
 =?utf-8?B?Z3U1MnNWS25wZ3BGQTZOQ1lvMkNjRjFUalZsRXRkUDhnbW8yS1pURUI4Y2RO?=
 =?utf-8?B?WGlDUUMxTjlwdUJKWWVxRkQ3Y3dFbzB5RlZZUFphZ05HYnQvdTZ6em0ycVZs?=
 =?utf-8?B?NDZId1BLYWFVdThkWXZzQU5DSS90VzRPemd5azhQbkVQR3lEVExUN0VDQ1Fy?=
 =?utf-8?B?bVFVT0U4NHJtNmMveG5nUndkQnJEenczTVZsVVJTR1RyaXc5SGlySnJRc1dR?=
 =?utf-8?B?b09sRUhWRXdXTWZ1TTR2MmQxZ2RDRmNJVXFpWVViUU11RXRKVmxHMVA3UnB2?=
 =?utf-8?B?RGNFamNHMjNBSkdvZEFETmVaUEQ5NkRPdkJDbFhRS3NwLzAxUmNXM3M0aUQz?=
 =?utf-8?B?dVlMQlJ0Y2JmUU1IbDREYzdhMWNITFJUWmJmSXF5SUFHTjFiNUFZNUxvUWQ3?=
 =?utf-8?B?QzFsRHRSUkNXWFFKeWx3ZVk2QWFoM2dUaWhSWTM2N0NRTEYzWHZGeG1kenRV?=
 =?utf-8?B?bDJqSG5uSGI3RUI1ZVc5YTRUWngzVjZoZWlkL1hGMEdLR3EvbytGdEJlZ2FG?=
 =?utf-8?B?RnFNUldPb2pKUFBjQjMzaDRSb0pPM056QW9UZkM2ZXo0NE5RV2swd25CWHI1?=
 =?utf-8?B?cWxLYkVPd081Y1ZPMk9nOTJnMnJhKzVpUVpZK0oxQ054VUw2UitHdWlNV0R1?=
 =?utf-8?B?bVR6YnhGeCtwRFQ4ZHQzcE1OQzlROHdsbVQrSnRBd0NDRWFTU3B1QjBWY0N3?=
 =?utf-8?B?OVoweEFJK082WmpUYlpNYTBld0ZoT1czMitxRTB3Um9oK2VNRitiT2lRcVEx?=
 =?utf-8?B?YnV3T0FVN2F5RmI5QWxENmlUeFZmalVQRzdnTUczUDRoanJRNVgwYnRYajEv?=
 =?utf-8?B?eVdiaERQNk1VMEppYU9CS2tJcSs3RTFRRTQvNThiTUtBZkNxK2t5bkVKb29O?=
 =?utf-8?B?MEVoRUkrRi8zRCtkQ0R3UE80RHlVV293c2NyTEcycERSWmN2cHJFWm9KVjdQ?=
 =?utf-8?B?aXFwMm93a1phSXBneVE0WEUyVHQxa0VjRStCL0ZrUW50aHRsTmVXM21MbXoy?=
 =?utf-8?B?dWh6Y0VPeFZTOGdPSWh5ZExSbktyRi9nTXBDOG5jYjR5R2oyYThXekJnL1JY?=
 =?utf-8?B?dnBXdllqL0lmb3VhQjkxamMwV0tBRDFFa0lPZHBJWmJYV1Y5NU9TWFBEQkZL?=
 =?utf-8?B?Ni85eFVaWGpGazBYdmhsSmlPUkJEbS93ZDZIY1B6cS81OGplcGZ1NlFZa012?=
 =?utf-8?B?bTJ1aTIyVTIzN2xsZUhvRUlDbUxTMWlsTG9ybW9MN25FQktNdXljUTg3cXJ5?=
 =?utf-8?B?NzF3WE1aVXJraEV0UkUzU0RVU1gyUjhQMG5TTjVjOVNDbVc1MktxTHVOWnBX?=
 =?utf-8?B?eGZJTFhMdURIQko2U0xuQy9PK3N6c2tnbHNiNERnMk9kdFZpV0krbTFCZ0NK?=
 =?utf-8?Q?VAyFmj88He1/AOAI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b75503d-3210-483e-6b13-08da23d9715f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 20:56:44.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNwQnuV4hQN60kvtue+wRiC9tvSsQSl781AidBA+UVasFC4701KXic90fsaCKpMOPwNZL2OCQi1g1b+Fm98hb5m81djvft4w74hBrAT5NpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5430
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_05:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210109
X-Proofpoint-ORIG-GUID: LB7Mjm4hd-h4z4eMnMlT55yWtsHWyWh-
X-Proofpoint-GUID: LB7Mjm4hd-h4z4eMnMlT55yWtsHWyWh-
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/22 4:40 AM, Juergen Gross wrote:
> On 20.04.22 18:12, Boris Ostrovsky wrote:
>>
>> On 4/20/22 5:25 AM, Juergen Gross wrote:
>>> @@ -569,7 +645,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
>>>       wait_for_completion(&pending_req->tmr_done);
>>>       err = (se_cmd->se_tmr_req->response == TMR_FUNCTION_COMPLETE) ?
>>> -        SUCCESS : FAILED;
>>> +        XEN_VSCSIIF_RSLT_RESET_SUCCESS : XEN_VSCSIIF_RSLT_RESET_FAILED;
>>>       scsiback_do_resp_with_sense(NULL, err, 0, pending_req);
>>>       transport_generic_free_cmd(&pending_req->se_cmd, 0);
>>
>>
>> You also want to initialize err to XEN_VSCSIIF_RSLT_RESET_FAILED.
>
> I did that.


Yes you did. I don't know what I was was looking at.


>
>> And also looking at invocations of scsiback_do_resp_with_sense() I think those may need to be adjusted as well.
>
> No, the invocations are fine, but scsiback_result() needs to pass through
> the lowest 16 bits instead of only the lowest 8 bits of the result value.
>

What I was thinking was that this could use the reverse of XEN_VSCSIIF_RSLT_HOST(), i.e. something like

#define RSLT_HOST_TO_XEN_VSCSIIF(x)   ((x)<<16)

to be explicit about namespaces.


BTW, should scsiback_result() use XEN_VSCSIIF_RSLT_HOST() at the top?


-boris

