Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB552C98E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiESCEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiESCET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:04:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8384B1DF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:04:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMJJml009233;
        Thu, 19 May 2022 02:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ahk08GN0j8eqSQSqyMhUaeznA7Rv6yUDG8hx3SZluFs=;
 b=z0p041z9f/a0W4PBjd985Lsh7nQM8FebptvLkv8cWj5+PUnhMsA4WreeJBDtQ6bCt7to
 ZErY4c81eN0tsMF/U14wWkCazquW6utFcGR9rTYHwA2kmgA0ezEO97O0vqh/6gMS9Cbm
 Ui8rWaiZ3f7QNu7Tswi2pvnFMm2pxei1BrE1wfRgjY0d2Q90N91uS7pj6Nxpi0sNR+E6
 RBDSIn3yKAORjQnd9rh4r4NHaZvlqOhCSG7f35Hx+LVOdGhHUEtM3GznCml5HpE2FMM0
 lJCIhB4Vrn6DM2eeFqEsjlDX+nMk8I5CeGfJtpVbtkyTiO06F6iyGCIoa/b/HN+wLQ9x qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310txw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 02:03:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J214dg021088;
        Thu, 19 May 2022 02:03:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v4tceb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 02:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfDyZ+O8oIds9CKesPkoCz9QYHHam5ezQfHS+yGoAdyK9yqXOkGNbFrxsVkjDXStEkPcpyaZF3UkS8nGsvb+2YcQ9xcDhZ1vwDm6duUck8bsqcISUbucZCEh3uzEmlYN5zb2fVPaeuQq1veaYj0EEBEQRBU9lpoR+WBH7DiVdiNiBnB+3b+TMWi6TSLzzmtlRE5QNxpf+RBO9Au6ArSImfzdXusioPKse4CjwrjzI+K0vAWbsh+ZKRoarM5j28C5wraXaBzbDhfT20rAjjA0MG28smXv/8yPNwo9+SGKcmcNlyGm6aLzyU4J49fEJ/oGS1Bug/z8ppX2FRCaz0kA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahk08GN0j8eqSQSqyMhUaeznA7Rv6yUDG8hx3SZluFs=;
 b=aAk4ALxuWCxwjBWd1ThaVsnj/JqNbXu8Nj+mYwYnF86vJEQ77oZaPZZ07uBWf61lC/tqlkpe5pNFW2UJUMOan0j19w/kfQb14g1xXlou2V8lNbn7toORCKNoqhNYaNDPaN2GRQtAUHIOnETf3mYj1Sd2sjjeKfC1yUwJyg0pNjbaBh6TyVqpOFpNimybcdsRT7lUVhNwlhXPIYl9UMSE/gIes9Aa+rH3qwRzR5SblJDCal1hkILcpnjr1MVpTLMhnG2oYajWft9Hn856odmHG7zip8e8MODuj+o5o3inifwWCyhEvBUVXBKJlL4NxzdX7MDTM8pFbhtVrgetkLaKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahk08GN0j8eqSQSqyMhUaeznA7Rv6yUDG8hx3SZluFs=;
 b=AiE1B79V1Qkb8FCgyeliJ6SRBOqRE+VfjqTzbUmJm8gzTdcN+eY6Xyf57Dv0wsrr8de00owuS3AO/IBbd1nhUtncrHk00eb1CDeJkt/aO5uAT1CO9nqII+yaeXO4X0WLk1Ls456vLYUBEV8G/gYVFP1bp1+3+pX1ov+G0ta3fCk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 02:03:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 02:03:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Michel Lespinasse <michel@lespinasse.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
Thread-Topic: [syzbot] general protection fault in vma_interval_tree_remove
Thread-Index: AQHYXh0PTeRSgseYNUW5AO29cTaGG60e404AgAAI3gCAAvUcAIADq9CA
Date:   Thu, 19 May 2022 02:03:53 +0000
Message-ID: <20220519020341.rr3s6b4dr7o36cqb@revolver>
References: <0000000000007f31db05de0638f0@google.com>
 <00000000000057d2f405defe7e00@google.com>
 <20220514135010.2528f75eb053a7b38d80584b@linux-foundation.org>
 <20220516175958.cswumupmeddptzdb@revolver>
In-Reply-To: <20220516175958.cswumupmeddptzdb@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 991c4b7d-aeb7-4946-5df8-08da393bd389
x-ms-traffictypediagnostic: SA1PR10MB5784:EE_
x-microsoft-antispam-prvs: <SA1PR10MB578453B376ECB36D53BA77E7FDD09@SA1PR10MB5784.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uKwGVLOo0fm+Ey4x6B21FXsWY8fybHDrN8NRZ33sp9M/NzeUvy3fia5kOWeOzJdviMXyA7ofR9zDV9+3oYKOrp9t9O3z4uXA7ranrcntg4K/VXdYLbXf6dwaCr+bqMHIHzToAb6YRcz4GszTR34Aljg/lH9OkDxAc9zawGzErpDNgak/8AsHrSyDOy2YH+1LpiN28P2pOxsfPbsddmjqAt4I2Qy8OpaQgFYa8WHo+mMaRP6evAAmCzbpah3jZOxKTuqTsWmT1+eyO+1czfgWqT2FfctZTQkdNSom+zsh0KQiGvxBXgyVkdUxl6PP1AjXBjbbM2jT1UEGL1aY20VSGzllh6/M4nV5zfTp68H1Ob9Tza0jPz1VcZquWWtr1d3f5j+hHUhgti7RmWLOt9V0941SGLAyI8cNPIrqjmamVqq5Q9p5Dl/+qOQJAV/ZECqfUUuTNXZtv1J6SRGAGrFVUp63Ov9LfRHTBQkcm1No2iaC+uUiRNO400FDHI8PX81KUngoiaVRE778sizcwPkAOVfDogGMtAxNX3bosAE0EMBqwJL1mUEc+n75raiYULvgfJm9BwKh0UcPoUjIrUdODYLmvP+meMko9o4br5c8QOtVF7k0PFPn9+WnXUoGIRsWYHHSLjpLLFAfe/krSgB0Ml2DY+UtWLqC2o+7Mg01RO4c118RZUjG1rEuC+WcS3nNjJyhf5WMBdee4O6bNZDnQ+LKYNnHE6UqQ6OowCuGQhA+ytwVLnmIwWaMHj+1v+HPP+KfsjiK+25QuAqkoTt7ijBeZgHlbZel68kZLhlpnjr07jkgS3XKFla5C9XwxzkcjlGBOOsPd+szoTqFY+CVfIczaYeKPc49NxYbbSP4/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(86362001)(9686003)(71200400001)(66476007)(64756008)(66446008)(966005)(6486002)(8936002)(6512007)(99936003)(44832011)(66946007)(26005)(76116006)(6506007)(91956017)(316002)(38070700005)(1076003)(8676002)(110136005)(5660300002)(66556008)(186003)(508600001)(122000001)(38100700002)(4326008)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7CzNA4VdjNgM6Ob2S8XZN1HSxA4HXt69VqMEnOmEHiT07ZHS5fIowtRBNVe?=
 =?us-ascii?Q?fypN93gZVPkdIt9kS/6ex5jGBsMugtDC6OO4XQRdl0ts5vpAwyqJYQzytBDq?=
 =?us-ascii?Q?ugZPR7U7Xmzw9eYrQ7/7VNYyOinefYGMbiYGfO9APA4bVSYw6Ul97U519IS6?=
 =?us-ascii?Q?bRqTGLDWBth/GiuaS+E5EpN8nKpDP5K+l5P5N+D+RGBwqZ0Zpn4vy14AnAPo?=
 =?us-ascii?Q?6NOCac3WxOUJgx+jUHS7EpWjQzCdWHU2AzKvk9lGp3b5aNGWDWkeOJMvIY8l?=
 =?us-ascii?Q?2aZJkviR3kHK18Vrl7Cz3qCTfQvkJUVoOFM6nhfcryP6UwPioH+tw8OHJS5C?=
 =?us-ascii?Q?WskRI1mDWVf7Op9j/PVWw6CLgYnYtOZRnwLr56vtL6xCDPSx3xOysOjFUTG8?=
 =?us-ascii?Q?tGTGXgI7wHGoFw3v+uh1Ceaxhzb9b2SVgMZYe75Dt/sEq8QkO8fO4sty8WaO?=
 =?us-ascii?Q?gPKu5wkZphwrUUvVN3ouSoMqRiN8jiw8DlpTLUOGLxiTNkWtHVhT/NoNZCD0?=
 =?us-ascii?Q?c+n8w74z2PuZw7jgk1CLF8ZZ/aSSVcfWYZflUuPcafQ+t0j8usK9SrFt6N1I?=
 =?us-ascii?Q?UxUkughhT2h3i91A3/JaddaYwC1R9hUx6jjxlGEEswM6pH+FWSm2C5m3kcSj?=
 =?us-ascii?Q?WEBBIcWq+b/hvCrQNBM6dWSclPrAw20wXe7MxK+Tw8WL4EHAHTJVmKYmbJuq?=
 =?us-ascii?Q?Rs9qBjaqjM/RlssdhnyAwxjudx/Eql5F7LfWqhZk6lIvQpqpVTRnscQtmxCw?=
 =?us-ascii?Q?RECkA9GpAohDjoOXJxYdAxg1X5PlA81wSm9lq5J9wWLwxfGNhGa4ODhhoiIr?=
 =?us-ascii?Q?NQ3F27VPkvlMHUuOIc/wngQ53jThVpQm+WN7nhKgxl3oJ6FN6WjRvRR1fqvt?=
 =?us-ascii?Q?IbWQ/wj9cBzqhn70L1yomy/OFkm5tQxrC9GWcurZysrlIpklb81sr1FuBx1G?=
 =?us-ascii?Q?1OEo/0iHoxnHK4KHMMwY785GzZlyn/SoAGMG0FWVfAGqXShokwMxPPq6gFCM?=
 =?us-ascii?Q?MYv2W3NbokWmP20fnQCeFVvToa6kye6Rzy9MX4wJ6fdwYY/yXbX0AgxZ8S3I?=
 =?us-ascii?Q?FiLOF5cQH3YePQkQkBbXHMlfFclcX/JWKSwRRcGQwCuD+ErtobFPYsZHNoE+?=
 =?us-ascii?Q?vuHDBXd1+lQYqozV867x+98EtriXG1TZb+DEg+EUkUtUq5nw3xVFlcWq2UQJ?=
 =?us-ascii?Q?exRZvyYQpaTFOak+us2P8m4wKTNaa9Y72YR/ErbSuni7zVHWjhpSXY/S8Egm?=
 =?us-ascii?Q?tz/W7QT+IMf+CS1mkVQc0JFH5Bh1DHKDo1SjDkINx/iXuKAtbhGPB9B8rNyT?=
 =?us-ascii?Q?ERWLp6pbXVyOm8pzlcSGexJHDxJzxUAZrVzBB4Gh0LxmvnYa2TtTpF0Ffkku?=
 =?us-ascii?Q?q37dQ3niwi1XLxGi8yIdWuWRfpDqIl1BZF4CpO/zqQi7Wrooi6gzk1rkzWm5?=
 =?us-ascii?Q?zg1J7DBptC4DkPDj6poL3Pg3vidOMbtTY0CdqYtazL480FtWeQpNgT8fz6Mp?=
 =?us-ascii?Q?RknyDxlL6GQLzW/2OPo0GCMQFBysfBZHWcisMBRztHb1NimQnGSoEwUjRs9U?=
 =?us-ascii?Q?8eoSQ/6P6Xfj7ghypYfhGvTQYC4sh2ymWDvWqyJriFRNvIdPq1M420uTC2Uu?=
 =?us-ascii?Q?dJrN5fCeqBaxOWuKCJtYOtyJlBPoHAuRWteqL6rc6DZq2MSrG0RBuw69jUfx?=
 =?us-ascii?Q?fzx2dLDcpQV0Xc0IYrFgc3oEmVpgO+wlGce2QmVbPS6AsMUub1EFzuKHy4Js?=
 =?us-ascii?Q?SfFGx42HiQNwuvbzG4xCYY1IFuAiHic=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220519020341rr3s6b4dr7o36cqbrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991c4b7d-aeb7-4946-5df8-08da393bd389
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 02:03:54.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdgYWlFmZA5fq/YPnLm81nGzy4hJx6Eta8/CF6UouuD7f66LQ5D1OSVnpZinuO7/MCg6VHni3C/NDExDbRrXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_06:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190013
X-Proofpoint-ORIG-GUID: 51mmXMWlTGjMMedJFeem4NUqpmy8jmaH
X-Proofpoint-GUID: 51mmXMWlTGjMMedJFeem4NUqpmy8jmaH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220519020341rr3s6b4dr7o36cqbrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D4D015B5C240643B10DA2BAAE84FA8F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220516 13:59]:
> * Andrew Morton <akpm@linux-foundation.org> [220514 16:50]:
> > On Sat, 14 May 2022 13:18:26 -0700 syzbot <syzbot+ee1fdd8dcc770a3a169a@=
syzkaller.appspotmail.com> wrote:
> >=20
> > > syzbot has found a reproducer for the following issue on:
> > >=20
> > > HEAD commit:    1e1b28b936ae Add linux-next specific files for 202205=
13
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11da21b9f=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De4eb3c0c4=
b289571
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee1fdd8dcc7=
70a3a169a
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D142757f=
1f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17cf0966f=
00000
> >=20
> > Thanks.
> >=20
> > So it was there on April 28 and it's there now.  Liam, do you think
> > anything in the mapletree changes could have perturbed the interval
> > tree handling?
>=20
> It is certainly possible, these two trees are intertwined so much.  One
> area that sticks out as a possibility is vma_expand().  I created a
> vma_expand() function to handle growing a vma and potentially removing
> the next vma.  I do some interval tree modifications in there.
>=20
> I'll add it to my list of items to look at.

This was my bug.  I reused a pointer that wasn't reused in this function
until I altered the error path in this commit.

Please apply this patch to the maple tree series to fix "mm/mmap: use
advanced maple tree API for mmap_region()"

Thanks,
Liam

--_002_20220519020341rr3s6b4dr7o36cqbrevolver_
Content-Type: text/x-diff;
	name="0001-mm-mmap-Fix-advanced-maple-tree-API-for-mmap_region.patch"
Content-Description: 
 0001-mm-mmap-Fix-advanced-maple-tree-API-for-mmap_region.patch
Content-Disposition: attachment;
	filename="0001-mm-mmap-Fix-advanced-maple-tree-API-for-mmap_region.patch";
	size=2000; creation-date="Thu, 19 May 2022 02:03:53 GMT";
	modification-date="Thu, 19 May 2022 02:03:53 GMT"
Content-ID: <42502F589680664E81B9B6977B2736DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwYTM4MTc1M2QwNTg0Y2EwMjUzMjg4OWE1ZTg0YzQ4MmVjYmMxYjlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBPcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAxMyBBcHIgMjAyMiAyMzowNzoxNiAtMDcwMA0KU3ViamVjdDog
W1BBVENIXSBtbS9tbWFwOiBGaXggYWR2YW5jZWQgbWFwbGUgdHJlZSBBUEkgZm9yIG1tYXBfcmVn
aW9uKCkNCg0KT3ZlcndyaXRpbmcgbmV4dCBwb2ludGVyIGluIG1tYXBfcmVnaW9uKCkgYnJlYWtz
IHRoZSBlcnJvciBwYXRoIGluIGENCmZ1dHVyZSBwYXRjaC4NCg0KU2lnbmVkLW9mZi1ieTogTGlh
bSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRAT3JhY2xlLmNvbT4NCi0tLQ0KIG1tL21tYXAuYyB8
IDEyICsrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMNCmluZGV4IGY3
MDVlNjg5MzFjZS4uOWUwYzY1N2MyNjVkIDEwMDY0NA0KLS0tIGEvbW0vbW1hcC5jDQorKysgYi9t
bS9tbWFwLmMNCkBAIC0xNzY1LDcgKzE3NjUsNyBAQCB1bnNpZ25lZCBsb25nIG1tYXBfcmVnaW9u
KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBsb25nIGFkZHIsDQogew0KIAlzdHJ1Y3QgbW1f
c3RydWN0ICptbSA9IGN1cnJlbnQtPm1tOw0KIAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9
IE5VTEw7DQotCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqcHJldiwgKm5leHQ7DQorCXN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqbmV4dCwgKnByZXYsICptZXJnZTsNCiAJcGdvZmZfdCBwZ2xlbiA9IGxl
biA+PiBQQUdFX1NISUZUOw0KIAl1bnNpZ25lZCBsb25nIGNoYXJnZWQgPSAwOw0KIAl1bnNpZ25l
ZCBsb25nIGVuZCA9IGFkZHIgKyBsZW47DQpAQCAtMTg4MywxOSArMTg4MywxNyBAQCB1bnNpZ25l
ZCBsb25nIG1tYXBfcmVnaW9uKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBsb25nIGFkZHIs
DQogCQkgKiBhcyB3ZSBtYXkgc3VjY2VlZCB0aGlzIHRpbWUuDQogCQkgKi8NCiAJCWlmICh1bmxp
a2VseSh2bV9mbGFncyAhPSB2bWEtPnZtX2ZsYWdzICYmIHByZXYpKSB7DQotCQkJbmV4dCA9IHZt
YV9tZXJnZShtbSwgcHJldiwgdm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQsIHZtYS0+dm1fZmxh
Z3MsDQorCQkJbWVyZ2UgPSB2bWFfbWVyZ2UobW0sIHByZXYsIHZtYS0+dm1fc3RhcnQsIHZtYS0+
dm1fZW5kLCB2bWEtPnZtX2ZsYWdzLA0KIAkJCQlOVUxMLCB2bWEtPnZtX2ZpbGUsIHZtYS0+dm1f
cGdvZmYsIE5VTEwsIE5VTExfVk1fVUZGRF9DVFgsIE5VTEwpOw0KLQkJCWlmIChuZXh0KSB7DQor
CQkJaWYgKG1lcmdlKSB7DQogCQkJCS8qIC0+bW1hcCgpIGNhbiBjaGFuZ2Ugdm1hLT52bV9maWxl
IGFuZCBmcHV0IHRoZSBvcmlnaW5hbCBmaWxlLiBTbw0KIAkJCQkgKiBmcHV0IHRoZSB2bWEtPnZt
X2ZpbGUgaGVyZSBvciB3ZSB3b3VsZCBhZGQgYW4gZXh0cmEgZnB1dCBmb3IgZmlsZQ0KIAkJCQkg
KiBhbmQgY2F1c2UgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IHVsdGltYXRlbHkuDQogCQkJCSAq
Lw0KIAkJCQlmcHV0KHZtYS0+dm1fZmlsZSk7DQogCQkJCXZtX2FyZWFfZnJlZSh2bWEpOw0KLQkJ
CQl2bWEgPSBwcmV2Ow0KLQkJCQkvKiBVcGRhdGUgdm1fZmxhZ3MgYW5kIHBvc3NpYmxlIGFkZHIg
dG8gcGljayB1cCB0aGUgY2hhbmdlLiBXZSBkb24ndA0KLQkJCQkgKiB3YXJuIGhlcmUgaWYgYWRk
ciBjaGFuZ2VkIGFzIHRoZSB2bWEgaXMgbm90IGxpbmtlZCBieSB2bWFfbGluaygpLg0KLQkJCQkg
Ki8NCisJCQkJdm1hID0gbWVyZ2U7DQorCQkJCS8qIFVwZGF0ZSB2bV9mbGFncyB0byBwaWNrIHVw
IHRoZSBjaGFuZ2UuICovDQogCQkJCWFkZHIgPSB2bWEtPnZtX3N0YXJ0Ow0KIAkJCQl2bV9mbGFn
cyA9IHZtYS0+dm1fZmxhZ3M7DQogCQkJCWdvdG8gdW5tYXBfd3JpdGFibGU7DQotLSANCjIuMzUu
MQ0KDQo=

--_002_20220519020341rr3s6b4dr7o36cqbrevolver_--
