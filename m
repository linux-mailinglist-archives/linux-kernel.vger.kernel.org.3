Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61364ED6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiCaJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiCaJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE9158796
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:20:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V9K4im027080;
        Thu, 31 Mar 2022 09:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oA3XuDTkjDr348BkGtJ37wAGt9T0IfLctMHFwDaFMJM=;
 b=gE3+HJ5RQpqLfP6K1OQW0QRzvnZSeTwvAuNe7krzgAnWzfZf3IgYh8OD7X7HgZtMpGMW
 o549KfN8so0tHKQWj1lEwtPe+3DRzGEdqRkCBiOaosUO5sEaZf2wPZsvmBabRaPUR+ew
 xSndPM0KBn0S6XBrKQigSIJ5u757RWiY4djB0D0+EFts//yOKYO2kAzbwiY9mSIsBI0H
 9YyDR4oaZ3v1bIEv/4ssuUAg7K/9TMNbA4ELYI2wiBXio+982x1BRjwEDXxppGMPdbqY
 OxtKTRPt7o+ShZZZUCebsiZk2N3YU/bzm2hPooo2tLv7kQrJDVDuZfiI7TxA+UiF+n9/ ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cuhe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:20:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V9BMRS020989;
        Thu, 31 Mar 2022 09:20:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s953kvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CApXDhSZGmds+2UKPHEi7xHmvEp7E5tXvmi29UFr6YyJ0K5wX6Pn6/VF6fHHJjvK2EOGkz0Xo8PGgfI0K+Fc5GwEMSDl9tNI7aNlJu9NLN9JMBG/a9mitCCb/de4hmHs4E8dVwEprra8DMEzO04h6paQS8eZ0NMmIl+80HXnX3pTzB+RPaXhgt0kS67d+1XtauA6biTnS2FImdAL2K1J3+6nicXrNGuUxENfqOxG9je4Da34ApDN1jdmomGmkyoFunmtzxTW9gHEYTUnuGkUjTbXH0a8tlHQ09hFGzZoXoE0f+MKWe3EDgGsXdi5D0NXBPDnsPbShEmpnXWw7k6t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA3XuDTkjDr348BkGtJ37wAGt9T0IfLctMHFwDaFMJM=;
 b=NQ59IsIhCScasGiR6bL9OXpMueF6pBeh3x2UxmrkJe6jfhY2hlhumecTR2xNyzadD1pM6LKanMwYVfTzeX5wL8MKLi+ubL/KSRHnbPV82S7xZKERyosF7iyNYm9Rf6Ov8ASGbLSMU750SMsEU4+a7pz9Z3Xpb+0CMy6j0ao10cXvkV6O4YbYTZugBTkgHNtyahcxoIveew4AgZe+B4jnbJjgljAlLMY3HWQcUbk+r1Lcq5wG9RRa1JPByJmh5grS/HrAZ+KmM2h5KI+y+l7S9q7FmBi10QqlUFBmBrLgGci528cIVy/hRoJnJrJEpzCY7pQfY+/oPU85N6xUxns2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA3XuDTkjDr348BkGtJ37wAGt9T0IfLctMHFwDaFMJM=;
 b=FA7OUkqMEVY4ZRnEzts0PLLf+oryvyTD3t75Hv4zxwblPPhl9d9PXsgr2k+Kk1PFIiur7bK8F+wJDYuHfswC63Z6F4eyvvuZukuU65/zjzdsuZ9Au81eFn3GjICGne6QIbm12Kmf0nPqsUO1hsp1umQSuWDscMnD1yCchWSQDbM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4703.namprd10.prod.outlook.com
 (2603:10b6:a03:2d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 09:20:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 09:20:32 +0000
Date:   Thu, 31 Mar 2022 12:20:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     "larry.finger" <Larry.Finger@lwfinger.net>,
        phil <phil@philpotter.co.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-staging <linux-staging@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] staging: r8188eu: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <20220331092013.GC12805@kadam>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
 <tencent_2F72CC5068850B2BEDFC2B8058303FE6520A@qq.com>
 <20220331073555.GK3293@kadam>
 <2022033116214474301568@foxmail.com>
 <tencent_7E870E856738AA52C5FF04C81D735AEE1206@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7E870E856738AA52C5FF04C81D735AEE1206@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f599b5f5-4231-4378-31ba-08da12f7b480
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4703:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4703E1D7970BB4641FBC39238EE19@SJ0PR10MB4703.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuxTgaXIYBmJnDbeyY16JWUd1RPUG7wIF/KD8yPJDeeF8wfhPMLnKOQg+C28Rfy6GQZbZBTmQ6R1PNlxOq0UcAfi9R+dZJZWaT3YfNQWDJ/pO5F2hgT5t2aNGCF9zH6qG5NjPrAejjmJCtWrvORcftsqEcrel8DhpI4mezKZXuUv0XRfzDk+l0+RaylOulOBemackr/S0NAmEL2Ik42cMbkf9c+78HBvr3ln/KF9o9+0a1JZXGc1j6h+ykZoyES2RHTPwIvCgIrJUnx9Kwh1xLBjaKVWjXFdFiX/Jw7ZjgbI6tTVzatzYJLmR7eQUxXCtyQVzQnSso0+6sSa69LkpkxZJfV83Gv9yAjne3QOwRU+iDISCDegkSzpFgogfR6jXx4eIognlN3xtAlba7oYheLppwnKS0jJWFe6Ww1j+0DmdxBQ3WB2IYAF94JSjkEMjSFNV6MyF6lTQnUNHLOguTT5lUKFGUbmrTCXtL6hQ4ALgQM2JbIXLqQbKuK9KUJskNupZWicajQH5WiV9PGRfUOou52WZ5kUWDx00G0opta+ydupDRY3NjWNzEvK8CKu7kK4VOfLI+Sx7XTce58Kecl3J1OYZraCvmpQEoymiT8HzGLs8CkodyfCY7zpUTLa7TMftWlWO5FC6FQVNf3phXcgxoPsQVXf41hJdHNUzTvaw95vNkHAhh9SqIQCZ05qmMQbTTllWeolK1D8HEI0f+qrcV3GKxNIMDJj53GQ9gh1eRm3CZXmg8Y2V9+nimm2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(4326008)(1076003)(186003)(86362001)(26005)(54906003)(66476007)(66946007)(6916009)(316002)(33716001)(508600001)(6512007)(6486002)(9686003)(66556008)(52116002)(33656002)(6506007)(6666004)(38350700002)(38100700002)(5660300002)(8936002)(2906002)(44832011)(83380400001)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/KZXTLbeoaCUB9snAkBXEkabJw2KoUqaYpdzjPtRRI2Jd/cXRJpB47zHxWN?=
 =?us-ascii?Q?6oPmKMd8+ZNGy+seWl0YQinN2WZd2GnRtwcVJFKnf7iu//MSco7lFYhKZh/O?=
 =?us-ascii?Q?4ko6uEzdcn1g67aobOhYqQu3MKbQFL1aa/sSjnGjYF/f4Fll6VhuaWy5dSge?=
 =?us-ascii?Q?33OeEe4uvEdVqXiZHNX3XgwqeM00DmHaWUwFWtRCvCM+UxCGQXFJeYTkG+U5?=
 =?us-ascii?Q?UC3WZYafHpgm2TVmxEmM5K1HxE4I9lK4NXjzThWXwJyeRECYgii96OGOuOC8?=
 =?us-ascii?Q?ZpXdv9SBKh0vd9nwTXLhR3Ixs2Emyg+eA8zUgcwIaEQK035LkYobLJyUauw6?=
 =?us-ascii?Q?9qdQkMMSlG7PT4OQkkcRHiIj4VORKD3MHzIdC0QJOJBFIBbSkPK9+4lJEhWE?=
 =?us-ascii?Q?GTBn9W3tKwgTsk/7IL9AbxGgzVWjHYZDHJPcmyCmHtoNgRyEAR6NaBzt/Iy/?=
 =?us-ascii?Q?gNbls9KiynwI7dUSm73Czycn4ZXy/7K7fGMXXNEXOQ7FNUDki3vlal2atykx?=
 =?us-ascii?Q?cyGaMHzcYOhHUbpAvZUW5KX/OcgchZqnAjFM2DJ5vvZiRBZ0of1tt5LUwhZ2?=
 =?us-ascii?Q?9Jq8CwhYGM7MvjtSur4g5cFWep0Ag1n9H8r9cKtlLQzAYmIzFqzYDUKebo+z?=
 =?us-ascii?Q?62fuvRzmBfnnx4Aex753gNy2VNsAL3VrVjNYnSS97+i+lpYYCbxcV3GqpnXI?=
 =?us-ascii?Q?+vvAK4plhEtQMITmyGbY4d1SPHxXXNMxKbmED12pTSk4UQjWwARAYyed8y5A?=
 =?us-ascii?Q?KmshL84UYjhHkBS5o+cilNtQM4gMI7Qmrx4J16FCoSsoJ7R4pIeS8oTyRZo+?=
 =?us-ascii?Q?0eDTEIr1pPD0a0bkBbvWk0hvJrE4VL4kaoNUafpk7w8OVc51+54cdNIzGLq3?=
 =?us-ascii?Q?QSocDcRzPg8b/OZ7dyUsDM1Ve+ojBooIxs70UFUrtIqAgNhJzK6p4Y2t1Ept?=
 =?us-ascii?Q?GBhsGfAFDpmK8VCVaMvXSkOSclZsjS0WNh/0tx4SQol6d/VWySlOTuGq/rcS?=
 =?us-ascii?Q?c+c86TDS14PpLCIDWhHgXPKRq5lBtRvSYMr+3XCEc13UIiZO0O8dKWqs5zvW?=
 =?us-ascii?Q?WJj/bawcHzQnran0JQz2N+6+iQsEmlqSVg6TN5UBvyfrFznAzNLOHPQlkxxx?=
 =?us-ascii?Q?c6yLce4Kg9xImKWbOex+ND3l/MBw580BhIEBgoNWR8SAdN+yrhX8ho3POXp2?=
 =?us-ascii?Q?UMoUTEdRqSxPbhP3W8OsIENsgGaqD2j+AdNj88+DaBkpGxvTjNadtKG4vx8i?=
 =?us-ascii?Q?d0jLagPyi+QKEi1t3fvboXofBU4R9U9XQFhl7T8+BtXez2Iea8lcPqOM+tlI?=
 =?us-ascii?Q?lpdYIDeihX0wA5iELIjdLxqOYQ1mvZSVffqhJiOVEPHcvF5/1K/FLkH6VkFs?=
 =?us-ascii?Q?M/8sM13Mal9gb+HC48J4AaWI+8+8MF9DnBO9d1sgicuxcyf16CXcsnKiWzZl?=
 =?us-ascii?Q?NcuJu/mG6eLWYwuwmIep+BV8fQf88co60a9QvD4eqsDu7kP1PT72/vyQUkVh?=
 =?us-ascii?Q?KWRVIHyvK9LxaYWt4DaB6bkxxSYCAM7ZFmAIIknoJjQYHeWnMo37iUQL/P0e?=
 =?us-ascii?Q?5tOyxPH7GaWmOFoe3Y/AA/UDmyiKNWX9dRpFAIHZFrfvmrVuNYqfNpHt22Tk?=
 =?us-ascii?Q?43zrtYqS/sL+fvD1UI/DkUsiOQ4dj1D3LhPOEWZ1i3+XnraUhIiDwuNlcS/6?=
 =?us-ascii?Q?/TzWQrOfIJcq5p6ljjo0AFTX5AcXjGR7bvV53CkkvmuKdkvM4u0xZTJ9vG+m?=
 =?us-ascii?Q?8Fbn2yhT2+yOSynFT9R8xu/GAxpbJ/s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f599b5f5-4231-4378-31ba-08da12f7b480
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 09:20:32.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmlD12qlqDwzhPL07Y/f42v3Z/dOl/aBRGx7BQGD+w5nJIZnLlZ4hBkrFe+R7+cLsv0I+doXYJ4Le73uxeB+sxTwogGhpdVKUgvBiFhd6+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=780
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310051
X-Proofpoint-GUID: oqOnaGYpuL4W8twTelDmCLHGEOQe-gfo
X-Proofpoint-ORIG-GUID: oqOnaGYpuL4W8twTelDmCLHGEOQe-gfo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:33:37PM +0800, Xiaoke Wang wrote:
> 
> On Thu, 31 Mar 2022 16:21:43 +0800, xkernel.wang@foxmail.com wrote:
> >In fact, this is considering that we do not know where is the failure
> >from. In rtw_os_xmit_resource_alloc(), the failure can from 
> >
> >> pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
> >
> > , but also can from 
> >
> >> 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
> >
> > So if we do not handle the current failed item and just skip it, then some
> > memory may be ignored.
> 
> 
> 
> Maybe this should be the problem of rtw_os_xmit_resource_alloc() as it
> does properly handle the error from it.
> Anyway, I will attempt to fix them.
> 

It would be a lot easier to fix this code, if it were cleaner.

It goes to a lot of work to ensure that the pointers are aligned at the
4 byte mark, but memory from kmalloc() or vmalloc() is already aligned
at 8 bytes so there is no need.

	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);

The + 4 is for alignment.

	pxmitpriv->pxmit_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_frame_buf), 4);

So then it stores pxmitpriv->pxmit_frame_buf which is the aligned
version of the pointer and the ->pallocated_frame_buf pointer which it
uses to free the memory.  Delete pxmitpriv->pallocated_frame_buf.  Just
allocate it directly.  Use vcalloc().

	pxmitpriv->pxmit_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame);

That stuff can all be done in one patch because it is:

Patch 1: Remove unnecessary alignment hacks.

This code goes to great lengths to ensure that the buffers are 4 bytes
aligned.  However that is not necessary as the vmalloc() and kmalloc()
functions return memory that is already aligned at 8 bytes.
1) No need for the temporary pxmitpriv->pallocated_frame_buf pointer to
   store unaligned memory.
2) No need to allocate "+ 4" extra bytes for alignment.
3) No need to call N_BYTE_ALIGMENT().

Patch 2: Use vcalloc() instead of vzalloc()
Patch 3: Declare the pxmitpriv->pxmit_frame_buf pointer as an array of
structs instead of an array of u8.  This allows us to remove some
casting.

Once the code is cleaner then the error handling will also be easier.

regards,
dan carpenter
