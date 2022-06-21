Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A017553388
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351456AbiFUNYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351411AbiFUNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:23:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421DDE2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:23:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBEojg031145;
        Tue, 21 Jun 2022 13:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eVSi+ZNXlGs/iDjpCuBEw5gpJaLtBL2YsU78lZBbTFg=;
 b=nMLoxjk8B1wKHNh8NloMaJk6m8W2yDgW+YTdybsNeydJHTXsOYFuJLiOY1HGf1tXGlsp
 2UYYtFrJP0319zrJ1d5JCJhQ4ynOAjewMAu19GnoOPEpvrDuHHfsUiVOTmHypDb7hNJ0
 u2tGhirkO9HvQlHb3DRFo/wNJ9JJWBjUxDywugR4ylMkhKNSrOqSKuuyafnpQ460sZBo
 I4CksAxKw+Ak2gvkOn0/iYoXmpulaMWVFATZcJJNE60GDUs9FwR0h3MpddZTKhC0SUy/
 3iNmc+Tqe79bqLF1LjWE4gb1GMEOVBuYTRiUXtjFnTq0Eh0e/La7mLAAUmZokGLbqqKQ RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf5gb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 13:23:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LDAewg009818;
        Tue, 21 Jun 2022 13:23:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5ce64p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 13:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0DXdm8I0krHBX/D5i+vzRsw3KrCWoo+DpWIThXeszDdl7ewMMZOoW2gsTYPJWLJ2PT0VZKLzukHgWVvgM6tPREEvO2TAfL7Jw1fJflEmJyUUEOxJK5mwOeN8uzMHAFA878Nov3NihdjjfIJ5Zo/zcJOL0VTfGS/+du6pPQhGQnGijY9R2VsFgbhceBAsgG27jbRJRw4zdXPYNQFYUrC2ZblrOhvWVrcSsfB30pb4kHJv2esHqR+QIFkmxRXzqT+EDALN/DcjPXglG9O3p8eh2Igrvb+NmCwbQWUho9uEHrGXbUgRrGZ26/F8tAiAJdKSr+0cuM/OrSMtuG2jrzstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVSi+ZNXlGs/iDjpCuBEw5gpJaLtBL2YsU78lZBbTFg=;
 b=B01OZVwoLydPMh6D6KTAqdLFeVy3unKwU3WYEOuAy+EArcFyv2mw36s79W/yIf54Vr5sX5pcDtmAD4fxmqUWxQG1djLUkrQVAdYg3TTXFaT/NsFxDx9B9s5eN3cSt63up0P+c/ZknKdECA3IiEQN/SXNOJo521UkPqVc8fSvC6IbKJXDhI8O0N4ZZ8TpFejVso08dwTK2qQ7quzsvcKnf+BLutTjJAvTkg741y35Lu4syb4ln6uTZcapfUZQn56tRiyp7O85u12Arlw3GMqQkcijMQmrdsWdNxxYUKdGZ/RiJskoRqCKSxHxJfsulu4jVy+DsjTU+IJR6mWjFW6YYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVSi+ZNXlGs/iDjpCuBEw5gpJaLtBL2YsU78lZBbTFg=;
 b=ZHDF6LAy1uhFgjQQLIct/bZ+7NJRTIeG8dkTUJp4FQk71FZTBlaXJwGSxWTbGG5QSPEBfSRA99edMQoB0y97eASiOFJKCCQvxbKT7qcO27xzr0/8AvC9lw0PXv7ZyzDjq2uR22nw5pqpklZS6ihL0EV6G46qn97SHyTuCkV9yzs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6115.namprd10.prod.outlook.com (2603:10b6:208:3ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 13:22:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 13:22:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Make mas_prealloc() error checking more
 generic
Thread-Topic: [PATCH] maple_tree: Make mas_prealloc() error checking more
 generic
Thread-Index: AQHYgN9Debp7oQI7bkyolUE9qJsVe61Zm5MAgABGsoA=
Date:   Tue, 21 Jun 2022 13:22:59 +0000
Message-ID: <20220621132251.sloxxcbecwmurb42@revolver>
References: <20220615174213.738849-1-Liam.Howlett@oracle.com>
 <f7e9b2a7-9ec8-3922-ee06-eea0e26a26dd@redhat.com>
In-Reply-To: <f7e9b2a7-9ec8-3922-ee06-eea0e26a26dd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7176f027-ccae-4f51-0a38-08da53892913
x-ms-traffictypediagnostic: BL3PR10MB6115:EE_
x-microsoft-antispam-prvs: <BL3PR10MB61158E568CBC6FD5A33449B2FDB39@BL3PR10MB6115.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zd3DwPjSw1ru2jLP0qi89Eimu6iNZfrboq/q2aCNhR1nWJeDs7MP0WriVqrH6cZuYV25dpuypULe8VksB65/MhvAc0ZFiTgj5YTLQNDyCyRO1M39Io0aYm45duusCpSVTPnDi+FfItVIhsCFEb2JVH2vkBM4UN/EH4+rnXMzy1U5/IdIwCTdFxLFTZtAC3smQijmJmh7E2nB06RJv8MqZYLH1UVyAdgGkPRO7f8N37AIemoNSP5l2XcOWaB4T8EWRZcJYNYoD4FGmS1Ff3UPELNr7BglbCzdfv9/IsClwch0GSExhE9a5ZzzHtC3+nMdEwEpsC2pn2eXNRMUL6lGobh0MUd81VxfqHNl4LQcAE1aaSowDS8gAyhYYKAOh7247ep04NKfBX5nIZsowD06dwWpK14Gx2ypOc90+XJuYUBfnOpSPfnjOG1IiaqmEiWbw7S+S8q/JSakxLe+nsKhWVz8RjkWwqW4CgeNwhP0v+iyFiTuIQG1SOSDq/sQLRrD/qYB1PIBh7Q6LuQdIi14em3Bp5QaYB971bbY/7V1XBAgKZQAhFdu/IpQyBX071KYAJ/Dw331QqNQBwH4tuj4ncg3yjVU6F+48oIj59sd0/r4e0bghjjqk6MFIKkxZAE3jvpO7PcU4PFD4xjcz0M0MIEwDuyRaXeP6W3sbk2ZKxR40QwM51Uo5xMeg0Jt0KcbtzlELY/eKkleAjwZ245okLJq3JVO4CfPVv8VUYbGX3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(83380400001)(66946007)(66476007)(8676002)(4326008)(76116006)(38070700005)(122000001)(64756008)(54906003)(6916009)(66556008)(91956017)(66446008)(316002)(38100700002)(478600001)(8936002)(33716001)(53546011)(9686003)(6486002)(1076003)(5660300002)(6512007)(26005)(186003)(44832011)(6506007)(2906002)(71200400001)(41300700001)(86362001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e4UWwnVHLhziK5radyakByoc23nxN85GCe0GqjmK72rgh+iul7+kKyYTaa+5?=
 =?us-ascii?Q?KNSo2f8kQjr1NDGUP5O5L64HEg3PDNU5EpdsokuebEDNtAb5tS7B3rAziKO4?=
 =?us-ascii?Q?WTWY2Iz7FcdIAn4jAudHRZ75LW5j9OeOBeKchwfvQ89w4jDa4pdkOe9w8Mld?=
 =?us-ascii?Q?Ztlwh2aWaEywqRWur5IgewHxcJzlu+T5NFCI7TGpom3bbALdc9F2NnBRK0b7?=
 =?us-ascii?Q?l9oirOoU8cRS8KsyEgtGJYGbC1VuqJlw/4W3JVmxOoYEu9HocX3nhYDwlnq0?=
 =?us-ascii?Q?llbhEiBjVxwGd2kYNQcVg6D5WorKc9RmYfxl6Uadf/67Uqs2A5M57WcvSCy2?=
 =?us-ascii?Q?1jmrhWx2eVU/cAnDztcOy/kXXivYITUxkUmIqXnTfiWgQWwDCQxbxoMS6VbV?=
 =?us-ascii?Q?wyzDhRBZMEYLDAfDa9WABtUxTiVfZbiOxbOu/sMflN6K1kAA9meT2vhnCH4G?=
 =?us-ascii?Q?o5xnWd+2ezGZg3WrCpB32++EIOhbGswsOk3AIoeLxvfjBe1YbwjNLtZVukBE?=
 =?us-ascii?Q?Jy+4Pzn7D4Gdorwp6qVQTR0GoBQLkAVBKz9a3ZQ0ln/Et1DCxPL1xaF174YC?=
 =?us-ascii?Q?178a2GDL91OPY01qtTQsgi6MA5UBE9Im0rACiyj3SbBl5kPpiRapFusDWG7Z?=
 =?us-ascii?Q?7kkUG9+gosHDrv/vi5ytEDMIHmug2+PKYPHD635thcSNyZkPCZk1c+rLxDvt?=
 =?us-ascii?Q?gS2FaB+f5nFshiPLOPL0Bk8oiXAR8S+F+4GTDbx5XVlXfx+gPAVF+xP/vOUW?=
 =?us-ascii?Q?rUQ29+sW9I+x+adwMVENmuwxGxldTHUH060gW7gzZUrMejZJvblh4ZoM0Qkn?=
 =?us-ascii?Q?2qB8/0c+Y8R/ONn6KH4oacvm5fPWov1qRREC/s6nJSqn940vpaygEwyZVlq8?=
 =?us-ascii?Q?mwq1HUzQYctlD/YugNy8R2pz5Ifkcoxfevqge6zNd8/AQI0GMsvooooatvLD?=
 =?us-ascii?Q?zsQi5XCT/LPAR81K5+4l7OC97nkhpEo6mRbFVMwdJWcfz2uet83u1fkmMkae?=
 =?us-ascii?Q?vQy/c62oKNST1XY9Pj3U9A32hz2BiTIjZWr5E2oNdVCdlfPslEXZY7VvzAVC?=
 =?us-ascii?Q?lB0m3uasUeEA7bxb46Ahxfje362aq8sc8vVtJsYY0uHsy6iy3cbcqkHvdVYv?=
 =?us-ascii?Q?r/Un9UGYHp6F5ZG8yhnfF80XjTdP3U5Wj4pgCg2XEzDAQj62gwB1jCmaAy68?=
 =?us-ascii?Q?Ev5IEEFITQxcwWnOb+qCl7xUCjWf5B6rWoLMwudi0U/Tk22ZL5b/F4RGoH/F?=
 =?us-ascii?Q?jtgmxzcvylQycSmedOY+x3F7gXkVKDarsZbnBLNCm6zLVGquf1KpnfNMHUTo?=
 =?us-ascii?Q?Hp/QRTTmWmKzItKvxU55WxRU9WddI+97fB4kwk9SbNs0DLzUckXpPzTo77kN?=
 =?us-ascii?Q?Fz8TT82ZX8aD9w63R76pB6KpubrLjbWwA/3SS3xUnFdUVmcNpKRZg6jc1ABv?=
 =?us-ascii?Q?9DZbqNEGHIddRAhkBHwGo3U5XvP28NoXH6ux6dv0XZgHG6mnGkC8OnWyuIx8?=
 =?us-ascii?Q?+kZtnCR25cj1dSIJFAzMEA5lhzS1vl/nu8lUwVK1v2RPEdIt0zcy/MwoHZSa?=
 =?us-ascii?Q?t4H92hH85ct+A4VIIA+jqPtRF7p/jFgBFVvBlA8g0Z5f/1pSjE4XPWHjbIC2?=
 =?us-ascii?Q?R2eIOlz6yzhZdrC5LqwPoQ2ow1LFwIdwN0d1TW5bwGgbRMD6TnGl7wTTy5FJ?=
 =?us-ascii?Q?tUrCcX65oAr/19wUSKtODrnG8FdEJwMN0hp3uWTDwMoeJBJhEn+iq9YiDs90?=
 =?us-ascii?Q?CZ7lR2pV12VLqFkT8ZY642J2ykCEqs8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A9315E01B985746806E4C60D11EBF4B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176f027-ccae-4f51-0a38-08da53892913
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 13:22:59.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vtj8gSLjTVxZqACYbHqgCUk31KzSggtYfm6tKfIPLe7rF++udmf4plwSKubbLJKIVL6aBIbTKeboXC9Pt8FT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_06:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210058
X-Proofpoint-ORIG-GUID: GjTI8QZQGqkTy7ChIKFQk97Ob8eNsV6l
X-Proofpoint-GUID: GjTI8QZQGqkTy7ChIKFQk97Ob8eNsV6l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220621 05:09]:
> On 15.06.22 19:42, Liam Howlett wrote:
> > Return the error regardless of what it is.  This is a safer option.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  lib/maple_tree.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index f413b6f0da2b..89ff5ef7ee28 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5670,16 +5670,15 @@ void mas_store_prealloc(struct ma_state *mas, v=
oid *entry)
> >   */
> >  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
> >  {
> > -
> >  	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
> >  	mas_alloc_nodes(mas, gfp);
> > -	if (likely(mas->node !=3D MA_ERROR(-ENOMEM)))
> > +	if (likely(!mas_is_err(mas)))
> >  		return 0;
> > =20
> >  	mas_set_alloc_req(mas, 0);
> >  	mas_destroy(mas);
> >  	mas->node =3D MAS_START;
> > -	return -ENOMEM;
> > +	return xa_err(mas->node);
> >  }
> > =20
> >  /*
>=20
> Liam, (as asked privately before, I was just too busy to respond :) )
> once all known issues are fixed, can we have a new version posted to
> ease review? That would make my life easier to see what needs review and
> in which order patches apply. Thanks!
>=20


Yes.  Thanks for asking.

Andrew didn't want to lose the comments so maybe I'll squash the fixes
into a branch and send that out as a response to v9 if that works?

Cheers,
Liam=
