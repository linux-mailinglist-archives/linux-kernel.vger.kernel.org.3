Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72015754CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiGNSSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiGNSSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:18:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92212120BF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:18:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFrJoM000875;
        Thu, 14 Jul 2022 18:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jdsbbH+N+ZhZlBAnsGwWpo7o4JzFCsDXhYIIFwCJz/Y=;
 b=CpVDuuhSqPH1z11IzeN39z3lQ4UAYbNhG+rste9sCkCR0zzCWY+8O6RmfFHPQE5/8Uqp
 A/Jnun/MhbOQu9tT5v41yxXUlR27BKklYJh573ereubVYQbndxe2FLSQ30OCqNoAWTFO
 6sP4f4Nzf4ezg3z6tuyXeY2D/G/yaGpENlqJZKiwBo1DJD+/zt4eRBtqtcIi7zTlz32M
 Bv+1ay+I/9KRgjog3JqZ2jCleEXz940QFedRIlu2RgeFBGbYuZ7KXXx+nUNLiWc/IUDX
 3QI7d/PZ1XK+O0Xz2vxbnfaXTW2D/G8sMDvFLTxLf3h0AYQDQQLt10YOrTkIeHMrAnKv NQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrp085-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 18:18:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EIFfpw019757;
        Thu, 14 Jul 2022 18:18:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046mq9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 18:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzxuU3oTq057QSJiLuQ5QYGnBXPPKp5SxNnBb33CKhqBRd6Ab9srETPcQo06DRWTM4ICM6DlxPjbZ5d0Dwvou+7JnY2jeIoWJiQOBT35jrcnagenlOOqSW8prrAp7yXQyKCWMOdPLBNi//k6eP4cr5wOKrNfmnGhBw/4nJH6N9qNxmdN51XUCywEfkZp+ABYDlCS6YQqh6ANB0LjaX9ojzY8+EU+/50HpJ1uzhO+9kyga7Gp9D9NAc0+NpGu1ZTFlfAooVOyIU10uE0sB6BdAIQUbF8jM3RC+RfIbRCgQ5bHt0fBvgLn+mPMAoZnrcb2OGvLpgSFBXsvZq+b1WJsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdsbbH+N+ZhZlBAnsGwWpo7o4JzFCsDXhYIIFwCJz/Y=;
 b=Bqv+PCFmzJATm/ye9j5x8hMInWrYUyEO4x4Vf8NUvAKVYcPB0u40f+SZWRqDicIpf1Ab2oG6nwp0FBrGTYgFSyqdXthED0e86m00kco5vRpAbQnnspApScwzuJI30DNY31hxaSxflrE8Z7TkRwrx9S02ZzA3/eVp+nOBhB2R/5ysp6lkKHCylugwbfdz+vsRy1ceeMFf4GUl3W2QQoaei2ipee57aC/l84YMgoFnDdsp6qc1k6xPa1jod+stB2aowYhFBkwaIrVdstlhv7sEbgE7j0wBXrN1h+y/gNjNR9r2SmAdzP5V6lQioHk/MvNcigytn++gU/dKrSvt86sgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdsbbH+N+ZhZlBAnsGwWpo7o4JzFCsDXhYIIFwCJz/Y=;
 b=DO+oXFL5f6m/MI+9vPenCHZT955C12LeCY0ByHEfUTVMk7tWaADQirw1vbcJOLYv8OAQcKh5Yss14kjoY3ey4Z/eetsQDSA2sGTFU9ttKzOdnMI8kU0WnNV0DORntAPbocIHG+yvwu6/jtwBcxrHKYe59eaT7S+F6WD37tjTSgg=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 18:18:28 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11%7]) with mapi id 15.20.5417.033; Thu, 14 Jul 2022
 18:18:28 +0000
Message-ID: <5516b436-1938-61f8-8e15-a11195329c40@oracle.com>
Date:   Thu, 14 Jul 2022 11:18:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <Ys//ktD6VYE2uGpw@worktop.programming.kicks-ass.net>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <Ys//ktD6VYE2uGpw@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a50cfb1-28c5-4060-1fab-08da65c53fc8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG4IUSnPBlLoP7CBjPrkEF8560j0zQt6alVC36sMmH/FhPb9axo1+Rseu/9MIJH7QjXh+s+CpuLYO+son4s2vCeEsj9FBSqCjDAzgXFE53oPpbbVgtdr0cR5XQ1I9O5vrUKs3hazxC6MXIZa1BdFKrFbG8F6SvUKTM6Apq3VgrHOuSTytbQBq4iDT+x9zIyMbvLNSzt78CAUJX3oBfpeJxYaBlKRHxwCylf3ZIBsHWAjVbknd3cPlCj1E82iOh01qFqyIYcankWX4Z9LxAJ3IinssObX2tXgHrRV6W8opF/rjoarWLXSLNZD18X9OB+kpHzztPE0KJcvH8yUEE0b8AA+EKam9MB63xIrALoqVPMY5OM+q+YIZJU8XD9ZEQZfvgmU2Yq4SAHE0s/x5SXg3GoHmVxB6/pmRRbodYNkurvEZCpT4i02ksoWzUvrAXFohzK6SajDMY94KA4F0VdQ0NYLaJ9LDOWnGaNucgMe097t97RA6NctNRQMhdMiCGXVvX4CLuLieG1cXtZuvlFu9hiEVpD9Xi+BJo36B/fDEPBcdcQBO36ybzRV+Gq6lzeCVEdvCJCFyYzXDLwoWH52Rtka+t8luXokRh2AzSImHSkBqeShRFp+D8hQ0+ed9e9f23tkeL+zMKVTqoG63extvliir/WBq49mTVoH8+eRVTMVvQ2IgvuhUaJzpdg4gJM2Aqghm9MkmIvh9HagmHdTwMBIXjY7VDiIg2h5IqiMuJHKaZGr3tgbO3yvxpUnODHSexG0z1al9bA46Jc9jGrSkihGZLEkhYd1KytwCBWVukz6LqDZil9c+VfnkIGO5mivQrGj6t18S+gPyTRhU+cf1kGGTGk2Dw9EIMOJPGB4+m3H1f/eEfBudsMAJ7fpk6rthASipa0vGDM8HOoKfcWznthL6HRs3+IVDPg4/Q9F8es=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(136003)(39860400002)(366004)(6916009)(316002)(186003)(86362001)(2616005)(966005)(6666004)(41300700001)(478600001)(6486002)(31696002)(52116002)(6512007)(6506007)(53546011)(44832011)(2906002)(8936002)(5660300002)(36756003)(38100700002)(66476007)(66946007)(4744005)(66556008)(8676002)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJSOHBLbzVzVENoQlpxZHJpNG9mKzZpZUVJUUJGbnNLbDBaWUJ0ZnhQbDVG?=
 =?utf-8?B?bDJrcndwWXFLSzhkRUd2UEc2cytNR1VUM1lyajFrMFovTUZMNmlSZnRlTHVI?=
 =?utf-8?B?Z09LbXhHRVdveUJnTmZHWVBwdjZEbG1qb3FZZTc2Z3BZOG9iWjRHUUVES0Ix?=
 =?utf-8?B?RmNKZjh0UTlML1c5em9CKzRsY0xxZVRDSWRaLytBOXd4dU8rbXorOEM4U0Zo?=
 =?utf-8?B?bzZqK0d6STNLSFZLbVI5c291aWZhUUY1L3VoUDl4REMwTXN5ajdpL1I2T2th?=
 =?utf-8?B?SkRVTmZ5NENPUUYxSUFDNXA5NWlBU091aHZXb3FNa1M2dllOaE1kT2l3b0h6?=
 =?utf-8?B?Zmp6Y3BnVTVZR0lldmhteUZRZkFHYUpTWXhwRTlENmk4RUZKVTR3TlBYVW1Z?=
 =?utf-8?B?ekVTYXlpTXo4RjBRWjkyOGZjMXJxbEFTYWc2MngxWDFJdEdzcERGb3E1QzQz?=
 =?utf-8?B?cGdoeHNINlpFMlJhemxGTWpRVDRhaWZDN1BRMU1NRERpZlRIK1BJY1dkd2Jp?=
 =?utf-8?B?dTBLTWphdGhPY1lUU2ZjZStJak5lelNDS3A0cVBQUU9VcHZaeGhFNVhHVUVR?=
 =?utf-8?B?WFQwa09vMFZYb0hZdEJMcmo1WWVPelNacU5xRGJNT3UxYm8vQ2MrcjEyM1ln?=
 =?utf-8?B?S0ZZdkg3bDV2YXpCWlZSMFNhdW1VWUYxUktLQTBaZDZ0RzZSeFRlWkxGQURq?=
 =?utf-8?B?Wmp3UVFjYUgrYTVVdXRBdC8vM29WMlFIVnFSS1Y0cEl6a1dPRE1IL3pMZjRJ?=
 =?utf-8?B?TEJieWVrUHdTQVc0azgxbnBkUi9HRldTS0JKbExkY2pQY0JlTXhLaXRmaXBT?=
 =?utf-8?B?N0pQR3VobVVkd3VFM3ZqSHArcnh2eHNyU1BaSy9QSEN5d2hMNU91Z3ViTCt0?=
 =?utf-8?B?L0VpNHBQczFKdERkTXhhMWZwQnE2aVVLUS84aUpKekZJSnhDL0ZmemJ3S1pP?=
 =?utf-8?B?aU0vbFpESWh0MGdIZHBJSytJZ0hKUkUxSlRlbUIyeTNIL2w4TUUzbHBaR1pa?=
 =?utf-8?B?RC9WRUR3VnNHeFVDNmRzOS9iclUxeHd5ZlY0cmFFQ3BqZnlEcUcrSStrZk8w?=
 =?utf-8?B?cXQxdklpMHBxcUdBWG5pc3pyM25KSmM1U0t1S2k3T255aXBacW41eG5HdDRN?=
 =?utf-8?B?MEsvMFdHdHZ6Q3ZlTE9lQUJqSEkzYWc2L0ZVQmJYWUNBQW1BL1pBNHB1YTdE?=
 =?utf-8?B?R09rTmJlL1dFMTdlZzUrNkRYdDdaSjk5b0orakZtOU5MVS9UcmpudUZzcFdN?=
 =?utf-8?B?L2JVd0NjNTMzNGR3dTk1UGhWa1c2UE1rK3hRaGh2dHVCWDFvVThwVUZ1WmVF?=
 =?utf-8?B?SStIRlBFS0txL0QvSTVxNEFpTU1lM05Pak4zM3doZUpCd284MUsxNDlZR2xa?=
 =?utf-8?B?U2VUcXc2QjcrQUZIbmpJbURXRWVyRDN0UDdZNW44TFVwVU9Mc0NjUmtUTmwz?=
 =?utf-8?B?VjZXRENXL3hNa3Q1dnp2TlFhZTZManMrMjlJVlRmUk9IMm1TelhtdHB5UTNL?=
 =?utf-8?B?eGxKdnV6SU0yL0pDNFE3S2lKYlJnNDc1VGFQLzdteE9YNW5GT3YwRU10QTY2?=
 =?utf-8?B?UnorRU5wem0yWkZwRndqdGZ0cXhCV0hadzRLUXJjMzFPWVR6S1lZMFduODdh?=
 =?utf-8?B?cDkySVhJMjlwVnk2blhZbUFINDNsUkMzdVQ4bmJBWkYybnFTR3ZkNGFoYktJ?=
 =?utf-8?B?SHdySmRiWkVtU0w2aWhOTUpMZi9QZHRYYUw3REdDVTRWSHRmVG1sVzV0SFBy?=
 =?utf-8?B?YzdpM3dKalZHdk5UUFY4MExNUDRwM0hBUDk1eG9OSzcwRWMxYmFpUDlOWVFh?=
 =?utf-8?B?RVU1UjczbkRoQjliWU5iS1VSQk45a3JndlpnaHhmNGJSMWhjMHg4SlQ4Q2ZF?=
 =?utf-8?B?U3VYK2JGL3V3M2RvOUNXd3NYSzZnb0hhYmR4aDBIb2lPOGtXS2krYlNtWUIx?=
 =?utf-8?B?RVNndmJmbFZkcjlHVTJUcU9CR0hWc254c0lUeUszVDhnY0Y3TmZrenZNam5P?=
 =?utf-8?B?a0NMdHUyWWpsNkJzdmdDakMyWklGZEx0VlRBLytlQmVaRldaRWttSnp0VUNr?=
 =?utf-8?B?dVVYYU03UkovMCtwZHAvTWErVUZ5OHpNcGtCSmRNOG1OOTFXMENtYlkrZ3JU?=
 =?utf-8?B?YzBpcVdlUEx2ZmFqZjJrQ2NRK3c2Q0x4S1VKQU5XV1pyaGh4RXlaOERUYnUr?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a50cfb1-28c5-4060-1fab-08da65c53fc8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:18:28.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49WfCk4VXLqu6nM19Rf+4n/H+NFCK+n+TmoNppNLc5Qry6d0LSla+wH2Rj/GqNGGW2ObWZMjKoQnzA7GA/buSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_15:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=981 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140080
X-Proofpoint-GUID: kwGl7wm4YTgtwGL4HD_Pl60tPQWHuY7B
X-Proofpoint-ORIG-GUID: kwGl7wm4YTgtwGL4HD_Pl60tPQWHuY7B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/22 04:35, Peter Zijlstra wrote:
> On Mon, Jul 11, 2022 at 03:47:04PM -0700, Libo Chen wrote:
>> [1]: https://urldefense.com/v3/__https://lkml.org/lkml/2021/11/5/234__;!!ACWV5N9M2RV99hQ!IwoFmg5mL051R93PCGfCs27IaZENjt_CV7Rp7RCZCGsuNi9gbcMOlNwOCkCosXNX94ZRzMjAuU9khXfg7A$
> Please use lore.kernel.org based links that contain the MsgID of the
> email in question, I think this wants to be:
>
> https://urldefense.com/v3/__https://lkml.kernel.org/r/20211105105136.12137-1-21cnbao@gmail.com__;!!ACWV5N9M2RV99hQ!IwoFmg5mL051R93PCGfCs27IaZENjt_CV7Rp7RCZCGsuNi9gbcMOlNwOCkCosXNX94ZRzMjAuU9Kr4MkBg$
>
> Right?
Oh yes, thanks.

Libo
