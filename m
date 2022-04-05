Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8EF4F3E75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392179AbiDEUGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572952AbiDERY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:24:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866B14012
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:22:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235HDiK5012570;
        Tue, 5 Apr 2022 17:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1kBo2uw2l9bxooNCHxQOP5kgG2s/7PLlf/PcQtRA62s=;
 b=B5JUvxDrUZzY9VlyJZELj90invcKNuJfYbN2vcKID1FiM6dT0VRayx6iV1wRUa+ZDx9J
 Rpd7azLgGjVaFeOJ+AIuo6sIZrLqeKdDsD5OeimXepaCzXLFRwBWXsXWiXu1YiX/2NDK
 14b7MhoC8918Ts7i/U3tj606+acEX99Ewq63XoHwrANEmRqSOXHGK68pdPgafSgHw0c1
 OfN9J2Ks+ogtKKKpIArIbmdGm/kl+R0bzEOxp0u7eY2ypGASuaijs+hO8bs5WyGAprpY
 +ShsMQiQQ+6Qnufe81T1TX35WJgFWepXnN4gC2Czz6O9EttkXVR3IWCPJF9IdScLY9eB Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcej5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 17:22:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235HGfQq021107;
        Tue, 5 Apr 2022 17:22:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx3s41c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 17:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOnOMkBv0dE03BXeAZSQwoOOy/E2OwVPmrDMsorlhxs/WY3XJkpvaqId/nKTgT7n0+jS+dcvEY2Vw4lwYBN35XXSvwjDWms8xnGwswaS/1W3Ebe0Wz21Op3rttB6FJr2dHc7RRIb8fOkVLCWN4U4Lltp0EmBhwB4erpMzawPNCRFWlIFs8a5SnIHmppJKs2me6bfkyqsKbQ23AyViJRHTYfYbm/jYckFirhd0ujLCHPc7K9vgeZd5BETGZq5aw0ggwU5xM+NT2QJA7W7ZO+5V1KhMUXpswURpTksKN958p8iXJ+LwnUpmLi8ntbpS+/e39R5HLcnmVZkf6sIjOda5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kBo2uw2l9bxooNCHxQOP5kgG2s/7PLlf/PcQtRA62s=;
 b=dXVbhzh75FDkQdYPUDzq1jUYXKWJ1OG2jm5WtBSwBdCmosiq3y+V66c5m3Y8gQS+7RDuqNBmE2W2kor/7S/SKvStF4lEf5pzZ6r0SDFQ9joJ5XVjAOZQMsZTOtBJQ898CMc8OvK6LGep1QSVopH4er5sD+P3tlVqby8edAdgqY+ohOFqUUppcV2SAjJHR9WaB/WuySsz0HQiL1J2tucN+fPrjDKqtxmqcFQzNf8W+6M6f01iCiWilPndEI8aY8ldnHn2Dsd6nZYeGmtUf1eU3DIQcNUEnk9lDJsRGAKVT6oNtrynlE88Exzy9oULjPWDwxnHi6DrNBMeBawTo2bK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kBo2uw2l9bxooNCHxQOP5kgG2s/7PLlf/PcQtRA62s=;
 b=x38+S3o2eExZwxKgYN+uhUHgUjQub+HplDcV2RhwGcpIuxUsyFb9mLPKNVl1fKFBrAlo9AL8FQzqVQB+Pqe1Wzg3qb8qtRdV7yDOgP90Pb0vFNJh2XsR+zgMMuZaJerSKR/c563myIX/DpkAnTd2kydTM/BV2SI8p3ZFSv2zGZk=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BYAPR10MB2902.namprd10.prod.outlook.com (2603:10b6:a03:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:22:18 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:22:18 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Dave Chinner <david@fromorbit.com>, Hillf Danton <hdanton@sina.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
In-Reply-To: <20220404010948.GV1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
Date:   Tue, 05 Apr 2022 10:22:14 -0700
Message-ID: <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::18) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff83454-0ed5-4e80-b085-08da1728d5ec
X-MS-TrafficTypeDiagnostic: BYAPR10MB2902:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB29028A633FADE28571CA79C3DBE49@BYAPR10MB2902.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huyztj+9EWgoZSvTzE+dLo1BeBpIKZks0pQKecTxJNwYYWKUGneZAUaMhuO3am54BMohYSoBk7sAVCA/1jsOXCr53pDf+Mxkn/OLYLwofHnpVAHff2Fz0fgfRlj5Kya4n52KhQXTeZ19Y+zbrs7qIGKUf+IYcp88YZLSie0nSMlLMNxy+O3Xe9ysqkJtojzWzekLnTCQ9e+CtaXKOtCUiMVTq40rBqb9hz1JsgTcDI4gDWQn/ZX/p7X/a0XWoKCl/gutR/tSx/sdfkyDIS3QvDt+fbl6cVNV6bGG6Nd5DnUTiJt3V/tLjWFULItBdFv6746hgnRKuSAqdieIGUVB9QkailTUbL7kupcEtvV/GuQm7ZgwaGww5UJhgyxW4AnLIbPaB0F041UC3lgsUXOQS0aBgNLv5LP3cu4CJYuTGx7MaIQw10PzSBlK+D5TCjlkBdQA9Qcl3a8RSpajQiizTMYiFTQsbpIxpMg1PPUoijYoyND76bZo7XHV/IR0lyrhuBJpfHJz1kHEuhJ65Q0voo4bsfmAsDjxZFRwnYjNAw4udsdJ9wxbYE+5H5BMw83iuXXFOL/r52Gost1m/AWcoo3ygD03SO1oVd3JLJDrlJUs9fqTFz4eHeyZDuSVl3x+DEu9aeN4YvpVveplGZ1EmwdecCWf98RJU0xGaPinO9jAW3yRNv+3jCDzcrjZGD4CVVJShqVcbbGWl4gB5nt1uEdb//R5THvP5VMDWbnU/W7ig26HgD4pcWluR3MwEJw7Ty+rhTGgh2fCaNj1XHeniZo71iiQKsvPRZcIvsUcwJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(186003)(6512007)(52116002)(508600001)(26005)(66946007)(2906002)(966005)(4326008)(6486002)(316002)(8676002)(54906003)(110136005)(66556008)(6666004)(66476007)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmXoVVHGKqQO7BofdbLp1tZTDG4DZvR+DLXZ1rRMhkg3Ml7RrMjQWbLZ1Vzt?=
 =?us-ascii?Q?c30d4xnzo0z8Z7Q0VyGpqWlQljpWuiST0kO+dsxrMJxURY0Qo0ApbFghzwms?=
 =?us-ascii?Q?2827dlwJhLMn2+GXrxEMtpnb2R7vEos2lZvabHTZbX1qbK/BqaYV+r+mpdFl?=
 =?us-ascii?Q?Q6ykJ7OmFCZnxL509tlQruqUHGke9c1iOGGXmk+Dc3LmgHXbaN3Ydym127wB?=
 =?us-ascii?Q?koQOkug0rfE+oJ7VRcEvtZQrAHCK6u/Mq/xvLEAmampneOuz6aLNAdj/xucX?=
 =?us-ascii?Q?9EO+ZpCC5yUaD9Zz7Xev2Qq6h1Kvk6DhDkWhJKCnenCdHkDyKDIWMWmdueI+?=
 =?us-ascii?Q?NlGLhOaZeWDVzhRJCk4XfHW7lhzBw/V9btlui5C+1v4bNZXEtgSZwumuL6y0?=
 =?us-ascii?Q?wdqiOG4m/b3xBvhRgb3+WV4XWuUmpaVhGWkLOA5iDQ04fQ6tVaPjDQC4+RJQ?=
 =?us-ascii?Q?+SaYLPwmlKox09aA99RQKAqTENDdwbVo5Ojnj5sj5BYmjb3iW98CekbKWvYh?=
 =?us-ascii?Q?guW41wM5GBimTa5OcjXWFCC28Peegu/+NoSMuRlcF9t20M8cOPsL4gbuOZ91?=
 =?us-ascii?Q?bz9L7xmZsWYQOn4f7diquUUxOG6N006kL+O9JZOIMBb38so7Nc8tN2YyORpy?=
 =?us-ascii?Q?zYjcdCTxO9jvfntmR0/2jGrbbuuZRgS8yYOlvYAJsE+rQIl+gFRCqOtAeQUN?=
 =?us-ascii?Q?mJ2jh0f/008LCccJHrJsor6ujVNzSz1TrN1Nht5KcxvF1Nqnt+H7Op/x3vdX?=
 =?us-ascii?Q?PrZDrXuBRus+4W7zAqYmh9ZT5SnKCC1+5eBPh16C0xxoDJcUscIYh2yOW4Vo?=
 =?us-ascii?Q?CSeXYoMMdgIRfel8+OpudWJbrFrGQq1YIGrS7Hfr1bkof2ZYgZ1U16OCi/C+?=
 =?us-ascii?Q?Zhmnq/iqZ13vGF1totFBE0mMOumPDizW2hRN3iZ59mrsyvEkZqkuCvZ0wC4o?=
 =?us-ascii?Q?gUiQ1dsjB9ngldwn8FA4ZxcReJOI8y3bmGLdmqQJk08aU/GGsPGyp2ilRUbk?=
 =?us-ascii?Q?P1+OrErqJa9ibnLPDOAGiUjEU7lbdcGmR5S6ju4f3NSaa2yZs7FtZ/8+4F5B?=
 =?us-ascii?Q?p6pDxco/QZnP6ce+ps7XC9Rw9lbVg/jjSVDH0xlINcFAGIdB3aU+kqAW1zuT?=
 =?us-ascii?Q?3ohUSBZpa+yu7BL7BvggakGy8D47GNlw9cMOPkJtdMPKY8Kz6IuScQK9I9lE?=
 =?us-ascii?Q?CcHteByWjREDczkRyM3u780IwRN2qZZw4p1wbGTLjQeshgWdgNvU0Zj1+j7m?=
 =?us-ascii?Q?5wh5y+AKWE+s4P0CK7AvOHHzLAa9mCHdWFuS4JbwAhoBdK/0AqA2UuUoNHal?=
 =?us-ascii?Q?/HS7ZDbsKtnROAlO0VIVhHIRoo+rPwi6RFRd2FxzzQi8836NITKOjpcazCBk?=
 =?us-ascii?Q?2tgJdItCW1UwS3OKPCmroE3Ow0JMi2CRFC7ioGehGQJ0HJN9DtVQRid3biVj?=
 =?us-ascii?Q?rom4NGyGc4WNnn2zuRnzWwo1gZStCu+SepMouoeHyK05Q+qSK518Tm40tTjk?=
 =?us-ascii?Q?8CBnLPLwwtKSoiFn1jcyKOPjl3kJgvQM6zNsWqiklr53TepT7LVmISXcfOKu?=
 =?us-ascii?Q?JPMzKDo2txesuNyPg0skZ1tyHnJbzKTQ0GpJZic9Mhv+7pa0zkvENtkVqkCk?=
 =?us-ascii?Q?00Vf9wxH0WaTp2iXtyHJBoW/roxHuT53gzQHsyLUWX+Zi1FI5WeLOqHiRO2A?=
 =?us-ascii?Q?gN0l0SenJqH9nln9UY8mrFXeCg8WvG6GClFcu+ULxJiP3yEW+5H7rCmJjnX+?=
 =?us-ascii?Q?vSnBoBFfe5KEMSZCqvvjomOp3LNNLqU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff83454-0ed5-4e80-b085-08da1728d5ec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:22:18.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFCPfnggCrcmXLTt7Y+qalJD2Nxv6RNeXhedCrOa7UfanaFChukRLA96HfYP8t2Gyi8YwTbf50GyVbEZpf25Zv5iqXTbEhQWUzT3gH9Veps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2902
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_05:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050098
X-Proofpoint-ORIG-GUID: LS5yp5rWzRVZ6KEVIv31CxxJbfhNdHs9
X-Proofpoint-GUID: LS5yp5rWzRVZ6KEVIv31CxxJbfhNdHs9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:
[snip]
> If the cache keeps growing, then it's objects are being repeatedly
> referenced and it *should* keep growing. If it's one-off objects
> that are causing the growth of the cache and so objects are being
> reclaimed by the shrinker, then matching the periodic shrink scan to
> the growth rate will substantially reduce the rate of growth of that
> cache.

I can't speak for every slab cache, but I've been coming to the same
conclusion myself regarding the dentry cache. I think that the rate of
stepping through the LRU should be tied to the rate of allocations.
Truly in-use objects shouldn't be harmed by this, as they should get
referenced and rotated to the beginning of the LRU. But the one-offs
which are bloating the cache will be found and removed.

My dentry-related patch here [1] does tie the reclaim to the rate of
allocations. In that patch, I looked for sibling negative dentries to
reclaim, which is just silly in hindsight :)

I've implemented a version of this patch which just takes one step
through the LRU on each d_alloc. It's quite interesting to watch it
work. You can create 5 million negative dentries in directory /A via
stat(), and then create 5 million negative dentries in directory /B. The
total dentry slab size reaches 5 million but never goes past it, since
the old negative dentries from /A aren't really in use, and they get
pruned at the same rate as negative dentries from /B get created. On the
other hand, if you *continue* to stat() on the dentries of /A while you
create negative dentries in /B, then the cache grows to 10 million,
since the /A dentries are actually in use.

Maybe a solution could involve some generic list_lru machinery that can
let you do these sorts of incremental scans? Maybe batching them up so
instead of doing one every allocation, you do them every 100 or 1000?
It would still be up to the individual user to put this to good use in
the object allocation path.

Thanks,
Stephen

[1] https://lore.kernel.org/linux-fsdevel/20220209231406.187668-1-stephen.s.brennan@oracle.com/
