Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6914F80F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiDGNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDGNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:51:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0078AB8999;
        Thu,  7 Apr 2022 06:49:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237B1wmW012558;
        Thu, 7 Apr 2022 13:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hbK6kp72mR61zO8h7Z4aHBzanOVpmKBdsyKEjA8LFns=;
 b=NR9xooi2xbRE89HmWKWdmkSm13acx0g5r80E68FgHIAl0DiCGWwylmhDkQdsU0PT492x
 Dveo5s0jxq4WeVqP5pQunI3fYwE+qPg+z+gfONDCXWA16s2p5T3Z2VHKtJchTH3PdcYR
 Tt1CIm8MevcFy1LGoPL5VvaTtCSkVFiPHdNzwuN8mqZejDFvey6zqZUMFBnw/V+FeV/G
 sn4jnrsoStN67lntkMv0cHDLq5koskbpAqOohK93nc9lyZFqY9mIVi9SbhoKmdW6on9x
 /4pn0p320jCiC9b15+ToWungr7cG9YaAOKDRwmohYiZSAbBHmZiR0t6G8V8OFSgLYs57 +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcknax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:48:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237DKYHE013760;
        Thu, 7 Apr 2022 13:48:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97ttbmga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5IOmGml72D4+f990gEZ2V3+eaILOxKa3ix6jwpaNzzGcpUAeou7MO1zQ/ob4y2Q8FGp61lsyAjEemvKvc/N48Aepj34D9NSIcCXSHX42gX4Y4e/XGsdmf2A39p5/qLzwjh5LjWeL+U4sxERMvNU1G7bIuIs2bR6VjaleRwjCY1rFzCmTU/PfWbQ9GPaSzrKOcMewffZdIeahs8bEM10lp6VntzGjtEPMrD0BLjAKlbMMJb9/05NBCHDuqaL0nFd12LSKkcYbfxHWUPiSyz6yb0+sEp9PIQnxsj8w+ieLD+Ghuc/ATrf/kqY8QhD48eU5BIqnpUSw70hKq3ueUJCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbK6kp72mR61zO8h7Z4aHBzanOVpmKBdsyKEjA8LFns=;
 b=nsEDGMdxke9x0i5CoBvVNoE76jJYiXnCcd8PYtlRKYhqQmw3O3j+981JKUJwq20lw2DtfeiKyEBX8pip9x/e062AYgmaE2BrLHMzb2sj33oZEuN/Xfg10E+VxtE5PFz3JHiCI4ozpqQM380xdwizOKOsUV+qTTOLR0GrP6UIDAlAiq3+5EZ7EZE+OYhC+6ERZk8FzoaTBCp0SoHFw2diSvQtxivm3uB7C6mCA9tzo7LCfRmEgH+JccDiapwFtbSJriP14/WrRpeWePxOgOLhzC693xgVB4Dahtinmf7/XqUrCgv0lyNDAB5JeRKl+O00EwGE1ch0Hv+oWvlFc201qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbK6kp72mR61zO8h7Z4aHBzanOVpmKBdsyKEjA8LFns=;
 b=FRamHaxT08UFk/2cAqzjEEr7gcHUoO/iY04AXu7CyI4lK43pi5J0qyX7wZ+YR6FymuZMrpyAXCvDeXRiuzN/9JyQ/V+vWT/ON5USpWSM+pcHFvuytb6MU0/RJ0lBJSbu6QO4l8rCD6p0BGnnMGvTpPPfd6RHSLi588faqcsDXx0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3830.namprd10.prod.outlook.com (2603:10b6:610:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 13:48:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 13:48:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Topic: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Index: AQHYSjpZ02rQX5R+XUqTnd+fShDo16zkd/wA
Date:   Thu, 7 Apr 2022 13:48:54 +0000
Message-ID: <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
References: <20220407144524.2a592ed6@canb.auug.org.au>
In-Reply-To: <20220407144524.2a592ed6@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e10cf4e3-e107-41f1-e587-08da189d5b61
x-ms-traffictypediagnostic: CH2PR10MB3830:EE_
x-microsoft-antispam-prvs: <CH2PR10MB38304FC4C0F5DCFC0F9F576E93E69@CH2PR10MB3830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4k/R9HJNeK1ir87ezBjtuARc6rkfQKPs1SDSL0lBQcKJxS/VV2MgbBsDmv2TkO28dpUnbDhfnrfw0zJaBJEYyQ7xodkuoGsS6v+evb9PygCV3qqUVW/n9u9ImFYYyCLrkt45z8y1ywZbN5dh/88ArxT0LIFtsgWaKITyIGJ8M1DTToq8lllcELSqrqOUaU4kh+86Puqf6d+cLPLPdpiPX0zzqTwB++Dvj3JtWkw6t/Qcg7dAfKiUsgktmHAk4y2sOSSQDnnkDRDYwE7n7d2o4rWOIQFmdA9ts60i/PwrYMJZswasIXPsp+aDoGTmns6z+/husitPVU+/orCg3wDcGIA59fht922saUFugZcNTlh7WzBoh1T+YBWPH7qP92MQ94MSX4hMfyLsKTDADvYDjSRKyvTq/3O1EQ0zXPxU3dRXkP9pSUSLPkLMBYeplYmboDe6I2/hia9YfAn9x6GdoQo3kGRmn5cO+0/4v2c+I29R35XoEDRRsgvNfV2jUHsBFt6WXUaHWWd5+s56KhJ13xNMEWw0ed98Go/VrG1OHgbIHHJ3FMnXI5R7s5HtIwFabHNzxQL8jSqn6StuOFmQNP7uIppPQ/8IefJN2mn4Hc0uIv46dbcSAEJrDQYOJlRNF9GRQcv1EfWwYCyLbgeOTI3/Z/n76LEjo3wExH5k/2qo21h7airJhaICEtnMCCo8qB24ym5SBOP3dLhE8jhD2CayDor1h8MfIPwy+SFDPYaygAqAvez220dTkqH2k/r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38070700005)(6916009)(54906003)(53546011)(36756003)(122000001)(6506007)(316002)(33656002)(64756008)(66446008)(4326008)(66476007)(66946007)(66556008)(91956017)(76116006)(83380400001)(45080400002)(6512007)(186003)(2616005)(5660300002)(71200400001)(508600001)(8676002)(38100700002)(26005)(8936002)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PnycKQVcyHWhNfeYmUSRQzpkgWIMHs82wHWT9VCIO1jQzYQXLpAKloeRDYZ5?=
 =?us-ascii?Q?BBShtANmS/e6W2JgiIZh96XA8l7WwGAwyN4c0eAatxbfUzuIHtueQd3ifSOc?=
 =?us-ascii?Q?dXLUdBoqz21Se22JhF9HC2xKybyktFoXQ9jG0DhnIe1DcyRksHB2UIiuqueS?=
 =?us-ascii?Q?Z7YCsUhEquAOf4Yj02iiVtU4NgAQNwS5PW44c5LIFnzX0xJiS1L9oh67ISNt?=
 =?us-ascii?Q?wHil7EeIEtJmTRFdZhEqe8eWrZf7AFzcH7sHe6q/Rg0RG/+boOon940782N0?=
 =?us-ascii?Q?qa7cfFlPi610qySWAhZO+WnOvg/yTb1u/qYzUeQFJxd5WwYER4vANrj/PdPx?=
 =?us-ascii?Q?D4MM/MumGdmjk0qdsD2kshmzcYxfqw48uz17LmiWc/05Y3emtJDz0QMB4+9P?=
 =?us-ascii?Q?qpczzfWWvmBU+apeDtP0B95i6szbeX+x3n/C8gOXV1p/8o+Q3yrucacwTN3P?=
 =?us-ascii?Q?Rose9YDjSs31izsOhekU/Ma9QL68iaW7skXxJ3iu2AZNniVFN4Glv9FmCqoN?=
 =?us-ascii?Q?Gb4w1qr1w5yubnKvLo6du7kq+IVJoz7tEu1ltg2qJDWoF2TY/e3i32Sg9UC3?=
 =?us-ascii?Q?DNePXQlBjIqDc1cHjBMO6f8z1X1KslvUgg9TU8b6e4Swld9EqGLSV3lSSH67?=
 =?us-ascii?Q?k1A6bOroNR6LAVOBwFdf002kH5bOkt4VS29HAQo6bLJs1vJLW58tE7+2pKmW?=
 =?us-ascii?Q?SyrDa9X9QA17QAulsdkkFQmnCMZGUuv8Gv7uFnrh4MrdIc+vWpnaSt/TYGm5?=
 =?us-ascii?Q?7a7o7+ImzhAxgRye8ZCqOyubABXl6760dB4KjKTfxoCHt9jLnnIsZCmBPAj3?=
 =?us-ascii?Q?5OLaAF7pFoZBHH/+FuNN6UTCFjktpBNYLBDc0kv7VlEPXfshuyn/cZbC6bYL?=
 =?us-ascii?Q?Spb9IYDI6DbgYWaGE3Mmj4aYeWfLY5p6ptVhIOk10wj0vVFwvYR8OyQ+EZxZ?=
 =?us-ascii?Q?B9oBF/sa1W4KtW9/WVaoCIivzl5ciK/udd5r48csGoNO5765Vqh6ScbtH0+y?=
 =?us-ascii?Q?8tIvA8uaUroLssawPT1cmtBKt0x5UmcF7VRSpbYnHGoe6coLH5BEfFD5D2z4?=
 =?us-ascii?Q?+QmCEv3wB4t6pj+2rMVXNnsxhlMjM3Fb9YwBTqYceKCxYPbnqz8uUCp0h2BS?=
 =?us-ascii?Q?jP3bUZiryrkKcSx/XEWitbMnG/u2TKjI6IWGRZSWO+FkSEQRG/6+I2oNPP53?=
 =?us-ascii?Q?fXJ9we84IyiTbfRvq26qXWaD2v3Z0HcV2W/LmCBXZNA4MnJr5QCfgjpUE7+e?=
 =?us-ascii?Q?EMPi0T+0JtGAG7UP7XHhKTgi3HDNM6J3KHw4lBdnfuH/8WkIo9UCvX8NcFlL?=
 =?us-ascii?Q?+PrS8NNyEY6ZGeFiEaCMjjQr/ZMAWZC57UkftUQ/3i2dIOuHNW8ebO4fZBJT?=
 =?us-ascii?Q?/OOVeB4TA0aBGruADMWwnQiVC/V7hWyaJ+GLqxtTUiHT7dch4t/FeIdc2w4f?=
 =?us-ascii?Q?nt+OE0n/NiYB853ikcHuve46izire49gew1sVHr7VWUZwjh4m/UR9AFrn69s?=
 =?us-ascii?Q?UnH6duzX4i7gjziklk1VTydMiepJzrgSfiO7WDxCg18UycZ0l97fW7IKGqJ+?=
 =?us-ascii?Q?5jUS7URP8LfDTeFMCddHxlQvJNbIYvVkolPB+2sWZ7rfzrDre+Z6iNTrYgJF?=
 =?us-ascii?Q?rO7JK4md2iiV3EmiW7IaGQnbUiceZcl6mfY6IPiEsAjxpo/CYd0N0WxulZcA?=
 =?us-ascii?Q?VUUQtaSUjXO8+f9qYsCUGEsw0znl5EDkJDWQ4XvZ2kjqan/hcRuKNcFA2fJc?=
 =?us-ascii?Q?4K3lAP3YHK2AwOtnMaSWCIWPg17gnqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F5C49D0E9A33D4FA64AA888A0F1130C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10cf4e3-e107-41f1-e587-08da189d5b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 13:48:54.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bKWgK+kzH9tEXbhJJfVKemvrLer2t8NS0WxPKUSGxsKwBAxQXqclzYXyHv90ggZaPH/+XYB22pD+Nz+WhErDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: 7Uk51SNCsdbn-Kge8xiGBc-joGx801Kl
X-Proofpoint-GUID: 7Uk51SNCsdbn-Kge8xiGBc-joGx801Kl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2022, at 12:45 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi all,
>=20
> After merging the cel-fixes tree, today's linux-next build (powerpc
> pseries_le_defconfig) produced this warning:
>=20
> ftrace: allocating 33539 entries in 13 pages
> ftrace: allocated 13 pages with 3 groups
> trace event string verifier disabled
> rcu: Hierarchical RCU implementation.
> rcu: 	RCU event tracing is enabled.
> rcu: 	RCU restricting CPUs from NR_CPUS=3D2048 to nr_cpu_ids=3D1.
> 	Rude variant of Tasks RCU enabled.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D1
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:431 trace_event_raw=
_init+0x1a4/0x7d0
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc1 #2
> NIP:  c0000000002c0924 LR: c0000000002c0ce8 CTR: c0000000002c0990
> REGS: c000000002787a00 TRAP: 0700   Not tainted  (5.18.0-rc1)
> MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000282  XER: 200000=
00
> CFAR: c0000000002c0b34 IRQMASK: 1=20
> GPR00: c0000000002c0cd0 c000000002787ca0 c00000000278ae00 000000000000000=
0=20
> GPR04: 000000000000002c 0000000000000005 0000000000000057 c0000000002c08a=
c=20
> GPR08: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR12: c0000000002c0780 c000000002950000 0000000000000003 000000000000000=
0=20
> GPR16: 0000000002bf00d0 000000007e68ebc8 c000000000fb0758 000508b58019388=
f=20
> GPR20: 0000000000000000 0000000000000001 c000000000fb0748 000000000000000=
3=20
> GPR24: 0000000000000000 0000000000000000 0000000000000001 000000000000000=
0=20
> GPR28: c0000000026fcde0 c0000000026f60e0 000000000000005f c0000000026f613=
f=20
> NIP [c0000000002c0924] trace_event_raw_init+0x1a4/0x7d0
> LR [c0000000002c0ce8] trace_event_raw_init+0x568/0x7d0
> Call Trace:
> [c000000002787ca0] [c0000000002c0cd0] trace_event_raw_init+0x550/0x7d0 (u=
nreliable)
> [c000000002787da0] [c0000000002bd908] event_init+0x78/0x100
> [c000000002787e10] [c0000000020346ac] trace_event_init+0xc8/0x334
> [c000000002787eb0] [c000000002033d20] trace_init+0x18/0x2c
> [c000000002787ed0] [c000000002004318] start_kernel+0x598/0x8d8
> [c000000002787f90] [c00000000000d19c] start_here_common+0x1c/0x600
> Instruction dump:
> 41800348 60000000 60420000 3bde0001 7fdf07b4 7ffdfa14 891f0000 710a00ff=20
> 4082ff5c 2c3a0000 38600000 41820230 <0fe00000> f9c10070 f9e10078 fa010080=
=20
> ---[ end trace 0000000000000000 ]---
> event svc_defer_recv has unsafe dereference of argument 1
> print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get=
_dynamic_array(addr), REC->dr, REC->xid
> event svc_defer_queue has unsafe dereference of argument 1
> print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get=
_dynamic_array(addr), REC->dr, REC->xid
> event svc_defer_drop has unsafe dereference of argument 1
> print_fmt: "addr=3D%pISpc dr=3D%p xid=3D0x%08x", (struct sockaddr *)__get=
_dynamic_array(addr), REC->dr, REC->xid
> NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
>=20
> Introduced by commit
>=20
>  e2e917f8677d ("SUNRPC: Fix the svc_deferred_event trace class")
>=20
> At least reverting that commit makes the warning go away.
>=20
> I have left that commit reverted for today.

Thank you, Stephen. The NFS community has already discussed a
fix for this issue. I'll push it out as soon as I can.


--
Chuck Lever



