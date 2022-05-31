Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130C539526
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbiEaRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiEaRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:00:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6869CF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:00:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFuxpr000309;
        Tue, 31 May 2022 17:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VMQaIG/OBhriPNPriL+sop9nTgThCzE9RiCZit7ucjs=;
 b=KtjzP4eefhWUQivcgl6mVDGLdPCR/33Z3gJXeVk4/5rYt9VFRy/fDxKo8hZGC4nSjz59
 WipbsG//3jDj2IDkUZN4Ei2OSK4R0K2y+DnYnbL/Ub53RW8x1GXHEVdNFIna8RJ6rcLY
 tnqIumxcG34DyHI8X94o2HFkuVwTLoiUdW8te4yQ+aG//WEgpyejatkBr/2quoxKiyJ0
 YNPzWpkcAsdtVtwgqADV3j4zaQdxuot1Sc/rcAMb4nbgSJ8Kjov8e0jtoYD703R8df8b
 gAv95L8fv32oFxQ8Wc/CDNVOikGsUnmwf3rHunyTzWaZu3wCJOWyVB5C3G1Sylu6izgD Fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm5br4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:00:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VGpbRu009460;
        Tue, 31 May 2022 17:00:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kf5kff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkgyV27ywH7X8FhwigLZx4a90j+7F6hl9ka86oCe2xzpfF8pmacOHEIy7HDEYjVS1Ad6oKcH62Xzyu9AeO3KqK7XQCPUy4YgeN3SrjmNWDp62csOJF1rpW4Tk+oVvgNqr8VoHia1A2aKz7U5hb+UlnQ6Kvsmc8Si3edvhCnwfJXO1+pnl16uccZuP4iey4V0xTOtBL5hWOEm22sbwMDLqh/tfjJb420DN8/8rmKIhjINqbqDgINBiQHneI4BGzI57IFq6xEOsYsmA4kAkmOKJ5BB7sZxVhacjCV8Lkf+BGeF+7O5PhOdi+VssHASx0OvdONfVzTCJNAooB3sFALfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMQaIG/OBhriPNPriL+sop9nTgThCzE9RiCZit7ucjs=;
 b=ZWBSDNVJijZSbObRTuwifT1Es31H+qOIBn6l3g8JAdRtyZmbTth9hLnW6tZl86tUi4mCTTbp+CiZ2J1tJvq8qWhQZ4fql9q24heqnYDPFsmQvSxxmWiDWpgCkqTo57gctxdhTv29UpdBpas0y3OjS5XINV/+hXEISLJyLte/hP1GkWEcyjjgpXCXyvansoL0h4Wx2pD4LxhkkfnquT9l6Stm/uiPn2EHgGHjrIqntBxt7JO23EYEUa6gwjUaWWcQ92GFOUNaRRaWBa72gE2Z9yLs9B2YWuYgacKAoXJTOec/P+k241pOHTrW54YnWhJrM3rZ/iWcFFt8I6yOyXhyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMQaIG/OBhriPNPriL+sop9nTgThCzE9RiCZit7ucjs=;
 b=mtRFF/uTHQvh5SUpkA4KBRiY5Xu4m6p1S61PbL20n3UEd8epZl+RfmB8a07K5uwUsT5kqdxXVHEBf8yl+RIdZAtTjoGvsG61d2UuN0UadkmZCjEU4w7cO0yeF9vH9loEkeZqwgYlbOx8kZ3U+rbPuJXP8rCG8/BSfKH7ElYtxs8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 17:00:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 17:00:24 +0000
Message-ID: <e9456223-c26a-4d49-2920-9a597a817190@oracle.com>
Date:   Tue, 31 May 2022 10:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
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
 <YpUhe6BSfflOVz7b@xz-m1.local>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YpUhe6BSfflOVz7b@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:102:2::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae3e85a8-1f68-45dd-96a1-08da43270ddc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4468E9495EF0257A3195AE26E2DC9@CO1PR10MB4468.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jARIKEGVDcRnlDUloFEIB+JgMp6hzYmMbZIa/gvtUR5TMWCmrWOuHIQhTIOfj/sbWFl6gtnAzuJ5FL47p8to7OSY/q7ARTyIF6Hqp6n7egPuFeOSfbI7Dc46nrkXZmoXkhPSbupXi6Q0BSjUzgoT9Jgnqv/ARpl6Mk8z0tAffGLl8BQK7bvLFIyALryBeUudueMBTu8dX7a70KxB1noJjear3tZaybTh0sg0CZ5ZXpksoC0RZ3L+vHyt3MYNmFQQCHbkIufZoWw3nqJ1IzaVz1yyyfGcwKNQf3sUNTiK2ZTIuegnVPijVTPDLNgQS522+QPDuUBXIyQwOFRraI0+1FbjrheEPWhDxoQHpWkCcDKCQqrIYBQFL2RcYFJ8NPBIDcKr+oT80ocmg5gDsQRc06IhL4RvRcpUqAd8GMJI1TgBqJrYk9ExLmCBRX3SSnoYduyxMJh2bUAeEHdeXJdyshYHovg+IL40oNTXDO/EnQWOuuF8Qryl/eNco2EfRZ6hJ+Oaq3KsVs33DRvVITAZUQSK0sMXwDQF8Rmpwy5GFX1rmnDi+zwTysw3fs6+zmkZQdRom2VIHxoFgepPktzZZeTjCQ/BlmTfdhXNk74CMuBdrwfBdZv/xSMwU688V3R9HdAxP10HreElal2dZDBTI/HNVaV2irIvSAn2/NO6Qxi/ZJFyAQbQ5Ut0noLeR/mKBMaDZmRCEeJZHmuTiPGaFx03303phHwC4lykk6FdaDWhIa4f5TJsrucyVwpcdTnOfJZi/W909BRr4c5XSd1zJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(38350700002)(66556008)(66946007)(66476007)(86362001)(83380400001)(8676002)(4326008)(6916009)(6666004)(54906003)(38100700002)(316002)(36756003)(8936002)(186003)(6506007)(52116002)(26005)(5660300002)(31696002)(508600001)(6512007)(6486002)(7416002)(2906002)(44832011)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TStNelhmTC9wd2hkblZIbW9oc2FoUUl6TzdSVUlIMUJ4a3I2OTZkL2diM2NG?=
 =?utf-8?B?cXlGTlk3R3d6ZUI0M1owSDJXcWJVdmpHejZnbGU1dUhCdXJhTmxZZEV5QmdT?=
 =?utf-8?B?MGRsNWsxM3NDaU1pOFdMWlJwTHR5UUZ1QXIxZmFpUDhsWXd4QW0vYjF1TEZz?=
 =?utf-8?B?b0djM3pLTnNGcFE3dnZsT2hhZjYvTGlPSVN2b3NLNmlwYWpvM2R3dmpPejUw?=
 =?utf-8?B?YUhIY3YrWnhZS3l3NnNjcnp1RndreTdERzhVeDBmcitlcEgzK0MzYnNNMlA2?=
 =?utf-8?B?RFlJMWVaZElMRk9BdTRlczZpb1pkdE4rcVEyOFZVR2VPZ3Z0cTcxWm9uanRI?=
 =?utf-8?B?MjJCaFVPN0xFd3pLWVVydFExaDhYOHpyTmJYMXliZEdFdkJBYXZFbG5FRmNn?=
 =?utf-8?B?N0VHT1AwOGJ2SlM4dVhHM3VRclF1aHhKWXhTdVdpRGhDRTVPWFJ5QUs4Nmwy?=
 =?utf-8?B?elZ4RTZpbk5TUXR6RFI5WStZNmpLOVR3aDBwR3RSR0JSRFBrUjJaOWFCTmpk?=
 =?utf-8?B?TUhPelRWOGlzb0NFaTlNY3VwQmV2eElCNG5YUlpKQXd3a0d4U1RPT2o3R091?=
 =?utf-8?B?ZkM5c2d0bE5xTGI4UGU5eDkrU2xaM0syTlR1cWMxTE05UURTSExjY3h1YXQ0?=
 =?utf-8?B?MDN4ODhGeElCTjF6ZkZRSDJOdzIxakRLZjB4UTVwaFJzVmF6TlZxemdvMnhh?=
 =?utf-8?B?dmx4eTJvcFN6WGM2K0xVendUMzVCdTFKOFN5WFg4VVhyQllJOW9heHNCdjZ6?=
 =?utf-8?B?aFVlN3JnSzFDRE5KcFRwYUsycHdmd1Q1cEpHTzdTNjhHM2lNUzlSV3hQY0Fr?=
 =?utf-8?B?Slc2UjRYMUgwdlF2TGV2MjM2NXY0a2lzNWplcTcyait3eGYrWUZYVEszSXhR?=
 =?utf-8?B?V2FTbHoxUkJzZXZxZXcxSlhNVGkvWEl2UzFsMDdONHQ3TFFkSDlhYUJZMTcy?=
 =?utf-8?B?OUZBWnlDelRUNVQwQ25abkxRc0tSRENKZS9iMms2QXg4NGE1c1lrR0QvTjNY?=
 =?utf-8?B?Tit5S21MTklBVmtJc3lzYVh3blR0ejN6Sjg5M2RadmZESlJQTzdLblM5WitI?=
 =?utf-8?B?T3RLNE9Ia1ZWUVE0WHh1NzhodWdHTEJhVlZYUXBQc0hTTWphQjkyNUpjOHM2?=
 =?utf-8?B?Wi9TQW0vRmgrNTJGUTM2TVdQU2thZFh0QW1FWldodFNvWXp0V0hQdnNkYk1W?=
 =?utf-8?B?RjBMazYxUEJveXFOQkNKSUpCK1BOaHc5eVZEbk1jS2liUUlTeTY1VkQwZjIr?=
 =?utf-8?B?MG11TTQ0QnVSUTNjdE15ekY1L0lQNGU2WWpUZDlTM0tTaElQWUdBQ05YRmtD?=
 =?utf-8?B?VkltY0kvZUNyUitFOEJkSHkva29qdS91TEYzcGhCSGNreXdNVUJhSlV5V1Ix?=
 =?utf-8?B?bXNlRVBrVUxZMkl5ekNhc2xjSHdsbTIra0JZUWZ2QVZJeGVUdWdiMXdzMG13?=
 =?utf-8?B?NnJsZFk3b0c1TXMzc1c5Wktkc2xDTHMrdngra2gzVTJjbnBIUUxzd0lyYXBM?=
 =?utf-8?B?MTNpMnBIVGNSR0kwcUx0SHRMMm9FeXNSSHpRK1loaVpPVkpJclZIajQzZjlD?=
 =?utf-8?B?UENYaVFPOVZaRVFSTUZRZEFOVGlRTUVZRmVNc2Z4dGFtQmJNZmRMbVZBdHFY?=
 =?utf-8?B?RnV1Z1FoSHBUWnhBQllEd0VINloxSzVTWFZOVkNYbFRCakV6VXBWZ3cyU0xj?=
 =?utf-8?B?WU1JZ3ZwV2J2SVJtWEEzVG81T2ZiT2ZQUjQvdWkzRVVLZDVuWkp5WjRuRDhJ?=
 =?utf-8?B?OVpiUVErQXBFV1MrdnM3VVR6eHZFMGZEb2hBN2hMamJ2QjArSVpBWGNWUmRK?=
 =?utf-8?B?YUdENklXbzFUcVJjd0VUbDcvU3NHR2Jrb3diWHlxdFZIYk9KYmdDS1FzM3Vv?=
 =?utf-8?B?Q2hqSDk3MS92blZTcmY5Y0JNOHd1cjk5Q2pGMWJRNXc4VjJ1aWJWdkJrVVVs?=
 =?utf-8?B?NWlHRFFLditvcHNnVGZRVXRFTThYckJyUWdFc2hmdWNudUhxQWN5emQrdkpQ?=
 =?utf-8?B?WWdWL1psYjRhUUlEb20rSmozcVVCa0ZZbERNVURGb090RnNkdjNZZ0ozUW9v?=
 =?utf-8?B?TW0wN1o1ZnlqUnkwaXVTa1BRM0lwTHYwaDErVmhWdnE3MkwzZHlzUWRnazE4?=
 =?utf-8?B?K1JPQXhsQ0o0bDBqN1RaMDBwRUhUakhWOFptUmVuazFEUjFSWEVuQ3RLYXRn?=
 =?utf-8?B?L2hiUDJaMzJ1OG9PNlc4RGg3V0E5TU40K3NFK0QyVzIrR1pCUEFXb1AxRmZT?=
 =?utf-8?B?VFJ5R3p3emJ5cjlnMEx6YVZ1NzVLaDgwdWNQbUovTThzQ05vT0gxUUkyNjFx?=
 =?utf-8?B?ckNxRDQ1QTNMUWoyNTQvVHpyY0lsbi92aU5US290cjdmZGFGc1hQam1Ub29P?=
 =?utf-8?Q?HzKEYSGFkDg+/J5Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3e85a8-1f68-45dd-96a1-08da43270ddc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:00:24.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLbTPR8hmTZIbpUk1Jac8DCmKUMdfmmfBIZ0TWdHUCuXrj00FQE/Mw3ECVfR5LOQXad7l+dR2i8OP28jNvq2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310080
X-Proofpoint-GUID: lJKn2dSNQk85-MMeq5KuV08Cc1-aHpeh
X-Proofpoint-ORIG-GUID: lJKn2dSNQk85-MMeq5KuV08Cc1-aHpeh
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 12:56, Peter Xu wrote:
> Hi, Mike,
> 
> On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
>> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
>> +{
>> +	unsigned long hp_size = huge_page_size(h);
>> +
>> +	if (hp_size == P4D_SIZE)
>> +		return PGDIR_SIZE - P4D_SIZE;
>> +	else if (hp_size == PUD_SIZE)
>> +		return P4D_SIZE - PUD_SIZE;
>> +	else if (hp_size == PMD_SIZE)
>> +		return PUD_SIZE - PMD_SIZE;
>> +
>> +	return ~(0);
>> +}
> 
> How about:
> 
> unsigned long hugetlb_mask_last_hp(struct hstate *h)
> {
> 	unsigned long hp_size = huge_page_size(h);
> 
> 	return hp_size * (PTRS_PER_PTE - 1);
> }
> 
> ?
> 
> This is definitely a good idea, though I'm wondering the possibility to go
> one step further to make hugetlb pgtable walk just like the normal pages.
> 
> Say, would it be non-trivial to bring some of huge_pte_offset() into the
> walker functions, so that we can jump over even larger than PTRS_PER_PTE
> entries (e.g. when p4d==NULL for 2m huge pages)?  It's very possible I
> overlooked something, though.

Thanks Peter!

I did think of that as well.  But, I mostly wanted to throw out this simple
code while the idea of optimizations for sparse address range traversing was
fresh in my mind.

I'll take a closer look and see if we can use those general walker routines.
If we can, it would be great.
-- 
Mike Kravetz
