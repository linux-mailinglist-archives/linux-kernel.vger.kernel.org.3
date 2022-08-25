Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C15A1ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbiHYVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiHYVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:13:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2627B0B3F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:13:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PL4JN0026773;
        Thu, 25 Aug 2022 21:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zHGRufvBYK1CZ0P7QxMIokWQk7IZtt8wTLViG1reNM4=;
 b=fIkOttSJxjexXeFzWSx5LqnrsVcKuzuyCremSUu+cf3Lp20rugKu7uW6kHGD+53Dg37+
 HIYkkDA9kmEw39zTU41G/ygRVXQ/SkH9lvuM7yXR3eO9eLHDwzKAnGQK+mwgfHFMsqME
 zwxYnhj2B5P1BbLwzkiVb8Flgm6rUlSsxfLU9XGi4f7RZ5ArAMBCctKoUPkHOwTft9ss
 eHasqWM5ogXJQCpU+lcAojp3qmDQWuQMA3mJ1y2/AjOcxqBn4sVZvpAxOYfXUNIV1n1o
 gf1s2JxdZYXgrhFmBu4PUF4kgYV+9Fmq92CtTPDF1rnnT/Ogmdtumnp5pnJj08rsF+VE 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23yxk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 21:13:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PK6wKW009565;
        Thu, 25 Aug 2022 21:13:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6nfwy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 21:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKdhV26D5VI/lvAuSf0zkazx0SkivZ6ftyndXqnewWC2v7r1/n07X3TsCRyjEoq44RLgj0wG523BGeYJGXNC9nuGP4FKxKzE1ouXGR5ZOrM5cZ1k+mPXBn7lBaJAPUT7JLahW73T+DMU88nGA/N1FdX18lunX7pHTevXw84Ai3WRL5p3qBiZrxFGEDhTzoBI08WTBrORPRIj7GgtNcohVJOyICSnXtu/zRjCKx+msEylYBbAmh8duQC24ml8tntVgOPqBUC+0Ji5QK6utvOctDewvyb8tb2VB1i6UktUYEEhqC/jxqNb5CEXUYQ0lAYGBzJl1LbREf+4Cv2guvCAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHGRufvBYK1CZ0P7QxMIokWQk7IZtt8wTLViG1reNM4=;
 b=cfua7BB/o+q8+YoC8VBYgS9nitpkFtmk2F5Eh+HUVAXUN+wRaFX1yqjhUG0fpUDcISp3RvYlRCXKkpouObSyYMQ6s6ZYQMhieEjHY/GNowyH9oozRj9GZOz+z/+AperzeWukpY0E2QXCnA442dQ6qYSCk7tNOt/pVTiMIN8gZyimS4Kk9P+s7KCFbbZzFDHaxQjgRPy0jddiOka0YzEEWprZ2H0ciM0wW43jkTR5B9Sy9Q/jTizPWFPgdxcVpzkMI/BIccUx7ALgkElI7Z9OzST6qA6DB4d4rkoBsG52+ENKipu0ax61QsMqXno49M09wKhinF/3nWqnkWpoaBa48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHGRufvBYK1CZ0P7QxMIokWQk7IZtt8wTLViG1reNM4=;
 b=cyHuVnimH1+1e1LAizQqQuxW4L1I0wEyXrHXEdEiyD3UK/0Hssc2QbPxYw3ofj2JnrgxF/E1Z5OuzR7bcDC1KHvC09Ze2MDyNO/lRhz0tq6+3tkECR5GDe1NO666TpfgykooiyYESFr8K6ddnLBiFSya5burp2T0ppkTAGMMgYU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3682.namprd10.prod.outlook.com (2603:10b6:408:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 21:13:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 21:13:35 +0000
Date:   Thu, 25 Aug 2022 14:13:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <Ywfl/HIeO/ZbwYCg@monkey>
References: <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: becc4efa-0127-4550-21e4-08da86deabf1
X-MS-TrafficTypeDiagnostic: BN8PR10MB3682:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fT4IBMIOz2IeYz4TWaTgQejmreK/0okxo/NnFdVNC70g2oCgXURtpxZE2VkyOpUwyak5sT8onOgMXrwocynTA+UwQhUKop3qTNK7XLpCrEn/go4sfhHGCzttNArCeTiimiTmURNOpFf6SsJQIpDS7pl+mSIgepXN+NFYBSVI+LZU1mGkrtFA566PFjWxL3vBiIN2bxRb6bgqCm+MtXZEMsrYdr8GWds3GjpG4LbWmMWetACOSCnP3zckhoUHT7yF5VIZKHt8eQkQ5VXo5V1XpPDg7CL/dIugvPJL0YR+te026IVQsHzMRmU1A2iAs/fJWjNT7vWT3/8xL0GAZmYtHTxJpGdbo4iuEU+U4o+vBCFBa7olvpz3kRIlP7JZkqGbEts9qYizJfLi40FaG/1ZXPSrdppfr3OD04kZlIolqCEnFCDM8i52r7635kweVEal23AWyHV6Pi0iShe0CjpNSYcV0QiUzgFOtnQgHL15VAAhkx+k+ONXJ2ysB+AWassfyKbaFdBS/rg1hIektnAFNexUiIjSmNg2Xj6+TOux5Ow/LIOQfp16U2w/yUTw+B+3tQt93/Dq84XHUivk2lFGeB3pUiFucMVODhTx+T3awPXr083HG2u8f/WmIJFjbhx2edtQeYQlY9RDlxRVGDKceOaB2YtkTzuJp3bkhX7DStUtPPIty8N/ylJB4OT1b6wuh5FmF5HoM5Dl9JJY9gZWyr7NurARkOsZrvQYA4WAMkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(376002)(396003)(366004)(6666004)(186003)(86362001)(2906002)(53546011)(110136005)(6506007)(26005)(6512007)(9686003)(316002)(6486002)(66946007)(478600001)(83380400001)(5660300002)(66476007)(66556008)(41300700001)(44832011)(8676002)(966005)(4326008)(33716001)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gObtyBz7s/00pu2vwOFlF1cjamtmh3M9Kwxx6bSedEMn8HcLjfoKZYLZM72G?=
 =?us-ascii?Q?YOiVb080azgTKepyDXz11rVcD/lVD7NTH7hGO6S6b96GNU3tfX6ajezAEu7d?=
 =?us-ascii?Q?P5dEYk665U+eY+oMBv25GZvl9n3WBMGrJiZf7uBAH/GGjeoKqFg1j+rdi96c?=
 =?us-ascii?Q?BrnzFbB/Okaq+CY6ZSCOnwkH+dzCSpMtujGxNnp9uRmqoDF3jOPUlw2ezF2E?=
 =?us-ascii?Q?r0f3uuDg0Xh6KNlEzfGgYS19qjfpSNwX9+zzKzgXZItzb8RNK4iuenfxotlt?=
 =?us-ascii?Q?HT7sNStRm8Vs7C+f8RIfad03ynl5E4Y+C4XCT/cR3tvrp1Y74yorsezJ0ae0?=
 =?us-ascii?Q?hXolYKvyx5kZuu4bT9fjK0fibFUrFotFxo0SNXiA086zVH0EOPIqI1LCgTlI?=
 =?us-ascii?Q?vTOMZ8WiRxtR4kA+0rznCpkAfJ63zRqQLX/TK1n6zDK2mklriDqQnBKvGs7V?=
 =?us-ascii?Q?4IDgcvQMy0wvbB+HfTn7QLAwMaZ6XVUzYYktbnaY4OwReXeh9HkHT6acXzIw?=
 =?us-ascii?Q?z3Cb7OC+tmvJAeUopyWtihqgYHaHWNzBPV59//EMoApIf2hMZW80wAD2Tx0q?=
 =?us-ascii?Q?Ja81pbQvEoBLCsd8Tbvy7hVg+RskXqrLpCSoQDggUhq5cFByyzgtmBWQdS7w?=
 =?us-ascii?Q?8dkO7z20b5xKkE66KVAm+2gGuy/2mUHWhwQvKEJbk0KIpiSVSTXAtDpyyEuR?=
 =?us-ascii?Q?5pnYKmM9aVqVCPLZT8cPEVXLSdB7kqvsl/7Kgb5jyAdTs+YIi7cs84eYaReM?=
 =?us-ascii?Q?DYDOUdAZS6hNTfgbPDLJSLFIAMinpUCOBjf2p01b45NdCSDl8qywBpHSijAl?=
 =?us-ascii?Q?RTOzr4U4QB6zTSOcTVc4ebD/7q0Buh8bGu0oxtHLPSa/5+vd2coN6cqPC4ck?=
 =?us-ascii?Q?k1+Qa9bseZloUarY7IzDAh7lnrw8wq0TfLuce9T/J/43CwQKO1xC4pLZad0w?=
 =?us-ascii?Q?GDf8rce0ms1XS61qWdXP4VYFhc4RrwIPhS78ychyQpq7k0QNElJBqPj8dQIN?=
 =?us-ascii?Q?zVIS4GYfx2BuwqJLaQ/HO61LO/S3VdOGFZ6/uLZ3mAHTOeT4jgJbCDgRoKyC?=
 =?us-ascii?Q?2RVpj77fhRL7s212ivzdhjHpp/ibaP6iL1Eqx+1jWbKlIfXYJS34/PdOps7l?=
 =?us-ascii?Q?hrs60El5GpV7S1KFURbW+6CN1yFrM43Hmf8kNhE8dYgyU849Tlca0QCDHe1U?=
 =?us-ascii?Q?qL2i4V6Wys/9VTobVMAk+WdxXr0SCcAgMXmZeTeX53Kz1NKbIGF+X/Nb9XMI?=
 =?us-ascii?Q?AqIvGJSQhUPo3TfM2KRLvlqiBzd92N1Ppg5b5fdt0FpHmbuEmOdmPmwLH115?=
 =?us-ascii?Q?TKIUcYVZzbki+Xc1xpzxE8gtQBgqPlrdIxCd8BHKNSf4hwHzAHjQ/JAa5Fbt?=
 =?us-ascii?Q?x2yQC958rH3r38Dcnnwt2bKm6rncDwDbHRpCRukZKUWswJof1n9EUlLehH6E?=
 =?us-ascii?Q?RlaE7+wC7ek8CSYx2OxPMgCZrkTMscwvA2EOt6TPYs6jOr8f5RQ4W/RY/sJZ?=
 =?us-ascii?Q?mC5R20Pua4MyqUM9p6FVwqI4PKAWUB4gvMZFVdLD+jYSTsbMTZX9H86jFPBm?=
 =?us-ascii?Q?5Rx4L4m/C445lUpcAZveucDrYJ2sSpzugcSujdSpsY71/mY6TY4ca6OE7RXc?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becc4efa-0127-4550-21e4-08da86deabf1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 21:13:35.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPRB6MkDnx/78wkAKIjCgJFb3yK7Gb8AkKuA5Cos07qrrLBdPdNlbvi7svbiyeMn1kQDbw6DxbhwPnveSPxKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=992 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250081
X-Proofpoint-ORIG-GUID: 6nEmq__fV9haGYaemTrlKVB-bxwf_ofV
X-Proofpoint-GUID: 6nEmq__fV9haGYaemTrlKVB-bxwf_ofV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 09:25, David Hildenbrand wrote:
> > Is the primary concern the locking?  If so, I am not sure we have an issue.
> > As mentioned in your commit message, current code will use
> > pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> > will either be the mm wide lock or pmd_page lock.  To me, it seems that
> > either would provide correct synchronization for CONT-PTE entries.  Am I
> > missing something or misreading the code?
> > 
> > I started looking at code cleanup suggested by David.  Here is a quick
> > patch (not tested and likely containing errors) to see if this is a step
> > in the right direction.
> > 
> > I like it because we get rid of/combine all those follow_huge_p*d
> > routines.
> > 
> 
> Yes, see comments below.
> 
> > From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Wed, 24 Aug 2022 15:59:15 -0700
> > Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
> >  follow_page_mask
> > 
> > At the beginning of follow_page_mask, there currently is a call to
> > follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
> > architecture which (incorrectly) provides a follow_huge_addr routine
> > that does not return error.  Instead, at each level of the page table a
> > check is made for a hugetlb entry.  If a hugetlb entry is found, a call
> > to a routine associated with that page table level such as
> > follow_huge_pmd is made.
> > 
> > All the follow_huge_p*d routines are basically the same.  In addition
> > huge page size can be derived from the vma, so we know where in the page
> > table a huge page would reside.  So, replace follow_huge_addr with a
> > new architecture independent routine which will provide the same
> > functionality as the follow_huge_p*d routines.  We can then eliminate
> > the p*d_huge checks in follow_page_mask page table walking as well as
> > the follow_huge_p*d routines themselves.>
> > follow_page_mask still has is_hugepd hugetlb checks during page table
> > walking.  This is due to these checks and follow_huge_pd being
> > architecture specific.  These can be eliminated if
> > hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
> > that need to do follow_huge_pd processing.
> 
> But won't the
> 
> > +	/* hugetlb is special */
> > +	if (is_vm_hugetlb_page(vma))
> > +		return hugetlb_follow_page_mask(vma, address, flags);
> 
> code route everything via hugetlb_follow_page_mask() and all these
> (beloved) hugepd checks would essentially be unreachable?
> 
> At least my understanding is that hugepd only applies to hugetlb.
> 
> Can't we move the hugepd handling code into hugetlb_follow_page_mask()
> as well?
> 
> I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
> stuff already ... ?
> 
> [...]

I think so, but I got a little confused looking at the hugepd handling code.
Adding Aneesh who added support to follow_page_mask in the series at:
https://lore.kernel.org/linux-mm/1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com/

I believe you are correct in that follow_hugetlb_page must handle as well.

One source of my confusion is the following in follow_huge_pd:

	/*
	 * hugepage directory entries are protected by mm->page_table_lock
	 * Use this instead of huge_pte_lockptr
	 */
	ptl = &mm->page_table_lock;
	spin_lock(ptl);

Yet, if follow_hugetlb_page handles hugepd then it is using huge_pte_lockptr
to get the lock pointer and is wrong?

Hoping Aneesh can help clear up the confusion.

BTW, I also noticed that the above series added the comment:
	/* make this handle hugepd */
above the call to follow_huge_addr() in follow_page_mask.  Perhaps there
was at one time a plan to have follow_huge_addr handle hugepd?  That
series removed powerpc specific follow_huge_addr routine.

-- 
Mike Kravetz
