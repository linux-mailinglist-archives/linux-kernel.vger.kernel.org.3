Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59735A8B52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiIACSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiIACSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:18:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F561616A8;
        Wed, 31 Aug 2022 19:18:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNmtRD026960;
        Thu, 1 Sep 2022 02:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P+CzBSTRFz4r+Ey6riCspyXOdE4e+dW5gOmgkQ5LV/4=;
 b=a/HB5BQHIUIF4F6qzUWCxaaRN2uaDny9B9JxWwZZwuzvZoJOu4t4A5cXOq2Ux85Y4dJS
 kuKUnkgW3eE/Ix8xZ3mysWVLEPVgWNpzzjIKnar5XSy7FfZ+k/ZBB4frF4SGfS+1Qp5C
 SAoehPOL1KNdBm6ICRWQdC3QUKO2PGurdowzw8OwjY6o8bWrw3muORupeTXh1vm9V3rX
 sUpRBKYVfHd6jxzwgusifckFAWDj6L2d3rUcy1OhTzdUNtWP5e+GAefiIfmZK7vuzeo4
 iYORhy4oZ/9sd21ZTBJphaE7m4mWT3X2YeZDOaQuAL+MouOxiJrSToOrcyL7siA2kf+l fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsjs39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 02:18:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNZGep022172;
        Thu, 1 Sep 2022 02:18:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q5pcm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 02:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1OENutZ7G1orvzHZP3rVsrBrJuU72Iqa2BBfAtR8cj0lqHcULv7T3A7AKPpRlUuJgWI963DxxqSvTsgrmJ9dBQO+qyVm5h/ylMNfSuAYmapQphv0JTzNa/SdOSlcMy228Bc/PB660OFzXmeIT0NHawSF6B9IiHQU27c6vdk4KpCuZdEWZ/pb+u5nlDvRmaeI4izynk58MDWqIMIH+/U62Kahz11mUjw+6flM7nk7LBj3B07rGEk/L9rAqZk2B4rsDxkntrsSwAb97VHgIOJfrr2ul/BlIcolBMHpbf6v0jOqiu2b9plaziKJIe2yQmyuMydT+Hkni54oWCYi6YBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+CzBSTRFz4r+Ey6riCspyXOdE4e+dW5gOmgkQ5LV/4=;
 b=g4+r36fVxe5lnKNVOpLAAuuNfLIzml9RYdBrtKjuhqyMX7QHlHLVljGGpVIjYw38iAusP3pApnMiAcCnH7AnoTupTqOV7yeK0Nl6knDi4yBc/EbrfoMF+rzleAO6jVQWtdyLcQyVNNtn1FOSpKjegYucOPJPY4ZvO28yinkBAy+TNQfrYwY6TV5ZdbuqfxIjoEjZurA1s0xlvyq+dtxxPyda+Dpgud3Un+16xcX0hi4qohl1Ml2bk2b4xEdsptV/K6MwtRza5TNBppWKvW9xSkqu9GasMGyUzXqJ3fOufSZRUfFAW0DwSuS6gTkxadfqtyiBfisx+Mp6pfP23fYaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+CzBSTRFz4r+Ey6riCspyXOdE4e+dW5gOmgkQ5LV/4=;
 b=Db+ruOlju4wbqnWTMhP8y0fCpZimdXSBStXW2yeGj3pH9WNEkI5gZLIsoItbODjMlOwIHht5B2ij5RqbPh6yzh/161NxDy3emW93kdASHdZFziab3q2au45/sMopqY8CyOf/0zIBWQcglTvM6rhRuDilIfUzFrE+J4cWiX1knbI=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DM4PR10MB6112.namprd10.prod.outlook.com (2603:10b6:8:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 1 Sep 2022 02:18:26 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:18:25 +0000
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
 <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
 <CAOUHufYHh3B6A8_pAusnW5==r3VhPxy6bOoUHbxe0qvhNGovqA@mail.gmail.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <982a4b95-0ab5-f18e-cbaf-1f503a35ada7@oracle.com>
Date:   Wed, 31 Aug 2022 19:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAOUHufYHh3B6A8_pAusnW5==r3VhPxy6bOoUHbxe0qvhNGovqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fce9969e-c8b2-4658-e8d9-08da8bc04067
X-MS-TrafficTypeDiagnostic: DM4PR10MB6112:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxlCVh7SP5HLvxpeK2BlbR3XeYvH0YmXjmweCD1urvHZlPTFL8noSssTGg3Mbo9gH4SpROuKlGR3dVjtG90y4I2IuqvlK1brN6h+965rUdn1owHWYAUTRHi3itUqK0B2mI5VGhUfuqLJV/mI4cjNtl+33RqfniSnErqYmsIqGYVRJrKU6jnkVo3tj0oCwgW0/XFSmT98c2QaPZA0Aw9EWdsu2E1jMCupBiLZViAn7lXPSEjr1S9wHdt5+T3eL/PxLfNVUJUURL/IjneyYeaZh1t6p0JnzACd99vtyFrdb04YlK+0KKoEZiA8/D4jNEwZhPSog0RDWq6DKVNmcKV6VLTpLqiWsosa9ePb/gy7pyFi0l4FTy0vMFDlLDZswgaB84rhFkLgX3OEVIdlCEhk5SYIBLmDIF6hVNO3XPxTNDjLMbh8Ec+JurESGdGX65y+QLZ1QvRgB/4o4z4p/4Tf3//3uyqiHpEeI4Za0/9kuzJ58wwuNdUFqxj1eUh/YT10GyZAM1IeQzIoEJxWH4FW5nlZVAmDqa4Hi9TQmkwoRqnohKLB+6ZvQ62jYqx+mThUvdiWi2Q2EL0FmM+JPn2Z106pAJajyVXA1Pjt5YdC0GPw/KKMHFymBwcMTkzbcb4QcbJuC2OcbJZ2Ob971AonXPDnxgmygRMViDqCmiGj5Hxtl291TcneSpqnyikpFMnwHrz2pIkhL6yz6Nj8cjYfPXjNik/g0rf/X5sTN9JzAEhh65pSd8cEmoWNQP9RPjSFNxkkM3ixzO5wH74r6cNBmXaB2DDVyNSK7/+2zqCllAmFXnkCl/ftUURRY5Jc7EiUkmvuXibk0UNjMNVXWRmMkGOArl3KuOYsrKlRfvurcBHvbpJo2uuiqc7Nbf36inwqha3150WmkdWFeSxRelBEk/cP9x4Bv2Z5VFDTkMjHFlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(136003)(346002)(2616005)(31696002)(86362001)(186003)(6666004)(107886003)(44832011)(41300700001)(5660300002)(8936002)(2906002)(53546011)(6512007)(6506007)(38100700002)(83380400001)(54906003)(36756003)(478600001)(66946007)(6916009)(6486002)(31686004)(966005)(66556008)(66476007)(8676002)(4326008)(316002)(160913001)(15963001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck56ZERGVDZwSFlQS2RRUVBXN3ZBb0xPVHd6MUZwMEFJbXBjM1NVM203T1Bk?=
 =?utf-8?B?eVByRlY0SlF6RGR4MnBidFZUNzlSVFZjTHBXMFhMWE9OQ1pvcEJIZmdzSS9W?=
 =?utf-8?B?VjI4UFF0TW5FazUzNFY3bkJxNmcvWklsVnZtR0gxbmhMMEpTQU1OcjcvdUNs?=
 =?utf-8?B?d1E5V1NiWmxOMDJ0cldSdS9zVlhqNHRVWTMyVENWcGd3aWlRMkhIM2hrUFhp?=
 =?utf-8?B?VFhLcnRxSUNBekxOL2lRWm5UaXFVeXFoSEI5Qlp4MnNFZitZdHkwZDJWZVZz?=
 =?utf-8?B?aDJNWEJNWk5ac3MwL1k5OVdnVFJNMjFuNlgrNHY0MWNJZ2x4RTJhODJsczJO?=
 =?utf-8?B?aU85K1hNMDRSS1RkaFRNVnRidHoycHJURXhna3UyQXRxSUFIOHJiMGxtVGJq?=
 =?utf-8?B?K3dLOGR1SlFzbWRnOE93UjdrTDRoMWFGZ05raFJBZTM1R29kTzdRRzdsTm9Z?=
 =?utf-8?B?bXk1eWJ5SzIydE9GKys4b0Z4Z1dsckhYbUVoVm1hSnQ2VGs4SURvL2ZzVVBp?=
 =?utf-8?B?SUNzZ0JMUzV3RUdFKzRLcGVMbDlCcTFBTXRwMmE4MENzL0Q0YWhMUDdncGhT?=
 =?utf-8?B?V2d2dVpOVmx5UkFIUy9hQVJwOEVKWDB0QUdkVXhOQUdFZWF4VDIvRkxTaEg1?=
 =?utf-8?B?TFJXVEowaGVrU1V5M2hGMHF4Zll0bHFBL3d0bzZHMEI5V3YvTHkvdG9SQUtP?=
 =?utf-8?B?YUVFcVFIVWl1TjI5SlhDS2R6Tkd4SHdNaGhvdEtOMnNGWWdXc1NVQ1RKbWtP?=
 =?utf-8?B?c1JTMWZPVno3VVJTTnN2SkMrNExtOHVUQTFobUx0RFppUGRqN2VLS2hPcVZo?=
 =?utf-8?B?QitwQzcwY2tSU3FqUU8wNzhVTEsxdUtSTGhaZ29UeksrVFQySFJGWVNLRCth?=
 =?utf-8?B?djlHcnVyV092WHQ2T3hYNU41NURPSnAyZzRtSUNHNE9DNE15dXlGY3VzUExm?=
 =?utf-8?B?R3p2S09PS2VCdVlxVGdDNE9WMkJIQlRDK2o1cmdCbXhHRzFuc3pYaW9nVUk0?=
 =?utf-8?B?MVd1M1FZU3FMWGNNN1A2MEVJcFVXdU9hME5UMzJraEhxamlxWlEwME81QVVN?=
 =?utf-8?B?OU03WERpdHJUU3NZNEVNaVIxQjIrdGF4VzhBUjdBQzI0RVp0L3Vjb1NXdVVM?=
 =?utf-8?B?VThxL0MrWG1VQ1FSSkR1U05qZmRZT2FUS2pJczRYekI5RE92MDZiRFdxSGpZ?=
 =?utf-8?B?amxZSGIwSXRLSkkwUDlLR1ljM2Frb3ArTnd0MWdYeU8rbHpHWUZpM1N6YVkw?=
 =?utf-8?B?VURyZFJWOUx6c1BYMjRVdDI2cEhndXJEdXA3cGlpZkFCc3IvcXFuNEFGQWF0?=
 =?utf-8?B?QTVMTDdobGZuNHMzS3FiSk9Tay8wZW1OVHVTUmkzMEhLK3hMWnQxdVN0SXkx?=
 =?utf-8?B?Q01NZkxKSHM5eUVjWDBhWE1uWFJVZUs2TDFnbXdzSlVEd3ZPazFKRkFhTkJZ?=
 =?utf-8?B?R2hEcHByZFBKQTBCNjZoUzZZeXN4SWp5R3VXNys0SUxLSHIyZkw5dkQ2a2U4?=
 =?utf-8?B?U1lLOC8zSmRGcFFGTi81MmlpZWJMS3JrSmcyMnlZNk5tdzJtKzRvQi84ejJD?=
 =?utf-8?B?OWN4TElWNlgzSjJIUU5uU0NJRlRiREhOSmtTWHZ5M093UnJCbTJCR3R2UTR5?=
 =?utf-8?B?KzFac3pXeEozRDBkbDI0N2hTVDN1WVVFZFdCdTl1STlvYUZ3R2JKcW82UEs5?=
 =?utf-8?B?VlNUb0thbU9NaXFIb2xYU1QxZXlaWE5LSFdUL0RSRTg4MDdDbXhBQ1JmekZt?=
 =?utf-8?B?ajJCMmxIczZyRzh6Mk84bjVtcjJraHFobFJ0N1o3d3RKZWR6UEZFK3NiWlkv?=
 =?utf-8?B?Sndqa0laY1E3UTkveHdhYXpSWUxadEo0bXVmRDV4VWFoUEVtbjZFdnZSYTRC?=
 =?utf-8?B?eSt2UmhtMk9oWXdGaURJT3E5R1FsaUpRM0NtcEZNY0JMd0RvWDVsSm9rRTU2?=
 =?utf-8?B?R29PVG41d1pNQXdxRXFaSWpkVlJHejFxcmI1eGRJS2hReTJmNlY1RFdIbGND?=
 =?utf-8?B?WTIvMXJ6UXBFcE1ISjNvYnJXS3FOR2dhYVZTZCtTYTA3U3NNd1NLaFVMQStV?=
 =?utf-8?B?eFZGWTFFaHA5WXRWeVIwRnZ1WGJnd1UydGRjU0gvUitSUWl3UWlxRU9Vc0ha?=
 =?utf-8?B?cnVUakRSMVVham5iU2tQVExPMEU1Y3k3UXI0ZUVDaWdVZ1NCd24vM1dLZVBa?=
 =?utf-8?Q?Fj6oEN4Tx1TAlsurxaCnW4s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce9969e-c8b2-4658-e8d9-08da8bc04067
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 02:18:25.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/aDA54ynmm0uBg0rJq88HUMupc52wpghSOQ4qo7m6AKiqolj3yOwJbHf0R+v90xbiN7yJKi1Lf4MpFrK0sJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_16,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010010
X-Proofpoint-GUID: dCy75uRjfrUQeYXo9vjDo_jdNk0lZDyt
X-Proofpoint-ORIG-GUID: dCy75uRjfrUQeYXo9vjDo_jdNk0lZDyt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On 8/31/22 5:24 PM, Yu Zhao wrote:
> On Wed, Aug 31, 2022 at 4:20 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>
>> Hi Yu,
>>
>> As we discussed in the past, the swiotlb panic on purpose
> 
> We should not panic() at all, especially on a platform that has been
> working well since at least 4.14.
> 
> Did you check out this link I previously shared with you?
> https://urldefense.com/v3/__https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld*pnerc4J2Ag990WwAA@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!PXzSLurBv7VqxI1451TV4zO3_-BYj4grk-HYBsXzSnA6nZcXaBzdsQ-rF2DAqlICSRPMt-efYv_Uu2A2CQ$  

Thanks for sharing! I used to read that in the past. To be honest I am still
confused on when to use BUG/panic and when to not, as I still see many usage in
some patches.

Just about swiotlb, it may panic in many cases during boot, e.g.,:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1955655

> 
>> because the
>> mips/cavium-octeon/dma-octeon.c requests to allocate only PAGE_SIZE swiotlb
>> buffer.
> 
> What's wrong with PAGE_SIZE swiotlb?

The swiotlb is like a software IOMMU. When the device supports only <=32-bit DMA
while the IOMMU is not available, it may do the below for each DMA operation:

1. The swiotlb inits and pre-allocates many 32-bit memory during boot.
2. For a DMA read/write, if the page is 64-bit but 32-bit DMA is required, the
kernel swaps the 64-bit DMA page with the pre-allocated swiotlb 32-bit memory.
3. After the DMA is complete, the 32-bit memory is swapped back to swiotlb.

The size of pre-allocated swiotlb is fixed during boot. The DMA will fail later
if the pre-allocated swiotlb is not enough.

That's why I think the objective to set swiotlb=PAGE_SIZE is just to minimize
the swiotlb pre-allocation when it is not required. I do not see a reason to
pre-allocate a PAGE_SIZE for DMA.

There was a discussion between Robin and Christoph whether it is a good idea to
disable swiotlb by allocating a small chunk of memory.

https://lore.kernel.org/all/d5016c1e-55d9-4224-278a-50377d4c6454@arm.com/

> 
>> This is smaller than IO_TLB_MIN_SLABS.
> 
> IO_TLB_MIN_SLABS is an arbitrary number, and it's inherited from IA64.
> So does the comment below. What exactly is the rationale behind it?

To be honest I do not have an answer as different people may have different
preferences. Some people may prefer to increase IO_TLB_MIN_SLABS, while some may
prefer to decrease.

That value of IO_TLB_MIN_SLABS was there since I started working on swiotlb.

> 
>> The below comments mentioned that IO_TLB_MIN_SLABS is the "Minimum IO TLB size
>> to bother booting with".
>>
>> 56 /*
>> 57  * Minimum IO TLB size to bother booting with.  Systems with mainly
>> 58  * 64bit capable cards will only lightly use the swiotlb.  If we can't
>> 59  * allocate a contiguous 1MB, we're probably in trouble anyway.
>> 60  */
>> 61 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
>>
>>
>> The arm may create swiotlb conditionally. That is, the swiotlb is not
>> initialized if (1) CONFIG_ARM_LPAE is not set (line 273), or (2) max_pfn <=
>> arm_dma_pfn_limit (line 274).
>>
>> arch/arm/mm/init.c
>>
>> 271 void __init mem_init(void)
>> 272 {
>> 273 #ifdef CONFIG_ARM_LPAE
>> 274         swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
>> 275 #endif
>> 276
>> 277         set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
>>
>>
>> On x86, the swiotlb is not initialized if the memory is small (> MAX_DMA32_PFN,
>> at line 47), or the secure memory is not required.
>>
>> 44 static void __init pci_swiotlb_detect(void)
>> 45 {
>> 46         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
>> 47         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>> 48                 x86_swiotlb_enable = true;
>> 49
>> 50         /*
>> 51          * Set swiotlb to 1 so that bounce buffers are allocated and used for
>> 52          * devices that can't support DMA to encrypted memory.
>> 53          */
>> 54         if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>> 55                 x86_swiotlb_enable = true;
>> 56
>> 57         /*
>> 58          * Guest with guest memory encryption currently perform all DMA through
>> 59          * bounce buffers as the hypervisor can't access arbitrary VM memory
>> 60          * that is not explicitly shared with it.
>> 61          */
>> 62         if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>> 63                 x86_swiotlb_enable = true;
>> 64                 x86_swiotlb_flags |= SWIOTLB_FORCE;
>> 65         }
>> 66 }
> 
> Thanks for the code snippets. But I failed to see a point.
> 
>> Regardless whether the current patch will be reverted, unless there is specific
>> reason (e.g., those PAGE_SIZE will be used), I do not think it is a good idea to
>> allocate <IO_TLB_MIN_SLABS swiotlb buffer.
> 
> For what specific reason? My current understanding is that you want to
> be future/fool-proof. If so, then you got the priority wrong. We need
> to make sure currently working systems continue to work first, then
> future/fool-proof.

My objective was not to prove which option was correct/incorrect. I was just
going to share my understanding of the situation to people on this list, so that
a discussion can continue.

But I do agree with your point on 'priority'.

> 
>> I will wait for the suggestion from
>> the swiotlb maintainer.
> 
> Chris is on vacation. I sure can wait.
> 
> But it sounds like you are unsure about what to do. If so, it's not
> what you claimed "we have already understood everything related to
> swiotlb" previously.

The swiotlb is a component used by many arch (e.g., x86, arm/arm64, mips and
xen) ... while I believe I understand the swiotlb well, I do not understand what
other components are expecting from the swiotlb.

That's why my objective was to trigger the discussion but not to prove my
statement was correct.

The swiotlb is still evolving due to it is more widely used recently (e.g., AMD
SEV). The discussion helps people avoid introducing more issue because there are
many components that may use swiotlb now or in the future.

About what to do, I think it is to either (1) revert the patch or (2) avoid
initializing swiotlb if it is not going to be used. However, I think my thoughts
do not count that much, and that's why I would wait for the suggestion from more
experienced maintainers.

Thank you very much!

Dongli Zhang

> 
>> Since I do not have a mips environment, I am not able to test if the below makes
>> any trouble in your situation at arch/mips/cavium-octeon/dma-octeon.c.
>>
>> @@ -234,6 +234,8 @@ void __init plat_swiotlb_setup(void)
>>                 swiotlbsize = 64 * (1<<20);
>>  #endif
>>
>> -       swiotlb_adjust_size(swiotlbsize);
>> -       swiotlb_init(true, SWIOTLB_VERBOSE);
>> +       if (swiotlbsize != PAGE_SIZE) {
>> +               swiotlb_adjust_size(swiotlbsize);
>> +               swiotlb_init(true, SWIOTLB_VERBOSE);
>> +       }
>>  }
> 
> Please ask the MIPS/Octeon maintainers to check this first.
> 
