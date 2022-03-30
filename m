Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5784EC99E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbiC3QZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiC3QZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:25:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E659BAB86
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:23:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFAuEn032352;
        Wed, 30 Mar 2022 16:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xNTTBnD897GQvAW0tqYeBWA0jOQNqqjuwaYhry+67MQ=;
 b=MMKQ+xDanCdGWPNNTh9A6Cc580ZTN50oONLwM0jws/UsiejC553aBjZUU2QPX5Qark8m
 757SiSolMY614Zp+xoniq/MHFqYPWACWhdMCldJxkJ0KGV3fCVLAbHzeZWOAPlG5G+6E
 uZdIyBDdoTIUSu1F/R4NSwcScOrySeE8jWnbKVTH90+QEYD/pIfXwsVr0riMAhWueqQA
 rVn9kdWs0tCowrjlknPcmkCMBov/EmZni6E7o1xOhVlMFGz1g9K5YFkU5hbct+YHuD1o
 X1A3T/WkmOlOOJcqg83gV6zLoNpiB+VbUpUHTLCSSYTeyqLt8prxTrPCyB7lQu/PRQB1 nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctt6jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 16:23:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UGG6JI031523;
        Wed, 30 Mar 2022 16:23:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg708aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 16:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYsLbn++gVHAIM98O2LPGkqzxUJQJ8yIyuGeEQJ50m0TnQ95DXow2w+RMeSoIXtyq8XktNX7BDuxV3q56tJWtvRGaF6CkMCBiIG54yB2X2732sRg8pK64WWz3uUoCm1NMagrh1ASlzYa4cbxBmXG79ZAXayxME6SrEoKCYxE3EEFu0jaRvQHKRqbZYn4JMyOPmPzgFx8QnnrI3MGDYyP2FLSD87FgrxhCaqbGSaga8gaVzPn3Mol7tr8Cy6K+tzm5PKODTjjTDVWPvB/geLN6jQRPMq+aaAw5jb5wSQGgN/Zt4QhE+mpnC6poLfRquK9VzlsORBEFpMd4hMWSIAfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNTTBnD897GQvAW0tqYeBWA0jOQNqqjuwaYhry+67MQ=;
 b=lGR9xCR3gsWl4FrHqpoSMCjg0LNJ1iM+ZGzeSe8vOwG9ecrXbD1mscc7wlTxHYMdd4KZ7otYc9LntGobyTbb25QBox4OZ6eBEEg45Q1R7BYl8RbOwF6R5DWNpbCRmZWqh633X0PYq4CmthNSQakGFluBeNGbGpo1zjceEQanIwGde681uVyNh0uR3gSwNnSQgVMoRiHug/kVi6sC7NxHSb+sH373H0Dik7gME+QVolaZ4zj13hxcdQFqMlf/EcKVSDfZCQiGXtk3J130DIie40FQJ6F1GXv7/pYIt7BKgZc3cBUf0EPMLpD1X+BjJyrp+yoegPqCTogKxAMgKkD6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNTTBnD897GQvAW0tqYeBWA0jOQNqqjuwaYhry+67MQ=;
 b=odO2+Y1I2ECSeQulBOTkI6yqk+m43LhQZ/IgOQw/Fh0x23nvLPPsSLyCMhQB/4+Y08YaCUs7JWJck7ox+nT8RFuERf89O6PkaXHH2BjbD+TJIm0VdqeuC8g/e3Ehme7H9sxj0u+WHOWYn9TCcTuhoFUbS+L5HyJBCF59fct2+JQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 16:23:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%9]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 16:23:07 +0000
Message-ID: <661307c1-71a8-195a-0a78-36bc3b773b8e@oracle.com>
Date:   Wed, 30 Mar 2022 09:23:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] hugetlbfs: zero partial pages during fallocate hole
 punch
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220324170600.16491-1-mike.kravetz@oracle.com>
 <070407bc-9a35-db27-43ea-ed8baaa219c6@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <070407bc-9a35-db27-43ea-ed8baaa219c6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743c99db-a345-4039-c2af-08da1269931f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4288:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4288C47DD28C051BEEA71AD7E21F9@MN2PR10MB4288.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKURafPNMnNTlb91MvS3zvIt5/oQAnzuxbXc8RIx/Iecb+ZDwTdqscF5bATcGwGBS5BIvhDesXo60/EBJK5zUETo9OupSkYUFxiZa0BimEpnthBcjQYF7F1+Y3ibRbyY97750nOq1yoloLWNKndfy1NnEc5YwoAukXUGZu/Z50+uXgvHR2ddYIEIEhMFpjjgkZ3z1AbIDYj7LheaStAuBdKQqSEXynv1UDwSwGTbbSwCB+UxTJwZSNz1WUuvzURgYBoISz2xA/fR3cUiQbThvv0M487uBokt0OHKaUIhg//qoxXEnYOv6FDNde3WQHZdyRR14RxvsdZEIuMO6SPAcrlh+3/2ykSB0kqT15vQeXdJhFbhMcj4+3NBnY9H4Ib01UWuQk20YzGT9Low0QSHtKl39Pc+Q7i2dnJPunnkHNIImdTcGMxaGDD6B1YIeDRTBIkmeG4DgC8XNh5+WLg00OcSpqIOQ1tbRltdd3FGMJDtF9fJUEqA9IiJ6quxRupKi1xFezTw+o7I6TqgMZKR6qT3fIzjXM4xDEuFiM9D/sdX8vYp+VZ4k1CuFCjgu+6ZuDnKBJ7w3tqsFLiB8xNJ7rAumncdRWuP7MdFMzcO5HAVQe/KHWoN9zcCIOQgdMEpZlrOitFeurL0kYWKprKRWQsC4YSKulbRFGeehQhu1zSRN1mBnv4xu+PrwKPx/k/RGwHyqKaCVqYK43AS3/epx2zMm3K22xBu8s7bhkK0HiHwe1iCYtJjAhDylP8yFdjYeuDFRKmG9K5NNhjPf44PwyPD1XU8k6cyvHAUyD6rnXtNACooIJ+S++ItTQZnTHv5M845YRUqqYsk4BKMrqExmxcm5P1f2DTXsvC+rjn3wpd71IQ4R+Z489NUVfWGEQJR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(38100700002)(86362001)(66946007)(36756003)(6506007)(316002)(6512007)(31696002)(38350700002)(8676002)(966005)(83380400001)(53546011)(2906002)(52116002)(2616005)(5660300002)(31686004)(26005)(186003)(508600001)(6486002)(54906003)(44832011)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0d4UVJ0ZGIvWjRBM2NIQzFNUTVsWmdQamNMQzg4eVV6TXZ0Um9XQU95Y1lX?=
 =?utf-8?B?SlFqdm10cmVuQll0eWw0UVBJditpV25lUERtQkowcnN2R1ZIMEF5YU5LNWdF?=
 =?utf-8?B?eVI3ckwrN1JlTk55dWxtYXFCTnJJTE5VV2JINmJLN2xXdmNPL083cVpHWVlY?=
 =?utf-8?B?dFQvaFBlRzRUalJhUlE2UVk3NE0xQk1GcFl2c1EvUytPZ2FMaFQwSm1JQzl1?=
 =?utf-8?B?SFplYlB4Z3FFUzVlOXcvdXNNdEpIWk9pb1VYTEsyZUNkam5PWDFTUXhFRGhX?=
 =?utf-8?B?RUdYNlpnbng4Q2NBZUE4U1J0MmYzTEN6RW1DLzVEU3cvVERLZnpONFphQStz?=
 =?utf-8?B?aGVEeStzTWw5Z2dOZTk3WTVIQTgxcm9BZXM1M1ZXNmtIVmdNcng5bzN1Rzc4?=
 =?utf-8?B?SWdndEdrU2ZCSldIbWxoUiszekhqVHRMZzBCMDFudlgyUThTMXBRYk52ajM3?=
 =?utf-8?B?SlQvSzgxMXlHQVB1MURhb1JLUXg2aVJWNXlHSnZoSnF1QkZIQ0xyMGN6YS9X?=
 =?utf-8?B?RDUzbUxqakZRRThISlRJZG4wMC95V3I0NEpuUFJ4SE5BSDVwckUwcmZLSVJZ?=
 =?utf-8?B?U0M1OTJhL2FzQjBSYVdjeFVDaTF1MFVxNjVQc2c0WDZCL3g2dzA2UEw1ZFA2?=
 =?utf-8?B?amhMWDJzTnNPQXZBVFgweDRLUFZZR2VnbTVLUERraHdNSkJpanJqYlY4aFVz?=
 =?utf-8?B?dUV2SXRZYWJjelJONWNReld5QWZabVpzRFpFT0Y5TzladnZ5NGZsNWViUnpz?=
 =?utf-8?B?d2RqUERGN0ltQ1prK1h4TFg5L1dOMlphUHlGU0RLT2ZTSFQ5WVRyQUp1WnJy?=
 =?utf-8?B?NFdNNVpjMS8vL214dFEra1FZZFlhODBVL3o3eVdMOVFENVFTaHRabXNNRzVU?=
 =?utf-8?B?K00wbTNwRThZZDNoTnpNcm5IRWF3OVVzM3NmQi9hWklFbk9GeVdPQUp0eXdk?=
 =?utf-8?B?d1p0d010ZEthVXJvTHNzSk11cGY4NVl2N3AxNWtVM0o4OFNUcDRzUk8zVjdt?=
 =?utf-8?B?ODExK0dZWUMwRHNuZXd3MmRjWHA4c1MveW9IelVMcU1Tck5sR09LbnVtb0ls?=
 =?utf-8?B?MTJUQ3g0bG9LVXZISmdhWVBJOE1DUVBBRDRJcmxNeUpZOGRFTUloRVNIK0RJ?=
 =?utf-8?B?b3RqaWVpM1ZJaUxsVVgrcUJhSGtvcXErWGR2R3hYblpHaUFGNURRUncvMmlH?=
 =?utf-8?B?VHZ5UHFjUnlndVdVcEZ0QU1MaHV4YjdvUUNJUXYraHViT3VCVXg4Zk0xMWtw?=
 =?utf-8?B?b0dBZTdyZXBWdlpUVEZQMFM0K0NnMjU2RHhjWjhWSFNjUVJiTG4yVURTbWJF?=
 =?utf-8?B?N3IvQjlQK2tVdTcwM096KzBFQkhzMU9nRWpYQkRvbFRvWkFjSFJ5M2tQcVlC?=
 =?utf-8?B?THJoWFl5by9HQUwyZk5QRWd2RjRyaTFDZm9WSndYZnJkSWFWYlhwYlZVTUth?=
 =?utf-8?B?K0hvdjYvcWV1S0N0c0cyejlGeGZmWVBFeVVJQlZ6VkVRVnptTFljSndYT2Q5?=
 =?utf-8?B?bzBnNFUyR1VuMSszdDZLemRTbUkzRkNSLzJFL0UrTjErSENNaUxlTUQxTWwx?=
 =?utf-8?B?dlM5cEVSQXFBc3AxZFFWOXJpeW1uYkZveXhJR0tDNHFLZTcxd3dNM1AyVkIv?=
 =?utf-8?B?NStJeThSY2xkLzYySC93STlna3Y5ZzlINUdwdHpSZGFRSFRvVUl4WnpUNk1o?=
 =?utf-8?B?Z0VHcDZrbU5tcTZMckxkSU92YkM2TmlTL3hHUEpManhJWHVwQVo0OXAyOUlu?=
 =?utf-8?B?TWgrWURaZjY4K0FXc2hJQWZ5MWtSYmtzWU45dUx5R1d2SnNZM0RJditJY1hv?=
 =?utf-8?B?ZHF4Zi9DRzA5OVNUOFpqQTMrdHdKM29DaHBueXFDY0dvMUF3cVdCTC9SeDFl?=
 =?utf-8?B?Z2NLUjdwbkVFNkg1WG91ZU5GUm5vV0RoaEYxVXp6UjBKSXB1UGlROE5ISnpu?=
 =?utf-8?B?SThnbTFXQUxNSGtYcGVzV0xTZWhHVW5MZUFrempwVVJlek9GdnlMUGRQU1pU?=
 =?utf-8?B?RndsQmkreFNMRlh5OUZQMkZmUDFldVhLczBaM0F3S3Z0TTZQRmpLQUlnVjVo?=
 =?utf-8?B?dnVEb0NKK2NKdUlUdW4rd0UzbTJsd0lKc3JFQTNGNXVXamZEdVhIUlVBZjA4?=
 =?utf-8?B?ZkdUSmVwZWpOUVN2Q1JXMFNUcit5YVFFZHl2ZGRGOTRlVXF3UG1WVDk4Ti9Q?=
 =?utf-8?B?ZVAwSXlFU1dlei9UWms0WEpCWXN6RzY3YWo5NTc0RGxRaFZhZTFXSXJ5dGR2?=
 =?utf-8?B?WC8wdUpFTkdxNGVkYnhzdHhGNmMzWnl2c01qY0NoOXBjSlAvMnFWN0F1OUtv?=
 =?utf-8?B?KzhwOGNrV1BSWExhNmtUZjFhdysvQUlqQklxMUllT28yblRhYkkvR0Rwdllq?=
 =?utf-8?Q?T37aS+RVeOUO7bHg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743c99db-a345-4039-c2af-08da1269931f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 16:23:07.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zgkwTB8hls75A89BTs/obqLQop9jDj/zSANW4X3E4QBXEJM6P6v3Yn9yKkbWqs5r+IJT11YbVbOrtarkWm/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_06:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300080
X-Proofpoint-ORIG-GUID: ZEUlkUvHk327CTGt2b21X-5n0fYc_AsZ
X-Proofpoint-GUID: ZEUlkUvHk327CTGt2b21X-5n0fYc_AsZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 00:58, David Hildenbrand wrote:
> On 24.03.22 18:06, Mike Kravetz wrote:
>> hugetlbfs fallocate support was originally added with commit 70c3547e36f5
>> ("hugetlbfs: add hugetlbfs_fallocate()").  Initial support only operated
>> on whole hugetlb pages.  This makes sense for populating files as other
>> interfaces such as mmap and truncate require hugetlb page size alignment.
>> Only operating on whole hugetlb pages for the hole punch case was a
>> simplification and there was no compelling use case to zero partial pages.
>>
>> In a recent discussion[1] it was assumed that hugetlbfs hole punch would
>> zero partial hugetlb pages as that is in line with the man page
>> description saying 'partial filesystem  blocks  are  zeroed'.  However,
>> the hugetlbfs hole punch code actually does this:
>>
>>         hole_start = round_up(offset, hpage_size);
>>         hole_end = round_down(offset + len, hpage_size);
>>
>> Modify code to zero partial hugetlb pages in hole punch range.  It is
>> possible that application code could note a change in behavior.  However,
>> that would imply the code is passing in an unaligned range and expecting
>> only whole pages be removed.  This is unlikely as the fallocate
>> documentation states the opposite.
> 
> Yeah, some weird code could behave differently; an app would have to
> pass in an unaligned range and expect that partially covered hugetlbfs
> pages remain unmodified.  It's hard to think of reasonable apps that do
> that, but of course, some buggy code might then be *actually* broken.
> Like some messed-up align-up implementation that accidentally adds +1
> too much.
> 
>>
>> The current hugetlbfs fallocate hole punch behavior is tested with the
>> libhugetlbfs test fallocate_align[2].  This test will be updated to
>> validate partial page zeroing.
> 
> This is in line with other fallocate() behavior and documented
> semantics, so I think that's the right thing to do.
> 
> I think it's worth to give it a try, it's hard to imagine that this
> actually breaks something.
> 
> 
> "After a successful call, subsequent reads from  this  range will return
> zeros." will work as expected with your change.
> 
>>
>> [1] https://lore.kernel.org/linux-mm/20571829-9d3d-0b48-817c-b6b15565f651@redhat.com/
>> [2] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_align.c
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  fs/hugetlbfs/inode.c      | 67 ++++++++++++++++++++++++++++++---------
>>  include/asm-generic/tlb.h |  2 ++
>>  2 files changed, 54 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index a7c6c7498be0..f62ec4f71132 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -587,41 +587,78 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>>  	remove_inode_hugepages(inode, offset, LLONG_MAX);
>>  }
>>  
>> +static void hugetlbfs_zero_partial_page(struct hstate *h,
>> +					struct address_space *mapping,
>> +					unsigned long start,
>> +					unsigned long end)
>> +{
>> +	struct page *page;
>> +	pgoff_t idx = start >> huge_page_shift(h);
> 
> I'm a fan of reverse Christmas trees :)
> 

Ok, no preference by me so I will change.

...

>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 2c68a545ffa7..4622ee45f739 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -562,6 +562,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>>  	} while (0)
>>  
>> +#ifndef tlb_remove_huge_tlb_entry
>>  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
>>  	do {							\
>>  		unsigned long _sz = huge_page_size(h);		\
>> @@ -571,6 +572,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>>  			tlb_flush_pud_range(tlb, address, _sz);	\
>>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>>  	} while (0)
>> +#endif
> 
> Was this change supposed to be included in this patch?

No, this should not have been included.  Sorry.

Thanks for taking a look.
-- 
Mike Kravetz
