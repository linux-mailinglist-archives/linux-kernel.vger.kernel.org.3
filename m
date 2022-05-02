Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283E516904
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379346AbiEBAST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356095AbiEBASR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:18:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC850462
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:14:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241Ivw0P027785;
        Mon, 2 May 2022 00:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0Nep7nyEF8FKFesMAh/TwrWbHP3sNBq4zKZfgNYIiBA=;
 b=STaoUzhMfIjaqH8D7tnBbY/UCHVtkZBrkUeLSHgRg3jAmjf8MechYqaNAp7V58lhdVPX
 x3FLq5VFOx0Gr7Zct4nL5DcAAp64pTbGNIzep8sigRSBeMOEV7eaMaySv3YUecRDqPld
 r0abw298tcye12+uhciX14rIIJtfAw4MXuz1CdEml6PNy1bhYAIhGAH5p8cn9SSf0SZz
 MjamdAj8+zqu3CCbWCNvjAC1DMaMpDNFttutt3ntGFuTmFDg2bj3Du2XpCd/3/NSycGf
 rCAU0zpWN8Bipr92EtYIhTl/KQK/VbfB03RB36VVRg2V5vC1erHdttsbeqXbDKdku7I6 iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2a30m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 00:14:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2420AKt6023396;
        Mon, 2 May 2022 00:14:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj7jkv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 00:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3+5hLLKBjRI2wX6X8yD3lHhppKJoqUvi9j0d7ACAtNdLrk0O89Y7dH5hTXxipaS0xfrDV5a4J+TQd3Ni9cCk7e8WQzXXyJnVagU3yfGBmVu9avp40VUMdGicNNw77hB6/eylQPNOmwdy6A/n6HkSAh9GwXIvW2LtnPZZsvnZrDIG+OttnhnLQQaCFc8YmiR5g/JaB9k9retj1QEqB8O6iClMFFdRhbjfYf6vaBYbO3IqzhGsaZFAiaMPirdBeChHZFHHh8pD4oa5rBuMNxI36Kpjd9VVUH878+XA60LG92TysH9HH+M1EMfBjf1VVdAd6kIZaBVazj2xpUXt6Z0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nep7nyEF8FKFesMAh/TwrWbHP3sNBq4zKZfgNYIiBA=;
 b=gkqyYkfA+dCms6uj8DPkwOJR2/9naqDW2yY/gA1yY0A/ekecVs8vCz1Ro3fHve9lY1Z7CMbS90VemYJrdKtMl6rksTVCFR3Vtsm+b7+nJW1w0e1xfdlV7mWQSWxiQTWpN9xhQTjT+/LUK+PCIvprKj6jTDmuzIrNYKFYA+P9EQzven7DHsWZ3RWWiQN6+ZCDZz7bHmStqUPxjbbtvHH0Dh2s8jniynpipV3Ne2T030Fal8qAGrEuA2BY0aFBev3V9HEy57fP5VshdMtTA8b2Kg1vuI93DIHK2Xy0lXemBXOMvntBWUT2+n3909IkTNsyXrmjiAJHzAAltTgrfpeKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nep7nyEF8FKFesMAh/TwrWbHP3sNBq4zKZfgNYIiBA=;
 b=STsz5rcSBXjbumSFHY46v+Se+rHyd79lWvLJ8BceYNrjd2Em9CjG4oEENP8Nub+7CLdFpbs091gBVI9Lp+KaYghQ1ZC8CtMsx5JNqAWASmksTkESa7H9QTRDxUKqHUT3AN6LZ4gb4fdeSfbxQ6X0DpU/1crLulDM2fmxIS5o95A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 00:14:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 00:14:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6Va0Fx52AgABIVoCAAAqGgIAEpZEA
Date:   Mon, 2 May 2022 00:14:21 +0000
Message-ID: <20220502001358.s2azy37zcc27vgdb@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
In-Reply-To: <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e795e3-8470-4c79-f99d-08da2bd0b51c
x-ms-traffictypediagnostic: SA2PR10MB4538:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4538A0951D8D4CA23A21D170FDC19@SA2PR10MB4538.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moVuhoy0WTHhaDFI1f1Fv101g6paPbCTxF2ft3XILH3adActrA7T7t4a0mCtPbTlPizZXU5Y9Rj59IBGXh4yFD3qEVrrvLmLJLJsbBT40eUe53VcwAbbnv0Mgzv6iLj2aNrAWbHXuTvV3IUmYlrzgAaj88ExP/wmEhYPkgqudA8pOMJtafZaq5VoKo14gppistKOeTXfl/AhaojhuqmpZZeDO6pUU/edg+LhuHvNlJ6xhGoSovRl4pvbLR9UtU/IoOmdYc0OtK/TyWV/8YBZ+z6Yq2mAl9hVTTrgi0lqhP8ki4kBj1FeQ7snAQlSJN1dqPz6dWLWJAJ+Thr8+GOIJqSLCR0V4lMC7VX7HGz4siVGqZiwJmT2TtHe2nLXGPXQU2y2QicYTK+oi8lvNuhFLqzZXlX1evoFEGXt6JmVR9VyhpRYquMNn4cdEh8fUToIc4t3oO3Rex1d2OI0+mX++OFGF7Gsx+h3F3t2frnnLRngLu06We7MIwmZEGeDnH28HBYnBA43i/jhQ7ZicTLnT+BaFKsA9qYuNnqRetpz8xBtecysHNJxZHE0POJkh1diG6O0y+qHMjEGlZVk+pgtT8NCzRgzbKG7XefukDwhDZsjWesT9SZiH9SuByZZo95j19Z1w7OIE0ve1+1tkTs1iw5CM2REZaUuc5UV59Ha2b665+m8h5K+nYOII12p7+XF5z8CVmzaGiK1nfzbfRYkMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(71200400001)(38070700005)(38100700002)(66556008)(8936002)(6486002)(66446008)(66476007)(64756008)(508600001)(76116006)(26005)(86362001)(9686003)(6506007)(66946007)(8676002)(4326008)(6512007)(54906003)(316002)(6916009)(122000001)(1076003)(186003)(83380400001)(33716001)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G6PRMpks/Y2mA8+HSwmCjO6VebAc2u739wrWfpGpnzMcCIDlO/Uhiu69pzvH?=
 =?us-ascii?Q?n+/u8JrdX7jKuYvE2icNeRqQ4LodMHZoRwf6Cb8HNjD6+Eb0YnpRWYm+nMQA?=
 =?us-ascii?Q?hp6I1i8Dq3xhtwrWfzf/lpQLbswiuJhizrGuxaSmPT6ZYuJlxQEemH9Ud2JK?=
 =?us-ascii?Q?wXImEBd03v7Hr4YK+ElQVyemen5mQ2Dk/FgbGLhQONRFmZaT0sgwr1yxMP+w?=
 =?us-ascii?Q?T03Ib+ihMkGkVl5osjhizX9MG4kHZayRb2EvpsK3YyJHgDlgxyFNwBBycWZU?=
 =?us-ascii?Q?kPwAsXF4sAmO5BCralLLtvJgziWewiz7H/Lj0gNDLWAormedR2hkJyoP8ecL?=
 =?us-ascii?Q?uvf8stD2ThDeWaYPoryZ4oHs5YilJ4vUSmOVG9n5rfeMV9LCmlgsO7JhMReD?=
 =?us-ascii?Q?rrkL2OMq7xrc+qGCiKzhV/4/CsHGdxpX3vIu1jyBDhhQX7Z6uG+7wan5bpAj?=
 =?us-ascii?Q?QBHW8tcO1Nw/I7ODCItWu6guRxFaPMqD223Dh3YWPDt+3ODe+6Hm9HgmJz+y?=
 =?us-ascii?Q?Nc+Vq+D6tXgFw8PN2x3asRIIm1WUVx+22W1O8QQTUyssqmMi2avzM+m1V1UU?=
 =?us-ascii?Q?hf2oaF9bO3NjQSkPGj17/+ROJfxKG4kuTdB6i57lH9v+iA1yM6t/9VvUIzQC?=
 =?us-ascii?Q?sjagOmBb0QXtduKE0ITIKtKXvD1gIjXsjgZdlFktPku2LNPjMMbVf2Z9ATJs?=
 =?us-ascii?Q?pXEfNcPe8gSzLRk5IjokgXVES8aPCluJkf3dwVukkzzQ4oCTUW+lJrPr7TMB?=
 =?us-ascii?Q?1EX296oB80wDE7D6zEeJz6hAXvq/gLJovlUfy52JAYusZh1ltVWjX+YIb0MT?=
 =?us-ascii?Q?YYN3DiXsokyEk1cxDx6hgnRDgxO9LTxWWn77WPxAyeVGNVYytgA/6kwFytTn?=
 =?us-ascii?Q?qGks8K+cdSoW/8/4dJJzUGoJ1BmLb1leORyntyx+WfZ3OPx1lXAJ3cYBDRW6?=
 =?us-ascii?Q?HvP2c1kZA7SsFN7G8XfSOUMsMzAETfGkjv41mvbSNHqt9yFDWUw2tIML2c48?=
 =?us-ascii?Q?ba4tgUBHrZOT7DRQBrlmin6J9CWrd4ikxXaSiX91Z6vbs0A7Kr2nFvDQkQVV?=
 =?us-ascii?Q?iz6jOFjDuWkG9lzetcTuAN6e80n54tsNL4mI+Mt9OUOg7Nv0WISCN+Spx1nH?=
 =?us-ascii?Q?EnO/uYZ6olTgqucXYEkLH5HrOhc8O9dLjADF/Cgg9R74MJIynVsjCHxKRU+S?=
 =?us-ascii?Q?fsyMyCmAuYbKsG8XKr4eCobTDVjbkwNER8ZuNrjLrbirTR/+xhznpHvA3UyH?=
 =?us-ascii?Q?ZlLheXxhrN3L6j4MxQ3sDAEbFF1Fqoka7QsFvtyUtQM7KsJtia77PP0kgT8Y?=
 =?us-ascii?Q?j5je8dqMn15KaeMOOCA8npY1R82H07C2xB6mRN9yTYmaUVGmT+sZKXJqKmqT?=
 =?us-ascii?Q?Lj90L0Eg+HwpKaAohVthKshXY0mH+pIL5YsJi4A1pXXHBY5PwyKQCvBeRpo6?=
 =?us-ascii?Q?1MqVV3E1s/uIDIc0sCaLrNcTG62DOVnjtCMO+QsGA6jEEKaNB/uHvRH6UNgQ?=
 =?us-ascii?Q?m+F/V92la/HBiopF921S8kb41wDOGGXboDRDgCGll7cdO7gxCjBaas0ZjbWs?=
 =?us-ascii?Q?HeHCTe6XbUSZXz3ym87gPj8dJIFB8s9QWibZZvTbnETfqCD4G/HMsD61LDej?=
 =?us-ascii?Q?dUXF9np7KRyszu1SsdlUdZzfbDlaa5ePQi8mSSwnSS+j0xzn2cKeLv6E3wNn?=
 =?us-ascii?Q?xRgaYVWC12KXjVaxoJsvmrrOmKs8EsedvPvgJ3CyLbKTAh27GyUY81kAH7ce?=
 =?us-ascii?Q?zF5Uub0n8Y9vQAuCeKv/I4J3JUSZbhI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21B6B5885B276E44BD00C280A2697E29@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e795e3-8470-4c79-f99d-08da2bd0b51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 00:14:21.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKhZ2KgzAoNnuvPeBWDzY+HqgIcybmGUNsnlQznw4E5ttsbLCakTN6W/28OAY08V+33oajgFirEdz8dZgrqXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-01_09:2022-04-28,2022-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=990 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205010193
X-Proofpoint-GUID: WVwW29iJs4OzAFHDA3Rmcp48gZVfQs7H
X-Proofpoint-ORIG-GUID: WVwW29iJs4OzAFHDA3Rmcp48gZVfQs7H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220428 21:16]:
> On Fri, 29 Apr 2022 00:38:50 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > > mm/mmap.c: In function 'do_brk_flags':
> > > mm/mmap.c:2908:17: error: implicit declaration of function
> > > 	'khugepaged_enter_vma_merge'; did you mean 'khugepaged_enter_vma'?
> > >=20
> > > It appears that this is later fixed, but it hurts bisectability
> > > (and prevents me from finding the actual build failure in linux-next
> > > when trying to build corenet64_smp_defconfig).
> >=20
> > Yeah, that khugepaged_enter_vma_merge was renamed in another patch set.
> > Andrew made the correction but kept the patch as it was.  I think the
> > suggested change is right.. if you read the commit that introduced
> > khugepaged_enter_vma(), it seems right at least.
>=20
> Things are a bit crazy lately.  Merge issues with mapletree, merge
> issues with mglru on mapletree, me doing a bunch of retooling to start
> publishing/merging via git, mapletree runtime issues, etc.
>=20
> I've dropped the mapletree patches again.  Please scoop up all known
> fixes and redo against the (non-rebasing) mm-stable branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Okay, sounds good.

I have been porting my patches over and hit a bit of a snag. It looked
like my patches were not booting on the s390 - but not all the time. So
I reverted back to mm-stable (059342d1dd4e) and found that also failed
to boot sometimes on my qemu setup.  When it fails it's ~4-5sec into
booting.  The last thing I see is:

"[    4.668916] Spectre V2 mitigation: execute trampolines"

I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
build_zonerefs_node())

With the this commit, I am unable to boot one out of three times.  When
using the previous commit I was not able to get it to hang after trying
10+ times.  This is a qemu s390 install with KASAN on and I see no error
messages.  I think it's likely it is this patch, but no guaranteed.

Thanks,
Liam


>=20
> The mm-unstable branch is a rebasing tree which contains mm-stable as
> well as all the quilt-based MM material which isn't final enough to get
> into mm-stable.  So before sending please do a test merge with mm-unstabl=
e,
> evaluate any issues which might be encountered.
>=20
> I'd prefer to concentrate on getting mapletree stabilized and landed
> for now, worry about mglru after that.
> =
