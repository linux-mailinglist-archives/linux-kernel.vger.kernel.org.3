Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945D7511D78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiD0Rzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiD0Rzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:55:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910461FA62
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:52:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RHpUOS018603;
        Wed, 27 Apr 2022 17:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f1zALc50L5QTOaP8HmcJOixFlRUPFsv6YPo/jIUq9Gg=;
 b=z/AVCmrq6usHQvWvp05gmTv7Ci26kDsXPBcRMVci7a71TSLGG/n7v/fJvow9b+JPF+Cw
 mjttHmtNStc2Tmv7w1xOztjIqW+OZWsn48QO5XYHUsvWebQtKKPEWPpklATng/Et++ok
 pbKBjCzalvMWxC1gB1iNY3Eyexayg1jUxYd6NdDTzJQ3TqdsZminD71LqLipeC6xOFJg
 +DgdK59P8P4DoqExf1bYQUx1xXsT2GTAMKlO/ON777AhZg03dCUS8rysx+Xy272A36tF
 7sibUtIp5TmLa/eSDp7t3Bcwue2tXIcV1u8uKgF+TxIHe3Mt109Nhl32wdrQibEqKZZp FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k1uys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 17:52:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RHj8tx014271;
        Wed, 27 Apr 2022 17:52:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w57n27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 17:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lptW7+rHqzxwkUPj9IYbJE9bV117IHtZfiQIiM8zX99ANgX8jjMd6lIBlfRsnNoopRViZqHI1YL/Qb3N2h4M6quRpoH+MswAGh3kXtH4iSuovep6qSyMSUI2XGGMXWkth/MuglAt9gTKSV0qbmUkLNLyS/46M4Ym77o5zUfcYD9SSSTzjB7maWZWGQ7TF/Al7zK4Mn8Gv/KBOkV8YGHf7DDnadK2dJ2bEBkGNuHtvJClhwd7c5A7qxaRSV8TXemvnKdsSzFXnUWRaYLYMCWJjku04FXehT6XGHcN7LtpwpydX1fnPwArUSaTRT+amKx3n9hMKw+cFALEJ4SOyqe0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1zALc50L5QTOaP8HmcJOixFlRUPFsv6YPo/jIUq9Gg=;
 b=PFc9ppmeE2Ttf7FvXr9icQqDpVdDpTZTbzW74N3knAjS6LwEHroImrHFFwoi/t360z+e+4V9ju6WeisqCsB9Opjjh91u1RNcnGDFFOk8sdmpk0Qi0keAggPxdOse6uoJRJfLfkKFXHQMAqx14hv/K60XmDfm78IdIpD+imE/HEW56rNcO16eSSJ7M4G/+5CsfrwDguoBFD5VMbWHuDxbbKJcEYUM8ZOGi3VzXww3klykJbGYEC2dMnBSmgOdZm8mqHqVlQaQjgqjgD+xEebttQKtUVQfAylYYmPstP63EgMusdx8kXIvbZFKN9Grc1YnIXreqgn7xpXDwyYy8p3Npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1zALc50L5QTOaP8HmcJOixFlRUPFsv6YPo/jIUq9Gg=;
 b=RE6E7dUB2rgFgYTgrJ+FgpMDRTGE/X9udcczfqmiOY3IC7IAlhXgNiVusx0r/6joaF0v33N5YBEoIb1LZryOHl/6uQx49ybTNApVsK29uKPonceGJlMylno3VavEk8E57DCHMLbvCs2i7CIHrFhIT2KaaDpkN9kxmY62LilQZys=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB2965.namprd10.prod.outlook.com (2603:10b6:a03:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 17:52:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 17:52:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Peter Xu <peterx@redhat.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [syzbot] WARNING in vma_merge
Thread-Topic: [syzbot] WARNING in vma_merge
Thread-Index: AQHYWjRmy9YwbzHJ/0e8lY/ldotJ+K0DvUcAgABEggCAAAjgAA==
Date:   Wed, 27 Apr 2022 17:52:24 +0000
Message-ID: <20220427175218.cazytgdlpc6lpn45@revolver>
References: <000000000000a23c8505dda227eb@google.com>
 <000000000000f28f0005dda29992@google.com>
 <20220427102032.5a87283eb64d06c1a6d682fd@linux-foundation.org>
In-Reply-To: <20220427102032.5a87283eb64d06c1a6d682fd@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e8b5e9c-656e-4947-a3a3-08da2876af90
x-ms-traffictypediagnostic: BYAPR10MB2965:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2965AF470BA4AE05D4E6CE1DFDFA9@BYAPR10MB2965.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yVxLLM7X4/HwoV+eNlt65eFRqbcByQXN0/Xi1fzvESZGg3kAdhMyHDuBxfxZVxr28NugEB4nWKvjISfmcoUjbz82czxV33br7sC8gdSKGGtY8lt8i0SVY79HVgD2+Zit/fvdTRfPgkl+VIJ1kmStSVdciIfG37TSnsVrd3uVtkla3qljseblsVWPM3JHxXnjuC5CQMtJQ+66gSS7KpK+4Ox9yMXCQDUEkdrLz2WdkpMhvWlVa1aqGPtAmEMhRY0aEK2uphdwhzzR+5Ggq/dMitr+sPVxr9Q3EMtC6xt5yFdQ8+NSjvzetn6/rdTSw8nlgmxvEl9NwvGD4zTLMffUfVCAzJW1xZSyHBqN6KpHBYPAEsKFngj/mwXjseBxFk/Bwy5yofsYrIon1kIYlF8QE42QddMbAQ/v/WJYoGt+pYT7s9UXuDV/OUQn/8d8k38K92tacx7c2NjrMfR4GtwEq26tXSQN93KyeIaM+00k1T+oX2AY93qEn/tpM238hl7isC/8nqCX0OItaSxP6rL9gMFOkle3dwSdhXmjTynecnl/RK/V/uT3UZ/5s0j7e40MAj6vm2pyeudkAsMOoAr1LCiyBStGjDZH5NEm7IymVnmPSwytbJVYdtcVkfAPvgLBrQ8v/dqsh8oT9oqSbfRqdAc1djdEmm+q122xTNUyL5JlgBIwycwh9Sd+45ARAQSrurhJYpTNujFhfN0ZcSra97Dt2ftzmK/s3cPwGRxTiIb/0//CcwFSRgLKO0eyawImUJSQqoap+D2RAUL+bTE/YVfa8ljPDuC2f545yfczk+5JHLKxWRGIphcZbY13TEsjYFVl7C7WylZGxaQ59tFlqBk/8dzSXSfHHAvPSKlEfqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(76116006)(5660300002)(44832011)(91956017)(66476007)(316002)(186003)(66946007)(66556008)(2906002)(4326008)(6916009)(66446008)(8676002)(64756008)(83380400001)(8936002)(54906003)(71200400001)(86362001)(966005)(6486002)(508600001)(38070700005)(38100700002)(9686003)(1076003)(26005)(6512007)(122000001)(6506007)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ishVF/IjrwXHYsC4vDOgegejM9yAToepgVGLJnuwPUm0ai8Y5L7Vf9fjrfSN?=
 =?us-ascii?Q?QBy/bkHLzP0le5hz/zIHgRNivAYWy1Ft21Dw/6hDvTlaAA8OwLXVcWqEcFsF?=
 =?us-ascii?Q?mpEpb0jI3qLkn1nyyk00xaRe2ykKGHszwo0go8nkqN2/JQm9vEfr3E4bdp7p?=
 =?us-ascii?Q?mPXYJ2ho6t2qoagnswkEFKlsD6bkiZCIfzlsCWzU9hdb+dJFTliii143CXs4?=
 =?us-ascii?Q?R5ix3RQqW2KXZOmMc44RDhuqpR/l6a339Nk5/izZ3LNcxCO/bJNpPvb8kZoR?=
 =?us-ascii?Q?8SAreAybrlL2rh4uNn9BPKkgKfK13h5nTTQAJZdws5m+jQhWnbMVs8gh3T1N?=
 =?us-ascii?Q?Nm/VB6M3DH6U8ZUnJ3dZuHVgU4pIpoL+wHord2Hb9XR4Eo1HSXia+f2e07l9?=
 =?us-ascii?Q?Syi9XPxhWsuOk3pU8GUluoOHFSdZH/0kky3a0Y826JdNS6Jkb9f2oG1yOJKE?=
 =?us-ascii?Q?eWJrd0N7SdKFRBvp80UG96qcWedSRhLDkss+5gltiHNVo3m/QynlEd0c+MdK?=
 =?us-ascii?Q?vEBjrsUtl8hyplH3dakObwvDZV4GHyBEfK8OSGjO2Ya30vGuq7ivJ9t9PryP?=
 =?us-ascii?Q?jURF0Yd6bYhhPYbQAJjDsrOWCwI+njNRw24JI54YL3XuwajzVW4xz3W7/Ks0?=
 =?us-ascii?Q?iezVbgMg6VaOV1j6aEqLJIClNSbSy3fV4BVkwh1XuAFYipKM2jY2de1+rrpw?=
 =?us-ascii?Q?CS6At6AWIaKqnKNfM/HRPltwaQVjW9uQPbcjOqgVFOqY8+e7vqUGpgyYl1/S?=
 =?us-ascii?Q?AmUaKr56AsOcIR0eSPyIC3o8mhi6WGNXaUSSkH4j/uxFT63UxylHeIONLVVC?=
 =?us-ascii?Q?ryLPY4M7RWEssjjJjJ4ujRdYWeF/iD9tn6YLQ85QZam8AZmmWTmBXqbSzn7A?=
 =?us-ascii?Q?yK49V1gutkNrUqr/op5sxMOZANtNgb4dsOWFLFWpqhkpARxtnP2J2n1qxPIL?=
 =?us-ascii?Q?yix15KYWcI3nzqMkXX1Qx/pMwOJCcEgs3utAtNNf5xT3+J+tQy+5p8guT/a7?=
 =?us-ascii?Q?oLSWbzWwl3lcNIIGip94i913K52ZCItbotn8UIErD5IO65Ce1NdkWU7tikIv?=
 =?us-ascii?Q?tTmNGQJCFyg2NJeP4Aex/7tY0HXan7/AAgiSUHDaricQkcQHBLj/4Mepq+5v?=
 =?us-ascii?Q?hcBy0JpsWFnLteupuHdabrLhXIVYdpAhlHnVQK08rioN2t9SzDAgIR6JBlun?=
 =?us-ascii?Q?QSBq6D8EPewjz2YHQwEnZc3k11FCglaBS3/MvtMVS9ae9vAigmYVFx87Xlos?=
 =?us-ascii?Q?gr0IuXCbWslmFeVu8RecYkpQ/HLIRpWGnG0QaHK1/DyHEKxIsbem0OJTyMlE?=
 =?us-ascii?Q?3Sxm/LHISl95ZwNAMMRNzLl56mHKDL2WjH/drvNyNqlZVnbMuQWEqBmCi4og?=
 =?us-ascii?Q?N9kF4coIeHClGJ0ZpFPOnyvKODCwhyndOIW4iGRhYW2eqAERbamRkP7MWSFc?=
 =?us-ascii?Q?twU+F+/xysAUbvOsGSUVCJPR1cZzMEWuFxz+HPDsZcXij3xZpnQD5N2DKWru?=
 =?us-ascii?Q?a5TUalzKAhxcXRTpbJfAulRDckbiD9UqoHv4Zx6es1yg4Sy4JijiIrmRJF5W?=
 =?us-ascii?Q?bHMmWJhaUfczTMGtCr/SL4a9PaWxTqAYOXt8dQzmepzKfW2cUUla6zRNSNnf?=
 =?us-ascii?Q?bS5euMrQL4MnyV12djL0leJ9TY1LlTLiZC9I1kmES4v+h2G0swdEL6rQ0alb?=
 =?us-ascii?Q?nEWteoXUBvczk3hrqeuhr6nhHywmvYuwZsfW1b9tMgYfSlhwdamdtKvyxLlM?=
 =?us-ascii?Q?6ED5UL2KObPauqZjx1ioZc7AfgUdlCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7E0166E401D6C43831B249BFBEB56DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b5e9c-656e-4947-a3a3-08da2876af90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 17:52:24.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkkmXmmqmzv48aQEGnGvUH0fyWzBn6ew6YYUD5LsKN1+ZArWLCABTrHKyDJeO78GC5GxuQnj4Yiws84x8haJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2965
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=991
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270111
X-Proofpoint-GUID: 74Fg3yWUxHeHoznMAquRratOfZiX1YqN
X-Proofpoint-ORIG-GUID: 74Fg3yWUxHeHoznMAquRratOfZiX1YqN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220427 13:20]:
> On Wed, 27 Apr 2022 06:15:20 -0700 syzbot <syzbot+7728e4ab5371cebc9c00@sy=
zkaller.appspotmail.com> wrote:
>=20
> > syzbot has found a reproducer for the following issue on:
>=20
> Thanks.
>=20
> userfaultfd_release() appears to have offended vma_merge().

Potentially apply_mlockall_flags() and not userfaultfd_release(). There
is a potential that the vma iterator is stale if a split/merge succeeds,
although KASAN should pick this up and KASAN is active according to the
config below. I've sent a patch for the mlockall issue after Qian Cai's
reported it to linux-mm.

>=20
> I'm not seeing any changes in that area from Peter, but Liam's
> mapletree work changed things around a bit.  Gents, could you please
> take a look?
>=20
>=20
> > HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D105a33a2f00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De9256c70f58=
6da8a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7728e4ab5371c=
ebc9c00
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15f76f82f=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12b42c3cf00=
000
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3593 at mm/mmap.c:1072 vma_merge+0x428/0x950 mm/mm=
ap.c:1072
>=20
> I assume this is
>=20
> 		VM_WARN_ON(area && end > area->vm_end);
>=20
> But lines change around a lot.  It would be great if the script which
> generates these reports could quote the code around the indicated file
> and line.  Like:
>=20
> 	next =3D find_vma(mm, prev ? prev->vm_end : 0);
> 	area =3D next;
> 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
> 		next =3D find_vma(mm, next->vm_end);
>=20
> 	/* verify some invariant that must be enforced by the caller */
> 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
> -->	VM_WARN_ON(area && end > area->vm_end);
> 	VM_WARN_ON(addr >=3D end);
>=20
> 	/*
> 	 * Can it merge with the predecessor?
> 	 */
> 	if (prev && prev->vm_end =3D=3D addr &&


That is the correct line according to the git tree and HEAD commit
listed above.

I cannot get this issue to trigger with the given tree and git repo with
my config.  I will try again with the kernel config above.

Thanks,
Liam
