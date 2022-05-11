Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFD523F46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiEKVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348020AbiEKVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:10:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89512BA9A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:10:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BKFmbd010355;
        Wed, 11 May 2022 21:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FASIeEUl1pX/XPtEFTSF4e42NLZ0OSScKjkvXRCXnGI=;
 b=Qr8U7S6Y2Y9NTq7iPZAHVdglo0ws/1AUAE+DRW3ZdCJtzRVFofRsfzGjFMcMJHwGK8Qv
 dUZrjqUuPVlBmDE0CCdf9jYgbpn5bo8l6tVBr2OvTiRXBQpC1sAAL/yHSKuXGNumhzN5
 XA2ZBmW5HmwU7dpdWTsWTe7jDRqnVpYe9OFA9k7/mV/VwUW94H2lEtudNWrPLsYo4tjO
 /Mi2iAfUN4VEUbqBLQA6M9+SUAYZHp7ItFDsezIrvNEOmkfJ7EUAWIbcUwXTBdepG29u
 58DCblDhhboBC0FjHnm+XeSioUZJEi8Q5FAQkHWr8LHNQoKpCT3oxy3rP2gdE4eqbzgs 1g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cas4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 21:09:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BL1gZ8018519;
        Wed, 11 May 2022 21:09:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf74tv4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 21:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrzI2kbDIJu3Nw7mWh+Nw4x/BAVusUt75Lb7CLWKODm93YhoEj2aYTmhj2cZZuXq0MK9LpuQ/m0vDvSJWmCynQrBG9U96tcmu9NLmLdcrR4FeMvDPkDtK5iHxslDRfpJKdvScl31Y9r9pcOdVP4vQrqxW7adz2LBsFJvMgAOE+ghi3IJCvsntuR7hdPdjHadbIk6sE11NDdvh1TluGjC0gg+qQFcxpxZpRde3dnv01mjlqkQxxs/Yd13CE3Xj4+YZ8UIsWK4S8ziM5AwaF/o8WixWk9zkMxUTvq6jJ5EXqrzD7azU+2wDqYGf58b8/mRoh/QHbVN0TVthzg21pPBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FASIeEUl1pX/XPtEFTSF4e42NLZ0OSScKjkvXRCXnGI=;
 b=YrPMgcCQp3e7Xw8cy4axVnUop3baYBFUhxglb12L1aAVH0VbpMRoNTN7kep+n1GFp54CJB1UfTHkJJeB2q+QsDrtWMNuKDYjgLGZMfmUe67K5owm6D6dh1DWgkd0SR6oDr2WlrJDtucPVttqMr89di4pReaDhLZU+wX1A5ouU38PjewIpXojM2stCHYDn3OxcLfxRa/WBcTxy5WvHz6K4/YEV+l4WWdF7DGy2qBadzXFc1sBJstfyCcAX0mc+oTwXqSOdEnyx8HoqvjHIPegFAUxzwWeax8aOM8TxexwEutCVb2KTOUVjrmpz/utcfvJ0TH+aiIeU+PnPZyvzqMO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FASIeEUl1pX/XPtEFTSF4e42NLZ0OSScKjkvXRCXnGI=;
 b=wG0A6H9eBNOVekpQdbcjM12RCDHIZ+oGc74OHqc4FC0yFFff1QJ3wyodLPbFAjA68ELNuQ0U1u/igP1vNuRH3rEeTl1ef76TDBMYI+Kps4xtZz6M4ruJrwNte6qiF+U6FK45fvQ18VRRmU6XN4Oxi+egzL5eETfkAnEfwZl4/ys=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB3872.namprd10.prod.outlook.com (2603:10b6:208:1b8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 21:09:39 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4%3]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 21:09:38 +0000
Message-ID: <24748b59-e2ed-1d7d-801e-ab9dc12b0983@oracle.com>
Date:   Wed, 11 May 2022 17:09:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <8409e636-94e3-e231-f181-c76a849534a1@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <8409e636-94e3-e231-f181-c76a849534a1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d2aae7-7c63-4434-e8ea-08da33928f25
X-MS-TrafficTypeDiagnostic: MN2PR10MB3872:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3872E8C0488BCABCC827AC0E8AC89@MN2PR10MB3872.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1IEc00CSvy0hdctJzqvlCVoRMAfNuOsitnX5ByHJ5nMwLGs+pPuzHDl2w+3symHWzZvwkznr5us39Uyr1/XYURdccZOXDW4LISx7N2S1ThdYvuhcTX2R5AvwKtcor9I1JxJO4z2DGRhs351oWNh5AtNqZ/0zTVmTQdnfRgwvxLWeE81b5csRgyF/J0v/IDED+e6QeDbqS/nlbgwz5vaqvDzvNZmLqNvyweMhn/OrFFbnb5UHzIbDpAYuv/Oyr93z98XiG5Pls/61rjewKeNbM+c1r043CJnkbC4pJBbMeGWprIqRNRLQt3A5TQUF/EULP+YzlMjjmyGFOHZKNkhw4PGI1yXd+nKLpj+sc8pNFGlf6s+5UeWWfEDkU/HJ/iygdT9V7Kr4yDfLG68Cg8DDavVWPlip4wONkJGEf33SRGUlA1KFwRTAgbZgKkPSzFeLBLMK3J0h+yBo5HZODWMM82X7eCsMbr01FpLeyDo32YXwE/62dimxux0Yeq0Mt4IhY+qnCVp6q152/sALnPDHaurL8uw/UbMoLH4NhEndw62jzVsmT76NLnZaYqKv4xxfAz8J9cW/EXB0vrGC51ttBXk9jO3g+fNN5l16jriuMqPMh1t751YQhmRYzSxLcVVgbCmWOZoMd4ppUHMxXCplnh+ON0CMevaY58EqrQ2BRbyul1jj/F40utQwfGQu+UR/1211TguVWtKvnXWqPosIoyMICd8UcgMnB0QXmuqyRTfP//D4ropeqXWRo9bds5w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(66476007)(66556008)(31696002)(36756003)(86362001)(4326008)(8676002)(508600001)(66946007)(2616005)(54906003)(83380400001)(2906002)(186003)(44832011)(6666004)(6512007)(26005)(7416002)(5660300002)(110136005)(6506007)(53546011)(316002)(38100700002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlBQnN3R2xYRnQzWjJuNWxhS2RTNGJ3NjJFYktDSEJka2hndWNHcnlqZWJF?=
 =?utf-8?B?S2hSOXBkQ1JNMWxoWVg3VFV3a3Mzd0g1cVJQUWZmUi90ZDRIYXhzWlBubUxp?=
 =?utf-8?B?RlBPeHNtWldYYzlUNkRtV0xyY2NnVWNXN1BKUTJESXFKbmFrNHdDZkZHYTVq?=
 =?utf-8?B?bzU1ZDRSRlp3Vkh5cFdwemFvanFEaVVyaGhOR0c5akdRWitueS9SMEJSVS96?=
 =?utf-8?B?TzJWZldOdTd1QnZQM3lCQ1RSaWZNWTFZTTkwbWNjOWFjRXk3VnZ3d1l3dFNZ?=
 =?utf-8?B?bmY2ckJLeGtPNW5LdEVBNlhybEpvQnJnSngzV3FqUnVUNWp5WVVkbDg2RGhs?=
 =?utf-8?B?ZENoNG0reW9oeGxndXVVQkNtN0ZOT00rWVVuS1c5TUJlK0JxcGdDYnJYUTlG?=
 =?utf-8?B?ZlNpOFIzSEl1ZjJuU3VZakE3b0pZVVhWNW13SVU0K3E5ZzNZanRJVVFqSEp1?=
 =?utf-8?B?eEhGUm1jbkRBWkJRLzFla0hnQU5VZ2lLaGZRNmdjS2x0K0h1T0MrcGZBb3dr?=
 =?utf-8?B?cTJ1ajJKOXhaam1qelE0NEU5VWtBYksydFJuS1NUVmk3UFRGb2xldEVhdTJL?=
 =?utf-8?B?d1E2VGN5SWlBeWFjWno4WG1VdXpnWEdqMHRqT2crMUdGMlpoRlZia2lsemF4?=
 =?utf-8?B?MUk0dEdEbUIza3RCZXg4ZzlDeW91RjdhQmxaMUUwU1JrSllrTjN4SHFDSWlt?=
 =?utf-8?B?V3l6TDc4dittTlpSZzkvZzMzMWwyN2lMRXNFZ2R3Vk5CUW1hV2o5T1FERUFr?=
 =?utf-8?B?VHFwQ2xST3AyMThLakMxdXRWZ0M1bW9yeUw2S2hDTUZNU3l2UUZzRU9VUGV6?=
 =?utf-8?B?TE9sdTN4RlZlbmVZdmVVaGdHZ1JYVFRWa2w5UHpmV1BLWGpXbUZoWE9FUGUz?=
 =?utf-8?B?cEs0elptVVJyemxDdUlJNFE2dy9KS2hoWncwemVqZ1FpRVVOckRmUCsyOTdo?=
 =?utf-8?B?MVJTdWV0Ui9zV3M5MENvZGY3RzE3NG9nanJoUUtVeGRXVVJGSHEvcGJrdzZp?=
 =?utf-8?B?QXFTVlIwV2JDYkJUQjM0VFlPUzlFcGN6YVhYTzE5aUcvVTZDMTJRU1QyT01j?=
 =?utf-8?B?dTlQOGRYZ1NNOVB0TXBKU000SVlyZjBxWXRMK001ZWk2WjhNbXJwdWp4WGxw?=
 =?utf-8?B?K1FNeXo1cmpURjRBcnhrY1MrcTY1eGtQdmkyWERGd04xNFdKWUl5NzFrOHAx?=
 =?utf-8?B?SlZWTFVndDRsaG5BWnAycDVIWWwxTjJXUXNyRmg0eHVNVjFScVE2dW9CeURB?=
 =?utf-8?B?MHVEZHd5eXEwSzJjQ05nUUNGVCtRREJjREJSck8xN1RtUlVjbi9VUmtvOXJz?=
 =?utf-8?B?dytIZjgxQkQ0NVFVK2IzcCtZaVpBS1ZXMjlLQk5LNWtpdVNPZi9YYmZpd25U?=
 =?utf-8?B?QysrYlE5amc2SkNvc3NoUnFxd2tSNjY3Z2N2LzhPSHN3eDlIVDRSenlEQlUz?=
 =?utf-8?B?by9wbWpxaTBKN3JoSlNwNkpLODZRemVWcHduR3lDd1hxU1BPNm9LbFN5WGh2?=
 =?utf-8?B?b2JlT3FHb1dLWTBsVkg0eWlKQTliRUQ3UGJwN3RoNm9yMmZBdjFERStkT2RH?=
 =?utf-8?B?SEwvaG9kLy9qK3RZODJIUWNZSURaNCtJSVBETUU4VFl2dmtKclh2MmNxVmlH?=
 =?utf-8?B?S1VWQVZKZkt5VkJlT2tPR3FHUzh0SVFEejNTMlJYQWdBdlhPNFNHcTVENEg1?=
 =?utf-8?B?SmlrdzRpamJ3UVQyY3pPcGsvU0VBbEpYcVN2MVhWUzdSTXlxa1NnSmZoMGhz?=
 =?utf-8?B?ck1NV0p2Q1pzVWJOY1Z0MlU0SXlWUlhOMEVvSlRYMlRxaXh1US96ZklrN2la?=
 =?utf-8?B?Z0I2Q0NjaS9oSEJZemR1dmZOTGlLMW1ZN1NCU2lGMEJBdDhtMWxhQWY3R1Yv?=
 =?utf-8?B?THVjdHRMRmx2Nm1GMnpDK3BVSUoxRW5LYkZDeVVIZGIzN0h6YkNwWWRsWTVa?=
 =?utf-8?B?bkphTkt6bDhNK3o3aWpUQWZ5dWJWUlo4VHN5SkdCMS8xRUdsU3BhbEJwQnA0?=
 =?utf-8?B?M3NFSVI2NVFDTlNBRk80SVNMTktYcytldVBOMmJqYjkrYUd1MzZ5Tll6L3A4?=
 =?utf-8?B?VU5sZjRKSWJXZUtOMWw0bUVrS0lQZUlCdnp4bEhaeHdwTlBDMDNweHpaVFNt?=
 =?utf-8?B?WnJBTDNCVzU3Z25FU3U4YVdrU2V0dXNKVUN5SDVLS2VDSXBORDZVSzlBTVFE?=
 =?utf-8?B?OTJOZzhFdndCZjdNQ1MyMnV3Nm42aWdSTEFmbWRIc1B3WWhFSVhJK0RiSjBs?=
 =?utf-8?B?M1phRitzdzVUQ1pUTDFQUEl0V01HdG13eStSOUMrQzJKU3BDYkRIeGwyU3NQ?=
 =?utf-8?B?TU5Jek8xWWZFYlNFWlZPTFltWmdFYnN3aHhDQUJoYTk0L2RxTURFVm0yT0p4?=
 =?utf-8?Q?W/rjUGlTk89hs0QM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d2aae7-7c63-4434-e8ea-08da33928f25
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 21:09:38.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEif40vTMr5TYc2Qku+3LVVncd4ooM9Hco2gBDpcL2sshp1lcCWlldVBfsmFndQKCk1eij+UXJmKU8/yCUiGijFLmLDlszaBEDjsfC4fXkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3872
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=804 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110091
X-Proofpoint-ORIG-GUID: e3AavS7o_eFKu7AeDx8tI1DYYUovFplk
X-Proofpoint-GUID: e3AavS7o_eFKu7AeDx8tI1DYYUovFplk
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/22 2:00 PM, Oleksandr wrote:
>
> On 07.05.22 21:19, Oleksandr Tyshchenko wrote:
>
> Hello Boris, Stefano
>
>
>> From: Juergen Gross <jgross@suse.com>
>>
>> For support of virtio via grant mappings in rare cases larger mappings
>> using consecutive grants are needed. Support those by adding a bitmap
>> of free grants.
>>
>> As consecutive grants will be needed only in very rare cases (e.g. when
>> configuring a virtio device with a multi-page ring), optimize for the
>> normal case of non-consecutive allocations.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> Changes RFC -> V1:
>>     - no changes
>>     Changes V1 -> V2:
>>     - no changes
>
>
> May I please ask for the review here?



I had a quick look but I am stuck on get_free_seq(), I need to stare at it some more. Unless someone else reviews this, I will try to get to this in the next couple of days.


One thing I did notice is


>
>> @@ -1452,6 +1624,13 @@ int gnttab_init(void)
>>           }
>>       }
>>   +    i = gnttab_interface->grefs_per_grant_frame * max_nr_grant_frames;
>> +    gnttab_free_bitmap = bitmap_zalloc(i, GFP_KERNEL);
>> +    if (!gnttab_free_bitmap) {
>> +        ret = -ENOMEM;
>> +        goto ini_nomem;
>> +    }


This overwrites 'i' and will break error handling at ini_nomem.


-boris


