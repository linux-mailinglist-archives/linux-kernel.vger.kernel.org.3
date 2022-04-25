Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC450E9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbiDYUCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:02:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EF7B126
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:59:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHj1hj022277;
        Mon, 25 Apr 2022 19:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hcNiCc7tvkDTBbyqxcWLVUbgdY4hQYz4lD0RotoLzU4=;
 b=qNk4T9cUSxTnO8RkVq3d/hNxAnLPtT/+c4QZzsDR+GgRdQDFjj/vXxmiqUAvGZR7gfIo
 fqKYRh+uQumzoKi9//nIOnZzjDQrpBopj3OT/JpdWgr7cJQsbvUHgCKdhPgn0Kc52A1L
 od4yk1RX4O2t5CYS80wYaUKnsStKJARJDWqwwFUYDWuUdiP7nC/tW9jBkOll1V6eXP5d
 QprtOUXCCRaEmkTRygSGyWWKSry8EHKdwHs3zM54/TgHNM4Cx7Xy2Y/AA9ozczDi5k9P
 qo3s3CcW4fxUzWQ/CVWf4WvyCItaY6BJxw4CvrrhryNzPeoUn5431dPbMhaEwS+d5pqN cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4cbvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:59:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PJu2EO019571;
        Mon, 25 Apr 2022 19:59:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2xr5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbAu1OZJejEC0uNDzIv/+NIUcOScMZ7ig+8JVi/6KyGXRcBl1Qllsxhhal1dTvrRTny2WGX8DWn1L1MDKujST0aeheqatR+SCHAeV+pbN+hDJ9WL7IOLLfmD7JZZ2KGOWkFOtTWYK7Q8ufL6pcqjmyONDSCmSkZ4VLMF5eDSloKoNtNCWfpJYtx1nc1N057rS3jVRQC4iusf6NabzlTLRb3Mn7gMMBW3U56VZbZv7d0MBzIMSPUoU5VAH1LRiYWbuYLJ/HGRnhnGf73iKgueF8k077vdv8nAZM8Oo6bGQvql7PUHG4CiPLC2dkc1QC9+Q4h4mjdizWTd+uceWD0kwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcNiCc7tvkDTBbyqxcWLVUbgdY4hQYz4lD0RotoLzU4=;
 b=lxTvWuyktod5xPWPeEWfY8B97jeUy4DnRP56sT6lQIOj7ZbiQ5urd+udnIJX1sdckBVpDVoy0d9NBm6tfrliBzDpe1RDk/Vei0mk30fJGCpQJUBOwdO0tmv4YwVN82K6iztaJopNCc0wrDvOP/0tXpBOlr3fjIZmMCdIp7Ami5eEy0uxfEtj+RwLP7+U+WoMH5kM683pJwODbo52lLNY8nN+TUlvH44Pz9IzIek3Go47jkR1mrZwlmQzZAuSepslxJGnpCa+lyTg74bRqAkWiGVMG1+YBPKq2LpcBLAXwT+aAXHfquGubsZQ0IDTkFZBK+i514RQKpVWnH8Ozfuw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcNiCc7tvkDTBbyqxcWLVUbgdY4hQYz4lD0RotoLzU4=;
 b=sv3yWCm71kSU6/X6HMy1GNX8cSR2OjYrHFzrj8LrMsGRqCToQR09vFfzSqnX8CAH66SePJFDyhnlWfHIk8ZxSTL9oK7Vna22agkUU0/zrsjnU3pulrvgZhQulAFr084rGWo/oLn06/6M2PmqxEI2N0jx0WMdskf/oLP7nPmMvoA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:58:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:58:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6AgAAimYCAAMbngIABK32AgAA0VgCAALsBgIAARfaAgAR5x4CAAGa4AIAAFiQAgAABYoCAAPCFAIAIJO2AgAAflAA=
Date:   Mon, 25 Apr 2022 19:58:58 +0000
Message-ID: <20220425195852.qd3dzzjpitwaocx7@revolver>
References: <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver>
 <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver>
 <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
 <20220419231748.omnhkl43vl5ep2j5@revolver>
 <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
 <20220420134336.bny7wza3ez2ldjsd@revolver>
 <CAOUHufZZbF-e6LF=xgig-Q8zuTSq_hvgPc-rMOwhyPdsD5=p0w@mail.gmail.com>
In-Reply-To: <CAOUHufZZbF-e6LF=xgig-Q8zuTSq_hvgPc-rMOwhyPdsD5=p0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2401c447-27f1-4aae-cf51-08da26f6094a
x-ms-traffictypediagnostic: MN2PR10MB4333:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4333EA8C5141E5AA31C73B9DFDF89@MN2PR10MB4333.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rqbH2PZ2IYg5eKyTOW3AOJtygyV8/B4lsaGkYZ5A+Ib8bTq6FcFdCqQBUdH+1hVHCetH8UIyGwsuQ3oJmUkvPSbkbujvcnqLssANcJZ1CzRi7FtG6cmRfAIEwSeiLEHn6TPjHoxtQaW5geu/dXn2obg6KWzjYe2wrLH0yYB95xwhsBwCOYhe+w/NJbNO6hC4unOHL31eavF9dETf2naEsT6gW5lVMnweqJWf8lOP2HmVLmTbs/y4tgVUdCWwWvmPO6tElIDlczS/JuyxprkbeTQ2aXUeH9qEtTPAwHfCMLqPRFFBwKmFjveY61+VwRqYi9Un33iIyyv61tto1Ar7s4hM8ice9OVk4Mtj3x3M5C/RpYvbnS5MD/xHjW+Ar+DQGZ6z+ktfPCHQ9Cb17ij3RyKM66iqxTKtwP1kXiw8qlHnHX4adLXvVX12nde5f27QvoeszsitKJUbt1i/3NS2vAKrlafplgATd0M0rRt2VWJeXfm26OURUJc5edvRrALFMUgJzDPKXqQwcloACRXkS9QH34Enf13XVjclFn6xydtgWQEiZcAf7sqaxfH9M5BxSvqeQggKWxNZzaJpXG/kMnpIBzwddFbpdeQdPS9g58rjBkx4Td/lo8PzNGnSXbrwnUj2WQ4zl1vw2eUM5bz1A0Xos5OdbHz2YbfTk82v/KbWXUwTAJC0TmeVSwPiEh2yrA6nYdZuXpGpBbP0dcPKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(44832011)(6512007)(83380400001)(26005)(9686003)(66446008)(5660300002)(86362001)(316002)(54906003)(53546011)(6506007)(186003)(1076003)(38100700002)(38070700005)(2906002)(6916009)(508600001)(122000001)(6486002)(71200400001)(4326008)(8676002)(33716001)(76116006)(66946007)(66556008)(64756008)(91956017)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WF3Jwgd+zZHF4tyfRQQwWTJOGN5yAzG0HwfdAhh4BSd2KfVnKC9cTYYWQ12N?=
 =?us-ascii?Q?RthZGF95SrvIIt6CszwEoYt7++w4CyamgsJzlGRAdoZSfr2Ia+Fi4sK/m/90?=
 =?us-ascii?Q?ukI21i++MXAs+cKZMyNuV/XVe3LXgpRfEJoYpOaDHLDpvV352Vz73tf5Je4t?=
 =?us-ascii?Q?KiQicErNuDHRVJx43qQU7I2WXirTNWAEUpv0XJpk5c56dTlZ2TnHPpsmyTm8?=
 =?us-ascii?Q?V+B9BqMj/nRQtRP6BYbt5E7kmFPJcVOvUmUsjSj64k76Wt0JD/Gx5G3TNUBP?=
 =?us-ascii?Q?NxCP6d8urCDGZp05kxMxEi7ilk/B22WTylvRXpnSDt0EfjIZRBzAfAstOXPv?=
 =?us-ascii?Q?so6sKISHpuuUHOfecJOMfW1v7eC9sgL8I86kb87DXbJiDcphcRlRfYHpz7Us?=
 =?us-ascii?Q?d23tb2dK7Orsgac1OHRwLaXRhgs/9tyaRWoEChgkfpBIqI6M08zpTC93CU6V?=
 =?us-ascii?Q?eTiXh/2vJytQVPMeqg0a+XiBgI6KkAdVrPDq6REbMsj5C7hbtS+4bMxLsF53?=
 =?us-ascii?Q?Y2YCpiOBVIXpF4x/EeO2UD2AMI1OzfpJwyYd+zdhptRm/ui/WABihvB1hsVC?=
 =?us-ascii?Q?FRmvmDpga1p8uKBlpEULtMeokir484LXNNVZ4GYMbxWz7EU+5uLpvDS+tJpn?=
 =?us-ascii?Q?hrUQXWOY026QMdtCNPez8SCjLUxPRBCaV/SBRKLUS6WuLqs/GSC307vo502b?=
 =?us-ascii?Q?4Sa9Qw+of4MiWE9pOLEzA77WhSF2X0nqRnE2Fmh4DPNW1d2fmxgAwgbdYAGh?=
 =?us-ascii?Q?6JpXy5J2s0RiqycxKtN+Glg4OMZnJMuSrbriGuqkQauGepdV9b7uM44xo9b5?=
 =?us-ascii?Q?YpItb7OxosXgeCDPUC3MtBxhWZi9gtfDSzwZz6e2+zD7LlHyXYVZVIIn9YKa?=
 =?us-ascii?Q?5TDUWR5Mh8JPyA2hW19inKOzAwCeGbOSx0ME/L5tWxGRoDcItmwnlQp0HKLv?=
 =?us-ascii?Q?4CdNAv13+5N944qAtLKRVcqFjJu0RJUBUAQEez8Ta3sChniKcvzwAR3up/SU?=
 =?us-ascii?Q?oHgsqczXyL8ZS0MIM9J/gZLMUXXUsK4Hs/TPbvlk1huc33f7w2nayK4TbDxs?=
 =?us-ascii?Q?1MCRoJOF2LfHkn9tqHSEZb1vjGIVOL0gFjf5vhYl5/mYsOFtHJUdZ42Ow2JF?=
 =?us-ascii?Q?q1MnZut9I+7UE37qwp42ak7/oN2xkNR2yCfDzJoFAKI9jB/ZklKo9jx7XEBL?=
 =?us-ascii?Q?d126t6y9aeYYz8aDRNBYAMnKGz8jGYM+WBVA3QJ+/DRBG+rM6QLZykm0ybBk?=
 =?us-ascii?Q?BNHran0c7LGQ8Vp44xxkvTQ/R01ePKa4eNMil4+j0Xh4JuqEsP9ecbiJV9Ti?=
 =?us-ascii?Q?UCRF+tlht1tlCVfEZ3f0IO68iR/6m67ItepxIQyx2ODkVAjkY4TA8SUQXj1Z?=
 =?us-ascii?Q?0On2jb/9LTOl4GbGGmlwtmZKZOY3pDX8HJ+lEuJPT5BeQS2jK3hKi27UKQV2?=
 =?us-ascii?Q?OZ1MNFZ2qJ3MCU8Gk6EZIW0yXzcJCuyX6Jrz5zj75B8OI52j6D7v/g6CdgaX?=
 =?us-ascii?Q?rdTu37PIcuYBcTXisEm/LJRgin0ZbTkBg3rc53mkoQWXlOwSoBzCCQZmWjyl?=
 =?us-ascii?Q?H4Z040hWtWS2LPyADzTOA7lrm4TUgyYcMgSaWSNXmsOA2++STo09sUuCjwg/?=
 =?us-ascii?Q?PmwEIfu7lNx00HmeyzEi3RU4Dxslf/8aD5a5Klh+xR385VxryfZPiRjuzBa0?=
 =?us-ascii?Q?oO+sZMNtQusDZadeNUVpkT3oAphTPNFpEZsVputkUuT9qeU6qz3AANiq5U/v?=
 =?us-ascii?Q?GSzVhK/09Tvtabzf2/zgM4ewrt5zs6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3BCE1F7C93E931499A3BE410560DE4BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2401c447-27f1-4aae-cf51-08da26f6094a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 19:58:58.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUNOeGOp3Acvbhix90PLE5AE60yn6OlBJSeP+xWnhySbybtvXpPUxkpFzqlL+vbgM14qc00VuS5EKzBcCC0LEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250088
X-Proofpoint-GUID: Y7xA12RRcJPj9lQ-OSABpQ09Vx5euchw
X-Proofpoint-ORIG-GUID: Y7xA12RRcJPj9lQ-OSABpQ09Vx5euchw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220425 14:06]:
> On Wed, Apr 20, 2022 at 7:43 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220419 19:23]:
> > > On Tue, Apr 19, 2022 at 5:18 PM Liam Howlett <liam.howlett@oracle.com=
> wrote:
> > > >
> > > > * Yu Zhao <yuzhao@google.com> [220419 17:59]:
> > > > > On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle=
.com> wrote:
> > > > > >
> > > > > > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > > > > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@or=
acle.com> wrote:
> > > > > > > >
> > > > > > >
> > > > > > > <snipped>
> > > > > > >
> > > > > > > > How did you hit this issue?  Just on boot?
> > > > > > >
> > > > > > > I was hoping this is known to you or you have something I can=
 verify for you.
> > > > > >
> > > > > >
> > > > > > Thanks, yes.  I believe that both crashes are the same root cau=
se.  The
> > > > > > cause is that I was not cleaning up after the kmem bulk allocat=
ion
> > > > > > failure on my side.  Please test with this patch.
> > > > >
> > > > > Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
> > > > >
> > > > >   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usa=
ge!
> > > > >   Call Trace:
> > > > >    <TASK>
> > > > >    dump_stack_lvl+0x6c/0x9a
> > > > >    dump_stack+0x10/0x12
> > > > >    lockdep_rcu_suspicious+0x12c/0x140
> > > > >    __mt_destroy+0x96/0xd0
> > > > >    exit_mmap+0x2a0/0x360
> > > > >    __mmput+0x34/0x100
> > > > >    mmput+0x2f/0x40
> > > > >    free_bprm+0x64/0xe0
> > > > >    kernel_execve+0x129/0x330
> > > > >    call_usermodehelper_exec_async+0xd8/0x130
> > > > >    ? proc_cap_handler+0x210/0x210
> > > > >    ret_from_fork+0x1f/0x30
> > > > >    </TASK>
> > > >
> > > > Thanks - I'm not sure how this got through, but this should fix it.
> > > >
> > > > This should be added to 4236a642ad185 to avoid the LOCKDEP issue.
> > > >
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
> > > >
> > > >         BUG_ON(count !=3D mm->map_count);
> > > >
> > > > -       mmap_write_unlock(mm);
> > > >         trace_exit_mmap(mm);
> > > >         __mt_destroy(&mm->mm_mt);
> > > > +       mmap_write_unlock(mm);
> > > >         vm_unacct_memory(nr_accounted);
> > > >  }
> > >
> > > Will try this.
> >
> >
> > Andrew,
> >
> > Please add this fix to the commit 4236a642ad185 "mm: start tracking VMA=
s
> > with maple tree"
> >
> > I've attached the patch for your convenience.
>=20
> Hi Liam,
>=20
> I assume you are still looking at the BUG_ON problem. I'll restart my
> testing once you have something for me to try.
>=20
> Thanks.

No, The above fix stopped the suspicious rcu dereference.  I've found
another issue in the mlock() code which I've also fixed.. but I needed
to change my allocations from within the immap rwsem lock as it triggers
a potential lockdep issue on high memory usage - lockdep complains about
fs-reclaim lock.  I've a patch set that works but I'm working through
making it bisectable.  I think the easiest thing is to integrate these
fixes and the others sent to Andrew into a v8.  I hope to have this done
by the end of the day tomorrow.

Thanks,
Liam
