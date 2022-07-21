Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3257D424
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGUTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:30:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1E18E3F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:30:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJG0J0026588;
        Thu, 21 Jul 2022 19:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=65o5excUNPYlKlBju2MXajspLyZ904om0JV1gL4f5Z0=;
 b=KUinpAA/v++/BrKvNjA3iXMudpPMEmejJA3WjfEEe66kX3i0Xlrzxuhf8IMMU7Zv+ZPY
 8OTzW1hBOa33QgWDJ7fIZl+kcOVgZO6+OhldmH99y5w8Tb72k6gS4l4iM13THFTyVogz
 MLhaoZl1HmhyCVMHgDn7x8HA3CS3YFcQ4FgGo2gh1dNXKwse9ndVSnRANMJowIOQIdaC
 DUwqZ33+2FVTu2f1x2wymqu3HQD8ekdPlcUa8qRKbxy5JlLSAB1ReGR69S3+ak8A5KVv
 mfBRLW2oux9NCNRiMqOULx/9ykWA0ow/QcqTA3xmA/Dsq0xTZNkjX+a0ymj3zrVSJrgR 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7ad9k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 19:30:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHaCWV039255;
        Thu, 21 Jul 2022 19:30:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k744hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 19:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+kzP7TlPyBICLiC5Dx2umFJOo2LqZ+Yyy4MBTEho6l2a5AANAMSuIYa7W62U1QxxhAOZgV+iSF6gqt8gxprmInPYhsKQlNqsGFe7+Xlt59IQFNJ9edUfgXUuF1nurp53tKE+sqZy08b1+15pISagoQX0Pk80/sJtFGhWarCDYEx4aiIdolt82xd0GE9l7ftpJ/FgPqxYlIP0EG7fnjl8EtAfjIwSlzmpX8fjGeLNIzBUCeHGuth00Q5Mn4FKW8YkpbSjboklLajRW8MrJyeFQ/kDzEJNerbpuZrX0QQf0TWcDPfWC+iid1tHJT1dmhim6VOd7mi6jNa5NgHGIkj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65o5excUNPYlKlBju2MXajspLyZ904om0JV1gL4f5Z0=;
 b=HVEVBjX3O0dqWyjl/d60x6gTcX+IivwTU6I/pjZmyLJjkfRqHVD+s38o51nLI3o1OUNYa/iKONPmluPfqCQySN3qSXVEM52OfS730ZX+xM/sfYHwKsAimmZcz2EgwuG/G+AWOm5B7ZHjY6SPT49fh8sjiL2wiPthphh3Os1PFlXQYobfX/qrAFJu2ffYXOwMZ2pNSvWuBRFpwAQpiczjSVz+Ipykig9y3q8k/Cm4NPv0EoYAYnvkLybgEa/wBXr23PpAap6P/3b91JRCyZp7KT8+Ds9pZbPKt8Grd96xruKdbrDcVQnX/H1Gc3QPXHC3jhWzRNQQWS76mOqA/ITDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65o5excUNPYlKlBju2MXajspLyZ904om0JV1gL4f5Z0=;
 b=j2tsI+kS1rPcFYGPsFI9vg1M26taI91HmDyH+ctY7rmQgT7SxCbeKM4JX4ILOwV3AcFeQImUUbiWvaZnjx2ycR7pwqaFZ/7YJ2XUOjGiq/TIqwyLg1qehyEaPyPrlT0SqEa6w2oUBFksWbDn+8Lh6t976w5YbJaF/epEW4Ir3f8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 19:30:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 19:30:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] maple_tree: Do not inline write slow path
Thread-Topic: [PATCH] maple_tree: Do not inline write slow path
Thread-Index: AQHYnJw6aOsbtqNHaEaswARV7Qt6zq2IfbZwgAC5ooA=
Date:   Thu, 21 Jul 2022 19:30:13 +0000
Message-ID: <20220721193007.cmpdocvvmox6gktf@revolver>
References: <20220721005237.377987-1-Liam.Howlett@oracle.com>
 <040322fa455941ff9b82ebb0f53a576a@AcuMS.aculab.com>
In-Reply-To: <040322fa455941ff9b82ebb0f53a576a@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a59748df-4499-481d-4a37-08da6b4f6f17
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5iGMuhb2FiQzR20J9zCR7SLjpk2JJ2BRi8Jjx+L7tIMDCGY7kos21btchqz6dTmrQztzUxf7zE1sEv9+QMfZZQZRYd7WNXteA1nBJ+ivlNXEB4SVORkrPoE5/arC39VxjYtWxvB/2rsOUnvPCEv6Hz+r6Rzvv0XxiWlTk4kDG9F7pbeqDPE316JCT7NdrocJAC5anyjpNOSD9i6DYf8W/a1AKU+zqQmYVd82hbj96GpmKl5ZdjzhkZBaUv5cqcVz3wHAXlNxr/dNd3njCGScHBXAd8tooiwi+e0YjhMEmqRTKd1k53jWJpd0m0JV4GrcX+I4A5IKWmGlHt4W4xiR31b4w+mHVKFqWtESqxjo75abIwCy3cS/k/nKb7ZF/dl+boA2x8R+x8v6IoW6au7h6dIJ9yfsy0TsKHfHbRD9821vwVOR2QaXRTRQwPmYgKA48xAnSrv+QU+E3qhaCNouXaykRDRkR3mS0dT5FK8KUrszFbobJGIK4n0k95WbLHfwwYkiY6lEJNaKjgyx9gUUIS6FSb10hD71TL1ymK1co2KziU7/9JEQYtaX2TVcmqh8SLC1jHMNOfR8CwTUq3PWkQZGCx+3kb8TD+OY5WSNgfUdZ7E2mUq5EZRb4Emo8kloeTdtYJw8enAB10Mb9hmlHqgEO+MGhb1KUB7pIu+uBNNb1DuBmggJX3PzuymA4xIv08l6PMSa8iBhvqxfRLCQCNqK4gR/9+ULvhApwaT1+yicqJVwOszSseGSXbupoKDyzozZqsmpC2mcxh5A9PoQnT/yNTkAJ1sWA6FXNrpqOA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(9686003)(8936002)(6512007)(66476007)(6486002)(5660300002)(26005)(478600001)(44832011)(186003)(86362001)(41300700001)(2906002)(66556008)(122000001)(83380400001)(316002)(91956017)(76116006)(1076003)(6916009)(38070700005)(64756008)(38100700002)(6506007)(8676002)(54906003)(33716001)(71200400001)(66946007)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SRl84gZAy+jdMQzmBjyTK0g/d/2e5i24V9zylZMPrUt9GnNKL06IuiXGDabD?=
 =?us-ascii?Q?RLqbQGFd5oDVGRvyNlO7BqiI/LFofI2roti9uNacRwVDSScudXqzhFtev7/s?=
 =?us-ascii?Q?5eJuWeTx4hRNRx8VyuoBTFkB43LBy3mIRhyHBGhH+vXrSEkh/NwdTfcrOeD5?=
 =?us-ascii?Q?GBEolFbUmOfBhpzoLSCNDXweItwEryvUdUVbMIFReMClc4HElhRFVEVsDwaG?=
 =?us-ascii?Q?FVveBSQ+QBIw96ZlhCmK11+/WHJKfuk2jQlMsVP/vgC3ig5boDombTT+FRtV?=
 =?us-ascii?Q?dtsPAc2sqCik790F7cUz0xOnqFSDgp8d8L6ZiNSf4VSdsO77O1MpwsVB3ZbW?=
 =?us-ascii?Q?ao3C9UqzcorJnJ2ZIDoopgww6e3zirHWMjJk9ROsugca41L/q7pYUyX8p0P2?=
 =?us-ascii?Q?0e5goWcyTuoMJzNsGR2EOpN9ovyLc9A6ONLCO+pZNfjyMTT7+GoTARBjS2kX?=
 =?us-ascii?Q?ZsrFnoT0lQ7it3O58hfWTrlFr2X9zNQQ+kuDGFlkSQHRd7ovxWkGr6KlnXHc?=
 =?us-ascii?Q?LJGE6KfXd5aSP68325f970oJ4JfRJP8uI0S12v6vpLL92P1hDHywHwc8m1ua?=
 =?us-ascii?Q?cvSJ3noayXTrl8hEJk8mC22PY188O3XbIW0Vy2Qvg1usCzeNknIAjPnPDbal?=
 =?us-ascii?Q?ISoZnMKf00Q+ev1O34WWx+lSw7U/arDji31wTN++WaO2pALCw38o8Ih9zhjz?=
 =?us-ascii?Q?fPfSmSLZfFkktmkNffseC70y3ACOio9TjqmJzX8LHhW202A125ksJLqeShiY?=
 =?us-ascii?Q?8IGJbJga+5jjjVxa2Ra3tUJLji+PaA/gheCydyuXttTWEa/F5zsILnJzTqpB?=
 =?us-ascii?Q?4XAMKO4OsnUl7E4VD1cMKOCgFbuvbc9bX2hArWadel4RkyaIF5a3aeAKHMC3?=
 =?us-ascii?Q?EYUZddJLAAUEIWyL3PmbknOFuCPd4lYIhdsGL0o+ynH5daOwN2OVCeElIC6b?=
 =?us-ascii?Q?nyxek9JUEecm5FIEKTB1mKR2yKfO6QkPbihfH9VvzxK+B6dpYP2Yjzr/4jHa?=
 =?us-ascii?Q?96QFMcPd4GDw/J869BsGgS0aa+tkCMnJg9wBjMriJ7thPMdw02Zi7vw3q6nU?=
 =?us-ascii?Q?bvy9TsyaqUarLNLFWQ9g9rEflvqjY0fAH+/ianCG2GfsZ6ZfoYPD4TuNcfO4?=
 =?us-ascii?Q?o6P56VHQQFoEcYkk46fVFmzTBVwCcYDI6Ib/Cc84j3SOMgyQ58zznOumfb9k?=
 =?us-ascii?Q?cHKjvwEMkKYe3xwxTfqmYuvYjVtWT8SXGfx149qu7LhTtTm3ju/SlWJkKt+9?=
 =?us-ascii?Q?m9mgNddcZ61UwgMINp90+FiNnggizgY/D0TWWsta1CM+KegnnDO5WK8sLicz?=
 =?us-ascii?Q?6jq7qKjaWQcMlO6y+N5Y8CaoAhK+cIfD577v0bgNdryAQXWnsyv3NPJEoIne?=
 =?us-ascii?Q?IwP/K5JezzfR/rVQSYhlAgofXkiiSJz6xZAkcd61Z6HMjCVi+FRo8c+nAERX?=
 =?us-ascii?Q?7kLJ1HFdauOjHkM4ZemuFE5Lb2k4BNBHAIWBovRKQdjNX4gv4Eip+nGVJq6d?=
 =?us-ascii?Q?VNkKRhwPY5UltJxBiPbJ5tTDk2TfbsMs2bS5rbtQjXDxd9R42dJV1jVqxzEG?=
 =?us-ascii?Q?+TVOWsVWwj1n5rCEk/HYN4BCeXZbw1T4ENthHntWNvnnzAF8rtgEWqTCFMHq?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <366B607AFBAF5040B8C10D3BFC9354EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59748df-4499-481d-4a37-08da6b4f6f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 19:30:13.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24QfTjq7a0akUy5g93oRwdA3Pr1LJa5VAyOKLOiEZkdgh7NMGeeh+6dTkyVMwgvPibzUSLrF6978T3hNHGoP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_26,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210078
X-Proofpoint-ORIG-GUID: qaz4LXiiAOGnd1nP23iOXkJQh0U7N8Gr
X-Proofpoint-GUID: qaz4LXiiAOGnd1nP23iOXkJQh0U7N8Gr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Laight <David.Laight@ACULAB.COM> [220721 04:26]:
> From: Liam Howlett
> > Sent: 21 July 2022 01:53
> >=20
> > Having the slow path inlined causes too much stack usage.  Create new
> > function mas_wr_bnode() to write a big node into the tree
>=20
> Unless you mark the function 'noinline' the compiler is
> likely to inline it anyway.
>=20
> 	David

Thanks for looking at this.

On my testing, removing the inline allowed the compiler to stop
complaining about the stack frame size.  I don't mind if it is inlined,
but I don't want to force it to be inlined.  I'd like to let the
compiler decide if it does the right thing.

Thanks,
Liam

>=20
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  lib/maple_tree.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 95d8659c5a99..4c383c780162 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4297,12 +4297,27 @@ static inline bool mas_wr_append(struct ma_wr_s=
tate *wr_mas)
> >  	return false;
> >  }
> >=20
> > +/*
> > + * mas_wr_bnode() - Slow path for a modification.
> > + * @wr_mas: The write maple state
> > + *
> > + * This is where split, rebalance end up.
> > + */
> > +static void mas_wr_bnode(struct ma_wr_state *wr_mas)
> > +{
> > +	struct maple_big_node b_node;
> > +
> > +	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
> > +	memset(&b_node, 0, sizeof(struct maple_big_node));
> > +	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
> > +	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
> > +}
> > +
> >  static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
> >  {
> >  	unsigned char node_slots;
> >  	unsigned char node_size;
> >  	struct ma_state *mas =3D wr_mas->mas;
> > -	struct maple_big_node b_node;
> >=20
> >  	/* Direct replacement */
> >  	if (wr_mas->r_min =3D=3D mas->index && wr_mas->r_max =3D=3D mas->last=
) {
> > @@ -4338,10 +4353,7 @@ static inline void mas_wr_modify(struct ma_wr_st=
ate *wr_mas)
> >  		return;
> >=20
> >  slow_path:
> > -	memset(&b_node, 0, sizeof(struct maple_big_node));
> > -	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
> > -	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> > -	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
> > +	mas_wr_bnode(wr_mas);
> >  }
> >=20
> >  /*
> > --
> > 2.35.1
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
> =
