Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60FC513F97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352638AbiD2Amk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiD2Amh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D19BB09E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:39:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SMSCfQ003733;
        Fri, 29 Apr 2022 00:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tc5gDCbckwYTgZdq09ETcosK6B7HLuqSx+zfCmp2WGo=;
 b=nNfGPhepXKu9ldyCe71JCVikBeEBu9Q2uQu3hrOXuMgAI+skT5515iqDpXCqGNs9q9dK
 pkJ8Nd5EDx7OmPJlMsYG19En/Qn+xY4H5kfBoE7Clrgh912mPefCX9efVMqZGlpow8rB
 CDFtreOO6b2JMYI6kztO/gx+YTZXYst+Q8iGjF+Xy4iEGGeyvKZ6FU6J6tJ8ldAsXGQz
 Y8LucscRofgFY9RkJtzPREzUlgabyOl/YlRwyfbvuzl177x/kLaXBmDNPLEhdIaCO4PA
 uCbdqC2DYRG7vyl7mLWLDmklA7A9CFyy/JfRdLs1QrIMKtzMI3G/tjzeXq8rRYR1V5Sf QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4w1tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 00:38:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23T0KPIu009436;
        Fri, 29 Apr 2022 00:38:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w7dy33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 00:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxSTcxLACgDNsktPCyEtqp0c8KHpBniWBtdLBiJLr7rDRnLL8SBUFtg1OcqRkcEFaqvz0WwjRMugvFpQVyzCS95/IeeL/E8gyJ83fUt5/veaMdPdO/LVm+G2TR6+1G3YsZUUkwZ5oleCQ9/ITQYN8Z6NmIBSaWfBshbKLxaE5TjLOosvk7y2onJOP1e1CDvc2iJKcCSdWk07ESxdnsW6A91hr31Jxd2BXoMhHDdAATSmNcFFTTMynPW6WlSmwsF4cRyfTNbXUtsKYUaXt1Uf+GmqbxnRSXwJsRVDyE9Lfz9ts6SgKqKgSSxOPwuIHtx7GKMh/6zCzgIAwUb7VO2h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc5gDCbckwYTgZdq09ETcosK6B7HLuqSx+zfCmp2WGo=;
 b=Rtk0jCXQMNQu6ta/+9rWZ7gq295iFto8WhCipUrJ2ZNF6KXfQatZBojaFvck+0AvUVseKuyf/XZ5ZAGQO+oCqYWzbw9Uew5xfOY7SRzkTZnp4vWcvtgHbY5Vv+ZZrV55E9KjOOyxGLU1ss/eO2dTq+lyh+6bzUO1AcwtRP6PjIT4yYd7UkuC0FkgukB007Z3I7VX4elCbB2gq73YESp/N4aipFYMGNL50FCkwig6N6ibOKGFtJNWa9aDL96IemRqW7VGC5T0YPuykmrKGBswyljIFFEdfO6rWBUadTDoLLqMHhElhZyoXURvORwugwAEHDEsJVotMPsstkPqVsP2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc5gDCbckwYTgZdq09ETcosK6B7HLuqSx+zfCmp2WGo=;
 b=XEeES353iUtfXRjwKjT+7eUZPxUyppVMBSZL/Y6D6mBa7I6UJv81W/zkXJR9jake5eYv3m7WwNXteoB3pXIL0umC9jJtAg026GgmtroGEESPraSf2ZyPKPv1J8+y/Cg89VNC7/rdyozbTmHq4LZ6g6QlP7XfYeJr88sEaHS8Vfk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5282.namprd10.prod.outlook.com (2603:10b6:208:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 00:38:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.023; Fri, 29 Apr 2022
 00:38:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6Va0Fx52AgABIVoA=
Date:   Fri, 29 Apr 2022 00:38:50 +0000
Message-ID: <20220429003841.cx7uenepca22qbdl@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
In-Reply-To: <20220428201947.GA1912192@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 968c221f-a69a-4940-ea0d-08da2978a145
x-ms-traffictypediagnostic: BLAPR10MB5282:EE_
x-microsoft-antispam-prvs: <BLAPR10MB528203100A13D38865A40473FDFC9@BLAPR10MB5282.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJnwbKsDHrHmsc4/73ZtWy0ZFRNaBtu9nqhSeXpfwqCJ9UfJWU9CRlm9zd5SKkh650krn+RcooVLrGsXYKQiU5TmbMutlCtp2yDvCfQ3gRPSIEECr3i/BkQpA4mBSDPg0lVOmV3r6bmxa9bPRneqQ6cyfX4wyuU6YVvmf2sW4jDArZE2RiXBJzmLadnJhJuh0p907lFUz8Z9HONUQ9gwNn552Upcs4ozo3wCORr3kQmedgWAQseekpa9rX7XeP+PyiGmA27ifQM0MckG8AVSABxzy8s2w/8bIpiVzRv1R1mMGV7NFaqBeytWbQ8ilnbpPNkfT2vOc0X4UP2o1fhEMsrn7Q8iip0QReiEJFZXswZpe9o5YasGY0SEWEBkdeIZBggbsjRoeruH5ge2UmIbEScluPefcoaZMgyo0BP888MAVEIk5XBdyf8wEk47bF9Xtiokqse/RIC8APAvKwLRK5lf7EZsUMQpVnGcR0VpUtAQW9QXhDf6krwGAAgSTVQXuQjHMmWnS3k0ftZwmolN8sW9erStFmIPrfnblGlKeczF4Iacig6/H6IwMvWKsESwAgbhllxjaOO5lY6B6FQnC3yeNknhWs+KiOyv7cvrem1OQoB+Ib71yjpdsPWLGtYRVJ+Dn66DmvERdmVSkrOPDyIUyZmEleK6RKsnn0meLa37acDkBIGhsPC600Fcm+5bBSNvcxczG5hS+OUCie/5hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(508600001)(71200400001)(86362001)(9686003)(6512007)(1076003)(26005)(6506007)(122000001)(38100700002)(38070700005)(66476007)(316002)(91956017)(44832011)(76116006)(33716001)(2906002)(186003)(66946007)(66556008)(5660300002)(8936002)(54906003)(4326008)(6916009)(83380400001)(64756008)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQhzeuF4Diz92djD6tHEONa5SH+doKejMTq5gfCHFpJ+YKINShSzbsu3jac9?=
 =?us-ascii?Q?CMstqP154MKiygRpGlblFbyyZRDOuLbNwSQE1UEW3LjWdl9+4Aip/pIzIsT7?=
 =?us-ascii?Q?xrniejSgRqsTSgXmNtdSmbjqNx8CC4wrAdql76QgD5AMZxXJjH3iSl8qM+l1?=
 =?us-ascii?Q?vlbe71t6lJgoY3a0Rkq8GbO4vXaBs3LKvfP9YAJt6XCltU1k3zvzGIWv2tx/?=
 =?us-ascii?Q?/hmn5MiniPooNEiWke1WDiyHLNr+ZBvHOoD7qUl18/9/J504vnH7+KP08rM8?=
 =?us-ascii?Q?wwL93wwe+ljgyEvx64kEXeCURgjfk+izyea7uhSSGSPu5KgSR76WpHMDFD2R?=
 =?us-ascii?Q?XwbjjZKn4GCv9iTPZbDbInAfV4LuBntUgzyKwtTsLKHhuzjyJmqYaHfuGA3k?=
 =?us-ascii?Q?JYnh26PTFj5MCWlfHlqXPssDCCLmyNioIRHiha3eI74DvS2Qp7aCMLskPyb8?=
 =?us-ascii?Q?CMEeezvg+/lGUmUwtRLDqZlPWci6XGxBodaZCibVU6A0CBhS1XafZjI1UDmK?=
 =?us-ascii?Q?P8AI+iKzP1BACreUTnmG6DShaXJe/wdqIpEd5aJ/o/g9YHugU5RB8+EPMZ3+?=
 =?us-ascii?Q?pt0p5/bAjwu+uRa2b5CN6bXCi9NlKR7bOgUpVS8So7jADpszVvBPed2HNtIV?=
 =?us-ascii?Q?pFF/3CE9OuHwrivVJZDRSGWtHQpmOIwE7dk5riLeoh1rkUaRdRk45bQl3R11?=
 =?us-ascii?Q?FkGdojSjhbomJ69Kz3h1XHNOdiKmSzFHmap79VNpWEw62gWfKS+t1FfSxKNG?=
 =?us-ascii?Q?XSyf6RE7jQfEgFkU3ctW4D+TJKa9abGIZu6WTgX4okpRDTffjdLclrttkvBX?=
 =?us-ascii?Q?UNuWoPK5yLOiayFDyMe+PebvppHEcbqBUo3zu38DTcwfGiSnZdvvpM0B6DuM?=
 =?us-ascii?Q?jWM4tvSzU8I7qKyNNk25mqyTJ+NyJn60/Q9rYJv/kayb7zURarTs44WnjaUi?=
 =?us-ascii?Q?dmk12v5WUPbDOcbd9YpoVU+iFVHAzt70R0NBlqgJWzIsKOrEyxKN843IJ8hm?=
 =?us-ascii?Q?1VWmh/gzO4B6qCUaLeJ1RcbSABs96uNHzE4ZA3nX+obU2j4XSjnzkDyzezM1?=
 =?us-ascii?Q?DTMiZbebp83nh453+aDyklpqPp+knsbpxFzT5ndNhHLQ1N8u7WFTnVhWlly/?=
 =?us-ascii?Q?3q/tC17ubD0uniO6oUbwzLNjrSpnnUnx+huSgi6v3C+NYxOzCGPp2xcfZRhc?=
 =?us-ascii?Q?lDzNaD/g2hUNsh804VdYVf0AjUFAm5sOs8V4ObNNit8ain8gdZe8Jew5pC2H?=
 =?us-ascii?Q?nwTyoRqdatLgpFgIMfQ5FwlEHAgtm8jL40CYcKWws65q/bKYo9J3P8WIC2bd?=
 =?us-ascii?Q?KqdhfU/jAiQ9EbK2zXkvp5Y6kuD/P6U8xZisT1NsK/F4jWHzUhjWWTE/EMsV?=
 =?us-ascii?Q?08mM1FuQRx/nxRYFTX96xvZGHKDfhMHo4e63TmeXeaoCQf4Kfbj67X8X4XUn?=
 =?us-ascii?Q?7GzQHNnpmNHFTIm783QjiPdh/StwVlkF7Lig+VuRkQ4sBqFxlwerPNp6CRsY?=
 =?us-ascii?Q?g4S7xjqzRVCrAQXCK7Vv98zmhV2m4iCgsOgfioMQmR9B22WBDc98cs19+GsR?=
 =?us-ascii?Q?nMHdDTPdbY57ovzVrxMTSyQa5t4W/kUPiCCvpw4gnIJFntqpMcO4Lrb4/Yz3?=
 =?us-ascii?Q?OAcA7FQ4j4NOeRUURFbrgw21pUAtpC315tIqBE37rd9e7GuKRLjIo4uf1Cv0?=
 =?us-ascii?Q?Ny41QJZfK1/ysvu+hwx0CmeB3oi2hnu62u8p+J6jqKvvLgaWTysKha/j8mKO?=
 =?us-ascii?Q?ELnDovtEFMKOPjlp9hkgiF9uwLKvlGI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EA483A517ADE54398C21E135A2E04F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968c221f-a69a-4940-ea0d-08da2978a145
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 00:38:50.4405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no76xo6ZAq0mqpg8BIE9ckGP2Rn0+Pjey2xOw2dMUbXnr7aIrPR3KtOOovAxsxK3f1HJgC4m5XsFtWBO/EfgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5282
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_05:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290000
X-Proofpoint-ORIG-GUID: WND5cLvC7AyFrVewwUOj8FNLjz7wIRu6
X-Proofpoint-GUID: WND5cLvC7AyFrVewwUOj8FNLjz7wIRu6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220428 16:19]:
> On Tue, Apr 26, 2022 at 03:06:35PM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Avoid allocating a new VMA when it a vma modification can occur.  When =
a
> > brk() can expand or contract a VMA, then the single store operation wil=
l
> > only modify one index of the maple tree instead of causing a node to sp=
lit
> > or coalesce.  This avoids unnecessary allocations/frees of maple tree
> > nodes and VMAs.
> >=20
> > Move some limit & flag verifications out of the do_brk_flags() function=
 to
> > use only relevant checks in the code path of bkr() and vm_brk_flags().
> >=20
> > Set the vma to check if it can expand in vm_brk_flags() if extra criter=
ia
> > are met.
> >=20
> > Drop userfaultfd from do_brk_flags() path and only use it in
> > vm_brk_flags() path since that is the only place a munmap will happen.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> A build failure seen when building ppc64:corenet64_smp_defconfig also
> biscects to this patch.
>=20
> mm/mmap.c: In function 'do_brk_flags':
> mm/mmap.c:2908:17: error: implicit declaration of function
> 	'khugepaged_enter_vma_merge'; did you mean 'khugepaged_enter_vma'?
>=20
> It appears that this is later fixed, but it hurts bisectability
> (and prevents me from finding the actual build failure in linux-next
> when trying to build corenet64_smp_defconfig).

Yeah, that khugepaged_enter_vma_merge was renamed in another patch set.
Andrew made the correction but kept the patch as it was.  I think the
suggested change is right.. if you read the commit that introduced
khugepaged_enter_vma(), it seems right at least.

>=20
> While looking into the patch, I noticed the following.
>=20
> [ ... ]
>=20
> > @@ -2773,30 +2888,52 @@ static int do_brk_flags(unsigned long addr, uns=
igned long len,
> >  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> >  		return -ENOMEM;
> > =20
> >  out:
> >  	perf_event_mmap(vma);
> >  	mm->total_vm +=3D len >> PAGE_SHIFT;
> > @@ -2807,18 +2944,21 @@ static int do_brk_flags(unsigned long addr, uns=
igned long len,
> >  	validate_mm_mt(mm);
> >  	return 0;
> > =20
> > -no_vma_link:
> >  	vm_area_free(vma);
>=20
> That really looks wrong. vm_area_free(vma) can not be reached
> after this patch has been applied.

This came up elsewhere too, Thanks.  This shouldn't cause an issue
unless you OOM though.

>=20
> Guenter
>=20
> > +vma_alloc_fail:
> > +	vm_unacct_memory(len >> PAGE_SHIFT);
> >  	return -ENOMEM;
> >  }
> >  =
