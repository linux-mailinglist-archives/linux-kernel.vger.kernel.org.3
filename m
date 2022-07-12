Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043AA572728
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiGLUYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiGLUYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:24:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC7CA43AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:24:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJXoOn004672;
        Tue, 12 Jul 2022 20:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NJwkzDuOXR0dqbj5lwa/yTDUgZF+ahp8tDICCrXCnH4=;
 b=PthT9Wd/EtfEN22RNTPOCUPQBYIvnAfi7yOwztGS03OIwXP5jvcSSlhYBgJA5RoeaVvO
 we+hf2+YChTogfiR3cTPUrFt8/GA0fCtH2hWexQ0vzlGeU/MwyjOQNPtNMTjllsaxyDs
 IamTRGTbpqY6ZKNvD0CckXTYxgxXpI/k6bHrLRknqLhSE649Db92KhVaE15TIJyMwvWA
 whY4RssHC6rS3Z428nfVRTDBbCWz90ssja5ujM+svV62bJjq+PG4QgA0bYn2PZmIm8bx
 XikNziJfqjjN6s4SrwfjIlpo79Shpy2+FdiOVSeXBEDMbOP5Q4WRusai73JkQ9Rkct36 1Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrg7kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 20:22:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CKAbxp017395;
        Tue, 12 Jul 2022 20:22:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043j3fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 20:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmd5jYL4QWpEttAyeK3G5py7CsLFjZb0ZNbO536mo3ceUCWLtwgqtc7CbrapG/AK499oQf866A6UIXt9jDSdtnhFIg16Nl6phPs/iXtKkEUJ4IK9Fcto3WxJh554VVik34oiW5vbEE+jkhcCF/ZOTZE/j6hEBj4mCljKhL2fT5tPfyjgbhFtdS14Irj48+k+RSkL+pJblHabSLsw9s7S0JSPHLjIs7OV/yLBF1IYg9BQGfeZwGsjkb37Z9sGmn8o2kaZAhpLGp22nLzUffRsVSVEidiDiBeCuhsiATSpu/NVa8Q9Adlb45FoGJp+SkYUwfH+sAC762O++J/yO0lO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJwkzDuOXR0dqbj5lwa/yTDUgZF+ahp8tDICCrXCnH4=;
 b=klWw+xw4rZhL/oT9iMZf98/R4zIO7IGRccCytgD449CidMH0VKfIAiZXx73uf6iHGoftqhjLCuZIH1yBc0y6NNwPPsVg0brO65gaOZ0UGshp8PHuHJUsADqeFeRO+GRFZKGxvZ4IZZ1NebCneofWGfF7krgVOJzRXNn4D/gX4UeDRHTJud3wKt/wCSqQyVrjS4ElvlXq4+EmV581KY9mV4aJyobkXEFqLJ10eiJnrb4DjTFpWjyjZRxq4GCSgQCymQgHtrjNh0xJpFE74YMtPl8f06swSMJHl3cgut+9f7PCTRWjqbAMdQGJE+nm8EVsTDmcFRhTGLGe2XGhmpaxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJwkzDuOXR0dqbj5lwa/yTDUgZF+ahp8tDICCrXCnH4=;
 b=a1hvGbV9gtdH21eiX0FLbwzYSiekvyDzZqW14WXk4YG8K1IECzWNIh5g4crVDEnNrbx01868trQyF2SU4c9KdWZNZBiy0S+mLUYVLsK4V4ts7i+cEBy+wY80FdDFfF4G9lX/0eJWEAGMeOxYtJU4uke3H2tq1WC5ofh+opp5B9w=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM4PR10MB6015.namprd10.prod.outlook.com (2603:10b6:8:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 20:22:46 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%4]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:22:46 +0000
Message-ID: <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
Date:   Tue, 12 Jul 2022 16:22:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
 <Ys3MI7cv2yKj9RFc@kroah.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <Ys3MI7cv2yKj9RFc@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:805:66::42) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8573936b-b736-4edb-5149-08da6444488e
X-MS-TrafficTypeDiagnostic: DM4PR10MB6015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CF55cBR0c1mUt1KYTGfT+59S9oPfDNaOkdXLyjI2prgTX+mt9gKdTQX9mUYUppgcBecgmVfJ4HeaiUiCFTT7JwrK9pYinUxaveGR6wyeg4blZQmSi594D7FfNKokcsn1il1axztRgj+pDals+Pj6oVUM3ZWV9AwrJn54ZBJGKKkwtRbsxnEaJPRY2y/m78IvKupf1s6R7tjGkwF1WrJOJC415qFEubprxCajpUsd9sBjUBlhuMXdyDoouu7thwGsOYtbwOBo95PymTuPYKqaDDEHoQyfazyJ0yGbl6yX+f4U/5z0MApVPpMdLT3F+XsVuISRpyr5c4vZYyYQxEDIvhL9qw0Rm42nMGbpnO7PVkgGEdyCBubE53+ilcv+NISgiNurZByA9JLIVuNEYiLtbkRJ8zomCKlKctB0KXJ4rEwrbFZpkS5WczSu+qJ/d4xlRG8tvzMDszCr+8OchghCYVE5005UYfRknypXDB3Uh1uLksxZmZ1UC3yJuDsimA//ApzOoGN+LAVrkkzV+8ZHvtiKIODL6V9whL+nyiUzhI/otoOkcMi83/mnJ5r6PMWCG8ONXRzzderUwX32UJQy36xpgiJZOh7idNlEZKoO4NkVCTC/n6HIgeTX9xibfIK5CJYddXGh9RE7asC57fUDS8yfF3vE8dqf0sRQ3qw0QbknNcZvINeXQKnzf4FBRfBLg1/MnJl+J8pg1koogN5D/1OfrXJ0d8k0IybrmitqnxfPCT1gBeHZABD9hmrM9UydFVlIKB9SUSvy1yIPSeg/KUiBp7/whCkJx7FfpRDMzkk+h9qegk3kaHfDNrKFDLeTSOFhllIvV3uAbtzesK5RwENnb7r6CgFbevGEYt0KQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(54906003)(26005)(38100700002)(6506007)(6512007)(5660300002)(6666004)(31696002)(31686004)(53546011)(41300700001)(8936002)(2906002)(86362001)(44832011)(7416002)(478600001)(66556008)(6486002)(66946007)(83380400001)(8676002)(4326008)(66476007)(186003)(2616005)(6916009)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hiWnVZYmpScnZ2RCt0aGNpQzR0Ti9vOEg4OCtBbzNia1h4ZFNJc1Q3a1hQ?=
 =?utf-8?B?OWN5MmFvcjYzNTZZVG5mMGZiNHNHbnJxVE1Ba3lZY2kvM01oZ2FIa1h0Qmdp?=
 =?utf-8?B?MnJZakFZUGhHc2ZyRlVpckZVL1BZN3d4eTZoSllXT0hvQkR4aWVOTU1zNmM2?=
 =?utf-8?B?cnVoWEI2a0ViaDhpY3hIVUgrMTI3SkNubkxsK1FPRzR5YzN2THlpeXEwbG5j?=
 =?utf-8?B?N3Y0V0RCbWNibURHK3Y3Uyt1bTJjZnhZdG1IbFVnU1l6S2VOT2M5U3FTS0Yv?=
 =?utf-8?B?ZkN4aDdSd3VXUmliRVIxNWdwL1hUNGZ6OGZOekVqTnFhekExSGwxWnl0UEFk?=
 =?utf-8?B?VUFLbkJxZU1sdkEzdW43a2dYZ1hUQnR3RFNXTkNCQm1udTNIenUzb0JPODVX?=
 =?utf-8?B?bVhVaXAvclRxYWk1KzcyNHdXR3Q4Mnd2bDg5N3hlQVhFSkVXZTFMK1JFOE1h?=
 =?utf-8?B?ZE94dE9penE5eXFBU1F2NEdib1VMc0Z1MEdhSjdNaE83TDRWUldrck9WZThM?=
 =?utf-8?B?b0F6Wng0ek5SQlZ2Ykp4WlZOaVFwczgvTTN4cVAydlhyamJHVlJsY3hLS2Zs?=
 =?utf-8?B?SFdBWkRlNDB4OWh2M2NkazlPeUlMQnNhYlI0MG1pOG9xZWptZVMyUUhWU2Fr?=
 =?utf-8?B?T2hBUnVGdlROUmwwUTJDV2RsaTVsWFZobXFjN1lKY3l3dlQrL3FDWXZrT3dZ?=
 =?utf-8?B?bDlhY1cvOGVJcFdubUt2bnhtbEpFTFNwK24vZXpiQk9kRURZWmc5K1NuNmZ6?=
 =?utf-8?B?ZFJGSTFzQUVoblZxejN1YnZtZjJrNW42RU52eW8xb0pESFRQc2d4aE81RFJG?=
 =?utf-8?B?eVVkRlFwb0xxN3BGZWNXeEQ0cjFwVWZ3RmU5QUNWZWdwRjV5cEk3cXFnbVNj?=
 =?utf-8?B?NnZTUXkwMGo3MUR6aU0ra0VOdzQxTFA5eFBweVZ6YVBjUVM4eFgyZ1hGeG5i?=
 =?utf-8?B?OVpIWlR2ditPNElLNVhVdThtR05uc1BrVUd1SWIzWllhYVNyY3V6S3NzUzJz?=
 =?utf-8?B?UmhzMjF6WjJTQ3l0Nmd4VFdSTTJNZmRhYWUrdEJENHo3T3RnNWFRU2l2Q2tj?=
 =?utf-8?B?eHpIQ25ZRkszSFBUYTM2Q0ZjU09NMkNVZnVBN3g2SmlFTnFEUkhobnowRlRF?=
 =?utf-8?B?MXVEYVB4SlRtbHRQOGQ4SzcxSlVqaTVhajhod09FUVo0RGZzU2ErdVQvd2l1?=
 =?utf-8?B?Ykt4dEVhN3NuOWJEcERnSWRncDAzcVhiaFpwem1TTjNQUGlaWjF5enJnZjZQ?=
 =?utf-8?B?Vi92S3g5K05jcmRDVms3UW1JVnZLclJOcVN4cm9OdHkvRU10VFZwMSsxQ2VK?=
 =?utf-8?B?Sm9WcDR0T3h1OFFOTHFlQXpBcGpTZXZRL0RqaUhtbGE0dTluTUFvZlhZb2RV?=
 =?utf-8?B?cE9ycGY0bU1uOWdxdjFYR3hFdXZrMXVucklFRUsySFVqVXpTUWYrbzdhZ1g0?=
 =?utf-8?B?UVVyUnVWUTlUU3VHYlg2ZmpMbnFiMU54MEt5VDVTUXd3a0lyd3lITk15Tk96?=
 =?utf-8?B?eGZMUW5FTGVqdXREVzZzdE9vRHB5Zlp3V0NQZDlIbGdKNDJRbEt5TGlWVUFq?=
 =?utf-8?B?Mmo5OUVuVXc5czJPaFVyeDFER1cvSHR6SVVHcnNMQ0JLa1Q0T0R2MkQraUF0?=
 =?utf-8?B?WDgrcTF0N2wwQUozSS94akdtMjNHaXhjbGJvY1c1NDdJSng3TTVzQmRSZDdn?=
 =?utf-8?B?Y0dLbFpueTBxL25GRVg0Snc2TERGUktnOVE5c1VlUWlnenZyTUM5cW4rUVRD?=
 =?utf-8?B?MTBDTnhzRW5uU0VJVEgranFlYnJYQTFxS1hkMzZGS0JtY1BValgrbEE3cTg5?=
 =?utf-8?B?a003NVBMNUw2d1YrYWtFdVd0c1dqNTltQWJJd0RKTmRSTUJUMHNkd1NyU3M3?=
 =?utf-8?B?OHpJRGRKd0hDZjE4VDVkNGRNTHF0b0cyamFwaTN4ZVFDRitYVWpXZ3Q0WHFT?=
 =?utf-8?B?ek5lWU5rKzExKzZmQUg5ZUdmbElsK2o2d2VCd1V5SGh2TzJwRUVrRzU3TUFo?=
 =?utf-8?B?THJhbzEwKzBrdTUvVi92ZXEzMnEwMEh3cUJXUkNYMkRJQUNuaFlYZHZ5Y01P?=
 =?utf-8?B?UXZVbWZaRm04c0ZzUCtpa3JjWHJGVWNlRkJvaENObVc4NVpKK0t4U29XR2E0?=
 =?utf-8?B?Vy9XeDl3Z1BsZVAyWUhOa1ZjNW56LzZHU2xxNHVqbmJCU1kzMmNFT3Q3Wnhu?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8573936b-b736-4edb-5149-08da6444488e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 20:22:46.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 656axEEXAeyLOEk+YMiZk89YjxRKy+kaKtsqtxRksRUBtR4KeQ8VeZj5Gh4lfc3AxfYOsg7T/KptqS5Yot+G6R3qi825bEugh33R1BF9TeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120082
X-Proofpoint-GUID: yObhBEWzazCxw6dW4yliL8UZRyKPGEcQ
X-Proofpoint-ORIG-GUID: yObhBEWzazCxw6dW4yliL8UZRyKPGEcQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 3:31 PM, Greg KH wrote:
> On Tue, Jul 12, 2022 at 03:19:39PM -0400, Boris Ostrovsky wrote:
>>
>> On 7/12/22 12:38 PM, Greg KH wrote:
>>> Hi all,
>>>
>>> I'm seeing the following build warning:
>>> 	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction
>>> in the 5.15.y and 5.10.y retbleed backports.
>>>
>>> I don't know why just this one hypercall is being called out by objtool,
>>> and this warning isn't in 5.18 and Linus's tree due to I think commit
>>> 5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.
>>>
>>> But, is this a ret call that we "forgot" here?  It's a "real" ret in
>>> Linus's branch:
>>>
>>> .pushsection .noinstr.text, "ax"
>>> 	.balign PAGE_SIZE
>>> SYM_CODE_START(hypercall_page)
>>> 	.rept (PAGE_SIZE / 32)
>>> 		UNWIND_HINT_FUNC
>>> 		ANNOTATE_NOENDBR
>>> 		ANNOTATE_UNRET_SAFE
>>> 		ret
>>> 		/*
>>> 		 * Xen will write the hypercall page, and sort out ENDBR.
>>> 		 */
>>> 		.skip 31, 0xcc
>>> 	.endr
>>>
>>> while 5.15.y and older has:
>>> .pushsection .text
>>> 	.balign PAGE_SIZE
>>> SYM_CODE_START(hypercall_page)
>>> 	.rept (PAGE_SIZE / 32)
>>> 		UNWIND_HINT_FUNC
>>> 		.skip 31, 0x90
>>> 		ANNOTATE_UNRET_SAFE
>>> 		RET
>>> 	.endr
>>>
>>> So should the "ret" remain or be turned into "RET" in mainline right
>>> now?
>>
>>
>> It doesn't matter --- this is overwritten by the hypervisor during initialization when Xen fills in actual hypercall code.
>>
>>
>> So f4b4bc10b0b85ec66f1a9bf5dddf475e6695b6d2 added 'ret' to make objtool happy and then 14b476e07fab6 replaced 'ret' with RET as part of SLS fixes. The latter was not really necessary but harmless.
>>
>>
>> So it can be 'ret', RET, or anything else that tools don't complain about. It will not be executed.
> 
> Cool, thanks.
> 
> But what about the objtool warning that I now see?  Is that "real"?



It's not real in the sense that the code there is not real, it will be overwritten. (Originally the whole page was 'nop's)


I am getting a different error BTW:

	arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction




> 
> I don't run any Xen systems, so I can't test any of this myself.


You can't test any changes to that code --- it is rewritten when Xen guest is running.


We probably do want to shut up objtool. Josh, any suggestions?


-boris
