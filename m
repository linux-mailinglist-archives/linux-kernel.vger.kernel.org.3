Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6854573CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiGMTGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:06:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23025582
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:06:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJ4qJe007526;
        Wed, 13 Jul 2022 19:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i7xKPBozcp5gQtD/vB+sMWRhFtMIoLtIIxKkZaF0FLs=;
 b=y5FfVQgljwgrJKhkQ0aE7iQ0+tMJzTKJkKGu8PUR0DgYJBcn2sEMS8GelGM1T4hQ1waW
 omX1Dv0cOePOz8x+W4xiUV0hB5OYOlk0zTS2Rb/kzZv0f79SEM01v1fzX0UHBSjT3155
 Xrc9+tts3hgs4Xt16XHXX9+Ye8+mSNpc1SrQccrPl9M+Od/oyc9c5Op/NEr5P67tQa5V
 I/qONiAeA7YnlAAPxecpTHvWJj7Wuhs9/yTQ51yFLK/RZcpjVuM0vYwNUhwt2UifkN7B
 TTbkzmcyBQyUUIY0ANO9wY4gul85Yd/Ez3bi5xVnyBi+LvTV0I2Mq9EuDsZT4XTZi4Jm vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scb8p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:05:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DJ5cpU040768;
        Wed, 13 Jul 2022 19:05:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70456cwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+GCrMMQdN4g8ir9R/HK9R5/wPLTAFiFuNZnM0Y1LYYZUVejZS6gWvRN0l600zWBGWrCzwKrWpH29lBp6+celrQcMr4p7rFFPCztkGyLcy3RD11XtEoHI2TxmZnszG18aWt9CnFfNS8geUTP4YCD0zUBNjCuotsZEGqbWW86dxIIdhYcC2JIYW0G5lVlEZmXzNB26CLSXtzkNQIR0xolk3HhElNvuY0Pf9334II3QSiJeRJ+nkxOHALs5139g7cgtFdQ0aFM3cbtLtgEf4pjtIdo8VEIzvtDvwsPJ79uivq0TeUATb+h1TbU9r1+4Bv6Oc+xQGtmVpUnU2hSCLy9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7xKPBozcp5gQtD/vB+sMWRhFtMIoLtIIxKkZaF0FLs=;
 b=T+ywdBMinMSKib1Z/+fghu+S1C3jG1+cLBdoO3qd+tEBdo0I3jN73beDQJOX5vP0CwE4Wmv0RxXibyNujDQoCHj2bwajzdDnRhKkBGH8pq6Q2qvDFmd3LXyBrnHI9wX5hqaDrDRORsdl9hAaFGgOResPhI0h77GidM+u/jSZ3HlpRUEmYfpm/C1Q8V0yANdR7vsBjhyg2ZD9QZNdE7EnDHRGF215bk3tbdJ5n22vrDHeKDspYth6C3/12jXLfnCnIOjymyYwrcXp7usN5PzJDTy5r31OfVXQKoLA9JFM0ebaFs8u6HbWYUssaNrjsxI2Eb1JVg24TlmwLS/GEAzi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7xKPBozcp5gQtD/vB+sMWRhFtMIoLtIIxKkZaF0FLs=;
 b=V2BIixvLm00Vob5gRm4WOZycOKNN7ssRHNxl8OVk7TPuwvjOazfVN8m6+Bm/hojLBT6J//AfJs+6HyPDhPgSeFkIc/iJfjpoAnahnknJmQv7hIafJFcJ89f3PiRwxtyOzQigx6KryLr/oHtjZJfyh9IJTbayhcmMttVoxBDyq1k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2164.namprd10.prod.outlook.com (2603:10b6:405:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 13 Jul
 2022 19:05:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 19:05:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Topic: [PATCH v10 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYhbALw8Cgd88Oq0u0JtGnbVJYIK1dVqMAgB91CoA=
Date:   Wed, 13 Jul 2022 19:05:40 +0000
Message-ID: <20220713190533.buuibidk47wde6tj@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-15-Liam.Howlett@oracle.com>
 <5787e664-73c6-4ab0-451e-2b0f3becb6ae@redhat.com>
In-Reply-To: <5787e664-73c6-4ab0-451e-2b0f3becb6ae@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccbf02fe-423b-4492-7474-08da6502ad87
x-ms-traffictypediagnostic: BN6PR1001MB2164:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYUr5gilRXOXstguSlF7rWFr0lvOPofb4yWWjLYV1O/Hd5YXBrOyVOYSzYap3fnHFH2XI1o4lucgfVyuNd4HBfhNDFPfZi/8UDCokpmXochR/D8Sc2XDnevm2FWwQKfyhfNaApRH9i2eOHT8F944PgjSjNnuj5zLj4mLWYfIFu4X+M3Oa4B0DIuNhzTTXcn42mi6Us4mJS/oCJa1io5lzSy/+ljgxy0xz+rlRxXvbtP35VvRO9kuYRnp45RIA0jk91hcqFH1PWWZML2hVb9NVzMSFVA29kfnRGAUZKN5wa3wVJe5dhDiFV6sLiimUjume5mchwdriKoA3ImySE2x/7/0X2QKN2epjXW7HDPb8vvDf6wyNedYj/l4qDtHQD9JXElfo7KqDW6Q14Uc1gnir/HrLTVKAu+kUUq4363ut1BFh+IldjfZvrdkFl6XXeu6JNPyAxM6CnfAL/07tq4dVJOzCRUrgHRr01hjskFmR4fBtxy6AQzxdjYq3ZIct6zdjwraHUMqryY5pLVq1priSpxibd5aO1ZcPTvkMgjJEMtl446Fm4MvNof0HAlPBBkE1yVtd+hW/Z/A8xpN4vzrEvSBjkLFjWR++Igj4rZwlWwq0safHUrw8vdLm0G2xXFkPB9+rHqiDEbWdH5o1JNw+ATnokQ/8QU0NbbF/QVkxYyOifShZx9sRSgIfhPQ5gYe68Ddc+YwlV2W6/WCNNMOW78TfEBvKADgyLtU/IbFsG+w6v9mpKRD4ZDlu5G4+8VDJOkGk8X37LxX9+j5l11SkcOnwU4caYir3koslA3T1fUUgYbxUZF8YsXxiI1CfjTVlnw+K+ae5KdiaKzPrx7FVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(122000001)(2906002)(38100700002)(5660300002)(83380400001)(8936002)(44832011)(1076003)(38070700005)(66446008)(86362001)(316002)(54906003)(8676002)(66556008)(66476007)(33716001)(4326008)(66946007)(186003)(64756008)(41300700001)(76116006)(26005)(91956017)(6916009)(6506007)(71200400001)(966005)(6486002)(9686003)(53546011)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WMcNEEkq25JyPuZMAWW+m7jN8pr6VB0nTwJHG91WBCTBitZoi3u/xJnY7SeL?=
 =?us-ascii?Q?bH7ngPG/Sily4gjUvhdhBPB9udVU3cIEpbGEaM6HYAufE++EgeTKugsJQ35J?=
 =?us-ascii?Q?glGWEo2S+oKU7tHWSw+moo069jhIfFI+gzgrFM25yJVxEqY96jjMI9iG2qfY?=
 =?us-ascii?Q?YyT5tvWtHQ+/UnvqbARs9U84pLdUtT4RmzBugif0N9ZwW3asjoaZBJ4qItdC?=
 =?us-ascii?Q?Cf1GCtbG/bjj8162xNbJCVaJecJvjFVu+6M+5DHi2nUscPu25VA0aV5A8pzx?=
 =?us-ascii?Q?Iar7+FqMEcmLVG0XGmdn1S5OGuKquGXCbY9o0PTWsRsP6QxfsM6nr/Hj5AJL?=
 =?us-ascii?Q?lpHFf00iRs7o3gaYDAzs2asQxaGdTApY79Iibf6r9mcxz+P5JXfwOifj/7qm?=
 =?us-ascii?Q?wBlgHMLKVYlZSwtfkE2Po52ock4KjZQAZ9SPikwM39RZdrEGdkTKwjhHEzbb?=
 =?us-ascii?Q?57H3av+EOVJ4jNwS7yn/+p7WtZC00IK6QtvmTZcMi48/RWvGr4YfzAPjJCNY?=
 =?us-ascii?Q?UaYnmaI+gitkaPi7LfLGSr3lfjsN8QunHHDWbqTKA3pVmub18AaZ4IOBk5X1?=
 =?us-ascii?Q?aNndCzofPtudBK8z7Ru0cZxdGkmUQV8ei/Om731siqgBBNhE7TFdWtKX4kAN?=
 =?us-ascii?Q?a3L8wpUT3A2DtKlzyaCD7RAsgvRXIpNF+Bqismm1syeG9LhEtXxuLoiBEYgK?=
 =?us-ascii?Q?n/x3y6Yqsrh/kzi73AYWYJtgkN5AsSCRMB7L2hKtJosJFlYVh4tUW/RNZIks?=
 =?us-ascii?Q?ngPuvW+WKulaR/K/G8aSVxHAZRPurSsK1czTT5MZubWoXUeE/r2BE3o/sCLm?=
 =?us-ascii?Q?lUdCNc7fyRK7TR7DrvR5Xk0nmYEUkoGsbLMuAHyweB08m8wobUTkdxiu6ZSE?=
 =?us-ascii?Q?VUQUUq9XwSPMvzX5A3Mwf4zUY2HrEtpO2C6Jj76qpUD6TxkyxppRWhcNduex?=
 =?us-ascii?Q?v5m800AisbekmvkyoPxlkn8rEvphpFt/lMOY3NICIoNLWCsR76WLICAFUMPa?=
 =?us-ascii?Q?dm5bzNPJ32qCkFh0PqbfK8StUmlKzjrpZ9p+0PEY/EE9HEL4RD038UWlvdLx?=
 =?us-ascii?Q?TIAxov7VwhTApu5aLCMcALqh8+iALU3VS8mxLHUrdlFZJocC17WwjAmsG/Qr?=
 =?us-ascii?Q?Jk5wY7UnI4M6Eb6KuQWU9sSS5t3YNUEj79m/7/D8QIkclcpQknyMB/iHKSUB?=
 =?us-ascii?Q?3wDPYkv1BbiB/sEVj6uQZqocXGcogeM/LF52YXLedBwalYUMXpHthIyRLCJA?=
 =?us-ascii?Q?GJRgW5ds25lvKF8IR2nKKiqcs/uzGUDkepstmU5tScdKGlYpGgjA/9SvUpiL?=
 =?us-ascii?Q?56Q+8tsPg9YdKHZwNSnyBsXflV0hDygUsDP+6+AMvB5WaMCcT0qZqHHFBKIC?=
 =?us-ascii?Q?V4hQAddddUpudy3S+xJHJekqKIagDyAcyj4sv1QCsrU6qMCXq7satvUJ08bF?=
 =?us-ascii?Q?D4jAfTaN+7LLQMyVoVYd3j7qDwbP3XKL9c1CbqaF/LuClfr6Z0qnHON5TzUN?=
 =?us-ascii?Q?kWt5qOXtp2YfE0ST7uLTGGXzxrkwsdYSrlE8dr2mQmKLbGTLyxIXToWjoiuX?=
 =?us-ascii?Q?lvJVui/tTHD+PsWZUJIwkJrnzDs8EtArgqF+qQby5qoW9MIHfgEnzjwxO3aw?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D15F93A12EA794D8F28975FAB22C38B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf02fe-423b-4492-7474-08da6502ad87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 19:05:40.1865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0R2konMjf9PgoYm+Yr1WiRxcr2644Zr3jXhgxj6hJZdnyTMoP+d1/8wzEl7y5lFyxwaVibxFWAa0qo0u6/seQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_09:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130073
X-Proofpoint-GUID: Q1SvzEbQSV_rqowMpGjxvScRVbI35e3O
X-Proofpoint-ORIG-GUID: Q1SvzEbQSV_rqowMpGjxvScRVbI35e3O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220623 14:42]:
> On 21.06.22 22:46, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > The maple tree was already tracking VMAs in this function by an earlier
> > commit, but the rbtree iterator was being used to iterate the list.
> > Change the iterator to use a maple tree native iterator and switch to t=
he
> > maple tree advanced API to avoid multiple walks of the tree during inse=
rt
> > operations.  Unexport the now-unused vma_store() function.
> >=20
> > For performance reasons we bulk allocate the maple tree nodes.  The nod=
e
> > calculations are done internally to the tree and use the VMA count and
> > assume the worst-case node requirements.  The VM_DONT_COPY flag does no=
t
> > allow for the most efficient copy method of the tree and so a bulk load=
ing
> > algorithm is used.
>=20
> You could track the #VM_DONT_COPY per mm and optimize? Do you have that
> planned or maybe it already is part of this patch set? :)
>=20
> >=20
> > Link: https://lkml.kernel.org/r/20220504010716.661115-16-Liam.Howlett@o=
racle.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/mm.h |  2 --
> >  kernel/fork.c      | 12 +++++++++---
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f22c6f71a18c..27fa36a7c093 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2612,8 +2612,6 @@ extern bool arch_has_descending_max_zone_pfns(voi=
d);
> >  /* nommu.c */
> >  extern atomic_long_t mmap_pages_allocated;
> >  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t)=
;
> > -/* mmap.c */
> > -void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
> > =20
> >  /* interval_tree.c */
> >  void vma_interval_tree_insert(struct vm_area_struct *node,
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 1840da0732f6..4ecca79556eb 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -583,9 +583,10 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >  	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
> >  	struct rb_node **rb_link, *rb_parent;
> >  	int retval;
> > -	unsigned long charge;
> > -	LIST_HEAD(uf);
> > +	unsigned long charge =3D 0;
>=20
> ^ why that change?

mas_for_each() may not be executed - according to the compiler.  We know
it will be but this makes the compiler happy.

>=20
> > +	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
> >  	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	LIST_HEAD(uf);
>=20
> ^ why that reshuffling?

I'll revert this.

>=20
> > =20
> >  	uprobe_start_dup_mmap();
> >  	if (mmap_write_lock_killable(oldmm)) {
> > @@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >  		goto out;
> > =20
> >  	prev =3D NULL;
> > -	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
> > +
> > +	retval =3D mas_expected_entries(&mas, oldmm->map_count);
> > +	if (retval)
> > +		goto out;
>=20
> mas_expected_entries is a fancy function :)
>=20
>=20
> > +
> > +	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
> >  		struct file *file;
> > =20
> >  		if (mpnt->vm_flags & VM_DONTCOPY) {
>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
> =
