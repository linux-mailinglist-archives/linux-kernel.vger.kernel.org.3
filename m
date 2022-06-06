Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B24053E703
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiFFQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbiFFQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:20:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A924C0B9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:20:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256FaVjC016446;
        Mon, 6 Jun 2022 16:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=llnUS6z9e4XNG0y7as5ChelwA/x4fLSFVF8DaBqUvpo=;
 b=vptnsXV7oxMje3sLn8iFLvgs+lnZjqTAZDIBUF6y2u2Wv+6VDKoIELfJvzHsuiLcuRBq
 qEi+T91f9u4Jwusda1NkxUl3Ggv3b8IYWan+CoItUw0UFReUCcrz7exqUrT3vgEXJPe2
 8zwLOTI2IizmtW/XgdP41PKWfwLCG1/mQriSibzP+dr4FmsSjyArxCAkta+D3b6/3MwO
 WRTGpoPOGwMkWsIME7s/kYzULpNsNvKDhcxj+dYL0W8xL3RVHB5Cq2B3tOBHE3othuEt
 kdiZ0uQ86JuNSAdaAAqjRjGcGV2V1Qa84g1yndVMPJw2aj2120il6bDhiQ8kloHdlp/m Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqkhwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 16:19:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256FtkfE010739;
        Mon, 6 Jun 2022 16:19:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu7tw66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 16:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwUEnf1JGr9tJy6xGyy0g0RY7GqsZ6dfPO1uvRGWOXBPn652sb4c6W+/6s+BRSFQBnjPrLToxhSwaeC264ma8OcB4BSxoUMOG/8ydYbA39yP5ELB9Gh4kD9P7lyDgVXFxsp7jf6JCg4hhyhaonzcig7F/Bifl1o6L5NqWEvU53cvBUcTqiTAul9Uw3GzVCfmji5zUrr3G7m2csrn/WpWp4tC+cTAtNpHPbE6CC7ps7yjIA3ojDM+4p4QsT2mmoSHs8uEPNEpkfmL+mK+F7fPkmj5mgmk4QQooRqR+A4Fv/UACyMZG836CRoF5RAwdebzmQDBljcDOCUFCNLGoTymgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llnUS6z9e4XNG0y7as5ChelwA/x4fLSFVF8DaBqUvpo=;
 b=dqXQrHmG15MNXzeugGKHCJN/ILgKlvuGHUjyx3FgbMDxMMQTPB7+dWDdjOYHULjQHRK6czvir/igtEmzD2EE8Ylwx1rDzQkgVDeF2alTP2oeEYJe6NXnJU+34ymFdPVRuM0k8dQUY9TgQn7n+XnN+FNhO4j0/ljO4R4PIrWhOZ3UByd0+cPbauIcodimYSnfG14vJeRtde2/RkQYWGxG+YCouJ9+8kYQuqSezwFsZcO0/MLmALKfVlziDBNKiswDtwHwhL5wD8YqL+B+oBAh0XICrjVEba2vCJLSWGuk9YgcLvwYcuPN34+xA8wJ1ka3c9j2oDRKgmIdBka3PwhO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llnUS6z9e4XNG0y7as5ChelwA/x4fLSFVF8DaBqUvpo=;
 b=rmnejeBAXpYaLmCkqTKEOALolJ/rVUWoJWoWtmkJvmqIDPatkmjJT95pq53+vQkRX7B/rbwxSnrqRsHUXYEThbPNKM49Ons49fau1CC7beWsAJRsTNbt01qC1ln6KP9fe0EjBF6+Q9E3a1pkYbXuldNTGvur2PkEoE/YU71ciJE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 16:19:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 16:19:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YA=
Date:   Mon, 6 Jun 2022 16:19:52 +0000
Message-ID: <20220606161940.fh5edq5nyz4jru2u@revolver>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-13-Liam.Howlett@oracle.com> <Yp3udPy0vuDK8khc@qian>
In-Reply-To: <Yp3udPy0vuDK8khc@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ae96b3-22ee-4e43-06a4-08da47d86314
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB46239DCC5AE84F27C216B6F9FDA29@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQP7+ezhjlZG9JQzfjci2c8a4uVGB7EEWW5uGbp/K/LpUBrlWOtvnxrrpBeeI92yJY87JqV3nuEdzThK2/6QTVpeJMOmRs2t7uuTDxBzIvjncsH+v7Qd91AwX4v5RUd+jA1oNXBBqxTzbWSB+fjviEFJfW62Z0mSFERC8vC+ZYyMiPsAvjK142eZ1Ip1cSpKRqg6pnpIYwM95sF/fJC7Rb8hNMfvZh/A/1VzS1xxY0rGT7gvzPLsQf3pm1hUQyqcL8LnELp9lAcDJw1zbafNrld03Qtt016MDzCyDq6WGiUlOYPvd6n61RzpZ5Iu1nKHHwa2W+f354MBGFLHgL6fIt5OK5kIqbt2rIpq12oVgsGdW0CTdcj3d606IjKPpx+7HusCXwNKZ+lRqLci9W/okb5Ol61/q3JgwVHnbDgwrsrvRpKA02LqgZPrm+/Z8Qps8Di7Mu4VLJMohRKzpkDxsgzlguWdIYgU1FGEoNfVGQsQI5SPczmdZRcFjXusBgecGwF/CZMj4jwwQl0Z+qXm7mCBw6xc7J3OA7JkQ9gXF2NWmhd1Z9XvArBOyYiBK22M7gcHFRmXaqwcq4w+wtZPaGhKBvbeGBFtl99qSIjOx3jdVUF2LAFfoGqtRrM4LFJVfV6P334eQtFaj61QeCqUS2WJouFuuU+YYj3pl8lE5DOlo5PfZjjct3zwDT9mgvDaziWCOoq+8OnY21OyhH/GwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(86362001)(122000001)(2906002)(33716001)(54906003)(66556008)(8676002)(64756008)(4326008)(66446008)(66476007)(76116006)(66946007)(6916009)(44832011)(5660300002)(71200400001)(8936002)(508600001)(91956017)(38100700002)(6486002)(6506007)(1076003)(186003)(83380400001)(6512007)(9686003)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yo7OWUyQXa5NUlNXz6Z0sR7znPCTIwWMIABNNGJT8H3cuzuDwIqXDIQjtU8K?=
 =?us-ascii?Q?KGrJF+xarV3cCcpLrDzS2OxmbJOKYp7nLwYjEyU815kJlWwELq3MYrTmXoyg?=
 =?us-ascii?Q?6x9hebBFhckBV4omPIwBoAcx+XdHQB65Y3P1UjI3E46lEVE6huVB4Nm1b3R6?=
 =?us-ascii?Q?HE5xJMtXHPvTKSNXJA1BKUR/Uqc9/UPP+tUH2M9JRq5Ne4+AekCEIX9PTBBp?=
 =?us-ascii?Q?71opY+bfdn5uQYzivLrd6UytEPaJFb480N3KBF8/4+sD8eHZ2Ri4oZH6rST2?=
 =?us-ascii?Q?wEV6Wnnk7Qlwc9Bq0kGu9NogBtiXbPQSnL/QKVSyYoFdb6fOburrWzivPe7I?=
 =?us-ascii?Q?H/hhYoh64mF3klAhP66UEEVAg7FkmlsY6omXbdteaTyUfmy4tbfOyRmiGw/Y?=
 =?us-ascii?Q?+NxHBb2pcUCDAWlJqfgcKjONIpoywTjZLEj/2NiuhucsLAy6xHkI3Kl4qEXg?=
 =?us-ascii?Q?mAp9q2MWerwKCKu5KeHo7b9Yu1k/UQHYOCa0mZFo0pFAeDMhB5yGodvFcH2l?=
 =?us-ascii?Q?hmMlGqX+H4XXvHIXhgsCaO5DhEs4nJISpXRfKqTD+t9vQm9uvaFQCz8TSrDd?=
 =?us-ascii?Q?0k3VkrAQYqsfnTPvqPnxREDYZ9bThcGPBLzt2d5DkRwJ0f0FRkd2M4yZR2+I?=
 =?us-ascii?Q?cuN/tiJNzL3uWrkA7gXE0w82b2IQNsmFGDYVGurrMyNZT+JdP8956vSGwZjB?=
 =?us-ascii?Q?4T5TuiCNFk0ib3PwbylgoK3xDnpA2CwTW2bfKSF6+wgCu4eqHYHuPupbFoB7?=
 =?us-ascii?Q?Y71kWryG6Jy2DXgWAlnz099VSoSQ3MzzhqMwiLvg4WSgJrTQZV1Kpqsg0e9r?=
 =?us-ascii?Q?tj5x50LOb4x1it3hPfJVhmjxFFf41/gY4xr3D/CppSe+pSeus+uvG5XYvBXT?=
 =?us-ascii?Q?vOGnmH5YSyqQJzSscmhqMMeANmBQP0Zq5TTo8woD1JB9082ELbV/wcQUzOkI?=
 =?us-ascii?Q?S16cbGEuNmqV05fTtKJlpSotBSVjUK1FjVaXNR3slddRvwP9y49tM//HINnA?=
 =?us-ascii?Q?dq/Vm45iI2tDAZ55GnzVv5EnGLa82b0TBNVgXjyMKvu7hbw5IpatINEoJupG?=
 =?us-ascii?Q?YBsuDDTRspAGVZK+kWOZMZFEjn1tSUpeiyrl3wCkUYHQf9DPhZMeBel/WW5I?=
 =?us-ascii?Q?oq9QKUxbX/5LJYLY/ee4z4sokDj85zSu5QR6qJ1aU0K/Pq0XKDRMzpdp5BMV?=
 =?us-ascii?Q?rEzfXwt+Yn+VdHNeNmRcYRKhav8Ez2qF9CZylhyqFZmd8SH7LIVZZpY0Svnf?=
 =?us-ascii?Q?P6Z7krRK+sRWBmBlznVbZtXLY3ZPQuHgYCVFyhHPJCJXBsp+Nt4NeIPmp1TI?=
 =?us-ascii?Q?P7qmWHEzvBKEW0TJdxOe1fm7Di3xfT9pEBZmqLt0I/0vDZET8Fg2WoEQF7Ry?=
 =?us-ascii?Q?FYs2ZE4REigNCc5Geu0sdT7nPk0dg/4b19ztJWx5VJ8ipzHYb6wlJOxTtAOj?=
 =?us-ascii?Q?k3WoWsdRpPTQxFtkGQLGqHETZXnZ6XlobcfPrIKy2Y4x7AtxVzD3RFolHnIk?=
 =?us-ascii?Q?KTQpNeN9nLRnvjChiXutF9vC1uBvRwT9AVV8vDtWplZTPFiUGERITunuCrDE?=
 =?us-ascii?Q?d2SOWx7iFJQOuH7pzTfjyJH/ow+eSyaXpci2Tz/FK42IQsK1XRTM4y6q4sXT?=
 =?us-ascii?Q?3NfSDAyB3t8tE50qs2xhxic6xRHJtsCAzcIVdBSFoInbCEp4VkmGGRWs3PlR?=
 =?us-ascii?Q?WgHGPLjsjwsii1KB5wQ8ZaW67Zx2swlaJIp8mkJ4CgHuvERZNuVN9U38tV3C?=
 =?us-ascii?Q?Rhn6G95bcmNcPYBU9EJtFM6dVmuJsqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41153573CAF6F844B5344927990F86CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ae96b3-22ee-4e43-06a4-08da47d86314
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 16:19:52.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oWV4OzvofFGl3LUaRmsFG2ftyfcPOnv7wyklonVX/vVhAms35GVtgbu9NLVa+SFKhnM2xh1KfR5XOrONbwlWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=645
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060071
X-Proofpoint-GUID: MB1WRbo9qEwh4XyVHC-JrQ2NaOpAR76W
X-Proofpoint-ORIG-GUID: MB1WRbo9qEwh4XyVHC-JrQ2NaOpAR76W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qian Cai <quic_qiancai@quicinc.com> [220606 08:09]:
> On Wed, May 04, 2022 at 01:13:53AM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
> > do_mas_align_munmap().
> >=20
> > do_munmap() is a wrapper to create a maple state for any callers that h=
ave
> > not been converted to the maple tree.
> >=20
> > do_mas_munmap() takes a maple state to mumap a range.  This is just a
> > small function which checks for error conditions and aligns the end of =
the
> > range.
> >=20
> > do_mas_align_munmap() uses the aligned range to mumap a range.
> > do_mas_align_munmap() starts with the first VMA in the range, then find=
s
> > the last VMA in the range.  Both start and end are split if necessary.
> > Then the VMAs are removed from the linked list and the mm mlock count i=
s
> > updated at the same time.  Followed by a single tree operation of
> > overwriting the area in with a NULL.  Finally, the detached list is
> > unmapped and freed.
> >=20
> > By reorganizing the munmap calls as outlined, it is now possible to avo=
id
> > extra work of aligning pre-aligned callers which are known to be safe,
> > avoid extra VMA lookups or tree walks for modifications.
> >=20
> > detach_vmas_to_be_unmapped() is no longer used, so drop this code.
> >=20
> > vm_brk_flags() can just call the do_mas_munmap() as it checks for
> > intersecting VMAs directly.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ...

..
> Running a syscall fuzzer for a while could trigger those.

Thanks.

>=20
>  WARNING: CPU: 95 PID: 1329067 at mm/slub.c:3643 kmem_cache_free_bulk
>  CPU: 95 PID: 1329067 Comm: trinity-c32 Not tainted 5.18.0-next-20220603 =
#137
>  pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : kmem_cache_free_bulk
>  lr : mt_destroy_walk
>  sp : ffff80005ed66bf0


Does your syscall fuzzer create a reproducer?  This looks like arm64
and says 5.18.0-next-20220603 again.  Was this bisected to the patch
above?

Regards,
Liam
