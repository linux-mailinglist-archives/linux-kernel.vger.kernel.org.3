Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482FB58CEC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiHHTwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiHHTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:52:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6FE1A04C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:52:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278Itaqx011361;
        Mon, 8 Aug 2022 19:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hAdGRT4w3JvsXMGZrS2yfjWuox4clH94kmuncOOAHII=;
 b=wv380nSiTcFeOGe8pBgmaSx6/RowNEoVnk+auL0lm+4+Fmgo0QzcGaNdMJ6ADPwwPdOL
 zPJBaLuFdnr7ZAVy5h30Om+MJsropKxqYmFIg3kH0pRVC6CeybiFpnLCkljCkipAfKsp
 OnEfyswwumsv317HXl7bUPhLyd9ovh+tdCX4iy1gBv5knI5P/iH+upvrC3JQFN169AYO
 /FduXk+n/Vi9ZSuhiorH0OFLtCYB3cS7sOxYPzDePLntU4Zmqs79vLNalN19vsYHEyMl
 bTWaogh5x1x3+VQcBRwbjbv6yLsWZMTH6Anseff/hAXDdjTnAB4wmaXxygXv2c6DTRs1 Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsmm6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 19:51:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278J1ucm028040;
        Mon, 8 Aug 2022 19:51:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0n2x7ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 19:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUv/wyN/cNo8c0gwkkVUcERbWu2FB/8mCOz1RRDLUgn+UJOY4rjBChZHGjx0mDv7B4tgGytBR42NoYQxfr+QyVKuTBSc6ebYnfWJ59wPvNKgii5eRuCZNZMLFpW0n9tK1d8Mj3Hpc7oLyemXCjAjRSax3H/QUZOowR1dKaOjWNGSVgW6FOis48lywdaWNx7iRDnBRJEuxVXClCoRitbmgoJ8mYz52vahhk2knDEWnU/hbBUc3vBo9jWoM/pzBNvfhO3ZJO0J1pJdotmA7nSyvQBEclLO4B1AkYoJtT/so8/l8ZScJcGbAouN/xD5YLosJLaTwvkfNuiJe3G8xJt82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAdGRT4w3JvsXMGZrS2yfjWuox4clH94kmuncOOAHII=;
 b=gFwGfa5HqM5D5RxnoQKgegeaszMcL8SD1n7o7b35YNiz5oGpk9axDyDcyV6dp+zHD7r9Y4+M2oqyWUjWLcz6nIGLEWYKALSUNKLsCdc0h04Uq1ormK7geskErd0Mtn7E2Y7Ez4Dv8zh7lDzsb8wo9F6D5rO85idyTbN9dao0LQD07URwH7H1Xm8R1GI0YLzjfsjTbNh+U8ckLg0ua+NF10GtngnmMNTjBCjCocfgdalFvaj1DJANFlv91BsDMQ92mDpu7jwxDwn0B9qrRZxlxxIKSx1B9HSzbFIXQdErgiE1VV8ZoW/bHsj6jmmxLO9217Pk94TKSEgMeqx5XAXd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAdGRT4w3JvsXMGZrS2yfjWuox4clH94kmuncOOAHII=;
 b=yAhdxG6PPPszsFnJ+RBAiLm79hyI065ZWpTUg4d6qI6SJZ+umf8oSrIclvWnSsyH6dOXD0A7fEFN+GbGEHw7OiTkMVae6AnR+T7rPHlSZLC5v3XdztPVZiH2wOkax4u4Q1ojoFONl4OjHm7n9pLGHqOC8dcm3qA5889mWabAbx4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 19:51:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 19:51:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: Re: Binder regression caused by commit a43cfc87caaf
Thread-Topic: Binder regression caused by commit a43cfc87caaf
Thread-Index: AQHYqw+ISmpRZPmLpkiane2Iritf5K2lGuGAgABPlAA=
Date:   Mon, 8 Aug 2022 19:51:52 +0000
Message-ID: <20220808195146.im4diqaqnmxkzo5t@revolver>
References: <CAFqZXNtNjQLpzu4CFiMawfkKeVFULw4ti3MdZL1QejPrzeJv8Q@mail.gmail.com>
 <20220808150657.liop7yf5hsutbpp3@revolver>
In-Reply-To: <20220808150657.liop7yf5hsutbpp3@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c433c2-2c57-4470-86b6-08da797770fd
x-ms-traffictypediagnostic: CO1PR10MB4513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X70F4ApO1CNhlT+pomcOiryQ6XU+2uxUy0a8H7n3i37HXGGGu7LKAOjR5bMzRWkA43UTHmCC9ZDEMNqYgfoYegoqYpcKcyXevG00IRaKYsGwD8qq061q6RMWGMpRaGsLflAO8H40vYSWvpyHhiPyiKyAeDk1s/H2KcUhVhdtUZPaaiXj+Ebkl2BgJRMYpf38WxgxQ5czXiXNdS3FytDSn2qtz2trEKK481gW+6vFtMaF2H0WzctvhWY2VoKKGAyQ+OAj0ItJB94+OeHOGjyu9udxWprlDDqFnnZ1GpIECUL9qoUNDTyOQn5rxrs6zrCBC6v/K87z3fMflBxYaOiM2gybtqT5DZLKa0oWhNyfpIyKclPDOUXV4cQmVLWpXnnMnjwnf5ADu9R7/McfQfMvrGeQR4ElnRvKnVO8lvwKe4KSaqK7qj97zJ5fqSGB6xPgqEcG5HwVxh3WJu9OgkJPBVieQr9iPKOS8Cy+wdR9puH4t/CgDaaMEVg2aIGRxmOmL9NvOHiw3ihQRDFJP7rO0VSJtP462j9F5+/h9+SgJdkxfKviFrmdBn5W89EmY0RQL0xDizn1jC2Q7YVduyClVFj9RHrqOgUfjvk63NAeq/f9LnttjNqn2j07c9BkjW5p3WIv+CzW466uLKa3B0Xo/pf5ErVPVtHZCd4SxP1FZTWVKtPM1jqYZfdRYnO7DNTzh2AzWfKSDqhbNcdnVk4eBoONiHv4FCeLP9RO2Tmic2S/NZGOhzeCQFrSEIoTcdKpV1vTWjmlgJ1wTvMyldVqFz70lWHynXhBGZBhbUDqBH3kryd6M+xD/i5io4m1QPFF79H9r3UZMvo+/UodI334sQnalJcfQ5rztm3RC6AsD38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(41300700001)(26005)(6512007)(6506007)(9686003)(38070700005)(86362001)(122000001)(38100700002)(83380400001)(1076003)(186003)(66476007)(478600001)(66556008)(66446008)(64756008)(8676002)(66946007)(91956017)(4326008)(8936002)(44832011)(5660300002)(2906002)(7416002)(76116006)(71200400001)(966005)(6486002)(316002)(33716001)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ArpX6gv8eeFoGTf/7HpylZwBBYiRhg79Wi16S2CxkIgDH7Qvw0+s/hFiwt?=
 =?iso-8859-1?Q?r2GvwY5/Z89rCPHsP85VfhlFPpzjPU9nxCu1I1nkMaEjXlc4tVpiFd5blO?=
 =?iso-8859-1?Q?tm7K3dvJHxhh+YVFrZXU2x5FaOoEBv/W5truRoehnvU8bM76ogjAWDsUK6?=
 =?iso-8859-1?Q?hzOhUx8er0TqsqWkuyYt9H01BRwZ151qd21TzzykJt4jDYuHlYM1kVU9y4?=
 =?iso-8859-1?Q?DzrOHcJx7n2Ml3yQ2P+eGwoJ7hfaASqD/XLB0sBj1p6VCYw7TPzK+LyXdr?=
 =?iso-8859-1?Q?1+lwCy385/HjS65xw5Rv9eqBi6FEwpK/rleUEyUecu22qVrP4CgFGZx18X?=
 =?iso-8859-1?Q?suTPq5wOXHUeMG+1rq3B1w5Y+VrUjjm1EzWDI0PYSAbjctoU03GvIJ5u9w?=
 =?iso-8859-1?Q?j85Xfki4cK3geLADtDWFyTBBnxtwqKhvqDSqfKmLvLIBzcjHCl/bDYag6o?=
 =?iso-8859-1?Q?OzKhA5hJcvfwx9wZIItDURp9xB5qmm2xdUOARICs6bSOv4BC33Jv/5Q6uR?=
 =?iso-8859-1?Q?nLnd1Z026hqPhG/AvsVHMdAnCQYmob6sTkDCdCpCk0EF8SSWAyjpDS7JfX?=
 =?iso-8859-1?Q?1W4hKSpzkj+pWy1/eSmxM+jfsy+OqsL3RyZwEOFMKdskFF7QbVbc8/0jTs?=
 =?iso-8859-1?Q?RN/bVNPNeLmpB2AhLUnLu4H3MBykd1VFZBAVzNW+E5vk7s5ntwtYXg9uNo?=
 =?iso-8859-1?Q?eCe7tztz32B8zcy+US515dt81b0RrMy67I9Rg/vk17wUaUQUEpi9DvKZMi?=
 =?iso-8859-1?Q?KFFFc3JVl+VMbbwWY9HM2Fs42buHmeV+L8yCXskdtePAjmB82hvO/uVDYX?=
 =?iso-8859-1?Q?4OIZVqw+PI/h6PJlwbRRxobkuReW6HYqa2wh5Nh62Q/iDrWH+LJ6em1vMw?=
 =?iso-8859-1?Q?DppxR4g2ObUf6fV0zH9e8r81zUXfpbYJHI56ZZVXQgI3rl9vc3rx/78LGT?=
 =?iso-8859-1?Q?QE1p4FjsC+Il8bHer1vIp/NCrvCXPqwbPRupemYzLAg7VjXsN+MP5dTeys?=
 =?iso-8859-1?Q?r8nar71eg1iGWhyZJ/fQPaxJJHxWsAEL06v4VinpV/3VycpIcro0KPIH81?=
 =?iso-8859-1?Q?qYma9NjaRrhbglA9UijNVom/UnFQ8eIjHdk9wcZs7PxW9zPlkn8G65vG3B?=
 =?iso-8859-1?Q?HPpQu189+zBcGqgUV4FMv87/1UC/OrO365EbRr/6RAihZrZlfAkdnqAR3D?=
 =?iso-8859-1?Q?h03s/2YSN5PhOQi7cXNYHazD2QKt15NiCRmQ3qe5yU8h6Tp5HL3s6IiCiL?=
 =?iso-8859-1?Q?rUtUlIo44SpNFR9pgz3Ta2Xb9KlshqdTvqA3WwtYYsP7hWfsBMSM2WS+cq?=
 =?iso-8859-1?Q?naVqm7uy26FkSiAkzZAcdG0DeJds5lKEhOd05b+3aN3X+U3EoL7vI10gtH?=
 =?iso-8859-1?Q?jcnMXOQCsVExCBhDadMDufuN7xPq64OrKB12jdYOluFsgZm/CRhtpl4/PZ?=
 =?iso-8859-1?Q?eXmNKiSdh7wwCFHSefJP9mAOJd5s3bXRlkRX2oogBqHTE4xgqQRB7y7snN?=
 =?iso-8859-1?Q?dyfnia0giLPNjeQvbwL/Zl5xav0rkiKimV+6XvZ9mEy2/J1z20uFcM13wp?=
 =?iso-8859-1?Q?rep0g5cnXRZYnA+Iog6KDtXRFtXk6l/Uryu66c8Xjbg6SvxHFhBRVf9BPo?=
 =?iso-8859-1?Q?noZTnzDl0Li804hg4d+8MbgwaxA7dma1H0tIPYboGZMZZwZIke/QMckg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6E29A34D11C567458DF03715926F73CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c433c2-2c57-4470-86b6-08da797770fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 19:51:52.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AS75wUowcEmknMZlyG/Xmm8SzUyl/TTPnZp8fTpUVOffHcL4tkpnNmN3N2erbqRo+WerxTT+3egyQr/2v46+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080087
X-Proofpoint-ORIG-GUID: Bzn_CtP0Y5LT8_d4Vjbov0rIMIPmtKOX
X-Proofpoint-GUID: Bzn_CtP0Y5LT8_d4Vjbov0rIMIPmtKOX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220808 11:07]:
> * Ondrej Mosnacek <omosnace@redhat.com> [220808 06:13]:
> > Hello,
> >=20
> > FYI, since commit a43cfc87caaf ("android: binder: stop saving a
> > pointer to the VMA") (found by git bisect) the binder test in
> > selinux-testsuite [1] started to trigger a lockdep assert BUG() in
> > find_vma() - see the end of [2] for an example.
> >=20
> > A minimal reproducer is:
> > ```
> > git clone https://github.com/SELinuxProject/selinux-testsuite.git
> > cd selinux-testsuite/tests/binder
> > make
> > setenforce 0  # if SELinux is enabled
> > ./init_binder.sh || true
> > ./manager -n -v & sleep 2
> > ./service_provider -n -v
> > ```
> > Requires the equivalent of libselinux-devel, make, gcc, and git-core
> > Fedora packages.
> > The last command will trigger the BUG; on good kernels it will
> > successfully enter the ioctl loop.
> >=20
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > [2] https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-publi=
c/datawarehouse-public/2022/08/07/redhat:606549366/build_x86_64_redhat:6065=
49366_x86_64/tests/5/results_0001/console.log/console.log
> >=20
>=20
> Thanks.  It looks like binder has some paths that are not taking the
> necessary mmap lock for using VMAs.  I'm looking into it now.

This does not fail for me, are you sure this is the reproducer?  I see
the manager and service_provider communicate.

Looking at your trace and the code, the bug makes sense and I have
something that will probably fix the issue, but I'd like to verify.

Thanks,
Liam=
