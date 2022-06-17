Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD054F896
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiFQNuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382523AbiFQNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:50:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0044A1D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:50:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HCtf6o022342;
        Fri, 17 Jun 2022 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+TotOA5+6P9femTNyNOuccQjnq1sGjgF/DmJhj0Qcn8=;
 b=GOSggTpZkSFyU9pk/ibKB7ZIcFhZqCD49RU10O4lrSRlogzWqZcvu0sI5eWrMjWypQ7O
 ZBiCADm27AHhrEuOzJRdJ8pBzFzEP3P9wrtDwNP+7alI+OyPTYDJ5Fh0lRghOgdWK0aD
 BJexrxl7sjavt/neMvTBwB7vWrmTgHlDffgghVTHeYFgGOviz6fWettYOiH5y035sz0Q
 edsOaofO/ay62EVoM7SY4QEHqtlUNSzj4KSbPvfkyzUtPiNDh7Xunch5gIiTMMy8DKdP
 iLsDsuN7kQKB0ygFF09LDi0+vmVco5B7rGye+IazNNN8o9G/NWuY8xcPUOmxK3avI5Bm BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcwrqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:50:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25HDWI2L027571;
        Fri, 17 Jun 2022 13:50:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr285aga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 13:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LebHShjZIn2ztZXmV2sBjHKxw0oZ7vPTKeIXOk8fdJ61VaaoAqv+3AWI7MaJHUIk0GPLcaG4pu3o9B387rMQi9qCjfvVj3y7po6dRKBewpRThiX9NBjlgGOpS9LAKg+s4qZblotLzwUq+Nw0Vk49ljr8EI9Gz1GfZK7wkRjDW7k3tlT96G56DxMtEm9P+atTU3oAaoX1kNKM8lMec0IPy2r3zgHImJwBNSbPG0nWK2yemDE4Dpb8upM+J3lBa7BO4LC6EZ0ITmkWdjWCW3sUwLVsEJsmZQEFMlNefCMIy2GvlOBu+pj9jPzQouLu51sVj6oj0OdR7nU0eSPzaoEm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TotOA5+6P9femTNyNOuccQjnq1sGjgF/DmJhj0Qcn8=;
 b=iwuzorRGPNYZBSNDlHxWAFuGK+dalo7HETCUtIgjaCYInTah+nRy0iNnJjh9dlXcnEVa8ruIuv4tdhw3kDE47bOnQ0Prfn5NwQRcfMJj2txQKs2lTpVi5gqNl8aKhw+mgzEflhfMtP6OFnKXzhofqJ67Fvzr1va0bYR+JPPGJWalzrd0apGVCtTy8n6p5YkKnMTMku98s9VSuJDMjadvTCuPn+lU/LL9NnP4pVlWMKNmcbL2IGnK8zdxSjbcCMQWpaws+sCPJ9nP7deI5giocD6r+z3zDwcyYu77wDGK8eTrEkVIhANCSo0aLFQtTk9SKj8CBBBB/0aiAna99PWjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TotOA5+6P9femTNyNOuccQjnq1sGjgF/DmJhj0Qcn8=;
 b=z1mMg1jtSzM2M2uOe+iZJC97mJHPVIceHk9Ua3wECLIadcNtdgTuccFyLct748X+m+XbIO6LndtEskGSoTE5I8lnTkgi17VIKOx/o76qFHGEyjE4XKH8GDOZZpE5yOeRNsQn/HmNBoj5V3x6194DPi9oHJ8pA9PdkBJTQckMiYQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 13:49:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 13:49:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAIAAPjyAgAANPQCAAALVAIAAJMOAgABMQwCAAAJqAIAAEAiAgAAB9ACAAC1XgIAAAvwAgADRy4CAAAIzgIABQsEA
Date:   Fri, 17 Jun 2022 13:49:59 +0000
Message-ID: <20220617134950.6w73qt4hs7fjx3f7@revolver>
References: <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver>
 <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
 <20220616025557.euz6z5rlh7fqewy2@revolver>
 <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
 <CAOUHufbNR6NsYX_fd+_6WaiNkewyfWuDN-9KnPBOdxaPTks-8w@mail.gmail.com>
 <CAOUHufYd=H6un8=MHs0GE7oOjqMt6WNndEcrTJbJX_gmOHWbgQ@mail.gmail.com>
 <20220616182647.hlwadwzvlojbjlj5@revolver>
 <CAOUHufaEg6d8iwPapbp8MjeMUVbLf9Pfp-pL1yiOA6Km_j45FQ@mail.gmail.com>
In-Reply-To: <CAOUHufaEg6d8iwPapbp8MjeMUVbLf9Pfp-pL1yiOA6Km_j45FQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 412fdb20-45a6-450e-dc32-08da5068453d
x-ms-traffictypediagnostic: BLAPR10MB5140:EE_
x-microsoft-antispam-prvs: <BLAPR10MB51408DCADAFE783675E0501AFDAF9@BLAPR10MB5140.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TXtiu4VTcMeX2dDgSEgyhO9fuI+TJn50Is1f0HbPnGACYBPb0AQ8HmbwnjtQZJdwDfeWrI4ogpZh1MSl2yf6pe0u24cDZE3+3Xz5bGnZbkNTQRepiPZdhiJIcxCWWPSPpxyzhru9ICiaV3XgEruXjbKRDYbNXEGbHLKR4EvsuRK5b/NyrLRA/49FGmBtppq56jVzcJuraKIHsBx3B9SPJvrvsuVOI8oVgZperk83gAgjxNe5hSp3ycBqwtjmr1P/U6mGz8Q6UPGR1TDurACT2mSyFCTyhUNXKD9sXItrPLWcJ2o+IaGtpR+GwcSoIr+aTzlYSJh0l2LNKcYd9xp8FEfQ3GN9uRULcOF3hxYS6ulE24geN0/MiUGnlFMLV07HI/INhZXuz9+W1IRj/8yryqucWN9NAJ/51GHvlhTXCek3Lm6xXSsBtEyL3W0ikbnrekk3CebLgWGxyPeGF/X/mxFA06MSLervrPybGKObfWXovg3+cUPAWlSlxYYUAbs0rIFFNGeXBrpm/aWOLroBp4+UY+Nk5qNw8vrdicEdyCnQV17ELw5ZwZTsNnhm0SIu31moPF5ehpPuI9sgXmVn5zbJbti04P+JOdqhEsrWGejiEGyDcnvusu0gldMRUJAqSiwCLbsbLKSe+idIOCdSuT8Cz3+hX5o98z2jmCS8loho5/7acBPhVSoAIxsJNZOVdsqlR2ul9cm74zQGYxZSzsRYfvALST7V6od8+IXYz++gJbtXx7AWoBKptA9kzf1r4FuIOf+E1hRYDpRnNIcUKHYkyKuhsjcYi7wp+S7uvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(316002)(91956017)(5660300002)(9686003)(53546011)(6512007)(38070700005)(498600001)(8936002)(83380400001)(186003)(1076003)(6916009)(33716001)(71200400001)(38100700002)(122000001)(8676002)(6486002)(966005)(44832011)(66476007)(64756008)(66556008)(66946007)(26005)(2906002)(54906003)(66446008)(76116006)(86362001)(4326008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TDCPDcHYlcDzLZ843gEI7iwjrqiG+xqS2QKfJVw0YawqfSA7Nt4CzBbc4Qhk?=
 =?us-ascii?Q?I7VOm8HzfXDuI3wX343KDQSiz2du/7BS3mmd9sbhi1kR3KhBiVzRT1Qiu0eh?=
 =?us-ascii?Q?JuKxRrLctQXhoNtmORuxK6/ihwQ0QzP1CyywUMMCWEOUThSGB/+K/Iq1TJ4I?=
 =?us-ascii?Q?TmEHpepOHBx+C+yi++OaATLjPoNHLYuQv8nZD4CD8VFnUbBeVYtclvK4PA9L?=
 =?us-ascii?Q?DVdag/GQbV2ZEHxPzW2ZxJn0XVfjB5D5rjDzAwnC/ixC0qYtJr7L6iM8BGlk?=
 =?us-ascii?Q?2bdZtdH0z0PCWJ74EAzvkFc3xR20lPOK1bsuDFjRVQBokwEB0Shogb0qDio/?=
 =?us-ascii?Q?hJIMIUbEa8TFJOEoRRr/sCcVrlatC/wOE7kYQxo/bIMGQonm75nB6Ng3FoGw?=
 =?us-ascii?Q?Qaaohh/89kQe8fIQ8b2vQdD8DIHhcfQDLRz5uM8951lqvPkomhxtlYYt2HQR?=
 =?us-ascii?Q?HvyEkYMWpasuf3IfcmwgZr/pM9j0pva0Eh1nNbL2K88qJ9MUqSFAOSXMizDu?=
 =?us-ascii?Q?HnCIAC4TslmBKNLW14jZheUNtHlrf5LMwgmw9SlTBDjruNet18r05S+KVMWE?=
 =?us-ascii?Q?PYUFEgpT1Yd/VIOXzwcm24ZnrFYRWAEjefLPS048mqqz0dlPRf0D3Y6E2L7W?=
 =?us-ascii?Q?jSZusrHi7JbSPgUoJ0dXvjjzbYUyPYhXYvG7r2osi1KJ9TnYnL/aP0m4D3iU?=
 =?us-ascii?Q?mpogzMHCDhHUuR92q7wORWF/43sm7n+99Iksjyj9F5VxQ5OTURAeVvQ9m0Y6?=
 =?us-ascii?Q?F2P497tXUm3Ju5wGc6gtilreH954gR2ilTJ2Q3O6FDQKaoPnLa5kAKos+zVx?=
 =?us-ascii?Q?xgjlNGx5C3yZae2ypgwPetSaZQmiPf9wlFEOGcMuRctDrb4O5JJx2YcMcMKa?=
 =?us-ascii?Q?Fw0BrlDoEUL++queaYk/KkgIWUoVa2NwvjEJmxryd7QdTw9jhVs+i0ckSAeB?=
 =?us-ascii?Q?OLoRhsYP/Er4IAT5/UnT0//a8FbyJQKQZ6RVXMb/puUB+zp0lW8cKQjK6tCc?=
 =?us-ascii?Q?i7RP5lv1z7Qgt1xqwyIRp1KNAAqJDc1nga0Owol5gwVobe/fr+58XQ1+Qa/C?=
 =?us-ascii?Q?knzIo46JN+CRJffOsIusI1ix/EuLQnIqIl8M2NuOyqAp8E7DpgjPYaaV7TAa?=
 =?us-ascii?Q?r0mekJIWGfE7wjST686jYPHoUFdf09vP/NnZRtBQEwNMIlpqeqUyyOc+WrTR?=
 =?us-ascii?Q?hdEOlgNnykfQm+h5j7gdP2fx59C+36/lz6arbY5eAbznYOwlPx0bMS53cvun?=
 =?us-ascii?Q?4nb1aX29r4dkOAeG+w1QAZievCWxBFqcl+0obCEIBtt/rlLjPqxMtAF4od5P?=
 =?us-ascii?Q?riISfgKci+5ZpNo6kpBzpKJxaW7s/PJxXoL0vOIxtetMBBSxxvb9GJSrtvUn?=
 =?us-ascii?Q?8bDXjM5sZotrtPCaDZxULQply5LXXYLmG8CVxNqDy5uite9irp0TaV1imjhV?=
 =?us-ascii?Q?emdGf8GbvPJVbrPMLk3RKiu4dc6nbFLxVJ7tR98t0elV7fEcxx1bIEzwGuGh?=
 =?us-ascii?Q?Cqhxkf7SDHAWO4FUH1dxT6d2WU2D6R+BGQIuYOwRQlKod8Vm5TSgHRqeKfD2?=
 =?us-ascii?Q?Y0XEPcoPvYDNsLeApjUGyCUecwfAUsoieYnU6YD5jWvpA+a2exPqGc/8EP9r?=
 =?us-ascii?Q?TdfMylNz/TPxj0JM3Nmp1xAY7zReOf138wmj/d0dVAdC8ZsAXWnVkKjTbawv?=
 =?us-ascii?Q?d27ccqURPrnyVybag+luxg78KZXpAXR4S7qTJViHTSj/Ki6X3g4I8rx2rSw7?=
 =?us-ascii?Q?Iy1v41IaB5I6z3rdQqGbFRiMuY6npTA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BE6CF9DAF0AD44EA762BB561414FBA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412fdb20-45a6-450e-dc32-08da5068453d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 13:49:59.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeolA8qgVIQVHS0/8Om0Bf+JUDl/myN2PgdJeYzt4JN83XjvgMOlcZh+aPo09oI+41y7XRMiE9K+DHWlhKjWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_07:2022-06-17,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=964 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170060
X-Proofpoint-ORIG-GUID: a7GOU7no_BFqAt6AQqUE7US3zJ4kSxPS
X-Proofpoint-GUID: a7GOU7no_BFqAt6AQqUE7US3zJ4kSxPS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220616 14:35]:
> On Thu, Jun 16, 2022 at 12:27 PM Liam Howlett <liam.howlett@oracle.com> w=
rote:
> >
> > * Yu Zhao <yuzhao@google.com> [220616 01:56]:
> > > On Wed, Jun 15, 2022 at 11:45 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Wed, Jun 15, 2022 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Wed, Jun 15, 2022 at 8:56 PM Liam Howlett <liam.howlett@oracle=
.com> wrote:
> > > > > >
> > > > > > * Yu Zhao <yuzhao@google.com> [220615 21:59]:
> > > > > > > On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@or=
acle.com> wrote:
> > > > > > > >
> > > > > > > > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > > > Yes, I used the same parameters with 512GB of RAM, and =
the kernel with
> > > > > > > > > > KASAN and other debug options.
> > > > > > > > >
> > > > > > > > > Sorry, Liam. I got the same crash :(
> > > > > > > >
> > > > > > > > Thanks for running this promptly.  I am trying to get my ow=
n server
> > > > > > > > setup now.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/m=
m-everything)
> > > > > > > > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for=
_each() loop
> > > > > > > > > 55140693394d maple_tree: Make mas_prealloc() error checki=
ng more generic
> > > > > > > > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full no=
n-leaf non-alloc nodes
> > > > > > > > > 4d4472148ccd maple_tree: Change spanning store to work on=
 larger trees
> > > > > > > > > ea36bcc14c00 test_maple_tree: Add tests for preallocation=
s and large
> > > > > > > > > spanning writes
> > > > > > > > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked=
_page_nr()
> > > > > > > > >
> > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > > > > > > Write of size 136 at addr ffff88c35a3b9e80 by task stress=
-ng/19303
> > > > > > > > >
> > > > > > > > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I =
      5.19.0-smp-DEV #1
> > > > > > > > > Call Trace:
> > > > > > > > >  <TASK>
> > > > > > > > >  dump_stack_lvl+0xc5/0xf4
> > > > > > > > >  print_address_description+0x7f/0x460
> > > > > > > > >  print_report+0x10b/0x240
> > > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > > >  kasan_report+0xe6/0x110
> > > > > > > > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > > >  kasan_check_range+0x2ef/0x310
> > > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > > >  memcpy+0x44/0x70
> > > > > > > > >  mab_mas_cp+0x2d9/0x6c0
> > > > > > > > >  mas_spanning_rebalance+0x1a3e/0x4f90
> > > > > > > >
> > > > > > > > Does this translate to an inline around line 2997?
> > > > > > > > And then probably around 2808?
> > > > > > >
> > > > > > > $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> > > > > > > mab_mas_cp+0x2d9/0x6c0:
> > > > > > > mab_mas_cp at lib/maple_tree.c:1988
> > > > > > > $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> > > > > > > mas_spanning_rebalance+0x1a3e/0x4f90:
> > > > > > > mast_cp_to_nodes at lib/maple_tree.c:?
> > > > > > > (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> > > > > > > $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> > > > > > > mas_wr_spanning_store+0x16c5/0x1b80:
> > > > > > > mas_wr_spanning_store at lib/maple_tree.c:?
> > > > > > >
> > > > > > > No idea why faddr2line didn't work for the last two addresses=
. GDB
> > > > > > > seems more reliable.
> > > > > > >
> > > > > > > (gdb) li *(mab_mas_cp+0x2d9)
> > > > > > > 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> > > > > > > (gdb) li *(mas_spanning_rebalance+0x1a3e)
> > > > > > > 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tr=
ee.c:2801).
> > > > > > > quit)
> > > > > > > (gdb) li *(mas_wr_spanning_store+0x16c5)
> > > > > > > 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tre=
e.c:4030).
> > > > > >
> > > > > >
> > > > > > Thanks.  I am not having luck recreating it.  I am hitting what=
 looks
> > > > > > like an unrelated issue in the unstable mm, "scheduling while a=
tomic".
> > > > > > I will try the git commit you indicate above.
> > > > >
> > > > > Fix here:
> > > > > https://lore.kernel.org/linux-mm/20220615160446.be1f75fd256d67e57=
b27a9fc@linux-foundation.org/
> > > >
> > > > A seemingly new crash on arm64:
> > > >
> > > > KASAN: null-ptr-deref in range [0x0000000000000000-0x00000000000000=
0f]
> > > > Call trace:
> > > >  __hwasan_check_x2_67043363+0x4/0x34
> > > >  mas_wr_store_entry+0x178/0x5c0
> > > >  mas_store+0x88/0xc8
> > > >  dup_mmap+0x4bc/0x6d8
> > > >  dup_mm+0x8c/0x17c
> > > >  copy_mm+0xb0/0x12c
> > > >  copy_process+0xa44/0x17d4
> > > >  kernel_clone+0x100/0x2cc
> > > >  __arm64_sys_clone+0xf4/0x120
> > > >  el0_svc_common+0xfc/0x1cc
> > > >  do_el0_svc_compat+0x38/0x5c
> > > >  el0_svc_compat+0x68/0xf4
> > > >  el0t_32_sync_handler+0xc0/0xf0
> > > >  el0t_32_sync+0x190/0x194
> > > > Code: aa0203e0 d2800441 141e931d 9344dc50 (38706930)
> > >
> > > And bad rss counters from another arm64 machine:
> > >
> > > BUG: Bad rss-counter state mm:a6ffff80895ff840 type:MM_ANONPAGES val:=
4
> > > Call trace:
> > >  __mmdrop+0x1f0/0x208
> > >  __mmput+0x194/0x198
> > >  mmput+0x5c/0x80
> > >  exit_mm+0x108/0x190
> > >  do_exit+0x244/0xc98
> > >  __arm64_sys_exit_group+0x0/0x30
> > >  __wake_up_parent+0x0/0x48
> > >  el0_svc_common+0xfc/0x1cc
> > >  do_el0_svc_compat+0x38/0x5c
> > >  el0_svc_compat+0x68/0xf4
> > >  el0t_32_sync_handler+0xc0/0xf0
> > >  el0t_32_sync+0x190/0x194
> > > Code: b000b520 91259c00 aa1303e1 94482015 (d4210000)
> > >
> >
> > What was the setup for these two?  I'm running trinity, but I suspect
> > you are using stress-ng?
>=20
> That's correct.
>=20
> > If so, what are the arguments?  My arm64 vm is
> > even lower memory than my x86_64 vm so I will probably have to adjust
> > accordingly.
>=20
> I usually lower the N for `-a N`.

I'm still trying to reproduce any of these bugs you are seeing.  I sent
out two fixes that I cc'ed you on that may help at least the last one
here.  My thinking is there isn't enough pre-allocation happening and so
I am missing some of the munmap events.  I fixed this by not
pre-allocating the side tree and return -ENOMEM instead.  This is safe
since munmap can allocate anyways for splits.
