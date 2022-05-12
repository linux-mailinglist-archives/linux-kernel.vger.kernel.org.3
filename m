Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA04525427
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357353AbiELRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357389AbiELRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:51:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85A1C135
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:51:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGNEVB023549;
        Thu, 12 May 2022 17:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xNTfL3seme0AIR4FcLdVn9SeIIPosSxjZn6yibKRsv0=;
 b=IyysD/wvAzdxQDq2jtT5E6n6V7LTuXKRrCx/8ATqUiWlM7+S0Gm697cd0Y2mTcqIE0nq
 yfqFVqOGIeGgpCp8IAE4B1wiMqt7TS3rvTxRAQe6cQAEr3BcwS9GY1B4QA/mTkwC1HCu
 KPngxoCbvEyDEafqZb4LgTjTa4m0sEGEelewzAADlityi+8KCHePjPl6Hb9/ZC2dzOuc
 uKcxb5+i8P5uHeec91qx5mDdL2itYJnsq7CHUJFNq1mpU/RjeQIvYYkzi5JjL2/UdQsP
 NiWvPy6FRfHIeunloOFtmu8elsh1ozyd79ciw3yRo1xNJqvcf8/sys2wz9Ml2HwyuRH4 5g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcswkpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:51:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CHfJDK028600;
        Thu, 12 May 2022 17:51:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6g8ukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL9X9AFQqy1JDxMOIWwNpUsRYlH+yn3toiqUABlwL3BHhUB5fjRg7qQ4FTKZKhmW1sWzmbJjJEFCDo+fd77GgC/Vy7EFJ+SbdQdrPQH067TUoycqO5hi5zS0RlljN39Nt8LlN+zYr2lCFPzQR1Zu0OYCVW2WW+RN7x4LAPqD0l3UGSoDne4/HVa/ki/DtU263VpybBwP/w6q9vbm51/kxbA9DHhGERpHiI9GKl8Sq1sv4KJue74ECjq4oigFe8f0plrC5WTA0ri6NQ7mBlmHqdNXpowWqQ8jA/I7sZ9WFliwDbYdDa0i/VFV8RiBZpJraXPC2oKfaOaITsD/2MGTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNTfL3seme0AIR4FcLdVn9SeIIPosSxjZn6yibKRsv0=;
 b=oEIG0qdMytskKQpijikWMr5qIdkyQdUOc0ewO83T7vk0Do4deEc+uEk9LAUZSDCV/MqkwB+N3xrCVSNTWY9hzMSjGrF+WKQB9eNiTnSRXl1vqPzm5/H+PGvRR1PnC312crATBLZBWZYarBCfTXUWMQvCT6vDdggMWKLVy9hN5OlMVkgMwtIgCsUH9a0H3Ln7VhaW2NxWgK+HcUDL+iCpyh+Aw+30pyZxLsadJzqDwsVwTRDO1UkUSo0v+LEScIkunLMUQ7ijoSVM6r4SLq4RSONJ/AyjAHPe1OyCW+HuX0AgpnHzoFY+nR6xWttotM7Xm5ma7PkLWj+IY5iYA3q3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNTfL3seme0AIR4FcLdVn9SeIIPosSxjZn6yibKRsv0=;
 b=NqS8V2/19/0fy/yeThCiEVC9Q6mDkhJPLjO6oqxost8coylrjATyvd31KhkH3F8m6PBB7hROmV2ZqHGywK+d9w5MKkFCMwBxGiniJ8+ga3ak5HMigugV6JoPMY2bLHx67tghywLEh4kW83tXH1oT0spSiS2K18tTAIacOIlv1Aw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 17:50:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.024; Thu, 12 May 2022
 17:50:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYX1NhZKDMPG7C/keyeY6aTlfpJ60bhQ8AgAAN4YA=
Date:   Thu, 12 May 2022 17:50:58 +0000
Message-ID: <20220512175041.7dfrtpupnomtvxo2@revolver>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220504010716.661115-10-Liam.Howlett@oracle.com> <20220512170100.GA74@qian>
In-Reply-To: <20220512170100.GA74@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 042d0631-cadd-49d8-6308-08da343ff8a2
x-ms-traffictypediagnostic: SA2PR10MB4699:EE_
x-microsoft-antispam-prvs: <SA2PR10MB46993172ED49F54A9A2A00C6FDCB9@SA2PR10MB4699.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFXPcvZ/LEalX+574YIlPevvrESlpVNfPztFzZGAb2RpLA+X9RMFE9BcxIuUhDoejZPEItEOg16i6w9DASCha48UPwQXRUIbrGbn20FNjaj2yArwDmvDns2C5tHRyk54+yd/rsgiVbDZB+vkWVBCEqEkF8PnzrAFaHyJ/Bgg5cayh17ohdMPC1VFdkZChT1e/vBmJxo3wZPdWXR/bOyXTRYRGtzCi80TQbxB+Vch43VcpyB4XWHnSU3226PEZhy3FG0fbRrNEonhfROTIyQWRha8GxEWBhFpgBt89R6s9wnuW9Lxdc97gOjQv1Fsz5krWojGE2MeoQ/npkdaIzGkWf8AI9+YWWIMQuKxYhNQvUM5zUEqs93enG+EC6EIQ78l5i3CzxRp8TKGg1okR3VIB7D0qwYl6gbE0762Utn1ELlptPBTED8pL0r4FOOHuNKaWeXhg+TiIxoEE/GxjJ4CnYpv+TT95szOHKoK0WWNfD2pcwICVKt16U1sYobGUW4GGWpU9hEhPUQNIOUefjaHYF0ZDfIKMavy9qbxG6ZadHbEemjlmxqYGFXdxrz+aIaSuUu2pVqZq5jAkWLmvkHAgDtgZnMju2Mp4oZn17OfXcfYyWiChcF+B0yjjDWqOAb5DS/fx5w8KP9si0KoXn9WcSQRUwmfubceD8tSGdrYtVxaURwd17aX/9qyWGebh62vx/I5z3v+Eby1Vm7CkZ5LyDzrILqR9k5XNjtg28773To=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(38070700005)(26005)(508600001)(2906002)(71200400001)(4326008)(64756008)(6512007)(83380400001)(9686003)(1076003)(66446008)(5660300002)(6506007)(44832011)(6916009)(122000001)(6486002)(91956017)(8936002)(66556008)(66946007)(54906003)(8676002)(86362001)(33716001)(66476007)(316002)(76116006)(186003)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1UeX1WaT5YBweurnR1ocsdHqVPRCi/eN94bMniWw/BTHNG16Lw7r3TVj/ZMA?=
 =?us-ascii?Q?/ynb6/z9RXKKfFl+tldiiiovekRte9g+E9xvPBs+B82baSBu23/FQDEqM5t1?=
 =?us-ascii?Q?syBGVllzx6H89NraGanC73/SfwfhHA3YnyIAa6LdezBZwD5VAlLvZMUDj5VR?=
 =?us-ascii?Q?Yd4dupsf58qr/aRFjjdkV++vn5BNnvjG3ebg58mWZs7g13nFbRqEIyKklMQY?=
 =?us-ascii?Q?b6RwMQ6Il6yQCJPy39b4Y+zWn18kb4PZ0QEiAS7lYbthieDmfLB/I2P9wqnQ?=
 =?us-ascii?Q?ni/n9Ep9KmGeYD6OG+ma2z2fDs4WnzxAHQpknrUR2VftI+pZTeXRS/2MftDQ?=
 =?us-ascii?Q?+fXMIdVQjdg2UOwdIb+gXXEj831uHXArjqQ/edgyFcFGKNNrONdaNgWISYJD?=
 =?us-ascii?Q?lC5kMJcGSC8I9xLLknqwm6Gv3EaiYEa19SCws2hptEJl0rHdJ5xup8rF91Fb?=
 =?us-ascii?Q?+cesv1NrXHWyDD99ZGC+mjIyftWx6VqwqM6Gjg1YEB1Q+Oiqpa048lNftV8S?=
 =?us-ascii?Q?UT0tkLmZq8vJlPusLjFf64yGAPtxGiS5ItbrBm7YjmSfwAuPFwj3sZ7ijPXx?=
 =?us-ascii?Q?gEg5znVtCsYVWcO8WIuk/61BTYnLqe57xU7kIU+5Yuownvd+4BsRsTViNJss?=
 =?us-ascii?Q?Kf9eGHYA8scx+TA3KlAmMAcenAJfoXJ3DGGmo2rwMDsRhaKPh/B60GVAyaMw?=
 =?us-ascii?Q?wlhxfLRCZbpTwvCAw6ygzjb9wdmkg58Ws6vKRGYlD1fZrNyu6nx+3nYodBd1?=
 =?us-ascii?Q?JZnyv23L48OOxCAml8Z+w2zOLnT5gDv8xgVcDCFEToQQTnFnt8sRLuk4mecL?=
 =?us-ascii?Q?+faGcLbnr4gy9f8gVOnkElESq8PiTJmfjogc0Rskdvt6B37AGL6DuEYGTksA?=
 =?us-ascii?Q?5Eyad7Wm6KqqEQx3SBdKXYMuQri2WdlLVbOyJUFuw6eYIrSMml1awi4FXika?=
 =?us-ascii?Q?qos671dirpkioD4/sGL4xdsFdMZGlstHVQzE+ZY1QbURD7M/mF5g+yojeJPd?=
 =?us-ascii?Q?numYu4j6UsNUSWtm0CNkCxBPoxZHXURwmMp0HDSpTSmTlLNhG83QS9luuulO?=
 =?us-ascii?Q?lWtpn4s2KWxeX/Ckh56zxaPlQ03/Txnrh1DxmnIQ7Sbwf4TzFROJEBUhX+HS?=
 =?us-ascii?Q?H9CBiJ2fvmnuejo/+yGp/8Vq61OOXVjY1BFtZJueyr6vprpzAIU1HcHsMIVK?=
 =?us-ascii?Q?zojvSluC1mTfxlFOrn5nPF6/8cv3ZFM6/ZqtXyF996s2bx1IJQA5i3+1v2ec?=
 =?us-ascii?Q?a2+cTION6iNop4Y3XGh7YpR70froVMllhM02DN7v8GqgfU3bgfc0IQx02TSa?=
 =?us-ascii?Q?gP7hQhJdl5XTBQMJsVU1GDmtzkETknYcjmMZ+eni8ixEAYQxcpCElkoD6lx7?=
 =?us-ascii?Q?C9zNZdNpp6B/3NUHTik/QSs7ZsmBqBuz2AUXCB0jzKDrZSlM4djVpoESh64D?=
 =?us-ascii?Q?oxpFJNRxwgluHyMI3wc1p3mJMsZRFiWYX4BoYEVYF77evBiPIkmPstNuYXUC?=
 =?us-ascii?Q?XJWnlyQHrd8vrpWsWRBocCyd6W0iaaONmdPVN1BHp7SqXGVa+rDBUFFmIKhR?=
 =?us-ascii?Q?qtpJ2DD5WiVufXTVxAB3H5raL9VxUILGpfliTB82z9IGIebCWBy9tB2nRCG4?=
 =?us-ascii?Q?2lrKHdrh9PPcrPIPteRRvfeArheOSTBIt1FATZgQi7WPStIhSQY99YlLIKN6?=
 =?us-ascii?Q?RM4l5uEVpyElPgEka4J4tBxHuaKCWFo5d6RBq5i+3j+crWwjmBLxqRgh6Tn8?=
 =?us-ascii?Q?TOiAHDq8auHOTWTuSDXywG+smjfnACY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30756F8E02B8D948A99430DBE69C8887@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042d0631-cadd-49d8-6308-08da343ff8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 17:50:58.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAx9BxRcZQ0SPxzefRjHlOPkwG6mR/ohSBCvsXgPwqIDoeTA3xo6VAH0HcURzhhp5+w8q45SdNJO8GO0n0jO1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_10:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120081
X-Proofpoint-GUID: WimObpI0Hiz48d_V1PxRkB7-qgeMQF9S
X-Proofpoint-ORIG-GUID: WimObpI0Hiz48d_V1PxRkB7-qgeMQF9S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qian Cai <quic_qiancai@quicinc.com> [220512 13:01]:
> On Wed, May 04, 2022 at 01:07:52AM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Start tracking the VMAs with the new maple tree structure in parallel w=
ith
> > the rb_tree.  Add debug and trace events for maple tree operations and
> > duplicate the rb_tree that is created on forks into the maple tree.
> >=20
> > The maple tree is added to the mm_struct including the mm_init struct,
> > added support in required mm/mmap functions, added tracking in kernel/f=
ork
> > for process forking, and used to find the unmapped_area and checked
> > against what the rbtree finds.
> >=20
> > This also moves the mmap_lock() in exit_mmap() since the oom reaper cal=
l
> > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ...
> > @@ -2479,9 +2693,14 @@ int expand_downwards(struct vm_area_struct *vma,
> >  			return -ENOMEM;
> >  	}
> > =20
> > +	if (mas_preallocate(&mas, vma, GFP_KERNEL))
>=20
> We have thousands of leaks reports here from kmemleak while running some
> syscall fuzzers on today's linux-next tree.

Thanks for the report.  Yes, this is mine.  I am testing a fix now.

>=20
> unreferenced object 0xffff0803c0063d00 (size 256):
>   comm "trinity-c25", pid 177739, jiffies 4297781293 (age 354.988s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>      slab_post_alloc_hook
>      kmem_cache_alloc_bulk
>      mas_alloc_nodes
>      mas_preallocate
>      mas_preallocate at lib/maple_tree.c:5579
>      expand_downwards
>      expand_downwards at mm/mmap.c:2094
>      expand_stack
>      do_page_fault
>      do_translation_fault
>      do_mem_abort
>      el1_abort
>      el1h_64_sync_handler
>      el1h_64_sync
>      handle_futex_death
>      exit_robust_list
>      futex_exit_release
>      exit_mm_release
>=20
> > +		return -ENOMEM;
> > +
> >  	/* We must make sure the anon_vma is allocated. */
> > -	if (unlikely(anon_vma_prepare(vma)))
> > +	if (unlikely(anon_vma_prepare(vma))) {
> > +		mas_destroy(&mas);
> >  		return -ENOMEM;
> > +	}
> > =20
> >  	/*
> >  	 * vma->vm_start/vm_end cannot change under us because the caller=
