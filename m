Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99673512567
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiD0WpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiD0WpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:45:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F9F140AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:41:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKv3Gi018591;
        Wed, 27 Apr 2022 22:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+CX7CLHg1YmVA+3GbnATbLPeV3KlUUizNCNrXTOhI4s=;
 b=S+GAY4yMeSjnXMnX4U4WFF/Oik6byq69K0G/WwSrXW1aT0Jcue0KkbkygM5OFIEELfKL
 DDaztHAI64k/4rBr4kn7a0qKfJR1NThwnkgWA36YsYa0AQ3GbofAw9GHjj4n8yudOO4B
 SCBG5p/78RL/buTKUlvJuIgupgkXvKewcjw+5OmeBBftXu7Ddxxwk0qFgai5k1BbgKMA
 MwlwK4neBF3vlmd7RRFQ3gWtKu+FMareLpRGl7yv7OVXXkXefJmsnaubs8ez+txfd4nD
 tet9zNs2QuftDcoCYsLdIOqOF/jKmRDXBaWsp9MHogRQoUrLmXmos6LbbS8a5g2yUQhn bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k2gjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 22:41:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RMUPhh025883;
        Wed, 27 Apr 2022 22:41:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5mhvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 22:41:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYauiK95+dPvQ0S5fU9S2X57PVKFEL3XCPit49KnF60ZULYKgFNMnc4ZroQD5cPzEwcFawGQNZDPYspNWp3KcN4fsz49RL9oW3bJ49QKIPrpGEI6/rRahE06HqTMBF+v0Nm5xKEf2J66d6f2p9GnLZvdqhUKMKVah5Z55rnMaA1Mrc37/qqlf21X1NJdDlaViPna0KpagLJXAFEp7WBxejtaejAZyH0+1C/Lgtq1LwsM/uvisiLTLljG4zxy3XGNQD5tU6JgUB8cWQ3jefJrJCbzFTuhtfWqDNOTx2nDyb24z5OgIMOV+LWZ6FzlKn6kXuGdctnxay3VDk45Ubs3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CX7CLHg1YmVA+3GbnATbLPeV3KlUUizNCNrXTOhI4s=;
 b=W43tlFFRJXVgoR2AG31TXzw60+8W4lz1oIcRkospFZHGpMf36s7gaWX57B3SgOb3V4a7jJm/eMAwYk0bwh0fUOcR9jdVlu+PidNHVhbkgQ9C3kBX+NZFM0aBsPhPKq9Nt0mwMnCcqq1VQVvNA61Rd+y6hW/gl6yoN17P5ptbM/L0Hr7CGM1PjPD16Ir6svXoCy6SpE0sNk9DAwqSrYeJxUqUH8S55Yv6LA2IHbalf+sMnBtI9GSqhuxdn+NWhcKiizT8uKGfHnYxioPhiJATcxOS1GWUPoWsxRcUd6vHxDAsWMaTS+BH7khL6hWwFXR/3cT6/i+Yq0IuOVfAaWbD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CX7CLHg1YmVA+3GbnATbLPeV3KlUUizNCNrXTOhI4s=;
 b=sMRZ+6fUpDCKH0pI9lUxIGzSqqjt0HObMtivgdvBQQNYMNEQ+HikAWtSLsFwZshZZ+TC1cB4SbrKQPKsP96RvKIHGRlfaYJalFUuT5nMlyJxMgEpZyLPrmgNiEWeKitiorUABggAg8u1vOae0BSNLU/cwMzsm+ZBh7SzFTsL1dA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 22:41:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 22:41:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYa0D76aAgAALhwCAADqogIAAJxEA
Date:   Wed, 27 Apr 2022 22:41:41 +0000
Message-ID: <20220427224134.yurrplclbhmnrloj@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220427161033.GA1935@qian> <20220427165139.5s3qcj2u5vqrvwlc@revolver>
 <20220427202145.GA2047@qian>
In-Reply-To: <20220427202145.GA2047@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9f92bd-a3d4-4d0c-1eeb-08da289f197a
x-ms-traffictypediagnostic: MW4PR10MB5680:EE_
x-microsoft-antispam-prvs: <MW4PR10MB56807520E762081FAD65E0E0FDFA9@MW4PR10MB5680.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk2CX59+cdPulP3GtTqFh2KsntK085LGlrhCogb4ifITvQP8wLeQYEaMKAFWYBMLYnC56Zu7pykSKiAJfLJVGLRNAmycOlsqRrgcrq7uZj3AHgouuFEpVOMYoPT8BNWD4J8V/snjCRKfutnsBi561WEa58Uu/YfM7Ls+cvIPdH98ycMGLrzwlpwa8cFpGWyCfaaqAtmX3B+wDA0BgbiTaMHOBQxcCr24Lwj771AOB18MqfQCN3G/LF52MqJ5iMi6cCPO/nv3AHA/0vZEI8d2C+8Bs7KYVBmymEXtDTeQ3zO43YrXvOXe7GT6sd6JBLoYQ8Dq9pJEW1WKVOHospVDyDoWxcv6muxdMQhQJ8+rUNSDVJk4VkEknoDp32Fzh5is79OUmagOoth0Kx5Xgt9IGXlen4NWTiN2M6PtQTrgxvq3gFNM/S+A721yHQ9gAu99y6d/9VbvWVFHtZ+9nOTIK3rVIv/8b3SWHMD6kqeXpJRPB6E1u1IH1zOhx7sp+qC6U62gBOt9kRHpG9VFhJh9Akj0zFQSldKfRgI/SMo0GIK+1GdNgZMBRZjS1pgT84to//wGfRpKQ/xrDJt/+J2yh/Ix58SHBqRSCQ98fjuYkMKx6ZqCjOuxFn/coRnyZCJPwi/yae8d58Dqpl0Zc3aNzzxbNpLyOd8Ss4/seeCVJD4bsoVnS4Ni/qk2YavraEuLFDV09IuMFqUDrh8Dy/2QQpW7tHYj5ndMn2nV4Lq2ciM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(1076003)(76116006)(71200400001)(54906003)(316002)(66556008)(64756008)(66476007)(66446008)(6506007)(33716001)(6512007)(9686003)(91956017)(26005)(5660300002)(6916009)(83380400001)(44832011)(8936002)(8676002)(66946007)(4326008)(508600001)(3716004)(2906002)(122000001)(38070700005)(38100700002)(99936003)(86362001)(6486002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rvHEQdu2nOjAU7k49bEanoYwd6G730Gl8h8XwQ8fE8lwsNHyDmDhJLpgIuQ8?=
 =?us-ascii?Q?+4VgiP5cXR5CCZ0GYdmxUQftfFVWwGx1mpk16PQOyovw1DhY/L6qL0DhypXy?=
 =?us-ascii?Q?rvU05/ubinH9trU3C9VcdeRoCtptX9QIFj2+lDoj/NSubNK/4X3KtReP9lBQ?=
 =?us-ascii?Q?07P8TJkxEQG/qbvIET8Y3rGf32zixckBYT1iEyyLw14DeGujmS59zPIDoJj7?=
 =?us-ascii?Q?ZbDOWoMo07QGtzqCncSmeGcKyXGNfOJNPb8f1q5ltTSnT1RiWQuxDE3RUCDe?=
 =?us-ascii?Q?jalE6YDgEcaxbqFw3+ngHUCmskQre1KahZNmxsFo2SehV2Cjo0ENmEr5Jonh?=
 =?us-ascii?Q?H7oSaYQf7oCuEPzzstxUn99OuwXpl++jd6/yTeql+dNeXVeKVfoVQmUG4GMM?=
 =?us-ascii?Q?k/VrDC/wYnDplVGsRTfbamOtcS6g2GgsltNQEgPNoMsIcMe3iqPqZrTeEfGP?=
 =?us-ascii?Q?TpGVBEg96IUDJZ8kwghrs4VmObiaswYz2z6BpvTgXsRe4u/qYn+S+tKyyNEZ?=
 =?us-ascii?Q?17GQSzbgK44H+RhlQtCnpTClCoJ5nWTx7ZI3a/83hp9UVkmoJQvS21hJBYHt?=
 =?us-ascii?Q?eZBXS6Z8nPvw9MlUtPKiW9OAP8fdJNcjLJ+tTK8HgYoJYvjNXn0pWV87oXEW?=
 =?us-ascii?Q?9xQytU8o1l8RuYLoiuPHIiddl6Lbe+G5xe7K6YZ2VVmyd7ZWAiTQJsJjWJac?=
 =?us-ascii?Q?eV5ER7uslh2S2BTvA5zdLDcVLZ22YtWtwSvS9RXihR56qXQpoW7clTNQiG67?=
 =?us-ascii?Q?mX3dh+/gDxuqscUYb2ZKmmXdem87c5olEPdM9Ya/ImlKbiZELq0k1MD7lzrh?=
 =?us-ascii?Q?1nxecIo+l7BL56474s0bM+6bGjUQDAHrz9HnSe5cDN0Tc85UNkgIv1C6W+wr?=
 =?us-ascii?Q?IY5FdWxgwldTWZb7Yt+3x5fBVDi9T59yvXOIxaZQdwTfRNulpsQpRua9pO3z?=
 =?us-ascii?Q?vjJFxu1xq40f9gU9n03JBbFYEdiUUDr2FulCA++PNG3IjLuDABYN/Kf77lRY?=
 =?us-ascii?Q?jSDBx8HNdMbVTZkYOhGbo/vd/hYNIkbP0oR/DivX4x7DZnJvoNXRxeAGVfez?=
 =?us-ascii?Q?PERdZCCYUL1EKetMumvAua/cl6wXWfGiFTCqP3jUKPrDihnRuMdvjBRSxyWm?=
 =?us-ascii?Q?5jR/7B9/Fw1l2X4qAwVNzoX5R6zANgb2783daKSNRCiRYjaTUQQf8lmjIt7l?=
 =?us-ascii?Q?gzKMCvs6hV+l8Z7ONHQxeEQNan3Igzx6lPnVQM9258qHYGnl2+NzGU4HT8xU?=
 =?us-ascii?Q?IYJ1pmmDcYc5XkTZyMMKp07WusEKFeLjOmEL3vqAFT7TKFtDQ1P92pykG1HZ?=
 =?us-ascii?Q?wvRtQapexqRFDQyPOx7JpSLtPegDotSMUMTIooxwN8o4sKG7zM1ocimNUuqP?=
 =?us-ascii?Q?SyrREKT00x0CiMrblz01Xm3v9VUOmKTNxi7t3/fPwMGJhFkWar6wPt/xDp2P?=
 =?us-ascii?Q?dr5rplZo3DBTS828H7mWLPVjyXurhdtM8m8bS+5yy+RYhNLm/CGSkpKiVhB/?=
 =?us-ascii?Q?VSVwUoNMDhux7VzHcMxwMTY3R/mgA1lRTZ9LoUGe26IQtXQ461YCwK4ptCUo?=
 =?us-ascii?Q?Aec1PQLz+q8B8CUcemh2FDN0imGrgCsZu3JGqcOsgBR+Um+KO6RgkY1TL1tT?=
 =?us-ascii?Q?lYtNNMsb1NtWH0EamFt+zzGJmv7jnjQb1QDj7E4WQe5RIA3CySm5UtaUr2vt?=
 =?us-ascii?Q?sBbAzzjdUS89+BAWK5U9LZX218usZN2+7Vkk7iBqCaiN/dltii8rxAah6Vsu?=
 =?us-ascii?Q?nq/9YMlR733h8h8BXhG0V9fEe2bkQso=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220427224134yurrplclbhmnrlojrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9f92bd-a3d4-4d0c-1eeb-08da289f197a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 22:41:41.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOnGrD71BEAW/kvtKfTgvLGda94BblrXH4e3gnD9RJ3tsN3gsjsK65+8DRh3U4qKpsu4LaHO8QQ7GdZUEmwZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270133
X-Proofpoint-GUID: ReE5g9oHFeip8vz6hwOpJN2CpXcwSR-5
X-Proofpoint-ORIG-GUID: ReE5g9oHFeip8vz6hwOpJN2CpXcwSR-5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220427224134yurrplclbhmnrlojrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F10ED4314A48DE4994CC64899D566B19@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Qian Cai <quic_qiancai@quicinc.com> [220427 16:22]:
> On Wed, Apr 27, 2022 at 04:51:50PM +0000, Liam Howlett wrote:
> > Thanks.  This is indeed an issue with 0d43186b36c1 (mm/mlock: use vma
> > iterator and instead of vma linked list)                               =
                 =20
> >=20
> > Andrew, Please include this patch as a fix.
>=20
> Even with the patch applied, there are still thousands of memory leaks
> reports from kmemleak after booting.

Thank you for finding this.

>=20
> unreferenced object 0xffff400259bd6d00 (size 256):
>   comm "multipathd", pid 2577, jiffies 4294915929 (age 2370.384s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>      slab_post_alloc_hook
>      kmem_cache_alloc_bulk
>      mas_alloc_nodes
>      mt_alloc_bulk at lib/maple_tree.c:151
>      (inlined by) mas_alloc_nodes at lib/maple_tree.c:1244
>      mas_preallocate
>      __vma_adjust
>      shift_arg_pages
>      setup_arg_pages
>      load_elf_binary
>      search_binary_handler
>      exec_binprm
>      bprm_execve
>      do_execveat_common.isra.0
>      __arm64_sys_execve
>      invoke_syscall
>      el0_svc_common.constprop.0
>      do_el0_svc

__vma_adjust is way too complicated.  This patch should fix the leak.

Andrew, please add this patch to "mm: start tracking VMAs with maple tree"


Thanks,
Liam

--_002_20220427224134yurrplclbhmnrlojrevolver_
Content-Type: text/x-diff;
	name="0001-mm-mmap-Fix-__vma_adjust-memory-leak.patch"
Content-Description: 0001-mm-mmap-Fix-__vma_adjust-memory-leak.patch
Content-Disposition: attachment;
	filename="0001-mm-mmap-Fix-__vma_adjust-memory-leak.patch"; size=877;
	creation-date="Wed, 27 Apr 2022 22:41:41 GMT";
	modification-date="Wed, 27 Apr 2022 22:41:41 GMT"
Content-ID: <4B1F136CDAFD0E44A682F9EFE743576F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA3NGY1NTEyMjdkNDRiMzUxZDU2ZjRlYzBhMzY1NDJkODcxZjMzN2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxODo0MDowMCAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtbS9tbWFwOiBGaXggX192bWFfYWRqdXN0KCkgbWVtb3J5IGxlYWsuDQoNCldoZW4g
c2hpZnRpbmcgdGhlIGFyZyBwYWdlcywgdGhlIG1hcGxlIHN0YXRlIG1heSBiZSBsZWZ0IHdpdGgg
YWxsb2NhdGVkDQptZW1vcnkuICBGcmVlIHRoZSBtZW1vcnkgYnkgY2FsbGluZyBtYXNfZGVzdHJv
eSgpIHVuY29uZGl0aW9uYWxseSBhdCB0aGUNCmVuZCBvZiB0aGUgZnVuY3Rpb24uDQoNCkZpeGVz
OiBiZDZhMWZkNThkYWYgKG1tOiBzdGFydCB0cmFja2luZyBWTUFzIHdpdGggbWFwbGUgdHJlZSkN
ClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+
DQotLS0NCiBtbS9tbWFwLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cg0KZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KaW5kZXggNmEzN2Y1ZDJlNDk2
Li5mNTJiYmY5YWEwMjQgMTAwNjQ0DQotLS0gYS9tbS9tbWFwLmMNCisrKyBiL21tL21tYXAuYw0K
QEAgLTkwNCw2ICs5MDQsNyBAQCBpbnQgX192bWFfYWRqdXN0KHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqdm1hLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KIAkJdXByb2JlX21tYXAoaW5zZXJ0KTsNCiAJ
fQ0KIA0KKwltYXNfZGVzdHJveSgmbWFzKTsNCiAJdmFsaWRhdGVfbW0obW0pOw0KIA0KIAlyZXR1
cm4gMDsNCi0tIA0KMi4zNS4xDQoNCg==

--_002_20220427224134yurrplclbhmnrlojrevolver_--
