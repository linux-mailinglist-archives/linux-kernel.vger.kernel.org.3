Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0354781F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiFLBJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiFLBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:09:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2B6A410
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 18:09:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25BF4F0X017956;
        Sun, 12 Jun 2022 01:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SQZJrBN87+rdGd7uhawKRv9G0mwhR4lG35JK0NjmimI=;
 b=P1CG4OnSEd5s5QCllxaf4jQ6E0edaEPECJBIVlBabiTDAffEt6F2YSXCF63/ThjCt+FU
 /cIh4Iwc6FhPuV4sVZ7mCUS6JQ54Dl9ZHvLFDN4As8+kTKSv/yi/nIGxxqmHOX2TI92/
 Qa9O343ArRB8BnRIXJng6pTX9g62lhDCP8j9BPxlUtC+CIVTY5m/oTzWdvfm8eL33yE7
 KbTO6LNUfkqSBuA7G6fIgGx05pit3dkLx6sLzj1e4Bcj1qJT2PCSmJ5E1d1fv+4RGDj6
 +Ujk1Ylyl2QbdAOttgbeqvGvu+4kW94BR8/t/OCSbSAeqPg45rnZ6/9DhFdxmnPh4aRY iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns0tp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 01:09:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25C15PPB006619;
        Sun, 12 Jun 2022 01:09:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg7mu3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 01:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTEboKcKdhJGLsRnfu6av3J4HgF6J/n3O505TohaZikW1vFkdAEaL+FSHD0JoWIp7Nihgy0gVcA2jlbmJQEQwgksW+R3izjbQpHKBeAUDg5lhniP9Q1FPsRoRC150vZRchJQqFm/oYp6zZztdjjfdBi5EtdCRLDi97/SicXlkXfX92ySqE5qDe9V5vVeW9Jvdr7gbUwY7NrtpQPKVA45br8Pv9+yUCo5HFVZovE2JpkLrcmTmxQVu5+0K6m/FaVCg/nt4Zy2SRPebGLzMLMJ3kVCps1lpV5L4nYGQH52vZyGn9p95lY6bMn8zwh4JVVIULr+hxy5V5nOsmus5nMu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQZJrBN87+rdGd7uhawKRv9G0mwhR4lG35JK0NjmimI=;
 b=O4LixWFA6rN0PRP2q/1pSTgFzehXBKW2LJ+6QWoHVB3WRlludMOb3zC4MyZF0WPcx6yzovQzaeNOJcZgwD8bZclFiKS2+Zmsps0zZn/sIDG0itvUHcQZ1r5V7CYIc98s2PltZxbKIPlr3dyta6aWJrCf65uJspIRlce3TmwQ1jiQIGSV8aEiHwbSFa3ouLABaVEpmSZFKZioqFcK7yiJU99kWEk11dC+8+zOhv7GbYaNRziWVTIezDrquBaTwD96x/xcOaWFu3NHhJCt56C7+A7HRHD6fx1whFo6I1laDyelg3Ftf5kT+CPdJqAVIKd7lXBgfdpBvTwrt1n67jB7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQZJrBN87+rdGd7uhawKRv9G0mwhR4lG35JK0NjmimI=;
 b=nLZTie3pPPpsqFTWCf8mQcFl9Q2F1yt2CBeFoX6zbFbwVdiqsgKeZhUPgy4Nq7DZHroVrxXMSzynFyEcjuL05UHRvBg+wCjlwKeW9/n6wTHxv8btN1/lmwgzCCrZq38nRTnMsoRxgGGvUgljYCl4rIHE21gUYMK06HZthotE9qw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sun, 12 Jun
 2022 01:09:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Sun, 12 Jun 2022
 01:09:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCAADfRAA==
Date:   Sun, 12 Jun 2022 01:09:33 +0000
Message-ID: <20220612010924.6kg5ie2prevye7es@revolver>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-13-Liam.Howlett@oracle.com> <Yp3udPy0vuDK8khc@qian>
 <20220606161940.fh5edq5nyz4jru2u@revolver> <Yp4uD8uWB3rit/Ee@qian>
 <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
In-Reply-To: <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0ae825-740f-48dc-a57f-08da4c1035fa
x-ms-traffictypediagnostic: BLAPR10MB5203:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5203646910B5C695B64D13F1FDA89@BLAPR10MB5203.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQtjDCuh+Gd7yxY/tpFhHoCI1PKdonTRzaUZpm6G6g9lm6vmovv7hMI92P6c8D8G2oRjpvx1R7/xerJpyoaKFfJpA6J87N0LpU4jUo4iCsv/l5JdtlskfBC6voRCTFVVaAEFp9H6bvv7hP9/qbScprLaFBXSWRWgafAicZzU5EwFF5UUl+oZJIo0jqohhz9o6OG1lk0FX+NsYWmOhbxYAf5nxczNFtSiU8DwLZ+yqVkXCAQafecsbG9srcm+rdbNCZxzUakaTMrYBdOeKHmPNq0mGfw8SGYTpTTY5t7ckmlT1FQg7F6MYwH1kZcakf4vVMPBGjy44khFukRfIZJVkuE35vriseahx/+sW4J8qZxdsa3yXfywaAuQj2m/9Y0vAueA6+unGq6iAdgr6KoBkhO3JRX6kfIUgqgWhiwZqo1EZJ4EdRt9/PBc/n6VqAME9XC0ygZfdy70Akv3S7W1SH9FJVCGiChQqHiSBRdEjiXSs39wLYCpArPcb/dgj6gDS48Lvbv8SeIwMtaRoPkRfYYAsGJm873m6jTviylSXHygVegcSKZEUiBg3nFhaZW4YpbzRWNsAHDITkZTu2pgVd4XLzaEvgSu6ecAJDE3nnGpW+PSnLIucHaFGTHuBF+SDvK/yI7HpzwQDOk4FlMzIdRWHDZWVQRvmrW9rmmjqx/BepSCfvFWbL9y7dvR79rHwIikcU9ME7Pi2RG0UnBxZjBio/trV7N191yGO2ySCu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(4326008)(64756008)(8676002)(76116006)(91956017)(44832011)(33716001)(66446008)(66476007)(66556008)(8936002)(316002)(5660300002)(66946007)(71200400001)(6486002)(6506007)(6916009)(54906003)(2906002)(508600001)(38070700005)(6512007)(26005)(9686003)(122000001)(38100700002)(186003)(86362001)(1076003)(83380400001)(53546011)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kmbSrlcFEcx4F7ZAMYiTkC7HY1JDcOBB1Nxq3o8mJeVDFX7J0FfGs+kJR5Ot?=
 =?us-ascii?Q?G/Wet6uJFjk+S4cQEoQL9TYLzQVF7mLw39iqjiR0CrOpdC6m3h9oX4SNwWXp?=
 =?us-ascii?Q?PDoslmHZEH8uQ9M2i1NHBZ5koTLSP7qg5W5G1OO4b1xB8U7k3qlmZsT7pYiG?=
 =?us-ascii?Q?AW9rYmeJyTeUt98swG2T40MqJOSnrP5Gks77/hEkTrwGcBLwwdCagtsd4RFG?=
 =?us-ascii?Q?Tev7cmO2ruzVPloOtWpXEszE2lis2gUMfiH/MVXTfSAdDXLCc8Jg2x/PSs/y?=
 =?us-ascii?Q?tj4FLl2Dcc94+w/MNOeF0jCdJHKFYj3qMm9ItXUTmjA0Bnv9xkappyTWdA7C?=
 =?us-ascii?Q?XVS1IVJVsdMCkRNXpE8EHoYIHEawAMcy4hYCm3AQZLJ5SxSguirUOnL4yvNX?=
 =?us-ascii?Q?N+zAoVYlF2fbv1aiY1pFERMhwokse8FfVBUMnXwXxbxhjOZnVmNkKCUSIP/T?=
 =?us-ascii?Q?8CST4K0F/Rom7B49jp0sLlx1BFFgSCwuNrv6WmZm1wdwhsBFaPqlH/N8FmRO?=
 =?us-ascii?Q?/VnFjKMsGU/ZUlcD8YHBSkingb6aE28+S8uIB3WiTPF1su+jCS7f1Yj+bzzi?=
 =?us-ascii?Q?AbLLrEGji2sAKff+hwhp43AIvaWrxqawpTlg83WJPomYKeNnZvYjh5tYFcbg?=
 =?us-ascii?Q?iETVV2fiR42vhBMP14lvp0C01mnLMBlzSNWi7JNTy4hRZvvMiRfEo2CefjOJ?=
 =?us-ascii?Q?vy505NF4LOAuEJSWK5WwxC7WDU+Zs4GIYbMBj0REPBRdwuY/BHPt+5JWPybx?=
 =?us-ascii?Q?9VoPcIBYnIZ1cWL5KNDvo6VgGTo941CcnTmG5ID1c3Pou5u/YnWGQuWc1hoO?=
 =?us-ascii?Q?xA9j5prYPSUrD55aGMRPh2n9MK0P5CCCFtkWayvr0b6svEdqiiLwoYdniJDf?=
 =?us-ascii?Q?NLCzFSkpIh8BfVYXgVHLKFh9umOCMNHz0gzsyCWB9B1Io9DpJe1m/rl9ejxb?=
 =?us-ascii?Q?q6QylHwFpn0mEcWHDjkS3KS+lQSJ2O7Y04UCXGZOBBn32LW9y9ekJ+Ogxgnc?=
 =?us-ascii?Q?ytPxjTlLXHrHDwo5tnjS/bBZYXO3UU4OqE+vkYXgqdWGZWdioepe3OYM18Ja?=
 =?us-ascii?Q?MyQ29kiw7Mt/n0EHci+Zl33FKV/eO4cDVbWwATDX8D/FqLi6bwpgsCEGkJbX?=
 =?us-ascii?Q?uoQHCDygyD14ah/cx0BAr9BYdrQgV4dgX+f9pnztecPbWYSCG06vwXBtS64x?=
 =?us-ascii?Q?x5Xy5PCKRP1KQX32jbSVyBCqqNVDhs5QklabD+JWS6jMmXLV6aGr6eWkmsaj?=
 =?us-ascii?Q?4M1yMoYyR60G6DMCYNqovL10nQGzc95z0+yPkJXEW0H/LttRCODF/rsVjoSY?=
 =?us-ascii?Q?y2a56bLhXSZi1u0ZjT1lNJVIfC0VJ63Beugn+zOi//Kb6uriXZXeyHb9RdXN?=
 =?us-ascii?Q?83R03RMULRHY7tb410C8RovEwUrJCoxj1Qzf75a598qTX2bK+0rPPXDYDYwz?=
 =?us-ascii?Q?feUQnR1M1aYTFaiWkrr7DE0ss0i40vUx+i4o+qhdWRYH0z9BqW+kjt3PJoiM?=
 =?us-ascii?Q?I1jHbu/bwtJ32bbNxyFnxu5vCXnQKeJS6lHuApa/323R5HvDi7r/u6VmaXZT?=
 =?us-ascii?Q?wzcGM0r/+zlXL1qo/eah76BZQHk//hKyM1ZswS2ekqZrRZkquImI/fcYcx4t?=
 =?us-ascii?Q?w67yfbbAIJytrucvprgKrGAagkEefg4rJT9tgBmh6GN9duXA2rLeSQIlo1vz?=
 =?us-ascii?Q?Q47KO/n8fYh3DPJbC4h6dXwWyhe0aiTvI31EAjamKRYTgc4asaqKkm6a4jaK?=
 =?us-ascii?Q?eb1jcf4FHtewISt783qkkAV15DlY5hw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38C5C33F0CB5CA45B5B3050823E52F17@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ae825-740f-48dc-a57f-08da4c1035fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2022 01:09:33.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLGQ6qPJ6wsJHO/HKD6gmr4+3ex2HEZ5vxklEcUwrVTEyedDz/SVauOubXjdkYSzUQc9iN0PR8EHtzOlIHBvxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_09:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=956
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206120003
X-Proofpoint-GUID: hlosCUDVXKl3-zJinFSb4J9n9nv3fW9f
X-Proofpoint-ORIG-GUID: hlosCUDVXKl3-zJinFSb4J9n9nv3fW9f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220611 17:50]:
> On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wro=
te:
> > >
> > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > Does your syscall fuzzer create a reproducer?  This looks like arm6=
4
> > > > and says 5.18.0-next-20220603 again.  Was this bisected to the patc=
h
> > > > above?
> > >
> > > This was triggered by running the fuzzer over the weekend.
> > >
> > > $ trinity -C 160
> > >
> > > No bisection was done. It was only brought up here because the trace
> > > pointed to do_mas_munmap() which was introduced here.
> >
> > Liam,
> >
> > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > not mprotect(). Please take a look.
>=20
> Another crash on x86_64, which seems different:

Thanks, yes.  This one may be different.  The others are the same source
and I'm working on that.

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
>=20
> CPU: 66 PID: 18461 Comm: stress-ng Tainted: G S        I       5.19.0-smp=
-DEV #1
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xc5/0xf4
>  print_address_description+0x7f/0x460
>  print_report+0x10b/0x240
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_report+0xe6/0x110
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_check_range+0x2ef/0x310
>  ? mab_mas_cp+0x2d9/0x6c0
>  memcpy+0x44/0x70
>  mab_mas_cp+0x2d9/0x6c0
>  mas_spanning_rebalance+0x1a45/0x4d70
>  ? stack_trace_save+0xca/0x160
>  ? stack_trace_save+0xca/0x160
>  mas_wr_spanning_store+0x16a4/0x1ad0
>  mas_wr_spanning_store+0x16a4/0x1ad0
>  mas_wr_store_entry+0xbf9/0x12e0
>  mas_store_prealloc+0x205/0x3c0
>  do_mas_align_munmap+0x6cf/0xd10
>  do_mas_munmap+0x1bb/0x210
>  ? down_write_killable+0xa6/0x110
>  __vm_munmap+0x1c4/0x270
>  __x64_sys_munmap+0x60/0x70
>  do_syscall_64+0x44/0xa0
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x589827
> Code: 00 00 00 48 c7 c2 98 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff
> ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 98 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff9276c518 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 0000000000589827
> RDX: 0000000000000000 RSI: 00007ffffffff000 RDI: 0000000000000000
> RBP: 00000000004cf000 R08: 00007fff9276c550 R09: 0000000000923bf0
> R10: 0000000000000008 R11: 0000000000000206 R12: 0000000000001000
> R13: 00000000004cf040 R14: 0000000000000004 R15: 00007fff9276c668
>  </TASK>
>=20
> Allocated by task 18461:
>  __kasan_slab_alloc+0xaf/0xe0
>  kmem_cache_alloc_bulk+0x261/0x360
>  mas_alloc_nodes+0x2d7/0x4d0
>  mas_preallocate+0xe0/0x220
>  do_mas_align_munmap+0x1ce/0xd10
>  do_mas_munmap+0x1bb/0x210
>  __vm_munmap+0x1c4/0x270
>  __x64_sys_munmap+0x60/0x70
>  do_syscall_64+0x44/0xa0
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> The buggy address belongs to the object at ffff88c5a2319c00
>  which belongs to the cache maple_node of size 256
> The buggy address is located 128 bytes inside of
>  256-byte region [ffff88c5a2319c00, ffff88c5a2319d00)
>=20
> The buggy address belongs to the physical page:
> page:000000000a5cfe8b refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x45a2319
> flags: 0x1400000000000200(slab|node=3D1|zone=3D1)
> raw: 1400000000000200 ffffea01168dea88 ffffea0116951f48 ffff88810004ff00
> raw: 0000000000000000 ffff88c5a2319000 0000000100000008 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
>  ffff88c5a2319c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88c5a2319c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff88c5a2319d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff88c5a2319d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88c5a2319e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
