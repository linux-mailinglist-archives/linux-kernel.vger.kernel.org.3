Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD957799E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiGRC2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:28:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5B11174
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:28:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I0MUbm011519;
        Mon, 18 Jul 2022 02:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hmrMwrVyXCW67KZhSWC+JztlFfbrAwZetuf/3hCuLqE=;
 b=zzblIs2uNg35s4cxC2WATKo3ni/1DCgG/wglAJnGiXLKzcGoemzfJDSu/8WNa/CImVeV
 oq0D7dJ0wvwE8fm425f3B2MupeSjS96ratsugYE2m37K9Uza2XOOPVOPJi0QIszo0DBO
 izzaCyizSm6oD9luzncX3oEwb7Bp1OsCaMRdOLwkjH9i4TnOjbkC/iKTMNCLRZzLggjU
 d1zV7fSCjTMkoSP5uN4vv9asAFT5gZ60HTne80hhbETgVIw38g96nyyOW6EbdfrvSDFU
 ppR19gPUaZA7ccQvOCBbke1FvLE03W6noVPqI8KqWe6Gy9IM/ZMLmKyqU+klt8OvkDM9 rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0t2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 02:27:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26HJjJ0D006359;
        Mon, 18 Jul 2022 02:27:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gf69w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 02:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djsHcHwlTALfEPfizmh2FSodpOJP8+jZl8BhzGCxPvVJm/LLk1P0axzLLj6G+kwnDqBROnbTUEmvLzJxtA9xhkZJibejZV1iTmd3zd2ia7TuAaf9oLcG1+3lcIoo7PXKjKrJYlpJwovd739OyR1Nl+ShBn6YX6azTE7iqYWn3QgvuNGjRVHwj4wMfCKO3vO4yHLQ5XfDATEztb1jYMG4/QCu/6s/OopYeKbWKB1bCExvuqQjVN3g00grpCn8G6idPmL3ej2Dda+YssvEELZciTCiadneA3lGN4buC6pwovvh52L2nZeXxPkmWS+Z3PtEYkXdIzOYNFPfyf3Tsx4u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmrMwrVyXCW67KZhSWC+JztlFfbrAwZetuf/3hCuLqE=;
 b=gLHbnNNpZnhcjNcQCKLHh04CWEKvFLgZzNRXZRtGPKjbNdhr6sXl8Vy8eMCdWR3GLqpTqlRJ3abSSQpL+FTD7XBPuVxw7SeOpU0jOLUxtnjtKLVCXl69T2QfRgwgIS+Wll+2yjQzbV6gBRmZ8p/PyeWESbLHFkHzfvAwO5dNG1Ea11T+8Axj7yyU9FOJ6lzdlNESicTvumwFbRFaUzLhtwbvPvD7NP7UszUM2Z06HufiHCL9r7QWuf1SppSAIRGJKXCd4LrXYO2RSm44XJiOL5/lYNPQcOKAGsXeJUPYoOC5MaAKjra8ckLLjN0r7VfkPS5DdZ8wJJ4xOY+yKZbUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmrMwrVyXCW67KZhSWC+JztlFfbrAwZetuf/3hCuLqE=;
 b=eLt0+YoTFif8oDA0Ck08iCkD0BmBMlBgCgXRJj0JBN8CunnPp57aD19Rh2TYdKm72pCqUFs+508NqL4pIVrW2xo6a8dqswx/CgXh6u8uyOGqhsn1cPNptI7atzfQI7Jr4GWqWpwLo8hjS0GlNoy6mZNUiV3S6tHU1USF7UvxCyE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 02:27:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 02:27:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YCAAzbDgIAAXBAA
Date:   Mon, 18 Jul 2022 02:27:40 +0000
Message-ID: <20220718022718.wtlw7grwp6dv5fcp@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
 <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
 <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
 <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
In-Reply-To: <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88cf9971-e4b6-4f28-ae6e-08da686516c5
x-ms-traffictypediagnostic: SN4PR10MB5605:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57b8HI/gRzYnthAv6pJoCIdYZ0iYgXF7OuZ34raWrh8mTiN8IraU0r96jq4O+1GE1NClpWjA/k1CDn6e3+EXxPxMiEYcEqY8Q+EMgTX5rlfe/cqdF6PflwfvwyG5WtDRy/LFJJnOlv4SCW8/eWEL2Gs4yNgLkUC09lOQ6jbgY6RPk9o9ZsDkz7L0VawG9u4icSK62I8N+3L/Ox/cVPqxWXPjwXhYsboI1oEywlGsF2EE92Mq6EFxMleYeZF2333edqV6n24Nfd+avw4BZqbJXTWPDSlkM6EUy/pYR7Z1M/OEzUMAve+gdGUFs2d5W1B7mn58FmdBTE3c8ZYiTMz81TlVRgOoEf/1RTCFiNOgZzjbnLoxADi2Hafxk5dtRqLHTOs7XDYz5dLUIZIJcD1iEk4I70ToUimtisCVQJCvYx7jlbV/2ZDEf2alj8yb1z7lik/6tmWsIixutBuRc+oA7qyOrGe76HHmvUP3uRspuauPJMbCGe+5xxx9R+ef9kZp/tNyyEy8ChCnfHpRqfp2ksi2uiyXD4DnVGgH1haAgFTQD9Px+IqCGj8wGYeO/ELB1C6CpFWai5f4B4/aADEP4wpvGGkBe4VGedQ0EAWort4SAglyWbJmtjH1hTpzh/dXK/R4apmfzSXJ+fYUpaJr5E7svMOdil+zzD1bJ5SC3GVSZNtwAqmCDNJNiEfrAhice0IPi6lFqqazuaLVX6BlzNcGFAvQX5Pg2C3H0oqp/UDWqcT5E1tTS4yiuCxy38wAkY5nfhUNHV1+6DwsEV0tb8KLhQLWoO6NlriQPB7CwATrX5HDGKKA/jPOEcegeeNM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(99936003)(71200400001)(83380400001)(478600001)(6486002)(38070700005)(6916009)(41300700001)(6506007)(9686003)(6512007)(91956017)(316002)(1076003)(186003)(53546011)(26005)(76116006)(54906003)(33716001)(66556008)(66946007)(66476007)(5660300002)(8676002)(30864003)(66446008)(4326008)(44832011)(64756008)(8936002)(86362001)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EqPZfEjuGbXM7ASk3qMUOBtxXscDInRkkO1WIsfHv/LwCq6GsYOyU4in0vx/?=
 =?us-ascii?Q?r3l33dQWQjcto/IQJNOH5ud2EF17fe7UBgAdk6VPjfv182Q79oEzwIhpBzba?=
 =?us-ascii?Q?XmRmIiC8zJ0dLbrbvN+qi9fb5IVGoE8llGqgoYb1LG5MiBpSwe7mpjrQIaQQ?=
 =?us-ascii?Q?kvr1B63UlH1ulZT3vq3jKQGTssCNVq7GimRi1kZ3BAn4Hk6QJwNBfE2cCF6T?=
 =?us-ascii?Q?bzei+sPJNTAao/D/EbvTUbNFPYtes4bCKu1/g/i+4vyN8vAtYrJ0bpbN288G?=
 =?us-ascii?Q?SUC8Hbe65PGFbMNhBupDGfqHpFKvi2UM0n+1rRlLRNX1e8LXX0q9TI2q+M4K?=
 =?us-ascii?Q?wBT0YeNLrY/kGPPEZncu5SzvO+m048mvl8VV3vRLHbXPcfNsi9rNB61NHNRO?=
 =?us-ascii?Q?PUX3/ZfDA5SBDrR0957u8pWOurF8u7xzzqATOxmwFaHS3fKwsEErmhRWl+fr?=
 =?us-ascii?Q?sGYwkQrmZZ1qcPJDYjDxyKPlyW6tAZjQGmr11cqZCWYfOi+lRzZ6bp7aRw1F?=
 =?us-ascii?Q?xFfgTt6dnHWDs4FPPoS8MOs3zlA9dkcxEhOJMsOrPSsXbQYZyI5C65RZRk+p?=
 =?us-ascii?Q?6oxM6+QXcbY8hZdmil6qlAtt2hkBhOYxYJ4YjcgIcehVo3NmvfxeClbxjcVV?=
 =?us-ascii?Q?hIqYQcbK8pH34V6EX6AMxjb+n6WZBCcdUXUlG57yuqzUpY/etYv9CDiRjR5/?=
 =?us-ascii?Q?AeVikgATnAzlh5sq9UkJFFKwNt644Qrmlk7sCSYJQVQKaxqoKq5YD8zhRk28?=
 =?us-ascii?Q?zsrS1J386ngrReaJrz+iJbGYgPRF0OwLDyHGEtLSUlFdH4bhSbs36U984cEA?=
 =?us-ascii?Q?7XsClODGcWA8PXbIopqJ5PW/ZgQAHe5zNU3gU0R39SJXbKWYoeb130CRY1A1?=
 =?us-ascii?Q?gqkSfcdFdIf+jvZnND6QLYNZOrWaNvWZCA1CjWMZ4gviWgq2gxbsHjePXLUx?=
 =?us-ascii?Q?BS/MTqiqGq7SaLXRzdKikhGHU2Vps/zT8EreH/w2nozj8CHqbr0DxiITQ+pv?=
 =?us-ascii?Q?LZSFayabsQywhGd6U32kN9GlK91U/9EPyR7XfT9GQ3Wbppdhl+/n8BJhbaCP?=
 =?us-ascii?Q?qWO1vL/IgQutjIKdCOX1SuppmYTYqbAG9rL7TqmhRi22G9TvShWLrldMHLfP?=
 =?us-ascii?Q?OphkU/R/ocR1DZrtVPw/W4ElL/hRiASUeC3vHzoa8XIvN1xHbQ+2RT8jygrT?=
 =?us-ascii?Q?74ob60jv7XnNWX1GywhuBxbl+WY5583bkQBRRw1+MUC7oIdiCN9CZF8WdkQ6?=
 =?us-ascii?Q?pG1u02gru+xcM3TkFX5SR0b589hO6Xnht5L85top8k8xmwwkcB3mPJReoc37?=
 =?us-ascii?Q?e2k+adDe3d0Iaf85Lkim2osf7YA8fVVHzE92Ijfc6qm11JvbHajzubmQiriu?=
 =?us-ascii?Q?UBAlRO16tNTGjVPUqi06gqQNUJkUuO/H4jQzXE7DokN6mnmkSQYJOdGmMZpI?=
 =?us-ascii?Q?Y6LoqopwWcgtEkQQFvqYZhI+NejprNS/lWvTBxaZWggZflfG2Tbds/0zKlow?=
 =?us-ascii?Q?dj7tkUH4iAwqard/8mxa8zZqEtvBDePIFujMZbwJ3FOJu74x+7c/dVw1xlDL?=
 =?us-ascii?Q?ecCVfiiP8Ut9NXtNfJy64Cn3bVIFmVAmryj9MLbqHS7b2PkqiLVHf1CY0/Zx?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220718022718wtlw7grwp6dv5fcprevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf9971-e4b6-4f28-ae6e-08da686516c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 02:27:40.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/PlyMamWp7Y4fzbKimgvkKYM913fypP1NJdMHXmTBdkrHZsW50W6UK8MBKKByez3bROXQbZf2DojLHgfHuVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180009
X-Proofpoint-GUID: 2zHvuFDLhw5nsBUm-ny4ysNt2PBh_h7T
X-Proofpoint-ORIG-GUID: 2zHvuFDLhw5nsBUm-ny4ysNt2PBh_h7T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220718022718wtlw7grwp6dv5fcprevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A4A9BAB749AA94AA4A652E575E35EE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Hugh Dickins <hughd@google.com> [220717 16:58]:
> On Fri, 15 Jul 2022, Liam Howlett wrote:
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220713 13:50]:
> > > * Hugh Dickins <hughd@google.com> [220713 11:56]:
> > > > On Wed, 13 Jul 2022, Liam Howlett wrote:
> > > > > * David Hildenbrand <david@redhat.com> [220713 04:34]:
> > > > > > On 12.07.22 16:24, Liam Howlett wrote:
> > > > > > > When building with C=3D1, the maple tree had some rcu type mi=
smatch &
> > > > > > > locking mismatches in the destroy functions.  There were cosm=
etic only
> > > > > > > since this happens after the nodes are removed from the tree.
> > > > > > >=20
> > > > > > > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > >=20
> > > > > > Sorry to say, but the fixes become hard to follow (what/where/w=
hy). :)
> > > > > >=20
> > > > > > I guess it's time for a new series soon. Eventually it makes se=
nse to
> > > > > > send the fixes as reply to the individual problematic patches. =
(instead
> > > > > > of fixes to commit ids that are not upstream)
> > > > > >=20
> > > > > > [yes, I'll do more review soon :) ]
> > > > >=20
> > > > > I appreciate the feedback, it's much better than yelling into the=
 void.
> > > > > I have one more fix in the works - for __vma_adjust() of all func=
tions
> > > > > so that'll be impossible to follow anyways :)  I'll work on a v11=
 to
> > > > > include that last one.
> > > >=20
> > > > Please do also post the incremental for that "one more fix" once it=
's
> > > > ready: I have been keeping up with what you've been posting so far,
> > > > folding them into my debugging here, and believe we have made some =
but
> > > > still not enough progress on the bugs I hit.  Folding in one more f=
ix
> > > > will be easy for me, advancing to v11 of a 69-part patchset will be=
...
> > > > dispiriting.
> > >=20
> > >=20
> > > Okay, thanks.  I don't think it will fix your outstanding issues but =
it
> > > is necessary to fix case 6 of vma_merge() on memory allocation failur=
e
> > > as reported by syzbot.
> >=20
> > Hugh,
> >=20
> > Please find attached the last outstanding fix for this series.  It
> > covers a rare failure scenario that one of the build bots reported.
> > Ironically, it changes __vma_adjust() more than the rest of the series,
> > but leaves the locking in the existing order.
>=20
> Thanks, I folded that in to my testing on next-20220715, along with
> other you posted on Friday (mas_dead_leaves() walk fix);

  Please drop that patch, it needs more testing.

> but have not
> even glanced at the v11 you posted Saturday, though I see from responses
> that v11 has some other changes, including __vma_adjust() again, but I
> just have not looked.  (I've had my own experiments in __vma_adjust()).
>=20
> You'll be wanting my report, I'll give it here rather than in the v11
> thread.  In short, some progress, but still frustratingly none on the
> main crashes.
>=20
> 1. swapops.h BUG on !PageLocked migration entry.  This is *not* the
> most urgent to fix, I'm just listing it first to get it out of the way
> here.  This is the BUG that terminates every tmpfs swapping load test
> on the laptop: only progress was that, just one time, the workstation
> hit it before hitting its usual problems: nice to see it there too.
> I'll worry about this bug when the rest is running stably.  I've only
> ever noticed it when it's brk being unmapped, I expect that's a clue.

Thanks for pointing me towards a usable reproducer.  I should be able to
narrow it down from there, especially with the brk hint.

>=20
> 2. Silly in do_mas_mumap():
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2513,7 +2513,7 @@ int do_mas_munmap(struct ma_state *mas, struct mm_s=
truct *mm,
>  	arch_unmap(mm, start, end);
> =20
>  	/* Find the first overlapping VMA */
> -	vma =3D mas_find(mas, end - 1);
> +	vma =3D mas_find(mas, start);
>  	if (!vma)
>  		return 0;
> =20
> Fixing that does fix some bad behaviors seen - I'd been having crashes in
> unmap_vmas() and unlink_anon_vmas(), and put "if (WARN_ON(!vma)) return;"
> in unmap_region(); but that no longer seems necessary now do_mas_munmap()
> is fixed thus.  I had high hopes that it would fix all the rest, but no.

This is actually correct.  mas_find() is not the same as vma_find().
mas_find() uses the maple state index and searches until a limit (end
-1 in this case).  I haven't seen these crashes, but I think you are
hitting the same issue you are discussing in #6 below.  I also hadn't
realised the potential confusion of those APIs.

>=20
> 3. vma_adjust_trans_huge().  Skip this paragraph, I think there
> is actually no problem here, but for safety I have rearranged the
> vma_adjust_trans_huge()s inside the rmap locks, because when things
> aren't working right, best to rule out some possibilities.  Why am
> I even mentioning it here?  In case I send any code snippets and
> you're puzzled by vma_adjust_trans_huge() having moved.

Thanks, I will keep this in mind.

>=20
> 4. unlink_anon_vmas() in __vma_adjust().  Not urgent to fix (can only
> be an issue when GFP_KERNEL preallocation fails, which I think means
> when current is being OOM-killed), but whereas vma_expand() has careful
> anon_cloned flag, __vma_adjust() does not, and I think could be
> unlinking a pre-existing anon_vma.  Aside from that, I am nervous about
> using unlink_anon_vmas() there like that (and in vma_expand()): IIUC it's
> an unnecessary "optimization" for a very unlikely case, that's in danger
> of doing more harm than good; and should be removed from them both (then
> they can both simply return -ENOMEM when mas_preallocate() fails).

I will add a flag to __vma_adjust, but I don't see how it could happen.
I guess if importer has an anon_vma already?  I added these as an unwind
since I don't want to leak - even on the rare preallocation failure.  If
you don't want to unroll, what would you suggest in these cases?  Would
a flag be acceptable?

>=20
> 5. I was horrified/thrilled to notice last night that mas_store_prealloc(=
)
> does a mas_destroy() at the end.  So only the first vma_mas_store() in
> __vma_adjust() gets to use the carefully preallocated nodes.  I thought
> that might be responsible for lots of nastiness, but again sadly no.
> Maybe it just falls back to GFP_ATOMIC when the preallocateds are gone
> (I didn't look) and that often works okay.  Whether the carefully
> chosen prealloc count allows for __vma_adjust() use would be another
> question.  (Earlier on I did try doubling its calculation, in case it
> was preallocating too few, but that made no difference either.)

mas_store_prealloc will allocate for the worst case scenario.  Since I
cannot guarantee the second store isn't the worst case, and could fail,
I cannot allow for more than one allocation per preallocate.  I thought
I was fine in __vma_adjust since I preallocate after the goto label for
a second removal but it turns out I wasn't since the second preallocate
could fail, so I've removed the requirement for a second store for 'case
6' by updating the tree once and removing both VMAs in a single pass.
There could, potentially be an issue if the caller to __vma_merge()
wanted to reduce one limit of the VMA (I guess just the start..) and
also remove one or more VMAs, and also be in a situation where
allocations could cause issues (fs_reclaim).. and since __vma_adjust()
is so complicated, I looked at the callers.  Most use vma_merge(), and
those seem fine.  fs/exec only adjusts one at a time.  when splitting,
only a single insert happens.  Did I miss some situation(s)?

>=20
> 6. The main problem, crashes on the workstation (never seen on the
> laptop).  I keep hacking around with the debug info (and, please,
> %px not %p, %lx not %lu in the debug info: I've changed them all,

Okay, so I tried to remove all %px in the debug code so I'll revert
those.  I use %lu for historic reasons from mt_dump(), I can change
those too,  The tree uses ranges to store pointers so I print the
pointers in %lx and the ranges in %lu.


> and a couple of %lds, in my copy of lib/maple_tree.c).  I forget
> how the typical crashes appeared with the MAPLE_DEBUGs turned off
> (the BUG_ON(count !=3D mm->map_count) in exit_mmap() perhaps); I've
> turned them on, but usually comment out the mt_validate() and
> mt_dump(), which generate far too much noise for non-specialists,
> and delay the onset of crash tenfold (but re-enabled to give you
> the attached messages.xz).
>=20
> Every time, it's the cc1 (9.3.1) doing some munmapping (cc1 is
> mostly what's running in this load test, so that's not surprising;
> but surprising that even when I switched the laptop to using same
> gcc-9, couldn't reproduce the problem there). Typically, that
> munmapping has involved splitting a small, say three page, vma
> into two pages below and one page above (the "insert", and I've
> hacked the debug to dump that too, see "mmap: insert" - ah,
> looking at the messages now, the insert is bigger this time).
>=20
> And what has happened each time I've studied it (I don't know
> if this is evident from the mt dumps in the messages, I hope so)
> is that the vma and the insert have been correctly placed in the
> tree, except that the vma has *also* been placed several pages
> earlier, and a linear search of the tree finds that misplaced
> instance first, vm_start not matching mt index.
>=20
> The map_count in these cases has always been around 59, 60, 61:
> maybe just typical for cc1, or maybe significant for maple tree?
>=20
> I won't give up quite yet, but I'm hoping you'll have an idea for
> the misplaced tree entry.  Something going wrong in rebalancing?
>=20
> For a long time I assumed the problem would be at the mm/mmap.c end,
> and I've repeatedly tried different things with the vma_mas stuff
> in __vma_adjust() (for example, using vma_mas_remove() to remove
> vmas before re-adding them, and/or doing mas_reset() in more places);
> but none of those attempts actually fixed the issue.  So now I'm
> thinking the problem is really at the lib/maple_tree.c end.
>=20

Do you have the patch
"maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sounds
like your issue fits this fix exactly.  I was seeing the same issue with
gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
you sent also fit the situation. I went through the same exercise
(exorcism?) of debugging the various additions and removals of the VMA
only to find the issue in the tree itself.  The fix also modified the
test code to detect the issue - which was actually hit but not detected
in the existing test cases from a live capture of VMA activities.  It is
difficult to spot in the tree dump as well.  I am sure I sent this to
Andrew as it is included in v11 and did not show up in his diff, but I
cannot find it on lore, perhaps I forgot to CC you?  I've attached it
here for you in case you missed it.

You are actually hitting the issue several iterations beyond when it
first occurred.  It was introduced earlier in the tree and exposed with
your other operations by means of a node split or merge.

> 7. If you get to do cleanups later, please shrink those double blank
> lines to single blank lines.  And find a better name for the strange
> vma_mas_szero() - vma_mas_erase(), or is erase something different?
> I'm not even sure that it's needed: that's a special case for exec's
> shift_arg_pages() VM_STACK_INCOMPLETE_SETUP, which uses __vma_adjust()
> in a non-standard way.  And trace_vma_mas_szero() in vma_mas_remove()
> looks wrong.

Okay, I'll be sure to only have one blank line.  Where do you see this?
I would have thought that checkpatch would complain?  I did try to,
regretfully, address more checkpatch issues on v11.  It added more noise
to the differences of v10 + patches to v11 than anything else.


Thanks again,
Liam

--_002_20220718022718wtlw7grwp6dv5fcprevolver_
Content-Type: text/x-diff;
	name="0001-maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"
Content-Description: 
 0001-maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch
Content-Disposition: attachment;
	filename="0001-maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch";
	size=4411; creation-date="Mon, 18 Jul 2022 02:27:40 GMT";
	modification-date="Mon, 18 Jul 2022 02:27:40 GMT"
Content-ID: <7F0A0CA26E78614899104E91FDF8FE15@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBlNWRhMTAxNjFhMTViYjU5ZWUyMmRlOWM3OGZlYzM4ODFmZTQ1NWIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogRnJpLCAxNSBKdWwgMjAyMiAxNToxMDo0NSAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtYXBsZV90cmVlOiBGaXggc3RhbGUgZGF0YSBjb3B5IGluIG1hc193cl9ub2RlX3N0
b3JlKCkNCg0KV2hlbiByZXBsYWNpbmcgb3IgcmV1c2luZyBhIG5vZGUsIGl0IGlzIHBvc3NpYmxl
IHRoYXQgc3RhbGUgZGF0YSB3b3VsZA0KYmUgY29waWVkIGludG8gdGhlIG5ldyBub2RlIHdoZW4g
YSBzdG9yZSBvcGVyYXRpb24gd3JvdGUgdG8gdGhlIG5vZGUNCm1heGltdW0gdmFsdWUgYnV0IGlu
dG8gbG93ZXIgc2xvdHMuICBGaXggdGhpcyBieSBza2lwcGluZyB0aGUgY29weSBzdGVwDQppZiB0
aGUgcmFuZ2UgYmVpbmcgd3JpdHRlbiBpcyB0aGUgbm9kZSBtYXhpbXVtLCBhbmQgc2tpcCBzZXR0
aW5nIHRoZQ0KZW5kIHBpdm90IGluIHRoaXMgY2FzZSBhcyB3ZWxsLg0KDQpSZXBvcnRlZC1ieTog
c3l6Ym90K2I3MDc3MzZhMWFkNDdmZGE2NTAwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCkZp
eGVzOiAyZWUyMzZmZTUzYTggKCJtbTogc3RhcnQgdHJhY2tpbmcgVk1BcyB3aXRoIG1hcGxlIHRy
ZWUiKQ0KU2lnbmVkLW9mZi1ieTogTGlhbSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRAb3JhY2xl
LmNvbT4NCi0tLQ0KIGxpYi9tYXBsZV90cmVlLmMgfCA1NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvbWFwbGVfdHJlZS5jIGIv
bGliL21hcGxlX3RyZWUuYw0KaW5kZXggY2Y2ZDA2MmVjYTA5Li4wZGEyNjcxYzI4MTAgMTAwNjQ0
DQotLS0gYS9saWIvbWFwbGVfdHJlZS5jDQorKysgYi9saWIvbWFwbGVfdHJlZS5jDQpAQCAtNDEy
MCwxMiArNDEyMCwxOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbWFzX3dyX25vZGVfc3RvcmUoc3Ry
dWN0IG1hX3dyX3N0YXRlICp3cl9tYXMpDQogCWlmIChkc3Rfb2Zmc2V0IDwgbWF4X3BpdikNCiAJ
CWRzdF9waXZvdHNbZHN0X29mZnNldF0gPSBtYXMtPmxhc3Q7DQogCW1hcy0+b2Zmc2V0ID0gZHN0
X29mZnNldDsNCi0JcmN1X2Fzc2lnbl9wb2ludGVyKGRzdF9zbG90c1tkc3Rfb2Zmc2V0KytdLCB3
cl9tYXMtPmVudHJ5KTsNCisJcmN1X2Fzc2lnbl9wb2ludGVyKGRzdF9zbG90c1tkc3Rfb2Zmc2V0
XSwgd3JfbWFzLT5lbnRyeSk7DQogDQotCS8qIHRoaXMgcmFuZ2Ugd3JvdGUgdG8gdGhlIGVuZCBv
ZiB0aGUgbm9kZS4gKi8NCi0JaWYgKHdyX21hcy0+b2Zmc2V0X2VuZCA+IHdyX21hcy0+bm9kZV9l
bmQpDQorCS8qDQorCSAqIHRoaXMgcmFuZ2Ugd3JvdGUgdG8gdGhlIGVuZCBvZiB0aGUgbm9kZSBv
ciBpdCBvdmVyd3JvdGUgdGhlIHJlc3Qgb2YNCisJICogdGhlIGRhdGENCisJICovDQorCWlmICh3
cl9tYXMtPm9mZnNldF9lbmQgPiB3cl9tYXMtPm5vZGVfZW5kIHx8IG1hcy0+bGFzdCA+PSBtYXMt
Pm1heCkgew0KKwkJbmV3X2VuZCA9IGRzdF9vZmZzZXQ7DQogCQlnb3RvIGRvbmU7DQorCX0NCiAN
CisJZHN0X29mZnNldCsrOw0KIAkvKiBDb3B5IHRvIHRoZSBlbmQgb2Ygbm9kZSBpZiBuZWNlc3Nh
cnkuICovDQogCWNvcHlfc2l6ZSA9IHdyX21hcy0+bm9kZV9lbmQgLSB3cl9tYXMtPm9mZnNldF9l
bmQgKyAxOw0KIAltZW1jcHkoZHN0X3Nsb3RzICsgZHN0X29mZnNldCwgd3JfbWFzLT5zbG90cyAr
IHdyX21hcy0+b2Zmc2V0X2VuZCwNCkBAIC00MTMzLDE0ICs0MTM5LDE2IEBAIHN0YXRpYyBpbmxp
bmUgYm9vbCBtYXNfd3Jfbm9kZV9zdG9yZShzdHJ1Y3QgbWFfd3Jfc3RhdGUgKndyX21hcykNCiAJ
aWYgKGRzdF9vZmZzZXQgPCBtYXhfcGl2KSB7DQogCQlpZiAoY29weV9zaXplID4gbWF4X3BpdiAt
IGRzdF9vZmZzZXQpDQogCQkJY29weV9zaXplID0gbWF4X3BpdiAtIGRzdF9vZmZzZXQ7DQotCQlt
ZW1jcHkoZHN0X3Bpdm90cyArIGRzdF9vZmZzZXQsIHdyX21hcy0+cGl2b3RzICsgd3JfbWFzLT5v
ZmZzZXRfZW5kLA0KKw0KKwkJbWVtY3B5KGRzdF9waXZvdHMgKyBkc3Rfb2Zmc2V0LA0KKwkJICAg
ICAgIHdyX21hcy0+cGl2b3RzICsgd3JfbWFzLT5vZmZzZXRfZW5kLA0KIAkJICAgICAgIHNpemVv
Zih1bnNpZ25lZCBsb25nKSAqIGNvcHlfc2l6ZSk7DQogCX0NCiANCi1kb25lOg0KIAlpZiAoKHdy
X21hcy0+bm9kZV9lbmQgPT0gbm9kZV9zbG90cyAtIDEpICYmIChuZXdfZW5kIDwgbm9kZV9zbG90
cyAtIDEpKQ0KIAkJZHN0X3Bpdm90c1tuZXdfZW5kXSA9IG1hcy0+bWF4Ow0KIA0KK2RvbmU6DQog
CW1hc19sZWFmX3NldF9tZXRhKG1hcywgbmV3bm9kZSwgZHN0X3Bpdm90cywgbWFwbGVfbGVhZl82
NCwgbmV3X2VuZCk7DQogCWlmIChpbl9yY3UpIHsNCiAJCW1hcy0+bm9kZSA9IG10X21rX25vZGUo
bmV3bm9kZSwgd3JfbWFzLT50eXBlKTsNCkBAIC02OTQ1LDE5ICs2OTUzLDIwIEBAIHN0YXRpYyB2
b2lkIG1hc192YWxpZGF0ZV9saW1pdHMoc3RydWN0IG1hX3N0YXRlICptYXMpDQogew0KIAlpbnQg
aTsNCiAJdW5zaWduZWQgbG9uZyBwcmV2X3BpdiA9IDA7DQotCXZvaWQgX19yY3UgKipzbG90cyA9
IG1hX3Nsb3RzKG10ZV90b19ub2RlKG1hcy0+bm9kZSksDQotCQkJCW10ZV9ub2RlX3R5cGUobWFz
LT5ub2RlKSk7DQorCWVudW0gbWFwbGVfdHlwZSB0eXBlID0gbXRlX25vZGVfdHlwZShtYXMtPm5v
ZGUpOw0KKwl2b2lkIF9fcmN1ICoqc2xvdHMgPSBtYV9zbG90cyhtdGVfdG9fbm9kZShtYXMtPm5v
ZGUpLCB0eXBlKTsNCisJdW5zaWduZWQgbG9uZyAqcGl2b3RzID0gbWFfcGl2b3RzKG1hc19tbiht
YXMpLCB0eXBlKTsNCiANCiAJLyogYWxsIGxpbWl0cyBhcmUgZmluZSBoZXJlLiAqLw0KIAlpZiAo
bXRlX2lzX3Jvb3QobWFzLT5ub2RlKSkNCiAJCXJldHVybjsNCiANCi0JZm9yIChpID0gMDsgaSA8
IG10X3Nsb3RfY291bnQobWFzLT5ub2RlKTsgaSsrKSB7DQotCQllbnVtIG1hcGxlX3R5cGUgdHlw
ZSA9IG10ZV9ub2RlX3R5cGUobWFzLT5ub2RlKTsNCi0JCXVuc2lnbmVkIGxvbmcgKnBpdm90cyA9
IG1hX3Bpdm90cyhtYXNfbW4obWFzKSwgdHlwZSk7DQotCQl1bnNpZ25lZCBsb25nIHBpdiA9IG1h
c19zYWZlX3Bpdm90KG1hcywgcGl2b3RzLCB0eXBlLCBpKTsNCisJZm9yIChpID0gMDsgaSA8IG10
X3Nsb3RzW3R5cGVdOyBpKyspIHsNCisJCXVuc2lnbmVkIGxvbmcgcGl2Ow0KKw0KKwkJcGl2ID0g
bWFzX3NhZmVfcGl2b3QobWFzLCBwaXZvdHMsIGksIHR5cGUpOw0KIA0KLQkJaWYgKCFwaXYpDQor
CQlpZiAoIXBpdiAmIChpICE9IDApKQ0KIAkJCWJyZWFrOw0KIA0KIAkJaWYgKCFtdGVfaXNfbGVh
ZihtYXMtPm5vZGUpKSB7DQpAQCAtNjk5MCw2ICs2OTk5LDI2IEBAIHN0YXRpYyB2b2lkIG1hc192
YWxpZGF0ZV9saW1pdHMoc3RydWN0IG1hX3N0YXRlICptYXMpDQogCQlpZiAocGl2ID09IG1hcy0+
bWF4KQ0KIAkJCWJyZWFrOw0KIAl9DQorCWZvciAoaSArPSAxOyBpIDwgbXRfc2xvdHNbdHlwZV07
IGkrKykgew0KKwkJdm9pZCAqZW50cnkgPSBtYXNfc2xvdChtYXMsIHNsb3RzLCBpKTsNCisNCisJ
CWlmIChlbnRyeSAmJiAoaSAhPSBtdF9zbG90c1t0eXBlXSAtIDEpKSB7DQorCQkJcHJfZXJyKCIl
cFsldV0gc2hvdWxkIG5vdCBoYXZlIGVudHJ5ICVwXG4iLCBtYXNfbW4obWFzKSwNCisJCQkgICAg
ICAgaSwgZW50cnkpOw0KKwkJCU1UX0JVR19PTihtYXMtPnRyZWUsIGVudHJ5ICE9IE5VTEwpOw0K
KwkJfQ0KKw0KKwkJaWYgKGkgPCBtdF9waXZvdHNbdHlwZV0pIHsNCisJCQl1bnNpZ25lZCBsb25n
IHBpdiA9IHBpdm90c1tpXTsNCisNCisJCQlpZiAoIXBpdikNCisJCQkJY29udGludWU7DQorDQor
CQkJcHJfZXJyKCIlcFsldV0gc2hvdWxkIG5vdCBoYXZlIHBpdiAlbHVcbiIsDQorCQkJICAgICAg
IG1hc19tbihtYXMpLCBpLCBwaXYpOw0KKwkJCU1UX0JVR19PTihtYXMtPnRyZWUsIGkgPCBtdF9w
aXZvdHNbdHlwZV0gLSAxKTsNCisJCX0NCisJfQ0KIH0NCiANCiBzdGF0aWMgdm9pZCBtdF92YWxp
ZGF0ZV9udWxscyhzdHJ1Y3QgbWFwbGVfdHJlZSAqbXQpDQpAQCAtNzAyMiw4ICs3MDUxLDkgQEAg
c3RhdGljIHZvaWQgbXRfdmFsaWRhdGVfbnVsbHMoc3RydWN0IG1hcGxlX3RyZWUgKm10KQ0KIAkJ
CW9mZnNldCA9IDA7DQogCQkJc2xvdHMgPSBtYV9zbG90cyhtdGVfdG9fbm9kZShtYXMubm9kZSks
DQogCQkJCQkgbXRlX25vZGVfdHlwZShtYXMubm9kZSkpOw0KLQkJfSBlbHNlDQorCQl9IGVsc2Ug
ew0KIAkJCW9mZnNldCsrOw0KKwkJfQ0KIA0KIAl9IHdoaWxlICghbWFzX2lzX25vbmUoJm1hcykp
Ow0KIH0NCi0tIA0KMi4zNS4xDQoNCg==

--_002_20220718022718wtlw7grwp6dv5fcprevolver_--
