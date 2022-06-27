Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A882355D0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiF0RZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiF0RZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:25:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34E12AB7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:25:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RGLGNj031567;
        Mon, 27 Jun 2022 17:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=o/oMns1QbAZ5Xhf7W5EbpUjkhVki3iIstHyZCkaGYgg=;
 b=ldZcuH2kkzl2WIPFMPcqiuMVvrwFlPYPEWzhXjicOhaz8n9UE64UNxORjh0y95iIVRt6
 HYZVA7dF8tdbZvHK+7gFKlCs94eGHGG3r965psdwRL5nONrwJj8eVPzGzD18IDQp0wa/
 cbZdnqW9CSM+IZhQzTiIj+F2567Wetl1LHvuD87ZNWVOT5G6fEITxS/WoEO2KQSh89f+
 0IEG6rAzE7sX+58dcFV62RbVvlAkMMAkszuJFEHy4lHKUu4XDajwMXvIGKKMdhn2mwsz
 dYHTSUusrelnN/8peYwev3sb2C6TbDT3N74csk7QHT5YM0yIMIWbRioq0oiGuv8+tdNH 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscbvy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:25:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RHAnBd006383;
        Mon, 27 Jun 2022 17:25:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1n1yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBrkiPVuPukvz8EqzG5qoCk/x1SCwPM3BTXxp1x59JQYfTgtXH6LGBbMwRlRUSwH5vIiX/zmjKT/r4hagWRdBaaUEOl2kuCod35jrXRyxtrjfxh9muvwWRsI0dm0NSjrymNhtg+/pwD0eJaqE6av8gZ+nTXiMyGxGch9dsYPaWAUuYcMcoG4H0+Qkqf+lF5+c0vB5X/qDZVqlXNj4Cs73YBtxGgjVezlARelpGcYc0vWH8sv30bLUW7ZQ9J7UEHySYu/IR79jxaSC9Y/Hvd2IFw9iDzEAmO+774uqmjzqp5xd6+Y6LnWBlRp/qub30izym4Uk54pxcYoUs2xgGtnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/oMns1QbAZ5Xhf7W5EbpUjkhVki3iIstHyZCkaGYgg=;
 b=etDoaNi4L7VDBH+k7jEhHTd9BPxj0ThjH9pZMqWQkRdZTnaM1btsB/t0ZGE2lnINBnCj3qbRE2cIo83TC5Nw8wVvNu+2FYeYaf8/ypKlYBRrddw5tAcN3H4FRcKetnx4T+qDKfPgLzkuTdb+Uf46qbuWfaKpgy7wLETurHRmOJd4CfnByocodlFpKO5I0sOWGZNdE9ZvbLKJ3W83sW1uZK7VN2JKKGGpsm1sRzCTj3qGGNMJ+MCL6TL58prMN4cZdXrjR4X4zrucCTuEy6uVA5idk0k9cOcAbvnS6BnrSDZHFasvrYyBN8jMo/X9ptrUHyJtCNB7/2gg54vP3tZ/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/oMns1QbAZ5Xhf7W5EbpUjkhVki3iIstHyZCkaGYgg=;
 b=Caz4HrlxU3t26hA5auH5M0RkA+qMjppg2HoAT32h/2/ugtmaHLE2jLaulk27gIEGo9Hq8S1taYtOcLMDZLj+sSEVtszfTlzirLetkDBKC/etfT+ooi3JW036qFGNum4FYJ8LcFHtz2R7rr/W51nDJ4/rG6Bz4Gtl3kIA/lbqp1M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1475.namprd10.prod.outlook.com (2603:10b6:404:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 17:25:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:25:16 +0000
Date:   Mon, 27 Jun 2022 10:25:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Message-ID: <Yrnn+QS8JCMT/3JV@monkey>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
 <YrYMS5sATPzEgUxb@monkey>
 <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: MWHPR19CA0076.namprd19.prod.outlook.com
 (2603:10b6:320:1f::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d00575e-c4d8-4ff8-7455-08da58620080
X-MS-TrafficTypeDiagnostic: BN6PR10MB1475:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB9KGFdGCneVTJsci+QIeCirMu1XR425w9rJPyaEdcHm92UcshHk7VQxe20ooUGWhmul3W53iYsGZRgMPAzmmqYNBR7DoyaJVLEXl2r6b+nuBrz94pa6u4hRrn3lX5qlzLTvcCrvVSoEeMuNoCma3xCbDeOf4Y4ic/qcT6FwIStYfAsba2TnGieTgDc1EQdIHZabNBpMZsenNBkTVwe46ZCV/PfsRFdmab1ZK13dRrFqhGtLI9SzKv9O03APwlQ45TbgJ3H2qYEPsrEB0Ej1cKTiF5S5cKc+YKzVx6EBqFpyNKX81MrOYPu5x6qhstuEyga9FvhNxXzYIYUf2fXzC4yb7b99fmgBjPQFnE/l9CSw6AsN/ZH6/GeLHZPi1t+K3N/00aAXf8fdjF7oSQGcfY/c05CT50ZU0psVRfIdn28Y3brtOcs55gpeeAsOWFUTeWIOMCHmQv4k/YNC+NLDX1raKrYiNDs0fCuyBHZL9D7s+nUO0+qUBmtrCC09pO3WZ/bZuwlEtqZBZZVxMNPfGCA0ESKNlnHeBURar8EBxKEacJaYY54YkAapj4CCHPw3/kL7p7PtVKInKnpjwvkgSjA78vBcQ0Yb/gGiDQwtH2+3AQDrTtb0LirjucwqjjvcYgkfdEqULpAfbWcaIce2gQzoheLbMc3tyGF9aZ1e9ATjZaD2a2njsnDJrRJLzsD/umB+ZDjC2CJgmLPANZaTaUSjquXillLK98rJlVXrR6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(8676002)(38100700002)(478600001)(6486002)(4326008)(86362001)(316002)(6666004)(9686003)(6512007)(66556008)(53546011)(6506007)(6916009)(2906002)(41300700001)(66946007)(33716001)(7416002)(5660300002)(83380400001)(26005)(186003)(8936002)(66476007)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRkaUcrZGlGdFNsaU9wSVpDK2ZNbWRDNVBNNFgxTmZSeThLbXNvelNGQ0Rk?=
 =?utf-8?B?OG1kQ2twWXMzUXRWSVQvanZHamtZMUdoUUdVQWtNK1ZnQ2NxYTE2WCtOY3c4?=
 =?utf-8?B?bUFyWHpyZGNEdml6dzBIbE1QSENoSGlBZVAvdnp1ay9waExlZUcrNm9PQnRE?=
 =?utf-8?B?c2VHbG5PVS9Id0RUQUVKdmsrZy9WYk4zdUMza2dQR3JydHJtZXo3b1RyVjc5?=
 =?utf-8?B?ZlFtS2c3VFFZa2lRRVlXTjBPcDMzMTJWS29MdHRGZHozMW1uRWt5UVp0Y09W?=
 =?utf-8?B?dy9tZzRMTDJ5a2gyK0xUeENtTHNuWWROcTFMVGp1TDhzbUl4c0VybHZhZnd4?=
 =?utf-8?B?b3JSMjFCU252K1pLZGdNeWlZZUk2bjdINEVjaStPTHB3VDFXU3h5ZU4wYTZY?=
 =?utf-8?B?d2s0OXBYNWVSWUQ2SmZLSTJuWWhsbUVRNndCMHphK2dTOThGV2p0eWdNZEg1?=
 =?utf-8?B?UFIxRHV1dWtVT2hxMWxQQlZ6ei9RUUpYK1JXczB5cnlXaDh6VGhxMXhMSE1Y?=
 =?utf-8?B?SXhNWVdTS0FFTEQ0QzJMN0xwWkI2VFdZQVNmWFZyZnBvenQzTTN2MkRnSWtG?=
 =?utf-8?B?Zk5sVEYzcDFqTUVSaEloUlZRdXNjbThqcnRUL01HV2pKeEQ5Q1o0SlRadVJT?=
 =?utf-8?B?TDJEMmFRdHUwK3cvUHNEdzdlSERPZmEvSEpleDEzb21EdmYxR0o4MTA3OUtj?=
 =?utf-8?B?ci9RcHM1cm9rRUllakoyekQ1MmJRZ3ZRRTljWU1MUkpyRzQzR3NaSytOK3hJ?=
 =?utf-8?B?bk5zZjR5MVYzNTlybTdHYUVXR0N6ZFpSZnNXU214b1h3a1BLMlpFQXVQcHVM?=
 =?utf-8?B?a0ZqNXJtUTN3SFo0aWtQcm85a1ZmNFc5QW05NHBEcHpMUjBnTitZYU16cVhm?=
 =?utf-8?B?aHZJVWVDclJ1YW1MYUxDZkVUU1dCdzkzbmRRRDd6WmZMNzhnbjZ1MElIZ0w1?=
 =?utf-8?B?VEIxSzVTK3k4djVsUjFUQnRRU093QlE0SlpseVRlbXd4QVpSSWJHaEg4U0lS?=
 =?utf-8?B?bjVsUzZ3eGh6V3VGL1dOMUwreEVuVEpCMWhSYktxQkpxQTJvd05RVWdFL01B?=
 =?utf-8?B?L0RNT1NvVTNvc1MyTndxU003VzFCdkJYUXpLWitudlFNWm1JNnFqV3FnUHRx?=
 =?utf-8?B?UzRPdjgvdzZ3L28rcWhaTk92dnJHU0VMN0VKRUpJWlhQaXpXbU9LUXZNQ1JK?=
 =?utf-8?B?VDJ0VXR0K2pTdTFTNUl4MUV1cElLU3pVMm1RWXhBWjBDa25PdGZ0b2I5Ym5H?=
 =?utf-8?B?TmpTZlhOT2xCOG9xSFNLSnBudjJSdWJSbStWY2dseUp3b3lFenR2NUpUTDF0?=
 =?utf-8?B?dXB0amgyem83RWt5TWF6djhyM29mamo0K2RIYUxWYjFCblQrTGFOYW5STWVw?=
 =?utf-8?B?RUpMNjB6NDJjMXVZSTcraEd0TnZjY0k3NWFNbjkrV2sySEdzTi8vbDB4QkFP?=
 =?utf-8?B?STV4ajdyQm1tT2VDVWdtYmRpbGJ2MmYwcUc4NzYzYzJEWkNIOCt3VGI1TEtY?=
 =?utf-8?B?TkFiWkVjM2Y3RE1LM05hekhNMzFsbE9FQlJHekVrem16dkIwaHNLRllKQzBH?=
 =?utf-8?B?YVpObUM2ejF0TCtCenRZcVVhMTUySG1jUnd4K2IxYVh0OG5RVmlMcVpnQSs4?=
 =?utf-8?B?R0ptTWFRRWIvYjZBRDh4djMwdTZncjhpekhzeWhEaWo0QytoL0VNUU5zc1d2?=
 =?utf-8?B?dXhxc2dTdzQ5OW9mQVRxSzRuaVB5MnV6dGhVMnlNK3NUY1JxV1duVkJXV0hj?=
 =?utf-8?B?OTBVQ2MrS2JxNllaV2hReUM3WkozZ0pIN09qV0paNTFra3IwNmlBOWdZK0tp?=
 =?utf-8?B?MHJOSzhVTTF6TklxbjgvSWNyU29rNitVNGlwT1NWc1p5OXh1anczYm1ReU5k?=
 =?utf-8?B?L1poZis4SjQxSU91M2hvOXFINXgrdGc0UHpEU3dGNlZtakZUQk1nbUpzVStu?=
 =?utf-8?B?ZjhVOWVPSWtqci84eitPaVRCNGpqU3VaQmxQcTVNczJ5eWhBdFVOVGZjZEt4?=
 =?utf-8?B?alRIQTllS3RwZW5lMTFYeWlqRW0xc2ZaeGFaSnlJWG0zN3k5dEdqdkpDeHlU?=
 =?utf-8?B?TzVHMG1aTHFsMlZYcEwyZk01V002TzhZbmtiV1lwamFjVjhONERPcmVDdTVT?=
 =?utf-8?B?UURPclkxMDk3cTNTZjB4dXQ5UXZlekpFRzhNUGJqQ3ZMc21Ra1hFMlF4TUdR?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d00575e-c4d8-4ff8-7455-08da58620080
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 17:25:16.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUYZa2PKGQ+UATfQbnPDnyHwcrgg/D2xMjLtG0Uqqfs45H0gW944QvXUMtQP2AOTpXM5LSzfpKIKFleTKkpyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270071
X-Proofpoint-ORIG-GUID: o2gqL_4hGW8PvaJKodSE3nqjV-jpY4Ry
X-Proofpoint-GUID: o2gqL_4hGW8PvaJKodSE3nqjV-jpY4Ry
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/22 06:02, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Jun 24, 2022 at 12:11:07PM -0700, Mike Kravetz wrote:
> > On 06/24/22 08:34, HORIGUCHI NAOYA(堀口 直也) wrote:
> > > On Fri, Jun 24, 2022 at 04:15:19PM +0800, Miaohe Lin wrote:
> > > > On 2022/6/24 16:03, Muchun Song wrote:
> > > > > On Fri, Jun 24, 2022 at 10:25:48AM +0800, Miaohe Lin wrote:
> > > > >> On 2022/6/24 7:51, Naoya Horiguchi wrote:
> > > > >>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > >>
> > > > >> IIUC it might be better to do the below check:
> > > > >> 	/*
> > > > >> 	 * Cannot return gigantic pages currently if runtime gigantic page
> > > > >> 	 * allocation is not supported.
> > > > >> 	 */
> > > > >> 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > > > >> 		goto out;
> > > > >>
> > > > > 
> > > > > The change looks good to me. However, the comments above is unnecessary
> > > > > since gigantic_page_runtime_supported() is straightforward.
> > > > 
> > > > Agree. The comments can be removed.
> > > 
> > > Thank you, both. Adding !gigantic_page_runtime_supported without comment
> > > makes sense to me.
> > 
> > The change above makes sense to me.  However, ...
> > 
> > If we make the change above, will we have the same strange situation described
> > in the commit message when !gigantic_page_runtime_supported() is true?
> > 
> > IIUC, !gigantic_page_runtime_supported implies that gigantic hugetlb
> > pages can not be allocated or freed at run time.  They can only be
> > allocated at boot time.  So, there should NEVER be surplus gigantic
> > pages if !gigantic_page_runtime_supported().
> 
> I have the same understanding as the above.
> 
> >  To avoid this situation,
> > perhaps we should change set_max_huge_pages as follows (not tested)?
> 
> The suggested diff looks clearer about what it does, so I'd like to take it
> in the next version.  Then, what do we do on the "if (hstate_if_gigantic())"
> check in return_unused_surplus_pages in the original suggestion?  Should it
> be kept as is, or removed, or checked with !gigantic_page_runtime_supported()?
> I guess that the new checks prevent calling return_unused_surplus_pages()
> during pool shrinking, so the check seems not necessary any more.

My first thought was to keep the check in return_unused_surplus_pages() as it
is called in other code paths.  However, it SHOULD only try to free surplus
hugetlb pages.  With the modifications to set_max_huge_pages we will not
have any surplus gigantic pages if !gigantic_page_runtime_supported, so
the check can be removed.

Also note that we never try to dynamically allocate surplus gigantic pages.
This also is left over from the time when we could not easily allocate a
gigantic page at runtime.  It would not surprise me if someone found a use
case to ease this restriction in the future.  Especially so if 1G THP support
is ever added.  If this happens, the check would be necessary and I would
guess that it would not be added.

Sorry for thinking our loud!!!  Although not necessary, it 'might' be a good
idea to leave the check because it would be overlooked if dynamic allocation
of gigantic surplus pages is ever added.  I do not have a strong opinion.

P.S. This also reminds me that a similar check should be added to the
demote hugetlb code path.  It would be bad if !gigantic_page_runtime_supported
and we demoted a gigantic page into numerous non-gigantic pages.  I will
send a patch.
-- 
Mike Kravetz
