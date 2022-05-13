Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C15263BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353149AbiEMORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242869AbiEMORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:17:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B81207CC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:17:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DCdIa1024462;
        Fri, 13 May 2022 14:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R1keVxxAx5P4CI37k6fg5lBCI5B93IopElOJoQSJSck=;
 b=xV3VMBxKaiVz1FD6xVMstc6t98sZE/LBbJ0ZjVBMcmL/wzMx/cizaN2ZhgR41Y7Rc8rs
 FyE+V2A2ld7FwKVxIF0DTIyHSXiNLOTEOzuxHNzlJtmQsba3sO7akF8xhlOBOqciXEJ5
 NDvzTnajK7w4TuJZMIwe9OuWGJzVIS1OpiEreqXD7xZb2Y8X8h9JGc286Or1o2QoGbd2
 g+8C+5gJtHudaXYA9ZHu1aWXSQB9ED93cqdVKFcblUjTvtDtbcWOJSEGlrYTjxVQoo5q
 /uaqEzcv9jE6NEYWIm3QE+KLcDHZgXejFyqNyWhT2K02aR9tW/Pf3gwXSxPiIKEMOj+D +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0yk44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:17:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DE6gQO015776;
        Fri, 13 May 2022 14:17:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf76f6fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INvCSge97NkXzU8n6IpyR/AKjw76iq1AsDHavYYBPsxdrT15OllxAIjeYpWD2zrNV3p6SsJQEQMZ27HaRo3tZH9oqj6SVJc0xGnlbyanLBf0RZJdi1wxiJoZE/uAdwlYtyzaD2CiMGoM5o0SsmHZ4HOlAdjHCZVjMY4I3OssjIHXM4xH+0mBOng7n3LdFfSiFjn4SggukTbrvsIJDDigzHvyaZVXLndydEx1KuWO+sBbYptfy5HrrTpC/2BddAExR3YFcDR0ZGExdH2by0Q/8qjAH6x7I50BE92mzLc2/z0hIdeYyUzHQ9h3uPb/Z8EkYSL2Fhh/LVuOo+weaRkU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1keVxxAx5P4CI37k6fg5lBCI5B93IopElOJoQSJSck=;
 b=JaS5kI7BqORe88vEP7M6hnMPHseYFkZBJeUrgafW3VaLTUjo4risWIM/+AqKofahhm6EZBAFSanaV0ACzYfRS/sxNt1Bs3x027LUIUbM4iwJTNLgqOgbfFOfhh9bnSv6+aTceXH9ckhzdZsulJApKKsm5GOPB+Lghp9VCM8zaGgIRxeyITBRTKB+3u2lHhKNfjW+VFYFv5njaOhjeCQo/dc5JPznQgLU+fX2vD4YO6LeFQti4mOA1wiqdrV+Mb8wvH60zhUU6gGCnHgqcPhoKlHbyD51Mk46wfZsc7hx2Huj33F8oKtjmtxMh73IsLk/AXJy1iInfV7YBd6oZAzm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1keVxxAx5P4CI37k6fg5lBCI5B93IopElOJoQSJSck=;
 b=lMbGqnamTswW5X6ZCxRAJy98KO3cOsLRClAFZkp17NxcCj81H1fBdZmJ+YOW8wF0FQjoCsxf6pQ88ZvlFCJTo5hsww2uqnDfNO/UtMbx/GnXRnlZZ9DymxXxsUixNwBXYtPJ5iC5lbgFxeG1FVk8Xy9YLhNkax88Jb5Gi8S4EeQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 14:17:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.025; Fri, 13 May 2022
 14:17:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 67/69] mm: remove the vma linked list
Thread-Topic: [PATCH v9 67/69] mm: remove the vma linked list
Thread-Index: AQHYX1RAzsqg1aBYqkCXJCPO8HO1i60c3IgAgAANHoA=
Date:   Fri, 13 May 2022 14:17:21 +0000
Message-ID: <20220513141719.olyx6epuwoxggqmw@revolver>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-52-Liam.Howlett@oracle.com>
 <20220513133022.GA482@qian>
In-Reply-To: <20220513133022.GA482@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb72639b-7e48-4848-d1b0-08da34eb4ba2
x-ms-traffictypediagnostic: CO1PR10MB4451:EE_
x-microsoft-antispam-prvs: <CO1PR10MB445154461A1A545E5E97DBF8FDCA9@CO1PR10MB4451.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7fxbTqntpcf2+nF03qJlAdBXGoXhse/mfms9nHY7U6njBXysN+K8zmECwK4PJ0ETSAYnA7ILy3pDyJOImEtdFM7ZDLvnSUyvE9dixKomPKrHysCn8jppYfWoPCZO3yrDlfFnlaxyPPzHNT5Oo4app3vRATCNlHswHCpMVpbYEswN43GMJu4GH4E36leeTRbvQsh/cox8shK/ImhoaGMR/AV71IlyCZPnF3oVoXpodTrKACcwQ5GpYP2I84LccfGumCTZyemuvKVDGfxqiTo12zrTNaH1StYNbdANyseI2ukyiNmJbDT7LaJV77f0d5je0hPgGfNriZdyQtkKagFVHpbAx60Rdfmiyuxt7ddKVAUYVxwFW9c82V+tX7oZX55tY7oF0toYDzGJ1bty5I6GLjQxmfk8kbF035TD+fstYeAo7bXOSecM3KYi6erSY08wEYiLEN1bccukmS+s227s1yvDvq1eMK6h2xhQ/QrxMVozE3RFfZpb7zmmHdJtOqTgq7L2hQaNaDJccICGyfLeRUIi9QnzTGoR3UmU0Z+Uo6ofuIWSs5UFjZPzMdrR/JTSnUB9Bnalm9I/k6R+lCFW81jxQzo0CnIqB1eSscBL3eamci7JR2HdFkIvklu0M+6RLPu7/w+A0o+WBgNqrxQTn6t7pUDg5TYSKibh1hLoHtNuo3RTOWh73u3jZqyFPcvPMjL9TnYJv5U7pMBnHpyWu3l7MzcseNn7yWuwbNiQ26gXOGfzHGEintigv7RWFol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(38100700002)(186003)(38070700005)(2906002)(33716001)(122000001)(54906003)(6916009)(66946007)(8676002)(4326008)(9686003)(6512007)(66476007)(64756008)(66556008)(44832011)(26005)(76116006)(6506007)(5660300002)(508600001)(86362001)(8936002)(71200400001)(1076003)(83380400001)(6486002)(91956017)(66446008)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0LDumTDhjJfg3eAsUeBENfC+Bc5KpyV9stXJn8iKJFzKvPmoVXS6R49eJZkE?=
 =?us-ascii?Q?TvFkf47U+tdGNspjlmbhufes5ZaeUVfTlbouL+qi6FGhWQrqUy+ROkmgixfl?=
 =?us-ascii?Q?t40o9IOa5fcmMC7ZzntkKmKe3vVOs23BbmzxODFY5L+yQfFiNXtIB4LJgUP2?=
 =?us-ascii?Q?0xWi41R8eWmlEAi54DwgcNJrd6G2N4cQmtITlt3OQM3qdQBZYCN7em+v/9xR?=
 =?us-ascii?Q?3BluzIe8S2w+Ogl/+ppNiwKFpOPuf9TNF4UWchbyPC62U2hILuyujqsoP5Bn?=
 =?us-ascii?Q?fvSj2cgRxM8uoPYEX8H0vQWGD1X0IsA4L4OsYrgFasPBEMGW6FeYeEeryVIi?=
 =?us-ascii?Q?zpdi/uwpoOj33upn9+0DqaRgSsAcqlO37hcZOXm1IMykgNYe9DhH+Y+/vtkW?=
 =?us-ascii?Q?200A878niVmFmH74DlzcXpDeNksrmgf8AVFKXyiZ8UTIDOJVdINeGTlXyfbz?=
 =?us-ascii?Q?Qa4niFSevSPL08J425KCIxri77yeGTSaOf0UaSXTHsXXGSgz66VVPKjRE7+V?=
 =?us-ascii?Q?ofJ54j7WH7rOnGbLFNrn5TuubcfJD3suIdQahjldbwsurEb2nLmgG3ldpKZl?=
 =?us-ascii?Q?1nM2pOb8pU5paZ+ocmFZjDota+rZB7pqvEZXi6R5CNc0Iji3mdmz8S9S9Xkj?=
 =?us-ascii?Q?knCdNIbriYD7yVDR2U0ArW52Gc34RMeyUcl+icVZIuwkbtnLQSIX9690BrpM?=
 =?us-ascii?Q?6jF/iU3JJsTIKIm0IcZSDBdnlyXe5uBIfxLbDe8b3POHo5CQ/9l4ICyBhmX4?=
 =?us-ascii?Q?67XIlwrnMzirL+0mZGo+y3imSY/yBgD9xe72M3q+yS0XfhbBu7zb0QFpoa2P?=
 =?us-ascii?Q?R1JrpGV8eG1ipJ+IiTlojTxXAzifJEjQeMFG2z4nowQUd8ZnXO1BpmSfEWo9?=
 =?us-ascii?Q?5TiPQusoINwoK7Oop+OQpw8tzOVoakRGgWunvgFKDzEzGqZ7XIfvG6mqIGS7?=
 =?us-ascii?Q?gXvaOBAnCDjQWIJVSDpEc5J8xPfV7v57AO5ebU0J0BvpD3GJGpgOcnop5B0V?=
 =?us-ascii?Q?51vNzLh4cB9Etn/Ck03WvAUhxDZ5Q2XHDVVCn0wv1Zgp2L0Cu42oinh2D53y?=
 =?us-ascii?Q?de09sJ/r4ZtVcsw9da8614ePn7fNWIZGmOkbTSGCYKgNedu1cQzbr/ngzACN?=
 =?us-ascii?Q?TqtCzNIpy1Mw2XM+6Um0zuQvWAHs/snfnmh21JoxTtb/maP9mA86aMFqL8Vo?=
 =?us-ascii?Q?ZedBPT9TLAHkzZIO8R2WVfTPoAZkZBXEybg7kQxlIMhFMjnZ8tRiqY5Y/PR1?=
 =?us-ascii?Q?veZZRzOUuPRm4WX5tYLxQmq4Qm4M1yVuqfTUesm0x0rMcRlbI1rXceb5I6m3?=
 =?us-ascii?Q?I1gJG98jTOL6LXGrk1rsRwy0X524Ti7Ge5Enjco9uAaEAlopKN6S5iYyQcYp?=
 =?us-ascii?Q?wTVISfEipdGEYbcEkOuUVuHzI7l4oqj0+fdfWfxwFlr6QegJuZWjlAihQ2CM?=
 =?us-ascii?Q?vbacTdQMIqMVJBvmduXQ4Luo2wOMNdzKeF/t4XY+G1XLYg7wPWEo+Rq+SPfA?=
 =?us-ascii?Q?XT54cSTMWuyRKljrmmVRZSUISNzbBcjpqSQECDHDzMgRrLlNa7Mvp2eG/Kvn?=
 =?us-ascii?Q?iVqLc6GPVrQMa0Mo5eDqdxHj3oKkB7qu9vftSKG7OTiJ2a3Voix0uJ99Fr3b?=
 =?us-ascii?Q?XSH8XPAOPBCQDwBysf/LdKA0nAUb/wHsijfeoGWLBqjw6cLNEcSKO0xbX3/N?=
 =?us-ascii?Q?GX2gnD9IuZoQabqGyVsIfNrahkDtMdYS9NxNl8HIdwbSx2Gj3CXqaovNZ0fi?=
 =?us-ascii?Q?UQ9d0EGYFg2aiWVC5o9Txgm82oS1GqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B315BA54BCBE5F41AADF1C7B4FC8F31D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb72639b-7e48-4848-d1b0-08da34eb4ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:17:21.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDX5rrrlwQh4Y/71HKnZHSDgQpHuMdiJUPnXMoyR6l3kmPHq2Gar6amGo6StkvqP+7nhjznv1K21LkUu4vLD3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_04:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130061
X-Proofpoint-ORIG-GUID: naM1o0MM-sGjV1-27Leo4aoVKcqnsCnW
X-Proofpoint-GUID: naM1o0MM-sGjV1-27Leo4aoVKcqnsCnW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qian Cai <quic_qiancai@quicinc.com> [220513 09:30]:
> On Wed, May 04, 2022 at 01:14:07AM +0000, Liam Howlett wrote:
> ...
> > @@ -2488,13 +2380,20 @@ do_mas_align_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
> >  		    struct mm_struct *mm, unsigned long start,
> >  		    unsigned long end, struct list_head *uf, bool downgrade)
> >  {
> > -	struct vm_area_struct *prev, *last;
> > +	struct vm_area_struct *prev, *next =3D NULL;
> > +	struct maple_tree mt_detach;
> > +	int count =3D 0;
> >  	int error =3D -ENOMEM;
> > -	/* we have start < vma->vm_end  */
> > +	MA_STATE(mas_detach, &mt_detach, start, end - 1);
> > +	mt_init_flags(&mt_detach, MM_MT_FLAGS);
> > +	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
> > =20
> >  	if (mas_preallocate(mas, vma, GFP_KERNEL))
> >  		return -ENOMEM;
> > =20
> > +	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))
>=20
> This guy was reported as leaks as well.
>=20
> unreferenced object 0xffff0802d49b5500 (size 256):
>   comm "trinity-c22", pid 107245, jiffies 4295674711 (age 816.980s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>      kmem_cache_alloc
>      mas_alloc_nodes
>      mas_preallocate
>      do_mas_align_munmap.constprop.0
>      do_mas_align_munmap at mm/mmap.c:2384
>      do_mas_munmap
>      __vm_munmap
>      __arm64_sys_munmap
>      invoke_syscall
>      el0_svc_common.constprop.0
>      do_el0_svc
>      el0_svc
>      el0t_64_sync_handler
>      el0t_64_sync


Thanks.  I have not seen this myself but there certainly is a potential
for a leak here when the task runs out of memory in the middle of a
munmap operation.  I've sent you and Andrew a fix.

Cheers,
Liam=
